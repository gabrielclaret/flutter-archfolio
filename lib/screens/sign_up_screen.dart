import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';
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
                  onChanged: (text) {
                    _name = text;
                  },
                ),
                RoundedInputField(
                  hintText: "username",
                  onChanged: (text) {
                    _username = text;
                  },
                ),
                RoundedInputField(
                  hintText: "email",
                  icon: Icons.email,
                  onChanged: (text) {
                    _email = text;
                  },
                ),
                RoundedPasswordField(
                  hintText: "password",
                  onChanged: (text) {
                    _password = text;
                  },
                ),
                RoundedPasswordField(
                  hintText: "repeat password",
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
                    print(_name);
                    loggedUser = await createUser(_name, _email, _username, _password);
                    if (loggedUser != null) {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => NavScreen(user: loggedUser,)));
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

  body['text'] = jsonEncode({
    "name": name,
    "email": email,
    "username": username,
    "password": password,
    "description": "haha",
    "location": "br"
  });
  
  final response = await http
      .post(Uri.http('192.168.0.36:8000', '/archfolio/v1/users'), body: body);

  if (response.statusCode == 200) {
    await prefs.setString("user", response.body);
    
    return User.fromJson(jsonDecode(response.body));
  } else {
    print("n ta bao");
    return null;
  }
}
