import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';
import 'screens.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  Text(
                    'archfolio',
                    style: const TextStyle(
                      color: Palette.iconTheme,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.9,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    color: Palette.cardTheme,
                    textColor: Palette.iconTheme,
                    hintText: "Your Username",
                    onChanged: (value) {},
                  ),
                  RoundedPasswordField(
                    color: Palette.cardTheme,
                    textColor: Palette.iconTheme,
                    onChanged: (value) {},
                  ),
                  RoundedButton(
                    color: Palette.iconTheme,
                    textColor: Palette.cardTheme,
                    text: "LOGIN",
                    press: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => NavScreen()));
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
