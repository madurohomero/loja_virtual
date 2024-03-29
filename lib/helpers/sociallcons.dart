import 'package:flutter/material.dart';

class SocialIcons extends StatelessWidget {
  final List<Color> colors;
  final IconData iconData;
  final Function onPressed;
  SocialIcons({this.colors, this.iconData, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Container(
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: colors, tileMode: TileMode.clamp),
        ),
        child: RawMaterialButton(
          onPressed: onPressed,
          shape: CircleBorder(),
          child: Icon(
            iconData,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
