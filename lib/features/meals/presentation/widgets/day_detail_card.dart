import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/meals/domain/meal_plan_model.dart';
import 'package:nexo/features/meals/presentation/providers/meals_provider.dart';
import 'package:nexo/features/meals/presentation/widgets/recipe_view.dart';
import 'package:nexo/features/meals/presentation/widgets/ingredients_view.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// DayDetailCard — Card completa de un día con sus slots de comida
/// Se usa dentro del PageView carousel
/// ─────────────────────────────────────────────────────────────────────────────
class DayDetailCard extends ConsumerStatefulWidget {
  final DateTime date;
  final Weekday weekday;
  final List<DayMeal> meals;
  final String? planId;
  final VoidCallback onAddMeal;

  const DayDetailCard({
    super.key,
    required this.date,
    required this.weekday,
    required this.meals,
    required this.planId,
    required this.onAddMeal,
  });

  @override
  ConsumerState<DayDetailCard> createState() => _DayDetailCardState();
}

class _DayDetailCardState extends ConsumerState<DayDetailCard> {
  // Track which slots have expanded recipe/ingredients
  final Set<String> _expandedRecipes = {};
  final Set<String> _expandedIngredients = {};

  static const _dayNames = {
    Weekday.monday: 'Monday',
    Weekday.tuesday: 'Tuesday',
    Weekday.wednesday: 'Wednesday',
    Weekday.thursday: 'Thursday',
    Weekday.friday: 'Friday',
    Weekday.saturday: 'Saturday',
    Weekday.sunday: 'Sunday',
  };

  static const _slotLabels = {
    MealSlot.breakfast: '🌅 Breakfast',
    MealSlot.lunch: '☀️ Lunch',
    MealSlot.dinner: '🌙 Dinner',
    MealSlot.snack: '🍎 Snack',
  };

  static const _slotColors = {
    MealSlot.breakfast: Color(0xFFF59E0B),
    MealSlot.lunch: Color(0xFF10B981),
    MealSlot.dinner: Color(0xFF6366F1),
    MealSlot.snack: Color(0xFFEC4899),
  };

