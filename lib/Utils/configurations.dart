import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextStyle customTextStyle({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
  }) {
    return GoogleFonts.lato(
        color: color, fontSize: fontSize, fontWeight: fontWeight);
  }
}
