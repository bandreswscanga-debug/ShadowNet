import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Constantes de color centralizadas
  static const Color _primaryColor = Colors.greenAccent;
  static const Color _backgroundColor = Colors.black;
  static const Color _surfaceColor = Color(0xFF1A1A1A);

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _backgroundColor,
        primaryColor: _primaryColor,
        colorScheme: const ColorScheme.dark(
          primary: _primaryColor,
          surface: _surfaceColor,
          background: _backgroundColor,
          onPrimary: Colors.black,
          onSurface: _primaryColor,
        ),
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.robotoMono(
            color: _primaryColor,
            fontSize: 16,
          ),
          titleLarge: GoogleFonts.robotoMono(
            color: _primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: _backgroundColor,
          elevation: 0,
          titleTextStyle: GoogleFonts.robotoMono(
            color: _primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: _primaryColor),
        ),
        iconTheme: const IconThemeData(color: _primaryColor),
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: _primaryColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: _primaryColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: _primaryColor, width: 2),
          ),
          labelStyle: GoogleFonts.robotoMono(color: _primaryColor),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryColor,
            foregroundColor: Colors.black,
            textStyle: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
          ),
        ),
      );
}