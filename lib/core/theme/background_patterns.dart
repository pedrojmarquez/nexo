import 'dart:math';
import 'package:flutter/material.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// Background Patterns — Patrones de fondo para el editor de notas
/// Generados con CustomPainter (sin assets externos, resolución infinita)
/// ─────────────────────────────────────────────────────────────────────────────

class NoteBackgrounds {
  static const List<String> allPatterns = [
    'blank',
    'dots',
    'grid',
    'lines',
    'waves',
    'confetti',
    'paper',
    'stars',
  ];

  static const Map<String, String> patternLabels = {
    'blank': 'Blanco',
    'dots': 'Puntos',
    'grid': 'Cuadrícula',
    'lines': 'Líneas',
    'waves': 'Ondas',
    'confetti': 'Confetti',
    'paper': 'Papel',
    'stars': 'Estrellas',
  };

  static const Map<String, IconData> patternIcons = {
    'blank': Icons.crop_square_rounded,
    'dots': Icons.grid_on_rounded,
    'grid': Icons.grid_4x4_rounded,
    'lines': Icons.horizontal_rule_rounded,
    'waves': Icons.waves_rounded,
    'confetti': Icons.celebration_rounded,
    'paper': Icons.description_rounded,
    'stars': Icons.star_border_rounded,
  };

  static CustomPainter? getPainter(String? pattern) {
    switch (pattern) {
      case 'dots':
        return const _DotsPainter();
      case 'grid':
        return const _GridPainter();
      case 'lines':
        return const _LinesPainter();
      case 'waves':
        return const _WavesPainter();
      case 'confetti':
        return const _ConfettiPainter();
      case 'paper':
        return const _PaperPainter();
      case 'stars':
        return const _StarsPainter();
      default:
        return null;
    }
  }
}

// ── Dots Pattern ─────────────────────────────────────────────────────────────
class _DotsPainter extends CustomPainter {
  const _DotsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x0F0F172A)
      ..style = PaintingStyle.fill;

    const spacing = 24.0;
    for (double x = spacing; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Grid Pattern ─────────────────────────────────────────────────────────────
class _GridPainter extends CustomPainter {
  const _GridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x0A0F172A)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    const spacing = 28.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Lines Pattern ────────────────────────────────────────────────────────────
class _LinesPainter extends CustomPainter {
  const _LinesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x0D94A3B8)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    const spacing = 32.0;
    for (double y = spacing; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Waves Pattern ────────────────────────────────────────────────────────────
class _WavesPainter extends CustomPainter {
  const _WavesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x0AFACC15)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const spacing = 40.0;
    for (double y = spacing; y < size.height; y += spacing) {
      final path = Path();
      path.moveTo(0, y);
      for (double x = 0; x < size.width; x += 30) {
        path.quadraticBezierTo(x + 7.5, y - 8, x + 15, y);
        path.quadraticBezierTo(x + 22.5, y + 8, x + 30, y);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Confetti Pattern ─────────────────────────────────────────────────────────
class _ConfettiPainter extends CustomPainter {
  const _ConfettiPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(42); // Fixed seed for consistent pattern
    final colors = [
      const Color(0x15FFD700),
      const Color(0x1510B981),
      const Color(0x15F59E0B),
      const Color(0x15FACC15),
      const Color(0x1594A3B8),
    ];

    for (int i = 0; i < 60; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      final color = colors[rng.nextInt(colors.length)];
      final radius = 2.0 + rng.nextDouble() * 3;

      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      if (rng.nextBool()) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      } else {
        canvas.drawRect(
          Rect.fromCenter(
              center: Offset(x, y), width: radius * 2, height: radius * 0.8),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Paper Texture ────────────────────────────────────────────────────────────
class _PaperPainter extends CustomPainter {
  const _PaperPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Left margin line
    final marginPaint = Paint()
      ..color = const Color(0x18EF4444)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    canvas.drawLine(const Offset(48, 0), Offset(48, size.height), marginPaint);

    // Horizontal ruled lines
    final linePaint = Paint()
      ..color = const Color(0x0D94A3B8)
      ..strokeWidth = 0.6
      ..style = PaintingStyle.stroke;

    const spacing = 30.0;
    for (double y = spacing + 10; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Stars Pattern ────────────────────────────────────────────────────────────
class _StarsPainter extends CustomPainter {
  const _StarsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(99);
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < 35; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      final starSize = 4.0 + rng.nextDouble() * 6;
      final alpha = 0.04 + rng.nextDouble() * 0.06;

      paint.color = const Color(0xFFFACC15).withValues(alpha: alpha);
      _drawStar(canvas, Offset(x, y), starSize, paint);
    }
  }

  void _drawStar(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    const points = 4;
    final innerRadius = size * 0.4;

    for (int i = 0; i < points * 2; i++) {
      final angle = (i * pi / points) - pi / 2;
      final radius = i.isEven ? size : innerRadius;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
