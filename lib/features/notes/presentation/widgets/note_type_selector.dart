import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// Note Type Selector — Bottom sheet para elegir qué tipo de nota crear
/// ─────────────────────────────────────────────────────────────────────────────
class NoteTypeSelector extends StatelessWidget {
  const NoteTypeSelector({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const NoteTypeSelector(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: NexoColors.white,
        borderRadius: NexoShapes.bottomSheet,
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: NexoColors.surfaceDark,
              borderRadius: NexoShapes.full,
            ),
          ),

          const Text(
            'Crear nueva',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: NexoColors.textMain,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '¿Qué te gustaría crear?',
            style: TextStyle(color: NexoColors.textSub, fontSize: 14),
          ),
          const SizedBox(height: 28),

          // Opciones
          _NoteTypeOption(
            icon: Icons.edit_note_rounded,
            iconColor: NexoColors.primaryDark,
            bgColor: NexoColors.primary.withValues(alpha: 0.12),
            title: 'Nota estándar',
            subtitle: 'Editor con herramientas de formato',
            onTap: () {
              Navigator.pop(context);
              context.push('/notas/nuevo', extra: 'text');
            },
          ),
          const SizedBox(height: 12),
          _NoteTypeOption(
            icon: Icons.sticky_note_2_rounded,
            iconColor: const Color(0xFFE67E22),
            bgColor: const Color(0xFFE67E22).withValues(alpha: 0.12),
            title: 'Post-it rápido',
            subtitle: 'Nota adhesiva colorida para ideas rápidas',
            onTap: () {
              Navigator.pop(context);
              context.push('/notas/postit');
            },
          ),
          const SizedBox(height: 12),
          _NoteTypeOption(
            icon: Icons.checklist_rounded,
            iconColor: NexoColors.success,
            bgColor: NexoColors.success.withValues(alpha: 0.12),
            title: 'Lista de la compra',
            subtitle: 'Lista interactiva con opción de compartir',
            onTap: () {
              Navigator.pop(context);
              context.push('/notas/lista');
            },
          ),
        ],
      ),
    );
  }
}

class _NoteTypeOption extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _NoteTypeOption({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: NexoColors.surface,
      borderRadius: NexoShapes.medium,
      child: InkWell(
        onTap: onTap,
        borderRadius: NexoShapes.medium,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: NexoShapes.medium,
                ),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: NexoColors.textMain,
                        )),
                    const SizedBox(height: 3),
                    Text(subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: NexoColors.textMuted,
                        )),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  color: NexoColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}
