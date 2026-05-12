import 'package:flutter/material.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// RecipeView — Visualización estilizada de receta generada por IA
/// Se expande inline dentro de la card del día
/// ─────────────────────────────────────────────────────────────────────────────
class RecipeView extends StatelessWidget {
  final Map<String, dynamic> recipe;
  final VoidCallback onRegenerate;

  const RecipeView({
    super.key,
    required this.recipe,
    required this.onRegenerate,
  });

  @override
  Widget build(BuildContext context) {
    final name = recipe['name'] ?? '';
    final description = recipe['description'] ?? '';
    final difficulty = recipe['difficulty'] ?? 'easy';
    final prepTime = recipe['prepTimeMinutes'] ?? 0;
    final cookTime = recipe['cookTimeMinutes'] ?? 0;
    final servings = recipe['servings'] ?? 2;
    final steps = List<String>.from(recipe['steps'] ?? []);
    final tips = List<String>.from(recipe['tips'] ?? []);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: NexoColors.surface,
        borderRadius: NexoShapes.medium,
        border:
            Border.all(color: NexoColors.primaryDark.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Icon(Icons.menu_book_rounded,
                  color: NexoColors.primaryDark, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: NexoColors.textMain),
                ),
              ),
              IconButton(
                onPressed: onRegenerate,
                icon: const Icon(Icons.refresh_rounded,
                    size: 18, color: NexoColors.textMuted),
                tooltip: 'Generate new recipe',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
            ],
          ),

          if (description.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(description,
                style: const TextStyle(
                    fontSize: 13,
                    color: NexoColors.textSub,
                    fontStyle: FontStyle.italic)),
          ],

          const SizedBox(height: 12),

          // Info chips
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _InfoChip(icon: Icons.timer_outlined, label: '${prepTime}m prep'),
              _InfoChip(
                  icon: Icons.local_fire_department_outlined,
                  label: '${cookTime}m cook'),
              _InfoChip(
                  icon: Icons.people_outline, label: '$servings servings'),
              _InfoChip(
                icon: Icons.signal_cellular_alt_rounded,
                label: difficulty,
                color: difficulty == 'easy'
                    ? NexoColors.success
                    : difficulty == 'hard'
                        ? NexoColors.error
                        : NexoColors.warning,
              ),
            ],
          ),

          if (steps.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(height: 1, color: NexoColors.divider),
            const SizedBox(height: 16),
            const Text('Steps',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: NexoColors.textMain)),
            const SizedBox(height: 10),
            ...steps.asMap().entries.map((entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: NexoColors.primaryDark.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${entry.key + 1}',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: NexoColors.primaryDark),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: const TextStyle(
                              fontSize: 13,
                              color: NexoColors.textSub,
                              height: 1.5),
                        ),
                      ),
                    ],
                  ),
                )),
          ],

          if (tips.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: NexoColors.primary.withValues(alpha: 0.08),
                borderRadius: NexoShapes.small,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.lightbulb_outline_rounded,
                          size: 16, color: NexoColors.primaryDark),
                      SizedBox(width: 6),
                      Text('Tips',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: NexoColors.primaryDark)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ...tips.map((tip) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• ',
                                style: TextStyle(
                                    color: NexoColors.primaryDark,
                                    fontWeight: FontWeight.w800)),
                            Expanded(
                                child: Text(tip,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: NexoColors.textSub))),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const _InfoChip({required this.icon, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final chipColor = color ?? NexoColors.textMuted;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1),
        borderRadius: NexoShapes.full,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: chipColor),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w600, color: chipColor)),
        ],
      ),
    );
  }
}
