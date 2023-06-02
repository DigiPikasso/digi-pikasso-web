import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(color: Color.fromRGBO(236, 112, 69, 1)),
    iconTheme: const IconThemeData(
      color: const Color(0xFF009999),
    ),
    textTheme: GoogleFonts.robotoTextTheme(),
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF009999),
      secondary: Colors.black,
      outline: Colors.grey.shade300,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF9900),
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
  );
}
