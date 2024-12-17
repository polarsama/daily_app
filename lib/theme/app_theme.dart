import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Definición de colores personalizados
  static const Color lightBlue1 = Color(0xFFB1D4FF);
  static const Color lightBlue2 = Color(0xFF59A3FF);
  static const Color lightBlue3 = Color(0xFFE2F4FF);
  static const Color grayBackground = Color(0xFFF0F0F0);

  static ThemeData get lightTheme {
    return ThemeData(
      // Configuración de colores
      primaryColor: lightBlue2,
      scaffoldBackgroundColor: grayBackground,
      cardColor: Colors.white,
      
      // Configuración de la fuente
      textTheme: TextTheme(
        titleLarge: GoogleFonts.dmSans(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        headlineSmall: GoogleFonts.dmSans(
          fontSize: 24.0,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        headlineMedium: GoogleFonts.dmSans(
          fontSize: 28.0,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
        bodyLarge: GoogleFonts.dmSans(
          fontSize: 16.0,
          color: Colors.black54,
        ),
        bodyMedium: GoogleFonts.dmSans(
          fontSize: 14.0,
          color: Colors.black54,
        ),
      ),

      // Configuración de botones
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: lightBlue2,
          textStyle: GoogleFonts.dmSans(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // Configuración de AppBar
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        titleTextStyle: GoogleFonts.dmSans(
          color: Colors.black87,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Configuración de Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: lightBlue1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: lightBlue1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: lightBlue2, width: 2),
        ),
      ),

      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  // Tema oscuro (opcional, pero recomendado)
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: lightBlue2,
      scaffoldBackgroundColor: Colors.black87,
      
      textTheme: TextTheme(
        titleLarge: GoogleFonts.dmSans(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineSmall: GoogleFonts.dmSans(
          fontSize: 24.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.dmSans(
          fontSize: 16.0,
          color: Colors.white70,
        ),
        bodyMedium: GoogleFonts.dmSans(
          fontSize: 14.0,
          color: Colors.white70,
        ),
      ),

      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  // Colores útiles para referencia
  static Color get lightBlue1Color => lightBlue1;
  static Color get lightBlue2Color => lightBlue2;
  static Color get lightBlue3Color => lightBlue3;
  static Color get grayBackgroundColor => grayBackground;
}