import 'package:flutter/material.dart';


class AppTheme {
  //!private contructor

  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    focusColor: Colors.black,
    hoverColor: Colors.black,
    disabledColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: primaryColor,
    hintColor: const Color(0xff0F2576),
    primaryColor: const Color(0xFF4C9BFB),
  );

  static final ThemeData darkTheme = ThemeData(
    iconTheme: const IconThemeData(color: Colors.white),
    focusColor: Colors.white,
    disabledColor: const Color(0xFF0096FF),
    hoverColor: const Color(0xFF0096FF),
    appBarTheme: AppBarTheme(color: Colors.grey.shade900),
    cardColor: Colors.grey.shade900,
    scaffoldBackgroundColor: darkThemeColor,
    primarySwatch: darkThemeColor,
    primaryColor: Colors.grey.shade800,
    brightness: Brightness.dark,
    backgroundColor: Colors.grey.shade900,
    hintColor: darkThemeColor,
  );
}

//0xffcaf0f6
//custom material color
//?  0xff007577 (greenish water)
const MaterialColor primaryColor = MaterialColor(
  0xffcaf0f6,
  <int, Color>{
    //?no applied shades, maintained one constant
    50: Color(0xffcaf0f6),
    100: Color(0xffcaf0f6),
    200: Color(0xffcaf0f6),
    300: Color(0xffcaf0f6),
    400: Color(0xffcaf0f6),
    500: Color(0xffcaf0f6),
    600: Color(0xffcaf0f6),
    700: Color(0xffcaf0f6),
    800: Color(0xffcaf0f6),
    900: Color(0xffcaf0f6),
  },
);

//custom black material color
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
