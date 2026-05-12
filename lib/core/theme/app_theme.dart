import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_shapes.dart';

class NexoTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: NexoColors.background,
      colorScheme: const ColorScheme.light(
        primary: NexoColors.primary,
        secondary: NexoColors.secondary,
        surface: NexoColors.white,
        error: NexoColors.error,
        onPrimary: NexoColors.textMain,
      ),
      textTheme: GoogleFonts.outfitTextTheme(
        ThemeData.light().textTheme.copyWith(
              displayLarge: const TextStyle(color: NexoColors.textMain, fontWeight: FontWeight.w800),
              titleLarge: const TextStyle(color: NexoColors.textMain, fontWeight: FontWeight.w700),
              bodyLarge: const TextStyle(color: NexoColors.textMain),
              bodyMedium: const TextStyle(color: NexoColors.textSub),
            ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: NexoColors.background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(color: NexoColors.textMain, fontSize: 20, fontWeight: FontWeight.w800),
        iconTheme: IconThemeData(color: NexoColors.textMain),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: NexoColors.primary,
          foregroundColor: NexoColors.textMain,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: NexoShapes.medium),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0F0F0F),
      colorScheme: const ColorScheme.dark(
        primary: NexoColors.primary,
        secondary: NexoColors.secondary,
        surface: Color(0xFF1E1E1E),
        error: NexoColors.error,
        onPrimary: NexoColors.textMain,
      ),
      textTheme: GoogleFonts.outfitTextTheme(
        ThemeData.dark().textTheme.copyWith(
              displayLarge: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              titleLarge: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              bodyLarge: const TextStyle(color: Color(0xFFE0E0E0)),
              bodyMedium: const TextStyle(color: Color(0xFFB0B0B0)),
            ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0F0F0F),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: NexoShapes.medium),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        border: OutlineInputBorder(borderRadius: NexoShapes.medium, borderSide: BorderSide.none),
      ),
    );
  }
}
