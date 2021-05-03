import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';
import 'screens.dart';

import 'package:http/http.dart' as http; //arrumar o request em outro lugar
import 'dart:async';
import 'dart:convert';
import 'package:flutter_archfolio/model/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = "";
  String _password = "";
  bool _login = false;
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
                  hintText: "your username",
                  onChanged: (text) {
                    _username = text;
                  },
                ),
                RoundedPasswordField(
                  onChanged: (text) {
                    _password = text;
                  },
                ),
                RoundedButton(
                  text: "LOGIN",
                  press: () async {
                    loggedUser = await fetchUser(_username, _password);
                    if (loggedUser != null) {
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
      ),
    );
  }
}

fetchUser(String username, password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> request = {
    "identification": username,
    "password": password
  };

  final response = await http.get(Uri.http('192.168.0.36:8000',
      '/archfolio/v1/users', request)); 

  if (response.statusCode == 200) {
    await prefs.setString("user", response.body);

    return User.fromJson(jsonDecode(response.body));
  } else {
    print("n ta bao");
    return null;
  }
}
