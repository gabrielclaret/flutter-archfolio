import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/model/user_model.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';

class EditProfileScreen extends StatelessWidget {
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
  final User loggedUser;

  EditProfileScreen({Key key, this.loggedUser}) : super(key: key);

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
                    IconButton(
                      alignment: Alignment.center,
                        iconSize: 90,
                        icon: Icon(Icons.account_circle_rounded,
                        color: Palette.mainLoginTheme,),
                        onPressed: () => print('upload image')),
                    Text("profile_pic.png")
                  ],
                ),
                RoundedInputField(
                  hintText: loggedUser.name,
                  controller: nameController,
                ),
                RoundedInputField(
                  hintText: loggedUser.description,
                  controller: descriptionController,
                  icon: Icons.description,
                ),
                RoundedInputField(
                  hintText: loggedUser.location,
                  controller: locationController,
                  icon: Icons.location_on,
                ),
                RoundedInputField(
                    hintText: loggedUser.email,
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
                  text: "SAVE",
                  press: ()  {
                    _name = nameController.text;
                    _description = descriptionController.text;
                    _email = emailController.text;
                    _location = locationController.text;
                    _password = passwordController.text;
                    _repeatPasswordField = repeatPasswordController.text;
                    print("_name: $_name");
                    print("_description: $_description");
                    print("_email: $_email");
                    print("_location: $_location");
                    print("_password: $_password");
                    print("_repeatPasswordField $_repeatPasswordField");
                    if (_password != _repeatPasswordField) {
                      print("password and repeat password are not the same");
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
