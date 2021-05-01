import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Color color, textColor, mainColor;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.color = Palette.cardTheme,
    this.textColor = Palette.iconTheme,
    this.mainColor = Palette.mainLoginTheme,
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
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: mainColor),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(color: textColor),
        onChanged: onChanged,
        cursorColor: textColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: mainColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}
