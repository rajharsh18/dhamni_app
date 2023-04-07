import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    displayMedium: GoogleFonts.montserrat(
      color: Colors.black87,
    ),
    titleMedium: GoogleFonts.poppins(
      color: Color.fromARGB(221, 0, 0, 0),
      fontSize: 24,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayMedium: GoogleFonts.montserrat(
      color: Color.fromARGB(179, 0, 0, 0),
    ),
    titleMedium: GoogleFonts.poppins(
      color: Color.fromARGB(179, 0, 0, 0),
      fontSize: 24,
    ),
  );
}
