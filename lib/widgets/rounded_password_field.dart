import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final Color color, textColor;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.color = Palette.iconTheme,
    this.textColor = Palette.cardTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(29),
        border: Border.all(color: textColor),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(color: textColor),
        obscureText: true,
        onChanged: onChanged,
        cursorColor: textColor,
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.grey),
          icon: Icon(
            Icons.lock,
            color: textColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: textColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
