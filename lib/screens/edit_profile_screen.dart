import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archfolio/widgets/responsive.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/config/settings.dart';
import 'package:flutter_archfolio/model/user_model.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';

import 'nav_screen.dart';

class EditProfileScreen extends StatefulWidget {
  User loggedUser;

  EditProfileScreen({Key key, this.loggedUser}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  User user;

  @override
  void initState() {
    user = widget.loggedUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context, user),
          ),
          iconTheme: IconThemeData(
            color: Palette.iconTheme,
          ),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Palette.scaffold,
        body: Responsive(
            mobile: _EditProfileScreenMobile(
              loggedUser: user,
            ),
            desktop: _EditProfileScreenDesktop(
              loggedUser: user,
            )));
  }
}

class _EditProfileScreenDesktop extends StatefulWidget {
  final User loggedUser;

  const _EditProfileScreenDesktop({
    Key key,
    @required this.loggedUser,
  }) : super(key: key);

  @override
  __EditProfileScreenDesktopState createState() =>
      __EditProfileScreenDesktopState();
}

class __EditProfileScreenDesktopState extends State<_EditProfileScreenDesktop> {
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
  bool updated = false;
  Uint8List uploadedImage;

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
    //FilePickerResult result = await FilePicker.platform.pickFiles();
    setState(() async {
      if (pickedFile != null) {
        _image = File.fromRawPath(await pickedFile.readAsBytes());
        //_image = File.fromRawPath(result.files.single.bytes);
      } else {
        print('No image selected.');
      }
      // if (result != null) {
      //   print('im here');
      //   _image = File(result.files.single.path);
      //   print('ok im not here anymore');
      // } else {
      //   // User canceled the picker
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Card(
        child: Container(
          alignment: Alignment.center,
          width: size.width * 0.65,
          height: size.height,
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _image == null
                            ? InkWell(
                                onTap: getImage,
                                child: CircleAvatar(
                                  radius: 63.0,
                                  backgroundColor: Palette.profileTheme,
                                  child: CircleAvatar(
                                    radius: 60.0,
                                    backgroundColor: Colors.grey[200],
                                    backgroundImage: CachedNetworkImageProvider(
                                        user.imageUrl),
                                  ),
                                ))
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
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: RoundedInputField(
                        hintText: user.name,
                        controller: nameController,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: RoundedInputField(
                        hintText: user.description,
                        controller: descriptionController,
                        icon: Icons.description,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: RoundedInputField(
                        hintText: user.location,
                        controller: locationController,
                        icon: Icons.location_on,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: RoundedInputField(
                          hintText: user.email,
                          icon: Icons.email,
                          controller: emailController),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: RoundedPasswordField(
                        hintText: "password",
                        passwordController: passwordController,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: RoundedPasswordField(
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
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: RoundedButton(
                        key: const Key('saveButton'),
                        text: "SAVE",
                        press: () async {
                          _name = nameController.text;
                          _description = descriptionController.text;
                          _email = emailController.text;
                          _location = locationController.text;
                          _password = passwordController.text;

                          print("_name: $_name");
                          print("_description: $_description");
                          print("_email: $_email");
                          print("_location: $_location");
                          print("_password: $_password");
                          print(
                              "_repeatPasswordField: $repeatPasswordController.text");
                          if (_password != repeatPasswordController.text) {
                            print(
                                "password and repeat password are not the same");
                          } else {
                            print(_image.runtimeType);
                            print('im here');
                            //   new_user = await _sendUpdateUser(
                            //     user.id,
                            //     _name,
                            //     _description,
                            //     _email,
                            //     _location,
                            //     _password,
                            //     imageFile,
                            //   );
                            //   updated = true;
                            // }
                            // if (updated) {
                            //   Navigator.pop(context, new_user);
                            // } else {
                            //   Navigator.pop(context, user);
                            // }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EditProfileScreenMobile extends StatefulWidget {
  final User loggedUser;
  const _EditProfileScreenMobile({Key key, this.loggedUser}) : super(key: key);

  @override
  __EditProfileScreenMobileState createState() =>
      __EditProfileScreenMobileState();
}

class __EditProfileScreenMobileState extends State<_EditProfileScreenMobile> {
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
  bool updated = false;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _image == null
                      ? InkWell(
                          onTap: getImage,
                          child: CircleAvatar(
                            radius: 63.0,
                            backgroundColor: Palette.profileTheme,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundColor: Colors.grey[200],
                              backgroundImage:
                                  CachedNetworkImageProvider(user.imageUrl),
                            ),
                          ))
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
                  print("_repeatPasswordField: $repeatPasswordController.text");
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
                    updated = true;
                  }
                  if (updated) {
                    Navigator.pop(context, new_user);
                  } else {
                    Navigator.pop(context, user);
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

_sendUpdateUser(int userId, String name, String description, String email,
    String location, String password, File pfp) async {
  var body_text = new Map<String, dynamic>();

  if (name != null) {
    body_text['name'] = name;
  }
  if (description != null) {
    body_text['description'] = description;
  }
  if (email != null) {
    body_text['email'] = email;
  }

  if (location != null) {
    body_text['location'] = location;
  }
  if (password != null) {
    body_text['password'] = password;
  }

  var dio = Dio();
  dio.options.baseUrl = Uri.http(Settings.apiUrl, 'archfolio/v1').toString();

  var formData = FormData.fromMap({
    'text': json.encode(body_text),
    'file': await MultipartFile.fromFile(pfp.path, filename: 'pfp$userId')
  });

  Response response = await dio.patch('/users/$userId', data: formData);
  return User.fromJson(jsonDecode(response.toString()));
}
