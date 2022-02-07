import 'package:flutter/material.dart';

//! Do not alter with these values.

class HydratorAppTheme {
  //!private contructor
  HydratorAppTheme._();
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    focusColor: Colors.black,
    hoverColor: Colors.black,
    disabledColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: hydratorPrimaryColor,
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
    scaffoldBackgroundColor: Colors.grey.shade900,
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: Colors.grey.shade900,
    hintColor: const Color(0xff202020),
  );
}

//custom material color
//const Color(0xFFF66BBE)
//?  f5bad3 (pinkish), c7d0df (grayish), fcfbfe (whiteish)
const MaterialColor hydratorPrimaryColor = MaterialColor(
  0xFFF66BBE,
  <int, Color>{
    //?no applied shades, mzintained one constant
    50: Color(0xFFF66BBE),
    100: Color(0xFFF66BBE),
    200: Color(0xFFF66BBE),
    300: Color(0xFFF66BBE),
    400: Color(0xFFF66BBE),
    500: Color(0xFFF66BBE),
    600: Color(0xFFF66BBE),
    700: Color(0xFFF66BBE),
    800: Color(0xFFF66BBE),
    900: Color(0xFFF66BBE),
  },
);





/* 
static final ThemeData amoledDark = ThemeData(
    iconTheme: const IconThemeData(color: Colors.white),
    focusColor: Colors.white,
    disabledColor: const Color(0xFF0096FF),
    hoverColor: const Color(0xFF0096FF),
    appBarTheme: const AppBarTheme(color: Colors.black),
    cardColor: Colors.grey.shade900,
    scaffoldBackgroundColor: Colors.black,
    primarySwatch: Colors.blueGrey,
    primaryColor: Colors.grey,
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    hintColor: const Color(0xff202020),
  ); */