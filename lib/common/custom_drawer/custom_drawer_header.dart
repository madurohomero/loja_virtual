import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
        height: 180,
        child: Consumer<UserManager>(
          builder: (_, userManager, __) {
            return Column(
              children: <Widget>[
                Text(
                  'Loja do Homero',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
Text(
'Olá, ${userManager.user.name}'
)
              ],
            );
          },
        ));
  }
}
