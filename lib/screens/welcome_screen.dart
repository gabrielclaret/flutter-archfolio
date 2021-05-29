import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';
import 'screens.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
                SizedBox(height: size.height * 0.15),
                Text(
                  'archfolio',
                  style: const TextStyle(
                    color: Palette.mainLoginTheme,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.9,
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                RoundedButton(
                  key: const Key('loginButton'),
                  text: "LOGIN",
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
                RoundedButton(
                  key: const Key('signUpButton'),
                  buttonColor: Palette.secondaryColorTheme,
                  text: "SIGN UP",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
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
