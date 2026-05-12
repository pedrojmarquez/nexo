import 'package:flutter/material.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// Nexo Shape System
/// BorderRadius y tokens de forma consistentes en toda la app.
/// ─────────────────────────────────────────────────────────────────────────────

abstract final class NexoShapes {
  // ── Radios base ─────────────────────────────────────────────────────────
  static const double radiusXS = 6.0;
  static const double radiusSM = 10.0;
  static const double radiusMD = 14.0;
  static const double radiusLG = 20.0;
  static const double radiusXL = 28.0;
  static const double radius2XL = 36.0;
  static const double radiusFull = 100.0;

  // ── BorderRadius objetos listos ─────────────────────────────────────────
  static const BorderRadius xSmall =
      BorderRadius.all(Radius.circular(radiusXS));
  static const BorderRadius small = BorderRadius.all(Radius.circular(radiusSM));
  static const BorderRadius medium =
      BorderRadius.all(Radius.circular(radiusMD));
  static const BorderRadius large = BorderRadius.all(Radius.circular(radiusLG));
  static const BorderRadius xLarge =
      BorderRadius.all(Radius.circular(radiusXL));
  static const BorderRadius xxLarge =
      BorderRadius.all(Radius.circular(radius2XL));
  static const BorderRadius full =
      BorderRadius.all(Radius.circular(radiusFull));

  /// Bottom sheet: esquinas solo en la parte superior
  static const BorderRadius bottomSheet = BorderRadius.only(
    topLeft: Radius.circular(radiusXL),
    topRight: Radius.circular(radiusXL),
  );

  // ── Elevaciones ──────────────────────────────────────────────────────────
  static const double elevationNone = 0.0;
  static const double elevationCard = 2.0;
  static const double elevationFocus = 6.0;
  static const double elevationModal = 16.0;
}
