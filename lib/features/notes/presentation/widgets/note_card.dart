import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/core/theme/background_patterns.dart';
import 'package:nexo/features/notes/domain/note_model.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// NoteCard — Diseño diferenciado por tipo de nota (tablón)
/// ─────────────────────────────────────────────────────────────────────────────
class NoteCard extends StatelessWidget {
  final NexoNote note;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    switch (note.noteSubType) {
      case 'post_it':
        return _PostItCard(note: note, onTap: onTap, onLongPress: onLongPress);
      case 'shopping_principal':
        return _ShoppingCard(
            note: note, onTap: onTap, onLongPress: onLongPress);
      default:
        return _StandardCard(
            note: note, onTap: onTap, onLongPress: onLongPress);
    }
  }
}

// ── Post-It Card ─────────────────────────────────────────────────────────────
class _PostItCard extends StatelessWidget {
  final NexoNote note;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const _PostItCard(
      {required this.note, required this.onTap, this.onLongPress});

  static const _postItColors = [
    Color(0xFFFFF176), // Yellow
    Color(0xFFA5D6A7), // Green
    Color(0xFFEF9A9A), // Pink
    Color(0xFF90CAF9), // Blue
    Color(0xFFFFCC80), // Orange
    Color(0xFFCE93D8), // Purple
  ];

  Color _getColor() {
    if (note.accentColor != null) {
      try {
        return Color(int.parse(note.accentColor!.replaceFirst('#', '0xFF')));
      } catch (_) {}
    }
    final index = note.title.hashCode.abs() % _postItColors.length;
    return _postItColors[index];
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    final rotation = (Random(note.id.hashCode).nextDouble() - 0.5) * 0.04;

    return Transform.rotate(
      angle: rotation,
      child: Material(
        color: color,
        borderRadius: NexoShapes.small,
        elevation: 3,
        shadowColor: color.withValues(alpha: 0.4),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: NexoShapes.small,
          child: Container(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (note.isPinned)
                  const Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.push_pin_rounded,
                        size: 14, color: Colors.black45),
                  ),
                // Solo mostrar contenido (sin título separado)
                if (note.content != null && note.content!.isNotEmpty)
                  Text(
                    note.content!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 12),
                Text(
                  _formatDate(note.updatedAt ?? note.createdAt),
                  style: const TextStyle(fontSize: 10, color: Colors.black38),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Standard Note Card ───────────────────────────────────────────────────────
class _StandardCard extends StatelessWidget {
  final NexoNote note;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const _StandardCard(
      {required this.note, required this.onTap, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    final bgPainter = NoteBackgrounds.getPainter(note.backgroundPattern);

    return Material(
      color: NexoColors.white,
      borderRadius: NexoShapes.medium,
      elevation: 1,
      shadowColor: NexoColors.black.withValues(alpha: 0.08),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: NexoShapes.medium,
        child: ClipRRect(
          borderRadius: NexoShapes.medium,
          child: CustomPaint(
            painter: bgPainter,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: NexoShapes.medium,
                border: Border.all(
                    color: NexoColors.divider.withValues(alpha: 0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.description_outlined,
                          size: 16, color: NexoColors.primaryDark),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          note.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: NexoColors.textMain,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (note.isPinned)
                        const Icon(Icons.push_pin_rounded,
                            size: 14, color: NexoColors.primaryDark),
                    ],
                  ),
                  if (note.content != null && note.content!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      note.content!,
                      style: const TextStyle(
                          fontSize: 13, color: NexoColors.textSub, height: 1.4),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        _formatDate(note.updatedAt ?? note.createdAt),
                        style: const TextStyle(
                            fontSize: 11, color: NexoColors.textMuted),
                      ),
                      const Spacer(),
                      if (note.tags.isNotEmpty)
                        ...note.tags.take(2).map((tag) => Container(
                              margin: const EdgeInsets.only(left: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: NexoColors.surface,
                                borderRadius: NexoShapes.full,
                              ),
                              child: Text(
                                tag.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    color: NexoColors.textMuted,
                                    letterSpacing: 0.5),
                              ),
                            )),
                      if (note.sharedWith.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Icon(Icons.people_outline_rounded,
                              size: 14, color: NexoColors.primaryDark),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Shopping List Card ───────────────────────────────────────────────────────
class _ShoppingCard extends StatelessWidget {
  final NexoNote note;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const _ShoppingCard(
      {required this.note, required this.onTap, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    final checked = note.items.where((i) => i.isChecked).length;
    final total = note.items.length;

    return Material(
      color: NexoColors.white,
      borderRadius: NexoShapes.medium,
      elevation: 1,
      shadowColor: NexoColors.black.withValues(alpha: 0.08),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: NexoShapes.medium,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: NexoShapes.medium,
            border:
                Border.all(color: NexoColors.success.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 16, color: NexoColors.success),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      note.title,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: NexoColors.textMain),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (note.isPrimaryShoppingList)
                    const Icon(Icons.star_rounded,
                        size: 16, color: Color(0xFFFACC15)),
                ],
              ),
              const SizedBox(height: 10),
              // Preview of items
              ...note.items.take(3).map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(
                          item.isChecked
                              ? Icons.check_circle_rounded
                              : Icons.radio_button_unchecked_rounded,
                          size: 14,
                          color: item.isChecked
                              ? NexoColors.success
                              : NexoColors.textMuted,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.text,
                            style: TextStyle(
                              fontSize: 12,
                              color: item.isChecked
                                  ? NexoColors.textMuted
                                  : NexoColors.textSub,
                              decoration: item.isChecked
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )),
              if (note.items.length > 3)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '+${note.items.length - 3} más',
                    style: const TextStyle(
                        fontSize: 11,
                        color: NexoColors.textMuted,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              const SizedBox(height: 8),
              // Progress bar
              ClipRRect(
                borderRadius: NexoShapes.full,
                child: LinearProgressIndicator(
                  value: total > 0 ? checked / total : 0,
                  backgroundColor: NexoColors.surface,
                  valueColor: const AlwaysStoppedAnimation(NexoColors.success),
                  minHeight: 4,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '$checked/$total completados',
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: NexoColors.textMuted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Utility ──────────────────────────────────────────────────────────────────
String _formatDate(DateTime? date) {
  if (date == null) return '';
  final now = DateTime.now();
  final diff = now.difference(date);
  if (diff.inDays == 0) return 'Hoy';
  if (diff.inDays == 1) return 'Ayer';
  if (diff.inDays < 7) return 'Hace ${diff.inDays}d';
  return '${date.day}/${date.month}/${date.year}';
}
