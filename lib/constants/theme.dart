import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getLightTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.leagueSpartan(
        fontSize: MediaQuery.of(context).size.shortestSide / 7,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.2,
      ),
      headlineMedium: GoogleFonts.leagueSpartan(
        fontSize: MediaQuery.of(context).size.shortestSide / 8,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.2,
      ),
      headlineSmall: GoogleFonts.leagueSpartan(
        fontSize: MediaQuery.of(context).size.shortestSide / 10,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.2,
      ),
      titleLarge: GoogleFonts.leagueSpartan(
        fontSize: MediaQuery.of(context).size.shortestSide / 12,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.1,
      ),
      titleMedium: GoogleFonts.leagueSpartan(
        fontSize: MediaQuery.of(context).size.shortestSide / 15,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.1,
      ),
      titleSmall: GoogleFonts.leagueSpartan(
        fontSize: MediaQuery.of(context).size.shortestSide / 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.1,
      ),
      bodyLarge: GoogleFonts.leagueSpartan(
        fontSize: MediaQuery.of(context).size.shortestSide / 22,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyMedium: GoogleFonts.leagueSpartan(
        fontSize: MediaQuery.of(context).size.shortestSide / 28,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodySmall: GoogleFonts.leagueSpartan(
        fontSize: MediaQuery.of(context).size.shortestSide / 32,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
  );
}
