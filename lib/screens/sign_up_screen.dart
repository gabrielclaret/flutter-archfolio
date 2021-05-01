import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';
import 'screens.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Palette.iconTheme,
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Palette.backgroundTheme,
      ),
      backgroundColor: Palette.backgroundTheme,
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => Palette.createGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: Text(
                    'archfolio',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.9,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                RoundedInputField(
                  hintText: "username",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "email",
                  icon: Icons.email,
                  onChanged: (value) {},
                ),
                RoundedPasswordField(
                  hintText: "password",
                  onChanged: (value) {},
                ),
                RoundedPasswordField(
                  hintText: "repeat password",
                  onChanged: (value) {},
                ),
                RoundedButton(
                  text: "SIGN UP",
                  press: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => NavScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
