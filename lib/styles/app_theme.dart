import 'package:flutter/material.dart';

class AppTheme {
  //!private contructor

  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    focusColor: Colors.black,
    hoverColor: Colors.black,
    cardColor: Colors.white,
    disabledColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: primaryColor,
    hintColor: const Color(0xFF4C9BFB),
    highlightColor: const Color(0xffa4dded),
    primaryColor: const Color(0xFF4C9BFB),
  );

  static final ThemeData darkTheme = ThemeData(
    iconTheme: const IconThemeData(color: Colors.white),
    focusColor: Colors.white,
    shadowColor: Colors.grey.shade800,
    disabledColor: const Color(0xFF0096FF),
    hoverColor: const Color(0xFF0096FF),
    appBarTheme: AppBarTheme(color: Colors.grey.shade900),
    cardColor: Colors.grey.shade800,
    highlightColor: Colors.grey.shade800,
    scaffoldBackgroundColor: darkThemeColor,
    primarySwatch: darkThemeColor,
    primaryColor: Colors.grey.shade800,
    brightness: Brightness.dark,
    backgroundColor: Colors.grey.shade900,
    hintColor: darkThemeColor,
  );
}

//Color(0xff6D28D9)
//custom material color
const MaterialColor primaryColor = MaterialColor(
  0xff7fffd4,
  <int, Color>{
    //?no applied shades, maintained one constant
    50: Color(0xff7fffd4),
    100: Color(0xff7fffd4),
    200: Color(0xff7fffd4),
    300: Color(0xff7fffd4),
    400: Color(0xff7fffd4),
    500: Color(0xff7fffd4),
    600: Color(0xff7fffd4),
    700: Color(0xff7fffd4),
    800: Color(0xff7fffd4),
    900: Color(0xff7fffd4),
  },
);

//custom typical amoled black material color
const MaterialColor darkThemeColor = MaterialColor(
  0xff000000,
  <int, Color>{
    50: Color(0xff000000),
    100: Color(0xff000000),
    200: Color(0xff000000),
    300: Color(0xff000000),
    400: Color(0xff000000),
    500: Color(0xff000000),
    600: Color(0xff000000),
    700: Color(0xff000000),
    800: Color(0xff000000),
    900: Color(0xff000000),
  },
);
