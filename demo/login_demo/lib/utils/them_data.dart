import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    buttonTheme: const ButtonThemeData(
        buttonColor: Colors.lightBlue, disabledColor: Colors.grey),
  );
  static final dark = ThemeData.dark().copyWith(
    backgroundColor: Colors.black,
    buttonTheme: const ButtonThemeData(
        buttonColor: Colors.teal, disabledColor: Colors.grey),
  );
}
