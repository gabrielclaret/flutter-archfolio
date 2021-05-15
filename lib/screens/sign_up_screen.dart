import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/config/settings.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';
import 'screens.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_archfolio/model/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatelessWidget {
  String _name = "";
  String _username = "";
  String _email = "";
  String _password = "";
  String _repeatPasswordField = "";
  TextEditingController nameController;
  TextEditingController usernameController;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController repeatPasswordController;
  User loggedUser;

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
                  hintText: "name",
                  controller: nameController,
                ),
                RoundedInputField(
                  hintText: "username",
                  controller: usernameController,
                ),
                RoundedInputField(
                    hintText: "email",
                    icon: Icons.email,
                    controller: emailController),
                RoundedPasswordField(
                  hintText: "password",
                  passwordController: passwordController,
                ),
                RoundedPasswordField(
                  hintText: "repeat password",
                  passwordController: repeatPasswordController,
                  onChanged: (text) {
                    if (text != _password) {
                      print("password is not the same");
                    } else {
                      print("password is the same");
                    }
                  },
                ),
                RoundedButton(
                  text: "SIGN UP",
                  press: () async {
                    _name = nameController.text;
                    _username = usernameController.text;
                    _email = emailController.text;
                    _password = passwordController.text;
                    _repeatPasswordField = repeatPasswordController.text;
                    print("_name: $_name");
                    print("_username: $_username");
                    print("_email: $_email");
                    print("_password: $_password");
                    print("_repeatPasswordField $_repeatPasswordField");
                    if (_password != _repeatPasswordField) {
                      print("password and repeat password are not the same");
                    } else if (_username.isEmpty |
                        _name.isEmpty |
                        _email.isEmpty |
                        _password.isEmpty) {
                      print("field is empty");
                    } else {
                      print(_name);
                      loggedUser =
                          await createUser(_name, _email, _username, _password);
                      if (loggedUser != null) {
                        Navigator.pop(context);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => NavScreen(
                              user: loggedUser,
                            ),
                          ),
                        );
                      }
                    }
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

createUser(String name, email, username, password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var body = new Map<String, dynamic>();
  List posts = [];
  body['text'] = jsonEncode({
    "name": name,
    "email": email,
    "username": username,
    "password": password,
    "description": "Here is my description",
    "location": "Brasil",
    "posts": posts,
  });

  final response = await http
      .post(Uri.http(Settings.apiUrl, '/archfolio/v1/users'), body: body);

  if (response.statusCode == 200) {
    await prefs.setString("user", response.body);

    return User.fromJson(jsonDecode(response.body));
  } else {
    print("n ta bao");
    return null;
  }
}
