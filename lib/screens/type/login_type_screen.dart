import 'package:flutter/material.dart';

class LoginTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Form(
          child: Container(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/capa_fundo_app_loja.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(
                      left: 60, right: 60, top: 80, bottom: 15),
                  child: Center(
                    child: new Text(
                      "Como deseja continuar?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 1.0, right: 1.0, top: 240, bottom: 10),
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 18, right: 18, top: 15, bottom: 15),
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                width: 150.0,
                                height: 40.0,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)),
                                  padding: const EdgeInsets.all(8),
                                  textColor: Colors.white,
                                  color: Colors.blue,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/auth');
                                  },
                                  child: new Text("Celular".toUpperCase()),
                                ),
                              ),
                              SizedBox(
                                width: 150.0,
                                height: 40.0,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)),
                                  onPressed: () {
                                    //  Navigator.of(context).pushReplacementNamed('/login');
                                    Navigator.of(context).pop('/login');
                                  },
                                  textColor: Colors.white,
                                  color: Colors.red,
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text(
                                    "Email".toUpperCase(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // // Container(
                // //   margin:
                // //       EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 15),
                // //   width: MediaQuery.of(context).size.width,
                // //   child: Row(
                // //     mainAxisAlignment: MainAxisAlignment.center,
                // //     children: [
                // //       Padding(
                // //         padding: const EdgeInsets.only(
                // //             top: 480, bottom: 20, left: 15, right: 15),
                // //         child: Row(
                // //           mainAxisAlignment: MainAxisAlignment.center,
                // //           children: <Widget>[
                // //             linhaHorizontal(),
                // //             Text(
                // //               'Login Social',
                // //               style: TextStyle(
                // //                 fontSize: 16,
                // //               ),
                // //             ),
                // //             linhaHorizontal()
                // //           ],
                // //         ),
                // //       ),
                // //     ],
                // //   ),
                // // ),
                // Container(
                //   margin:
                //       EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 10),
                //   width: MediaQuery.of(context).size.width,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(
                //             top: 510, bottom: 0, left: 0, right: 18),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: <Widget>[
                //             SocialIcons(
                //               colors: [
                //                 Color(0xFF102397),
                //                 Color(0xFF187adf),
                //                 Color(0xFF00eaf8),
                //               ],
                //               iconData: CustomIcons.facebook,
                //               onPressed: () {},
                //             ),
                //             SocialIcons(
                //               colors: [
                //                 Color(0xFFff4f38),
                //                 Color(0xFFff355d),
                //               ],
                //               iconData: CustomIcons.googlePlus,
                //               onPressed: () {},
                //             )
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Padding(
                //     padding: const EdgeInsets.only(
                //       top: 480,

                //       right: 140,
                //     ),
                //     child: InkWell(
                //       onTap: () {},
                //       child: Container(
                //         child: Text(
                //           'Esqueci minha senha',
                //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
