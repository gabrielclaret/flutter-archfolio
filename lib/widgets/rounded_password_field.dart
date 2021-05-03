import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final Color color, textColor, mainColor;
  final String hintText;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.color = Palette.cardTheme,
    this.textColor = Palette.iconTheme,
    this.mainColor = Palette.mainLoginTheme, this.hintText = "password",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      width: size.width * 0.7,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: mainColor),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(color: textColor),
        obscureText: true,
        onChanged: onChanged,
        cursorColor: textColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black54),
          icon: Icon(
            Icons.lock,
            color: mainColor,
            size: 22,
          ),
          // suffixIcon: Icon(
          //   Icons.visibility,
          //   color: textColor,
          // ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
