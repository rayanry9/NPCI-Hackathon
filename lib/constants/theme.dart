import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
	useMaterial3: true,
	
	colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
	textTheme: TextTheme(
		headlineLarge: GoogleFonts.leagueSpartan(
			fontSize: 32,
			fontWeight: FontWeight.w600,
			color: Colors.white,
		),
		bodyMedium: GoogleFonts.leagueSpartan(
			fontSize: 16,
			fontWeight: FontWeight.w400,
			color: Colors.white,
		)
	)
);
