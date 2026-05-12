import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/notes/domain/note_model.dart';
import 'package:nexo/features/notes/presentation/providers/notes_provider.dart';
import 'package:nexo/features/auth/presentation/providers/auth_provider.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// IngredientsView — Lista de ingredientes con cross-reference a la compra
/// Items ya en la lista de compra aparecen tachados. Los que faltan tienen "+"
/// ─────────────────────────────────────────────────────────────────────────────
class IngredientsView extends ConsumerWidget {
  final List<Map<String, dynamic>> ingredients;
  final VoidCallback onRegenerate;
  final Future<void> Function(String ingredientText) onAddToShoppingList;
  final Future<void> Function(List<Map<String, dynamic>> ingredients)
      onAddAllMissing;

  const IngredientsView({
    super.key,
    required this.ingredients,
    required this.onRegenerate,
    required this.onAddToShoppingList,
    required this.onAddAllMissing,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).valueOrNull;
    final notesAsync = ref.watch(userNotesProvider);

    // Obtener items de la lista de compra principal
    final shoppingItems = notesAsync.whenOrNull(
          data: (notes) {
            final primaryList = notes.cast<NexoNote?>().firstWhere(
                  (n) => n?.isPrimaryShoppingList == true,
                  orElse: () => null,
                );
            if (primaryList == null) return <String>{};
            return primaryList.items.map((i) => i.text.toLowerCase()).toSet();
          },
        ) ??
        <String>{};

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: NexoColors.surface,
        borderRadius: NexoShapes.medium,
        border: Border.all(color: NexoColors.success.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Icon(Icons.shopping_basket_outlined,
                  color: NexoColors.success, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text('Ingredients',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: NexoColors.textMain)),
              ),
              IconButton(
                onPressed: onRegenerate,
                icon: const Icon(Icons.refresh_rounded,
                    size: 18, color: NexoColors.textMuted),
                tooltip: 'Generate new list',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Ingredient list
          ...ingredients.map((ing) {
            final name = ing['name'] ?? '';
            final qty = ing['quantity'] ?? 0;
            final unit = ing['unit'] ?? '';
            final category = ing['category'] ?? '';
            final displayText = '$qty $unit $name';
            final isInShoppingList =
                shoppingItems.contains(displayText.toLowerCase());

            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: NexoColors.divider, width: 0.5)),
              ),
              child: Row(
                children: [
                  // Status icon
                  Icon(
                    isInShoppingList
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked,
                    size: 18,
                    color: isInShoppingList
                        ? NexoColors.success
                        : NexoColors.textMuted,
                  ),
                  const SizedBox(width: 10),
                  // Quantity + unit
                  SizedBox(
                    width: 60,
                    child: Text(
                      '$qty $unit',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isInShoppingList
                            ? NexoColors.textMuted
                            : NexoColors.primaryDark,
                      ),
                    ),
                  ),
                  // Name
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 14,
                        color: isInShoppingList
                            ? NexoColors.textMuted
                            : NexoColors.textMain,
                        decoration: isInShoppingList
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
                  // Category badge
                  if (category.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color:
                            _getCategoryColor(category).withValues(alpha: 0.1),
                        borderRadius: NexoShapes.full,
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: _getCategoryColor(category)),
                      ),
                    ),
                  // Add to shopping list button
                  if (!isInShoppingList)
                    GestureDetector(
                      onTap: () => onAddToShoppingList(displayText),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: NexoColors.success.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add_rounded,
                            size: 16, color: NexoColors.success),
                      ),
                    ),
                ],
              ),
            );
          }),

          const SizedBox(height: 16),

          // Add all missing button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => onAddAllMissing(ingredients),
              icon: const Icon(Icons.add_shopping_cart_rounded, size: 18),
              label: const Text('Add all missing to shopping list',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
              style: OutlinedButton.styleFrom(
                foregroundColor: NexoColors.success,
                side: const BorderSide(color: NexoColors.success),
                shape: RoundedRectangleBorder(borderRadius: NexoShapes.small),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'verduras':
        return const Color(0xFF10B981);
      case 'frutas':
        return const Color(0xFFF59E0B);
      case 'carnes':
        return const Color(0xFFEF4444);
      case 'pescados':
        return const Color(0xFF3B82F6);
      case 'lácteos':
        return const Color(0xFF8B5CF6);
      case 'granos':
        return const Color(0xFFD97706);
      case 'especias':
        return const Color(0xFFEC4899);
      case 'aceites':
        return const Color(0xFF14B8A6);
      default:
        return NexoColors.textMuted;
    }
  }
}
