import 'package:flutter/material.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/meals/domain/meal_plan_model.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RecipeModal extends StatelessWidget {
  final NexoRecipe recipe;
  final String slotLabel;

  const RecipeModal({super.key, required this.recipe, required this.slotLabel});

  static void show(BuildContext context, NexoRecipe recipe, String slotLabel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RecipeModal(recipe: recipe, slotLabel: slotLabel),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.85;

    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: NexoColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // Header sticky
          Container(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
            decoration: BoxDecoration(
              color: NexoColors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              boxShadow: [
                BoxShadow(
                  color: NexoColors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40, height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: NexoColors.surfaceDark,
                    borderRadius: NexoShapes.full,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            slotLabel.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w900,
                              color: NexoColors.primaryDark, letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            recipe.name,
                            style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w800,
                              color: NexoColors.textMain, height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: NexoColors.textMuted),
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(
                        backgroundColor: NexoColors.surface,
                      ),
                    ),
                  ],
                ),
                if (recipe.description != null && recipe.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      recipe.description!,
                      style: const TextStyle(fontSize: 14, color: NexoColors.textSub, height: 1.4),
                    ),
                  ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem(Icons.timer_outlined, '${recipe.prepTimeMinutes + (recipe.cookTimeMinutes ?? 0)} min'),
                    Container(width: 1, height: 24, color: NexoColors.divider),
                    _buildStatItem(Icons.restaurant_outlined, '${recipe.servings} raciones'),
                    Container(width: 1, height: 24, color: NexoColors.divider),
                    _buildStatItem(Icons.bar_chart_rounded, recipe.difficulty ?? 'Fácil'),
                  ],
                ),
              ],
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Preparación',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: NexoColors.textMain)),
                  const SizedBox(height: 16),
                  ...recipe.steps.asMap().entries.map((entry) {
                    final index = entry.key + 1;
                    final step = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 28, height: 28,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: NexoColors.primary.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Text('$index',
                              style: const TextStyle(fontWeight: FontWeight.w800, color: NexoColors.primaryDark)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(step,
                                style: const TextStyle(fontSize: 15, color: NexoColors.textSub, height: 1.5)),
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.1),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18, color: NexoColors.textMuted),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: NexoColors.textSub)),
      ],
    );
  }
}

class IngredientsModal extends StatelessWidget {
  final NexoMeal meal;

  const IngredientsModal({super.key, required this.meal});

  static void show(BuildContext context, NexoMeal meal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => IngredientsModal(meal: meal),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.7;
    final ingredients = meal.aiGeneratedIngredients ?? meal.recipe.ingredients ?? [];

    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: NexoColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // Header sticky
          Container(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
            decoration: BoxDecoration(
              color: NexoColors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              border: Border(bottom: BorderSide(color: NexoColors.divider.withValues(alpha: 0.5))),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40, height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: NexoColors.surfaceDark,
                    borderRadius: NexoShapes.full,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Ingredientes',
                      style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w800,
                        color: NexoColors.textMain,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: NexoColors.textMuted),
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(backgroundColor: NexoColors.surface),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Scrollable content
          Expanded(
            child: ingredients.isEmpty
              ? const Center(child: Text('No hay ingredientes.', style: TextStyle(color: NexoColors.textMuted)))
              : ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: ingredients.length,
                  itemBuilder: (context, index) {
                    final item = ingredients[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: NexoColors.surface,
                        borderRadius: NexoShapes.medium,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.eco_rounded, size: 20, color: NexoColors.success.withValues(alpha: 0.7)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              item.name,
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: NexoColors.textMain),
                            ),
                          ),
                          if (item.quantity != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: NexoColors.white,
                                borderRadius: NexoShapes.full,
                                border: Border.all(color: NexoColors.divider),
                              ),
                              child: Text(
                                '${item.quantity} ${item.unit ?? ''}',
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: NexoColors.textSub),
                              ),
                            ),
                        ],
                      ).animate().fadeIn(delay: (index * 30).ms),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}
