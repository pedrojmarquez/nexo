import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/meals/domain/meal_plan_model.dart';
import 'package:nexo/features/meals/presentation/providers/meals_provider.dart';
import 'package:nexo/features/meals/presentation/widgets/recipe_modal.dart';

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
  static const _dayNames = {
    Weekday.monday: 'Lunes', Weekday.tuesday: 'Martes', Weekday.wednesday: 'Miércoles',
    Weekday.thursday: 'Jueves', Weekday.friday: 'Viernes', Weekday.saturday: 'Sábado',
    Weekday.sunday: 'Domingo',
  };

  static const _slotLabels = {
    MealSlot.breakfast: '🌅 Desayuno', MealSlot.lunch: '☀️ Comida',
    MealSlot.dinner: '🌙 Cena', MealSlot.snack: '🍎 Snack',
  };

  static const _slotColors = {
    MealSlot.breakfast: Color(0xFFF59E0B), MealSlot.lunch: Color(0xFF10B981),
    MealSlot.dinner: Color(0xFF6366F1), MealSlot.snack: Color(0xFFEC4899),
  };

  // Estado local para loadings individuales
  final Map<String, bool> _loadingMap = {};

  @override
  Widget build(BuildContext context) {
    final dayName = _dayNames[widget.weekday] ?? '';
    final dateStr = '${widget.date.day}/${widget.date.month}';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: NexoColors.white,
        borderRadius: NexoShapes.large,
        boxShadow: [BoxShadow(color: NexoColors.black.withValues(alpha: 0.08), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 20, 16, 20),
            decoration: BoxDecoration(
              color: NexoColors.primary.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(NexoShapes.radiusLG)),
            ),
            child: Row(
              children: [
                Text(dayName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: NexoColors.textMain)),
                const SizedBox(width: 10),
                Text(dateStr, style: const TextStyle(fontSize: 14, color: NexoColors.textMuted, fontWeight: FontWeight.w600)),
                const Spacer(),
                IconButton(onPressed: widget.onAddMeal, icon: const Icon(Icons.add_circle_outline_rounded, color: NexoColors.primaryDark), iconSize: 28),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: MealSlot.values.map((slot) {
                final meal = widget.meals.cast<DayMeal?>().firstWhere((m) => m?.slot == slot, orElse: () => null);
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
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: NexoColors.surface, borderRadius: NexoShapes.medium, border: Border.all(color: NexoColors.divider, width: 0.8)),
        child: Row(
          children: [
            Text(slotLabel, style: TextStyle(fontSize: 14, color: slotColor, fontWeight: FontWeight.w700)),
            const Spacer(),
            const Text('Sin comida', style: TextStyle(fontSize: 12, color: NexoColors.textMuted)),
          ],
        ),
      );
    }

    final hasAiRecipe = meal.aiGeneratedRecipe != null;
    final hasAiIngredients = meal.aiGeneratedIngredients != null;
    final hasAnyRecipe = hasAiRecipe || meal.recipe.steps.isNotEmpty;
    final isRecipeLoading = _loadingMap['${meal.id}_recipe'] ?? false;
    final isIngredientsLoading = _loadingMap['${meal.id}_ingredients'] ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: NexoColors.white,
        borderRadius: NexoShapes.medium,
        border: Border.all(color: slotColor.withValues(alpha: 0.4), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: slotColor.withValues(alpha: 0.15), borderRadius: NexoShapes.full),
                  child: Text(slotLabel, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: slotColor)),
                ),
                const Spacer(),
                if (hasAiRecipe) const Icon(Icons.auto_awesome, size: 14, color: NexoColors.primaryDark),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              meal.recipe.name, 
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: NexoColors.textMain, height: 1.1),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (meal.recipe.description?.isNotEmpty == true)
              Padding(
                 padding: const EdgeInsets.only(top: 6),
                child: Text(meal.recipe.description!, style: const TextStyle(fontSize: 13, color: NexoColors.textSub, height: 1.4), maxLines: 2, overflow: TextOverflow.ellipsis),
              ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    icon: Icons.restaurant_menu_rounded,
                    label: hasAnyRecipe ? 'VER RECETA' : 'IA RECETA',
                    color: NexoColors.primaryDark,
                    isLoading: isRecipeLoading,
                    onTap: () async {
                      if (hasAiRecipe) {
                        try {
                          // Inyectamos ID para evitar error de parseo ya que Gemini no lo devuelve
                          final recipeMap = Map<String, dynamic>.from(meal.aiGeneratedRecipe!);
                          recipeMap['id'] = meal.id;
                          final recipe = NexoRecipe.fromJson(recipeMap);
                          RecipeModal.show(context, recipe, slotLabel);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al cargar la receta generada.')));
                        }
                      } else if (meal.recipe.steps.isNotEmpty) {
                        RecipeModal.show(context, meal.recipe, slotLabel);
                      } else {
                        _startLoading('${meal.id}_recipe');
                        await ref.read(mealsControllerProvider.notifier).generateRecipeForMeal(widget.planId!, meal);
                        _stopLoading('${meal.id}_recipe');
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.list_alt_rounded,
                    label: hasAiIngredients ? 'INGREDIENTES' : 'IA LISTA',
                    color: NexoColors.success,
                    isLoading: isIngredientsLoading,
                    onTap: () async {
                      if (hasAiIngredients) {
                        IngredientsModal.show(context, meal);
                      } else {
                        _startLoading('${meal.id}_ingredients');
                        await ref.read(mealsControllerProvider.notifier).generateIngredientsForMeal(widget.planId!, meal);
                        _stopLoading('${meal.id}_ingredients');
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                _ActionButton(
                  icon: Icons.delete_outline_rounded,
                  color: NexoColors.error,
                  isIconOnly: true,
                  onTap: () => _removeMeal(meal.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _startLoading(String key) => setState(() => _loadingMap[key] = true);
  void _stopLoading(String key) => setState(() => _loadingMap[key] = false);

  Future<void> _removeMeal(String mealId) async {
    if (widget.planId == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar comida?'),
        content: const Text('Se quitará esta comida del plan semanal.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('CANCELAR')),
          TextButton(onPressed: () => Navigator.pop(context, true), style: TextButton.styleFrom(foregroundColor: NexoColors.error), child: const Text('ELIMINAR')),
        ],
      ),
    );
    if (confirmed == true) await ref.read(mealsControllerProvider.notifier).removeMealFromPlan(widget.planId!, mealId);
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isIconOnly;
  final bool isLoading;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, this.label = '', required this.color, this.isIconOnly = false, this.isLoading = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withValues(alpha: 0.1),
      borderRadius: NexoShapes.small,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: NexoShapes.small,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox(
                  height: 14, width: 14,
                  child: CircularProgressIndicator(strokeWidth: 2, color: color),
                )
              else
                Icon(icon, size: 16, color: color),
              if (!isIconOnly && !isLoading) ...[
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: color, letterSpacing: 0.5),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
              if (!isIconOnly && isLoading) ...[
                const SizedBox(width: 8),
                const Text('CARGANDO...', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: NexoColors.textMuted, letterSpacing: 1.0)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
