import 'package:flutter/material.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// Nexo Ivory & Gold System (Clean Light Theme)
/// Inspirado en diseños minimalistas tipo Apple/Notion.
/// ─────────────────────────────────────────────────────────────────────────────

abstract final class NexoColors {
  // ── Fondos & Superficies ──────────────────────────────────────────────────
  static const Color background = Color(0xFFFAFAFA); // White-Greyish
  static const Color white = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF1F5F9); // Slate 100
  static const Color surfaceDark = Color(0xFFE2E8F0); // Slate 200

  // ── Colores de Acento (Gold/Yellow) ───────────────────────────────────────
  static const Color primary = Color(0xFFFFD700); // Gold / Yellow
  static const Color primaryDark = Color(0xFFFACC15); // Yellow 400
  static const Color secondary = Color(0xFF0F172A); // Slate 900 (Contrast)

  // ── Escala de Grises (Texto) ──────────────────────────────────────────────
  static const Color textMain = Color(0xFF0F172A); // Slate 900
  static const Color textSub = Color(0xFF475569); // Slate 600
  static const Color textMuted = Color(0xFF94A3B8); // Slate 400
  static const Color divider = Color(0xFFE2E8F0); // Slate 200

  // ── Colores Funcionales ───────────────────────────────────────────────────
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color black = Colors.black;

  // ── Gradientes ───────────────────────────────────────────────────────────
  static const Gradient goldGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
