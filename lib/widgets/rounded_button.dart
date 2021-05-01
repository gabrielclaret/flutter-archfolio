import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color textColor, buttonColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.textColor = Colors.white,
    this.buttonColor = Palette.mainLoginTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(buttonColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
          onPressed: press,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
