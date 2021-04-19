import 'package:flutter/material.dart';

class Palette {
  static const LinearGradient createGradient = LinearGradient(
    colors: [Color(0xFF496AE1), Color(0xFFCE48B1)],
  );

  static const Color online = Color(0xFF4BCB1F);

  static const Color scaffold = Color(0xFFF0F2F5); //aah my eyes theme
  static const Color cardTheme = Colors.white; //aah my eyes theme, do it properly later
  static const Color iconTheme = Colors.black; //aah my eyes theme, do it properly later
  static const Color notSelectedTheme = Colors.black26; //dark theme, do it properly later
  static const Color postTheme = Colors.white; //aah my eyes theme, do it properly later
  static const Color profileTheme = Colors.redAccent; //aah my eyes theme, do it properly later

  // static const Color scaffold = Color(0xFF313131); //dark theme
  // static const Color cardTheme = Color(0xFF111111); //dark theme, do it properly later
  // static const Color iconTheme = Colors.white; //dark theme, do it properly later
  // static const Color notSelectedTheme = Colors.white24; //dark theme, do it properly later
  // static const Color postTheme = Colors.white; //dark theme, do it properly later
  // static const Color profileTheme = Colors.redAccent; //dark theme, do it properly later

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black38],
  );
}
