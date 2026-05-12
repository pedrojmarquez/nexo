import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nexo/features/auth/presentation/providers/auth_provider.dart';
import 'package:nexo/features/fast_input/presentation/providers/fast_input_provider.dart';
import 'package:nexo/features/meals/data/meals_repository.dart';
import 'package:nexo/features/meals/domain/meal_plan_model.dart';
import 'package:nexo/features/notes/presentation/providers/notes_provider.dart';
import 'package:nexo/features/notes/domain/note_model.dart';
import 'package:nexo/core/services/home_widget_service.dart';
import 'package:uuid/uuid.dart';

part 'meals_provider.g.dart';

/// Calcula el lunes de la semana actual
DateTime _getCurrentMonday() {
  final now = DateTime.now();
  final monday = now.subtract(Duration(days: now.weekday - 1));
  return DateTime(monday.year, monday.month, monday.day);
}

/// Semana actualmente seleccionada (lunes de esa semana)
final selectedWeekProvider =
    StateProvider<DateTime>((ref) => _getCurrentMonday());

@riverpod
MealsRepository mealsRepository(Ref ref) => MealsRepository();

/// Plan de la semana seleccionada
@riverpod
Stream<NexoMealPlan?> activeMealPlan(Ref ref) {
  final user = ref.watch(authStateChangesProvider).valueOrNull;
  if (user == null) return Stream.value(null);

  final weekStart = ref.watch(selectedWeekProvider);
  return ref
      .watch(mealsRepositoryProvider)
      .watchMealPlanForWeek(user.uid, weekStart);
}

@riverpod
class MealsController extends _$MealsController {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  final _uuid = const Uuid();

