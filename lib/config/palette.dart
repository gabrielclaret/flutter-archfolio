import 'package:flutter/material.dart';

class Palette {
  // static const LinearGradient createGradient = LinearGradient(
  //   colors: [Color(0xFF496AE1), Color(0xFFCE48B1)],
  // );

  static const LinearGradient createGradient = LinearGradient(
    colors: [Colors.indigo, Color(0xDDCE48B1)],
  );

  static const Color online = Color(0xFF4BCB1F);

  //aah my eyes theme
  static const Color scaffold = Color(0xFFF0F2F5); 
  static const Color cardTheme = Colors.white; 
  static const Color iconTheme = Colors.black; 
  static const Color notSelectedTheme = Colors.black26;
  static const Color postTheme = Colors.white; 
  static const Color profileTheme = Color(0xFF283593);
  //static const Color profileTheme = Colors.redAccent; 
  static const Color backgroundTheme = Colors.white;
  //static const Color mainColorTheme = Color(0xFF283593);
  static const Color mainColorTheme = Colors.black;
  static const Color mainLoginTheme = Color(0xFF3846A4);
  static const Color secondaryColorTheme = Color(0x66CE48B1);

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black38],
  );
}
