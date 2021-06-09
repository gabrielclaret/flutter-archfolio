import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/config/settings.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'screens.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_archfolio/model/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _name = "";
  String _username = "";
  String _email = "";
  String _password = "";
  String _repeatPasswordField = "";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  User loggedUser;
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
            alignment: Alignment.topCenter,
            child: Column(
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
                SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _image == null
                        ? IconButton(
                            alignment: Alignment.center,
                            iconSize: 90,
                            icon: Icon(
                              Icons.account_circle_rounded,
                              color: Palette.mainLoginTheme,
                            ),
                            onPressed: getImage,
                          )
                        : InkWell(
                            onTap: getImage,
                            child: CircleAvatar(
                              radius: 63.0,
                              backgroundColor: Palette.profileTheme,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundColor: Colors.grey[200],
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    decoration: new BoxDecoration(
                                      color: const Color(0xff7c94b6),
                                      image: new DecorationImage(
                                        image: FileImage(_image),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: new BorderRadius.all(
                                          const Radius.circular(80.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("profile picture"),
                    ),
                  ],
                ),
                RoundedInputField(
                  key: const Key('nameFieldSUScreen'),
                  hintText: "name",
                  controller: nameController,
                ),
                RoundedInputField(
                  key: const Key('usernameFieldSUScreen'),
                  hintText: "username",
                  controller: usernameController,
                ),
                RoundedInputField(
                    key: const Key('emailFieldSUScreen'),
                    hintText: "email",
                    icon: Icons.email,
                    controller: emailController),
                RoundedPasswordField(
                  key: const Key('passwordFieldSUScreen'),
                  hintText: "password",
                  passwordController: passwordController,
                ),
                RoundedPasswordField(
                  key: const Key('rpasswordFieldSUScreen'),
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
                  key: const Key('signUpButtonSUScreen'),
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
                          await createUser(_name, _email, _username, _password, _image);
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

createUser(String name, String email, String username, String password, File pfp) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var body = new Map<String, dynamic>();
  List posts = [];
  var body_text = new Map<String, dynamic>();

  if (name != null) {
    body_text['name'] = name;
  }
  if (email != null) {
    body_text['email'] = email;
  }
  if (username != null) {
    body_text['username'] = username;
  }
  if (password != null) {
    body_text['password'] = password;
  }
  body_text['location'] = 'Brasil';

  body_text['description'] = 'A cool description.';

  var dio = Dio();
  dio.options.baseUrl = Uri.http(Settings.apiUrl, 'archfolio/v1').toString();

  var formData = FormData.fromMap({
    'text': json.encode(body_text),
    'file': await MultipartFile.fromFile(pfp.path)
  });

  Response response = await dio.post('/users', data: formData);
  print(jsonDecode(response.toString()));
  return User.fromJson(jsonDecode(response.toString()));
  // final response = await http
  //     .post(Uri.http(Settings.apiUrl, '/archfolio/v1/users'), body: body);

  // if (response.statusCode == 200) {
  //   await prefs.setString("user", response.body);

  //   print(jsonDecode(response.body));
  //   return User.fromJson(jsonDecode(response.body));
  // } else {
  //   print("n ta bao");
  //   return null;
  // }
}