  /// Genera un nuevo plan semanal completo usando la IA
  Future<void> generateAndSavePlan(String prompt) async {
    final user = ref.read(authStateChangesProvider).valueOrNull;
    if (user == null) return;

    state = const AsyncValue.loading();
    try {
      final aiRepo = ref.read(aiRepositoryProvider);
      final rawPlan = await aiRepo.generateMealPlan(prompt);
      final weekStart = ref.read(selectedWeekProvider);

      final plan = NexoMealPlan(
        id: '',
        ownerUid: user.uid,
        name: rawPlan['name'] ?? 'Plan de Comidas',
        weekStartDate: weekStart,
        isAiGenerated: true,
        aiPromptUsed: prompt,
        meals: _parseMealsFromAi(rawPlan),
      );

      await ref.read(mealsRepositoryProvider).createMealPlan(plan);
      
      // Sincronizar widgets
      HomeWidgetService.updateMealCalendarWidget(plan);
      
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Genera receta IA para una comida específica y la guarda
  Future<void> generateRecipeForMeal(String planId, DayMeal meal) async {
    state = const AsyncValue.loading();
    try {
      final aiRepo = ref.read(aiRepositoryProvider);
      final recipe = await aiRepo.generateRecipeForMeal(
        meal.recipe.name,
        meal.recipe.description,
      );

      final updatedMeal = meal.copyWith(aiGeneratedRecipe: recipe);
      await ref
          .read(mealsRepositoryProvider)
          .updateDayMeal(planId, updatedMeal);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Genera lista de ingredientes IA para una comida y la guarda
  Future<void> generateIngredientsForMeal(String planId, DayMeal meal) async {
    state = const AsyncValue.loading();
    try {
      final aiRepo = ref.read(aiRepositoryProvider);
      final ingredients = await aiRepo.generateIngredientsList(
        meal.recipe.name,
        meal.recipe.description,
      );

      final updatedMeal = meal.copyWith(aiGeneratedIngredients: ingredients);
      await ref
          .read(mealsRepositoryProvider)
          .updateDayMeal(planId, updatedMeal);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Añade un solo ingrediente a la lista de la compra principal
  Future<void> addIngredientToShoppingList(String ingredientText) async {
    final user = ref.read(authStateChangesProvider).valueOrNull;
    if (user == null) return;

    try {
      final notesRepo = ref.read(notesRepositoryProvider);
      final allNotes = await notesRepo.getUserNotes(user.uid);
      final primaryList = allNotes.cast<NexoNote?>().firstWhere(
            (n) => n?.isPrimaryShoppingList == true,
            orElse: () => null,
          );

      if (primaryList == null) {
        throw Exception('No hay lista de compra principal configurada.');
      }

      final newItem = NoteItem(
        id: _uuid.v4(),
        text: ingredientText,
        isChecked: false,
      );

      final updatedNote = primaryList.copyWith(
        items: [...primaryList.items, newItem],
        updatedAt: DateTime.now(),
      );
      await notesRepo.updateNote(updatedNote);
      
      // Sincronizar widgets
      HomeWidgetService.updateShoppingListWidget(updatedNote);
      
    } catch (e) {
      rethrow;
    }
  }

  /// Añade todos los ingredientes que faltan a la lista de compra
  Future<void> addAllMissingIngredients(
      List<Map<String, dynamic>> ingredients) async {
    final user = ref.read(authStateChangesProvider).valueOrNull;
    if (user == null) return;

    state = const AsyncValue.loading();
    try {
      final notesRepo = ref.read(notesRepositoryProvider);
      final allNotes = await notesRepo.getUserNotes(user.uid);
      final primaryList = allNotes.cast<NexoNote?>().firstWhere(
            (n) => n?.isPrimaryShoppingList == true,
            orElse: () => null,
          );

      if (primaryList == null) {
        throw Exception('No hay lista de compra principal configurada.');
      }

      final existingTexts =
          primaryList.items.map((i) => i.text.toLowerCase()).toSet();

      final newItems = ingredients
          .where((ing) {
            final text = '${ing['quantity']} ${ing['unit']} ${ing['name']}';
            return !existingTexts.contains(text.toLowerCase());
          })
          .map((ing) => NoteItem(
                id: _uuid.v4(),
                text: '${ing['quantity']} ${ing['unit']} ${ing['name']}',
                isChecked: false,
              ))
          .toList();

      if (newItems.isEmpty) {
        state = const AsyncValue.data(null);
        return;
      }

      final updatedNote = primaryList.copyWith(
        items: [...primaryList.items, ...newItems],
        updatedAt: DateTime.now(),
      );
      await notesRepo.updateNote(updatedNote);

      // Sincronizar widgets
      HomeWidgetService.updateShoppingListWidget(updatedNote);

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Añade una comida manualmente al plan de la semana seleccionada
  Future<void> addManualMeal({
    required Weekday weekday,
    required MealSlot slot,
    required String mealName,
    required String? description,
    required int prepTime,
  }) async {
    final user = ref.read(authStateChangesProvider).valueOrNull;
    if (user == null) return;

    state = const AsyncValue.loading();
    try {
      final repo = ref.read(mealsRepositoryProvider);
      final weekStart = ref.read(selectedWeekProvider);

      // Obtener o crear plan para esta semana
      final plan = await repo.getOrCreatePlanForWeek(user.uid, weekStart);

      final newMeal = DayMeal(
        id: _uuid.v4(),
        weekday: weekday,
        slot: slot,
        recipe: NexoRecipe(
          id: _uuid.v4(),
          name: mealName,
          description: description,
          prepTimeMinutes: prepTime,
          cookTimeMinutes: 0,
          servings: 1,
        ),
      );

      final updatedPlan = plan.copyWith(meals: updatedMeals);
      await repo.updateMealPlan(updatedPlan);

      // Sincronizar widgets
      HomeWidgetService.updateMealCalendarWidget(updatedPlan);

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Elimina una comida específica de un plan
  Future<void> removeMealFromPlan(String planId, String mealId) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(mealsRepositoryProvider);
      await repo.removeMealFromPlan(planId, mealId);
      
      // Intentamos refrescar el widget (aunque no tenemos el plan completo aquí, el listener en app.dart lo hará)
      // pero por si acaso, si podemos obtener el plan actual lo hacemos.
      final currentPlan = ref.read(activeMealPlanProvider).valueOrNull;
      if (currentPlan != null && currentPlan.id == planId) {
        final updatedPlan = currentPlan.copyWith(meals: currentPlan.meals.where((m) => m.id != mealId).toList());
        HomeWidgetService.updateMealCalendarWidget(updatedPlan);
      }

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Parsea comidas de la respuesta cruda de la IA
  List<DayMeal> _parseMealsFromAi(Map<String, dynamic> rawPlan) {
    return (rawPlan['meals'] as List).map((m) {
      final mealMap = m as Map<String, dynamic>;
      final recipeMap = mealMap['recipe'] as Map<String, dynamic>;

      return DayMeal(
        id: _uuid.v4(),
        weekday: Weekday.values.firstWhere(
          (e) => e.name == mealMap['weekday'],
          orElse: () => Weekday.monday,
        ),
        slot: MealSlot.values.firstWhere(
          (e) => e.name == mealMap['slot'],
          orElse: () => MealSlot.lunch,
        ),
        recipe: NexoRecipe(
          id: _uuid.v4(),
          name: recipeMap['name'] ?? 'Receta',
          description: recipeMap['description'],
          prepTimeMinutes: recipeMap['prepTimeMinutes'] ?? 0,
          cookTimeMinutes: recipeMap['cookTimeMinutes'] ?? 0,
          servings: recipeMap['servings'] ?? 2,
          ingredients: (recipeMap['ingredients'] as List? ?? []).map((i) {
            final ingMap = i as Map<String, dynamic>;
            return NexoIngredient(
              id: _uuid.v4(),
              name: ingMap['name'] ?? 'Ingrediente',
              quantity: (ingMap['quantity'] ?? 0).toDouble(),
              unit: ingMap['unit'] ?? 'ud',
              category: ingMap['category'],
            );
          }).toList(),
          steps: List<String>.from(recipeMap['steps'] ?? []),
        ),
      );
    }).toList();
  }
}
