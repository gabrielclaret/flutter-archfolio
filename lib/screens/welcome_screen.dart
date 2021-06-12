import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/widgets/responsive.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';
import 'screens.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.scaffold,
        body: Responsive(
          mobile: _WelcomeScreenMobile(),
          desktop: _WelcomeScreenDesktop(),
        ));
  }
}

class _WelcomeScreenMobile extends StatelessWidget {
  const _WelcomeScreenMobile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeScreenDesktop extends StatelessWidget {
  const _WelcomeScreenDesktop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child:  Card(
          child: Container(
            alignment: Alignment.center,
            width: size.width*0.65,
            height: size.height*0.75,
            child: SingleChildScrollView(
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0.0),
                        child: CachedNetworkImage(
                          imageUrl: "https://miro.medium.com/max/1920/1*YvhJBGJK5uxfvr0Z4dUVHw.jpeg",
                          width: size.width*0.65,
                          height: size.height*0.75,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 80),
                            child: RoundedButton(
                              key: const Key('loginButton'),
                              text: "LOGIN",
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 80),
                            child: RoundedButton(
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
                          ),
                        ],
                      ),
                    ), 
                    
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
