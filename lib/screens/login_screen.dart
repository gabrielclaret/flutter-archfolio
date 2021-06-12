import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/widgets/responsive.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';
import 'screens.dart';

import 'package:http/http.dart' as http; //arrumar o request em outro lugar
import 'dart:async';
import 'dart:convert';
import 'package:flutter_archfolio/model/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_archfolio/config/settings.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Palette.iconTheme,
          ),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Palette.scaffold,
        body: Responsive(
          desktop: _LoginScreenDesktop(
            usernameController: _usernameController,
            passwordController: _passwordController,
          ),
          mobile: _LoginScreenMobile(
            usernameController: _usernameController,
            passwordController: _passwordController,
          ),
        ));
  }
}

class _LoginScreenMobile extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const _LoginScreenMobile({
    Key key,
    @required this.usernameController,
    @required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _username = "";
    String _password = "";
    bool _login = false;
    User loggedUser;

    Size size = MediaQuery.of(context).size;
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
              RoundedInputField(
                key: const Key('usernameFieldLScreen'),
                hintText: "your username",
                controller: usernameController,
              ),
              RoundedPasswordField(
                key: const Key('passwordFieldLScreen'),
                passwordController: passwordController,
              ),
              RoundedButton(
                key: const Key('loginButtonLScreen'),
                text: "LOGIN",
                press: () async {
                  _username = usernameController.text;
                  _password = passwordController.text;

                  loggedUser = await fetchUser(_username, _password, false);
                  if (loggedUser != null) {
                    print("Log In successfull");
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => NavScreen(
                              user: loggedUser,
                            )));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginScreenDesktop extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const _LoginScreenDesktop({
    Key key,
    @required this.usernameController,
    @required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _username = "";
    String _password = "";
    bool _login = false;
    User loggedUser;

    Size size = MediaQuery.of(context).size;
    return Center(
      child: Card(
        child: Container(
          alignment: Alignment.center,
          width: size.width * 0.65,
          height: size.height * 0.75,
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://miro.medium.com/max/1920/1*YvhJBGJK5uxfvr0Z4dUVHw.jpeg",
                        width: size.width * 0.65,
                        height: size.height * 0.75,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: RoundedInputField(
                            key: const Key('usernameFieldLScreen'),
                            hintText: "your username",
                            controller: usernameController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: RoundedPasswordField(
                            key: const Key('passwordFieldLScreen'),
                            passwordController: passwordController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: RoundedButton(
                            key: const Key('loginButtonLScreen'),
                            text: "LOGIN",
                            press: () async {
                              _username = usernameController.text;
                              _password = passwordController.text;

                              loggedUser =
                                  await fetchUser(_username, _password, true);
                              if (loggedUser != null) {
                                print("Log In successfull");
                                Navigator.pop(context);
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => NavScreen(
                                              user: loggedUser,
                                            )));
                              }
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

fetchUser(String username, password, bool isWeb) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> request = {
    "identification": username,
    "password": password
  };
  final response =
      await http.get(Uri.http(Settings.apiUrl, '/archfolio/v1/users', request));

  if (response.statusCode == 200) {
    if (isWeb) {
      print('am here');
      var response_user = jsonDecode(response.body);
      response_user['pfp_url'] = "https://images.unsplash.com/photo-1521119989659-a83eee488004?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=664&q=80";
      print(response_user);
      return User.fromJson(response_user);
    } else
      return User.fromJson(jsonDecode(response.body));
  } else {
    print("Couldn't login");
    return null;
  }
}
