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
              displayLarge: const TextStyle(
                  color: NexoColors.textMain, fontWeight: FontWeight.w800),
              titleLarge: const TextStyle(
                  color: NexoColors.textMain, fontWeight: FontWeight.w700),
              bodyLarge: const TextStyle(color: NexoColors.textMain),
              bodyMedium: const TextStyle(color: NexoColors.textSub),
            ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: NexoColors.background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: NexoColors.textMain,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
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
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: NexoColors.white,
        border: OutlineInputBorder(
          borderRadius: NexoShapes.medium,
          borderSide: BorderSide(color: NexoColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: NexoShapes.medium,
          borderSide: const BorderSide(color: NexoColors.divider),
        ),
        hintStyle: const TextStyle(color: NexoColors.textMuted),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  static ThemeData get dark => light; // Por ahora igualamos para consistencia
}
