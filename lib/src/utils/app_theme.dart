import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:report_system/src/utils/colors.dart';


class AppTheme  {
  static TextStyle textStyle = GoogleFonts.lora();



  bool isDark = false;

  final lightTheme = ThemeData(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: primaryColor,
      ),
// Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: primaryColor,


// Define the default font family.
      fontFamily: 'Lora',
accentColor: primaryColor,
      //hintColor: primaryColor,

// Define the default `TextTheme`. Use this to specify the default
// text styling for headlines, titles, bodies of text, and more.
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Lora'),
      ));

  final darkTheme = ThemeData(
    backgroundColor: Colors.black,
// Define the default brightness and colors.
      brightness: Brightness.dark,
      primaryColor: Colors.white,

// Define the default font family.
      fontFamily: 'Georgia',

// Define the default `TextTheme`. Use this to specify the default
// text styling for headlines, titles, bodies of text, and more.
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ));

  ThemeData get  appTheme => lightTheme;
  void changeAppTheme(){
    isDark = !isDark;


  }


}