  @override
  Widget build(BuildContext context) {
    final dayName = _dayNames[widget.weekday] ?? '';
    final dateStr = '${widget.date.day}/${widget.date.month}';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: NexoColors.white,
        borderRadius: NexoShapes.large,
        boxShadow: [
          BoxShadow(
            color: NexoColors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Day header ──────────────────────────────────────────
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 12),
            decoration: BoxDecoration(
              color: NexoColors.primary.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(NexoShapes.radiusLG),
                topRight: Radius.circular(NexoShapes.radiusLG),
              ),
            ),
            child: Row(
              children: [
                Text(dayName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: NexoColors.textMain,
                    )),
                const SizedBox(width: 8),
                Text(dateStr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: NexoColors.textMuted,
                      fontWeight: FontWeight.w500,
                    )),
                const Spacer(),
                IconButton(
                  onPressed: widget.onAddMeal,
                  icon: const Icon(Icons.add_circle_outline_rounded,
                      color: NexoColors.primaryDark),
                  iconSize: 22,
                ),
              ],
            ),
          ),

          // ── Meal slots ──────────────────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              children: MealSlot.values.map((slot) {
                final meal = widget.meals.cast<DayMeal?>().firstWhere(
                      (m) => m?.slot == slot,
                      orElse: () => null,
                    );
                return _buildSlot(slot, meal);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlot(MealSlot slot, DayMeal? meal) {
    final slotColor = _slotColors[slot] ?? NexoColors.textMuted;
    final slotLabel = _slotLabels[slot] ?? slot.name;

    if (meal == null) {
      // Empty slot
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: NexoColors.surface,
          borderRadius: NexoShapes.small,
          border: Border.all(color: NexoColors.divider, width: 0.5),
        ),
        child: Row(
          children: [
            Text(slotLabel,
                style: TextStyle(
                    fontSize: 13,
                    color: slotColor,
                    fontWeight: FontWeight.w600)),
            const Spacer(),
            Text('Empty',
                style: TextStyle(
                    fontSize: 12,
                    color: NexoColors.textMuted.withValues(alpha: 0.6))),
          ],
        ),
      );
    }

    final hasRecipe = meal.aiGeneratedRecipe != null;
    final hasIngredients = meal.aiGeneratedIngredients != null;
    final isRecipeExpanded = _expandedRecipes.contains(meal.id);
    final isIngredientsExpanded = _expandedIngredients.contains(meal.id);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: NexoColors.white,
        borderRadius: NexoShapes.medium,
        border: Border.all(color: slotColor.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Meal info
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Slot badge + meal name
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: slotColor.withValues(alpha: 0.12),
                        borderRadius: NexoShapes.full,
                      ),
                      child: Text(slotLabel,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: slotColor)),
                    ),
                    if (hasRecipe)
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Icon(Icons.menu_book_rounded,
                            size: 14,
                            color:
                                NexoColors.primaryDark.withValues(alpha: 0.5)),
                      ),
                    if (hasIngredients)
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Icon(Icons.shopping_basket_outlined,
                            size: 14,
                            color: NexoColors.success.withValues(alpha: 0.5)),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  meal.recipe.name,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: NexoColors.textMain),
                ),
                if (meal.recipe.description != null &&
                    meal.recipe.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      meal.recipe.description!,
                      style: const TextStyle(
                          fontSize: 12, color: NexoColors.textSub),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                if (meal.recipe.prepTimeMinutes > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Row(
                      children: [
                        const Icon(Icons.timer_outlined,
                            size: 14, color: NexoColors.textMuted),
                        const SizedBox(width: 4),
                        Text('${meal.recipe.prepTimeMinutes} min',
                            style: const TextStyle(
                                fontSize: 12, color: NexoColors.textMuted)),
                      ],
                    ),
                  ),

                const SizedBox(height: 10),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.menu_book_rounded,
                        label: hasRecipe ? 'View Recipe' : 'Generate Recipe',
                        color: NexoColors.primaryDark,
                        isLoading: false,
                        onTap: () async {
                          if (hasRecipe && !isRecipeExpanded) {
                            setState(() => _expandedRecipes.add(meal.id));
                          } else if (hasRecipe && isRecipeExpanded) {
                            setState(() => _expandedRecipes.remove(meal.id));
                          } else {
                            await _generateRecipe(meal);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.shopping_basket_outlined,
                        label: hasIngredients
                            ? 'View Ingredients'
                            : 'List Ingredients',
                        color: NexoColors.success,
                        isLoading: false,
                        onTap: () async {
                          if (hasIngredients && !isIngredientsExpanded) {
                            setState(() => _expandedIngredients.add(meal.id));
                          } else if (hasIngredients && isIngredientsExpanded) {
                            setState(
                                () => _expandedIngredients.remove(meal.id));
                          } else {
                            await _generateIngredients(meal);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Expanded Recipe ──────────────────────────────────────
          if (isRecipeExpanded && hasRecipe)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: RecipeView(
                recipe: meal.aiGeneratedRecipe!,
                onRegenerate: () => _generateRecipe(meal),
              ),
            ),

          // ── Expanded Ingredients ─────────────────────────────────
          if (isIngredientsExpanded && hasIngredients)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: IngredientsView(
                ingredients: meal.aiGeneratedIngredients!,
                onRegenerate: () => _generateIngredients(meal),
                onAddToShoppingList: (text) async {
                  await ref
                      .read(mealsControllerProvider.notifier)
                      .addIngredientToShoppingList(text);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Added: $text'),
                          duration: const Duration(seconds: 1)),
                    );
                  }
                },
                onAddAllMissing: (ingredients) async {
                  await ref
                      .read(mealsControllerProvider.notifier)
                      .addAllMissingIngredients(ingredients);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('All missing ingredients added!')),
                    );
                  }
                },
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _generateRecipe(DayMeal meal) async {
    if (widget.planId == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Generating recipe...'),
          duration: Duration(seconds: 2)),
    );

    await ref
        .read(mealsControllerProvider.notifier)
        .generateRecipeForMeal(widget.planId!, meal);
    if (mounted) {
      setState(() => _expandedRecipes.add(meal.id));
    }
  }

  Future<void> _generateIngredients(DayMeal meal) async {
    if (widget.planId == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Listing ingredients...'),
          duration: Duration(seconds: 2)),
    );

    await ref
        .read(mealsControllerProvider.notifier)
        .generateIngredientsForMeal(widget.planId!, meal);
    if (mounted) {
      setState(() => _expandedIngredients.add(meal.id));
    }
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isLoading;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withValues(alpha: 0.08),
      borderRadius: NexoShapes.small,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: NexoShapes.small,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox(
                    width: 14,
                    height: 14,
                    child:
                        CircularProgressIndicator(color: color, strokeWidth: 2))
              else
                Icon(icon, size: 15, color: color),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w700, color: color),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
