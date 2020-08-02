import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/controllers/auth_manager.dart';
import 'package:loja_virtual/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  bool isValid = false;

  Future<Null> validate(StateSetter updateState) async {
    print("em validar : ${_phoneController.text.length}");
    if (_phoneController.text.length == 11) {
      updateState(() {
        isValid = true;
      });
    }
  }

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: "+55${phone}",
        timeout: Duration(seconds: 20),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          // user: user,
                        )));
          } else {
            print("Error");
          }

// Esse retorno de chamada é chamado quando a verificação é feita automaticamente
        },
        verificationFailed: (AuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
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
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code);

                        AuthResult result =
                            await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;

                        if (user != null) {
                          
                        } else {
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Form(
            child: Consumer<AuthManager>(
              builder: (_, authManager, __) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/cell.png",
                      width: 180,
                    ),
                    Text(
                      "Autenticação",
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 36,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: !authManager.loading,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        icon: Icon(Icons.phone_android, color: Colors.grey),
                        labelText: "Número de celular de 11 dígitos",
                        hintText: "(00) 0000-0000",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[200]),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[300]),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        prefix: Container(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "+55",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      controller: _phoneController,
                      autofocus: true,
                      autovalidate: true,
                      autocorrect: false,
                      maxLengthEnforced: true,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Depois de inserir seu número de telefone, clique em verificar para se autenticar! Aguarde até 20 segundos para obter o SMS e prosseguir",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: FlatButton(
                        child: Text(
                          "VERIFICAR",
                        ),
                        textColor: Colors.white,
                        padding: EdgeInsets.all(16),
                        onPressed: () {
                          final phone = _phoneController.text.trim();
                           loginUser(phone, context);
                          // authManager.verifyPhoneNumber(context, phone);
                        },
                        color: Colors.blue,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
