import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/meals/domain/meal_plan_model.dart';
import 'package:nexo/features/notes/domain/note_model.dart';
import 'package:nexo/features/notes/presentation/providers/notes_provider.dart';
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

  String _getDifficultyLabel(RecipeDifficulty difficulty) {
    switch (difficulty) {
      case RecipeDifficulty.easy: return 'Fácil';
      case RecipeDifficulty.medium: return 'Media';
      case RecipeDifficulty.hard: return 'Difícil';
    }
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
          Container(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
            decoration: BoxDecoration(
              color: NexoColors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              boxShadow: [BoxShadow(color: NexoColors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40, height: 4, margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(color: NexoColors.surfaceDark, borderRadius: NexoShapes.full),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(slotLabel.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: NexoColors.primaryDark, letterSpacing: 1.5)),
                          const SizedBox(height: 6),
                          Text(recipe.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: NexoColors.textMain, height: 1.2)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: NexoColors.textMuted),
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(backgroundColor: NexoColors.surface),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem(Icons.timer_outlined, '${recipe.prepTimeMinutes + recipe.cookTimeMinutes} min'),
                    Container(width: 1, height: 20, color: NexoColors.divider),
                    _buildStatItem(Icons.restaurant_outlined, '${recipe.servings} raciones'),
                    Container(width: 1, height: 20, color: NexoColors.divider),
                    _buildStatItem(Icons.bar_chart_rounded, _getDifficultyLabel(recipe.difficulty)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('PREPARACIÓN PASO A PASO', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.2, color: NexoColors.textMuted)),
                  const SizedBox(height: 20),
                  if (recipe.steps.isEmpty)
                    const Center(child: Padding(padding: EdgeInsets.all(40), child: Text('No hay pasos detallados.', style: TextStyle(color: NexoColors.textMuted))))
                  else
                    ...recipe.steps.asMap().entries.map((entry) {
                      final index = entry.key + 1;
                      final step = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 32, height: 32, alignment: Alignment.center,
                              decoration: BoxDecoration(color: NexoColors.primary.withValues(alpha: 0.2), shape: BoxShape.circle),
                              child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w900, color: NexoColors.primaryDark)),
                            ),
                            const SizedBox(width: 16),
                            Expanded(child: Text(step, style: const TextStyle(fontSize: 16, color: NexoColors.textMain, height: 1.55))),
                          ],
                        ).animate().fadeIn(delay: (index * 60).ms).slideX(begin: 0.1),
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
        Icon(icon, size: 18, color: NexoColors.primaryDark.withValues(alpha: 0.7)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: NexoColors.textMain)),
      ],
    );
  }
}

class IngredientsModal extends ConsumerWidget {
  final DayMeal meal;
  const IngredientsModal({super.key, required this.meal});

  static void show(BuildContext context, DayMeal meal) {
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (_) => IngredientsModal(meal: meal));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height * 0.8;
    final ingredients = meal.aiGeneratedIngredients ?? meal.recipe.ingredients;
    final notesAsync = ref.watch(userNotesProvider);

    return Container(
      height: height,
      decoration: const BoxDecoration(color: NexoColors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
            decoration: BoxDecoration(color: NexoColors.white, borderRadius: const BorderRadius.vertical(top: Radius.circular(32)), border: Border(bottom: BorderSide(color: NexoColors.divider.withValues(alpha: 0.5)))),
            child: Column(
              children: [
                Container(width: 40, height: 4, margin: const EdgeInsets.only(bottom: 20), decoration: BoxDecoration(color: NexoColors.surfaceDark, borderRadius: NexoShapes.full)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Ingredientes', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: NexoColors.textMain)),
                    IconButton(icon: const Icon(Icons.close_rounded), onPressed: () => Navigator.pop(context), style: IconButton.styleFrom(backgroundColor: NexoColors.surface)),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: ingredients.isEmpty ? null : () async {
                    final noteItems = ingredients.map((i) {
                      final name = (i is NexoIngredient) ? i.name : ((i as Map)['name'] ?? 'Ingrediente');
                      final qty = (i is NexoIngredient) ? i.quantity.toString() : (i as Map)['quantity']?.toString();
                      final unit = (i is NexoIngredient) ? i.unit : (i as Map)['unit'];
                      return NoteItem(id: UniqueKey().toString(), text: '$name ($qty ${unit ?? ''})');
                    }).toList();
                    
                    await ref.read(notesControllerProvider.notifier).addItemsToPrimaryShoppingList(noteItems);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ingredientes añadidos (sin duplicados)'), behavior: SnackBarBehavior.floating));
                    }
                  },
                  icon: const Icon(Icons.add_shopping_cart_rounded),
                  label: const Text('AÑADIR TODO A LA LISTA', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: NexoColors.primary,
                    foregroundColor: NexoColors.textMain,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: NexoShapes.medium),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: notesAsync.when(
              data: (notes) {
                final primaryList = notes.where((n) => n.isPrimaryShoppingList).firstOrNull;
                final existingItems = primaryList?.items.map((e) => e.text.toLowerCase().trim()).toSet() ?? {};

                return ingredients.isEmpty
                  ? const Center(child: Text('No hay ingredientes listados.', style: TextStyle(color: NexoColors.textMuted)))
                  : ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: ingredients.length,
                      itemBuilder: (context, index) {
                        final item = ingredients[index];
                        final String name = (item is NexoIngredient) ? item.name : ((item as Map)['name'] ?? 'Ingrediente');
                        final String? qty = (item is NexoIngredient) ? item.quantity.toString() : (item as Map)['quantity']?.toString();
                        final String? unit = (item is NexoIngredient) ? item.unit : (item as Map)['unit'];
                        final displayText = '$name ($qty ${unit ?? ''})';
                        final bool isInList = existingItems.any((e) => e.contains(name.toLowerCase().trim()));

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isInList ? NexoColors.surface : NexoColors.white, 
                            borderRadius: NexoShapes.medium, 
                            border: Border.all(color: isInList ? NexoColors.divider : NexoColors.divider.withValues(alpha: 0.3))
                          ),
                          child: Row(
                            children: [
                              Icon(isInList ? Icons.check_circle_rounded : Icons.circle, size: isInList ? 16 : 8, color: isInList ? NexoColors.success : NexoColors.primaryDark),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  name, 
                                  style: TextStyle(
                                    fontSize: 15, 
                                    fontWeight: isInList ? FontWeight.w500 : FontWeight.w700, 
                                    color: isInList ? NexoColors.textMuted : NexoColors.textMain,
                                    decoration: isInList ? TextDecoration.lineThrough : null,
                                  )
                                )
                              ),
                              if (qty != null && qty != 'null' && !isInList)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(color: NexoColors.surface, borderRadius: NexoShapes.full),
                                  child: Text('$qty ${unit ?? ''}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: NexoColors.primaryDark)),
                                ),
                              const SizedBox(width: 8),
                              if (!isInList)
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  icon: const Icon(Icons.add_circle_outline_rounded, color: NexoColors.success, size: 24),
                                  onPressed: () async {
                                    await ref.read(notesControllerProvider.notifier).addItemsToPrimaryShoppingList([
                                      NoteItem(id: UniqueKey().toString(), text: displayText)
                                    ]);
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Añadido: $name'), behavior: SnackBarBehavior.floating, duration: 1.seconds));
                                    }
                                  },
                                ),
                            ],
                          ),
                        ).animate().fadeIn(delay: (index * 30).ms).slideX(begin: 0.05);
                      },
                    );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Center(child: Text('Error al cargar la lista de la compra')),
            ),
          ),
        ],
      ),
    );
  }
}
