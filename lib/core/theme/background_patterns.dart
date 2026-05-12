import 'dart:math';
import 'package:flutter/material.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// Background Patterns — Patrones de fondo con mayor presencia y color
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
    'blueprint',
    'notebook',
  ];

  static const Map<String, IconData> patternIcons = {
    'blank': Icons.crop_square_rounded,
    'dots': Icons.grid_on_rounded,
    'grid': Icons.grid_4x4_rounded,
    'lines': Icons.horizontal_rule_rounded,
    'waves': Icons.waves_rounded,
    'confetti': Icons.celebration_rounded,
    'paper': Icons.description_rounded,
    'stars': Icons.star_border_rounded,
    'blueprint': Icons.architecture_rounded,
    'notebook': Icons.menu_book_rounded,
  };

  static CustomPainter? getPainter(String? pattern) {
    switch (pattern) {
      case 'dots': return const _DotsPainter();
      case 'grid': return const _GridPainter();
      case 'lines': return const _LinesPainter();
      case 'waves': return const _WavesPainter();
      case 'confetti': return const _ConfettiPainter();
      case 'paper': return const _PaperPainter();
      case 'stars': return const _StarsPainter();
      case 'blueprint': return const _BlueprintPainter();
      case 'notebook': return const _NotebookPainter();
      default: return null;
    }
  }
}

class _DotsPainter extends CustomPainter {
  const _DotsPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0x15334155)..style = PaintingStyle.fill;
    const spacing = 20.0;
    for (double x = spacing; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 2.0, paint);
      }
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GridPainter extends CustomPainter {
  const _GridPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0x120F172A)..strokeWidth = 1.0..style = PaintingStyle.stroke;
    const spacing = 24.0;
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

class _LinesPainter extends CustomPainter {
  const _LinesPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0x1A64748B)..strokeWidth = 1.2..style = PaintingStyle.stroke;
    const spacing = 32.0;
    for (double y = spacing; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _WavesPainter extends CustomPainter {
  const _WavesPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0x18F59E0B)..strokeWidth = 2.0..style = PaintingStyle.stroke;
    const spacing = 44.0;
    for (double y = spacing; y < size.height; y += spacing) {
      final path = Path()..moveTo(0, y);
      for (double x = 0; x < size.width; x += 40) {
        path.quadraticBezierTo(x + 10, y - 12, x + 20, y);
        path.quadraticBezierTo(x + 30, y + 12, x + 40, y);
      }
      canvas.drawPath(path, paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ConfettiPainter extends CustomPainter {
  const _ConfettiPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(42);
    final colors = [const Color(0x25FFD700), const Color(0x2510B981), const Color(0x25F59E0B), const Color(0x25EC4899), const Color(0x256366F1)];
    for (int i = 0; i < 80; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      final color = colors[rng.nextInt(colors.length)];
      final radius = 3.0 + rng.nextDouble() * 4;
      final paint = Paint()..color = color..style = PaintingStyle.fill;
      if (rng.nextBool()) { canvas.drawCircle(Offset(x, y), radius, paint); } 
      else { canvas.drawRect(Rect.fromCenter(center: Offset(x, y), width: radius * 2.5, height: radius * 0.8), paint); }
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PaperPainter extends CustomPainter {
  const _PaperPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFFDFCF0);
    canvas.drawRect(Offset.zero & size, bgPaint);
    final marginPaint = Paint()..color = const Color(0x30EF4444)..strokeWidth = 2.0;
    canvas.drawLine(const Offset(54, 0), Offset(54, size.height), marginPaint);
    final linePaint = Paint()..color = const Color(0x203B82F6)..strokeWidth = 1.0;
    const spacing = 30.0;
    for (double y = spacing + 20; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StarsPainter extends CustomPainter {
  const _StarsPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(123);
    for (int i = 0; i < 40; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      final starSize = 5.0 + rng.nextDouble() * 7;
      final paint = Paint()..color = const Color(0x1FFACC15)..style = PaintingStyle.fill;
      _drawStar(canvas, Offset(x, y), starSize, paint);
    }
  }
  void _drawStar(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    for (int i = 0; i < 10; i++) {
      final angle = (i * pi / 5) - pi / 2;
      final r = i.isEven ? size : size * 0.45;
      final x = center.dx + r * cos(angle);
      final y = center.dy + r * sin(angle);
      if (i == 0) path.moveTo(x, y); else path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BlueprintPainter extends CustomPainter {
  const _BlueprintPainter();
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = const Color(0xFF1E3A8A));
    final paint = Paint()..color = const Color(0x30FFFFFF)..strokeWidth = 0.8;
    const spacing = 30.0;
    for (double x = 0; x < size.width; x += spacing) canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    for (double y = 0; y < size.height; y += spacing) canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _NotebookPainter extends CustomPainter {
  const _NotebookPainter();
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = const Color(0xFFF1F5F9));
    final linePaint = Paint()..color = const Color(0x2064748B)..strokeWidth = 1.0;
    for (double x = 0; x < size.width; x += 20) canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    for (double y = 0; y < size.height; y += 20) canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    canvas.drawLine(const Offset(40, 0), Offset(40, size.height), Paint()..color = const Color(0x40EF4444)..strokeWidth = 2.0);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
