import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/meals/domain/meal_plan_model.dart';

class MealCard extends StatelessWidget {
  final DayMeal meal;
  final VoidCallback onTap;
  final VoidCallback onAddIngredients;

  const MealCard({
    super.key,
    required this.meal,
    required this.onTap,
    required this.onAddIngredients,
  });

  @override
  Widget build(BuildContext context) {
    final recipe = meal.recipe;
    final totalTime = recipe.prepTimeMinutes + recipe.cookTimeMinutes;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: NexoColors.white,
          borderRadius: NexoShapes.large,
          boxShadow: [
            BoxShadow(
              color: NexoColors.black.withValues(alpha: 0.05),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: NexoShapes.large,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Placeholder with Slot Label
              Stack(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: NexoColors.surface,
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=500&auto=format&fit=crop'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: NexoColors.white,
                        borderRadius: NexoShapes.small,
                      ),
                      child: Text(
                        _getSlotName(meal.slot),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: NexoColors.textMain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: NexoColors.textMain,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded,
                            size: 16, color: NexoColors.textSub),
                        const SizedBox(width: 4),
                        Text(
                          '$totalTime mins',
                          style: const TextStyle(
                              fontSize: 13,
                              color: NexoColors.textSub,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 24),
                        const Icon(Icons.local_fire_department_rounded,
                            size: 16, color: NexoColors.textSub),
                        const SizedBox(width: 4),
                        const Text(
                          '--- kcal', // Placeholder until model update
                          style: TextStyle(
                              fontSize: 13,
                              color: NexoColors.textSub,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: onAddIngredients,
                            icon: const Icon(Icons.list_alt_rounded, size: 18),
                            label: const Text('Ingredients'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: NexoColors.textMain,
                              side: const BorderSide(color: NexoColors.divider),
                              shape: RoundedRectangleBorder(
                                  borderRadius: NexoShapes.medium),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.auto_awesome_rounded,
                                size: 18),
                            label: const Text('Recipe'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: NexoColors.primary,
                              foregroundColor: NexoColors.textMain,
                              shape: RoundedRectangleBorder(
                                  borderRadius: NexoShapes.medium),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
    );
  }

  String _getSlotName(MealSlot slot) {
    switch (slot) {
      case MealSlot.breakfast:
        return 'Breakfast';
      case MealSlot.lunch:
        return 'Lunch';
      case MealSlot.dinner:
        return 'Dinner';
      case MealSlot.snack:
        return 'Snack';
    }
  }
}
