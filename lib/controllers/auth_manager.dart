import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loja_virtual/helpers/firebase_errors.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/screens/login/login_screen.dart';


class AuthManager extends ChangeNotifier {
  // AuthManager() {
  //   _loadCurrentUser();
  // }
  FirebaseAuth auth = FirebaseAuth.instance;
  // FirebaseUser _user;
  final Firestore firestore = Firestore.instance;
  User user;

  bool _loading = false;
  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  }

  authUsuario() {
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser({User user, FirebaseUser firebaseUser}) async {
    final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
    if (currentUser != null) {
      final DocumentSnapshot docUser = await firestore
          .collection('usuarios')
          .document(currentUser.uid)
          .get();

      user = User.fromDocument(docUser);
    }
  }

  final _codeController = TextEditingController();
  bool codeSent = false;
  String verificationId;

  void showToast(message, Color color) {
    print(message);
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<bool> loginUser(String phone, BuildContext context) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      signIn(authResult, context);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      showToast('${getErrorString(authException.code)}', Colors.red);
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text("Digite o código?"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _codeController,
                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Confirme"),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () async {
                    loading = true;
                    notifyListeners();
                    final code = _codeController.text.trim();
                    signInWithOTP(code, verificationId, context);
                  },
                )
              ],
            );
          });

      this.codeSent = true;
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await auth.verifyPhoneNumber(
        phoneNumber: "+55${phone}",
        timeout: Duration(seconds: 20),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  signIn(AuthCredential authCreds, BuildContext context) async {
    loading = true;
    try {
      AuthResult result = await auth.signInWithCredential(authCreds);
      user.id = result.user.uid;
      this.user = user;
      await user.saveData();
      await _loadCurrentUser(firebaseUser: result.user);
    } on PlatformException catch (e) {
      print(e.code);
      showToast('${getErrorString(e.code)}', Colors.red);
    }
    loading = false;
  }

//Verifica o SMS code automático
  signInWithOTP(smsCode, verId, BuildContext context) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    loading = false;
    signIn(authCreds, context);
  }

  signOut(BuildContext context) async {
    await auth.signOut().then((value) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => new LoginScreen()));
    });
  }
}
