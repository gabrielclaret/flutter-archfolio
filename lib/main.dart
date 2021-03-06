import 'package:flutter/material.dart';
import 'package:flutter_archfolio/data/data.dart';
import 'screens/screens.dart';
import 'config/palette.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Archfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Palette.scaffold,
      ),
      home: WelcomeScreen(),
      //home: NavScreen(user: currentUser,),
    );
  }
}
