import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_archfolio/config/settings.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/model/user_model.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'nav_screen.dart';

class EditProfileScreen extends StatefulWidget {
  User loggedUser;

  EditProfileScreen({Key key, this.loggedUser}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _name = "";
  String _description = "";
  String _email = "";
  String _location = "";
  String _password = "";
  String _repeatPasswordField = "";
  TextEditingController nameController;
  TextEditingController descriptionController;
  TextEditingController emailController;
  TextEditingController locationController;
  TextEditingController passwordController;
  TextEditingController repeatPasswordController;
  File _image;
  final picker = ImagePicker();
  User user;
  User new_user;

  @override
  void initState() {
    user = widget.loggedUser;
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    emailController = TextEditingController();
    locationController = TextEditingController();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    emailController.dispose();
    locationController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

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
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
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
                      child: Text("Profile Picture"),
                    )
                  ],
                ),
                RoundedInputField(
                  hintText: user.name,
                  controller: nameController,
                ),
                RoundedInputField(
                  hintText: user.description,
                  controller: descriptionController,
                  icon: Icons.description,
                ),
                RoundedInputField(
                  hintText: user.location,
                  controller: locationController,
                  icon: Icons.location_on,
                ),
                RoundedInputField(
                    hintText: user.email,
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
                  key: const Key('saveButton'),
                  text: "SAVE",
                  press: () async {
                    print('im here hello hi');
                    _name = nameController.text;
                    _description = descriptionController.text;
                    _email = emailController.text;
                    _location = locationController.text;
                    _password = passwordController.text;

                    print('iheey');
                    print("_name: $_name");
                    print("_description: $_description");
                    print("_email: $_email");
                    print("_location: $_location");
                    print("_password: $_password");
                    print(
                        "_repeatPasswordField: $repeatPasswordController.text");
                    if (_password != repeatPasswordController.text) {
                      print("password and repeat password are not the same");
                    } else {
                      new_user = await _sendUpdateUser(
                        user.id,
                        _name,
                        _description,
                        _email,
                        _location,
                        _password,
                        _image,
                      );
                      Navigator.pop(context, new_user);
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

_sendUpdateUser(int userId, String name, String description, String email,
    String location, String password, File pfp) async {
  var body_text = new Map<String, dynamic>();
  body_text['name'] = name;
  body_text['description'] = description;
  body_text['email'] = email;
  body_text['location'] = location;
  if (password != null) {
    body_text['password'] = password;
  }

  var dio = Dio();
  dio.options.baseUrl = Uri.http(Settings.apiUrl, 'archfolio/v1').toString();

  var formData = FormData.fromMap({
    'text': json.encode(body_text),
    'file': await MultipartFile.fromFile(pfp.path, filename: 'pfp$userId.txt')
  });

  Response response = await dio.patch('/users/$userId', data: formData);
  return User.fromJson(jsonDecode(response.toString()));
}
