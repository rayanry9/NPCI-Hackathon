import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.leagueSpartan(
        fontSize: 64,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.2,
      ),
      headlineMedium: GoogleFonts.leagueSpartan(
        fontSize: 56,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.2,
      ),
      headlineSmall: GoogleFonts.leagueSpartan(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.2,
      ),
      titleLarge: GoogleFonts.leagueSpartan(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.1,
      ),
      titleMedium: GoogleFonts.leagueSpartan(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.1,
      ),
      titleSmall: GoogleFonts.leagueSpartan(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.1,
      ),
      bodyLarge: GoogleFonts.leagueSpartan(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyMedium: GoogleFonts.leagueSpartan(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodySmall: GoogleFonts.leagueSpartan(
          fontSize: 10, fontWeight: FontWeight.w400, color: Colors.white),
    ));
