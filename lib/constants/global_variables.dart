import 'package:flutter/material.dart';


class GlobalVariables {
  // Fonts
  static const String fontFamily = 'Roboto';
  //Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF1E1E1E),
      Color(0xff03dac5),
      Color.fromARGB(255, 37, 129, 154),
    ],
  );

  // Colors
  static const regularWhite = Color(0xFFFFFFFF);
  static const primaryBlue = Color(0xff03dac5);
  static const backgroundBlack = Color(0xFF121212);
  static const secondaryBlack = Color(0xFF1E1E1E);
  static const primaryGrey = Color(0xFF1E1E1E);
  static const secondaryGrey = Color(0xFFA5A5A5);
  static const primaryGreen = Color(0xff41b637);
  static const primaryRed = Color(0xfff30a2e);
  static const primaryPurple = Color(0xff6200ee);
  static const primarySky = Color(0xff219ba3);

}
