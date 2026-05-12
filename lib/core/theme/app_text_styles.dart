import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// Nexo Typography System
///
/// Fuente primaria: Inter (Google Fonts) — moderna, legible, neutral
/// Fuente display:  Inter con peso 700-900 para títulos hero
///
/// Jerarquía:
///   displayLarge  → Hero titles (splash, onboarding)
///   headlineLarge → Títulos de sección principal
///   headlineMedium→ Títulos de cards / features
///   titleLarge    → Título de lista / nota
///   titleMedium   → Subtítulo / nombre de usuario
///   bodyLarge     → Cuerpo principal de texto
///   bodyMedium    → Texto secundario / descripciones
///   bodySmall     → Metadatos, timestamps, labels
///   labelLarge    → Botones y chips
///   labelSmall    → Tags y badges
/// ─────────────────────────────────────────────────────────────────────────────

abstract final class NexoTextStyles {
  /// Base TextTheme usando Inter via Google Fonts
  static TextTheme get textTheme => GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.plusJakartaSans(
          fontSize: 57,
          fontWeight: FontWeight.w900,
          letterSpacing: -2.0,
          height: 1.1,
        ),
        displayMedium: GoogleFonts.plusJakartaSans(
          fontSize: 45,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.5,
          height: 1.15,
        ),
        displaySmall: GoogleFonts.plusJakartaSans(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.0,
          height: 1.2,
        ),
        headlineLarge: GoogleFonts.plusJakartaSans(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
          height: 1.25,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
          height: 1.3,
        ),
        headlineSmall: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
          height: 1.35,
        ),
        titleLarge: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.1,
          height: 1.4,
        ),
        titleMedium: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          height: 1.45,
        ),
        titleSmall: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.5,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.1,
          height: 1.55,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.2,
          height: 1.5,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
          height: 1.4,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
          height: 1.35,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.3,
        ),
      );

  // ── Estilos semánticos de acceso directo ────────────────────────────────

  /// Título grande para pantallas hero (ej: login/splash)
  static TextStyle heroTitle(Color color) => GoogleFonts.inter(
        fontSize: 42,
        fontWeight: FontWeight.w900,
        letterSpacing: -2.0,
        color: color,
        height: 1.1,
      );

  /// Estilo para el nombre del asistente "Nexo" en la UI
  static TextStyle brandName(Color color) => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.0,
        color: color,
      );

  /// Texto de botón principal
  static TextStyle buttonText(Color color) => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
        color: color,
      );

  /// Timestamp / metadatos (gris, pequeño)
  static TextStyle timestamp(Color color) => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.3,
        color: color,
      );

  /// Etiqueta de chip / tag
  static TextStyle chipLabel(Color color) => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
        color: color,
      );
}
