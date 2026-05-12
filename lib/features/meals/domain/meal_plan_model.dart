import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nexo/core/utils/firestore_converters.dart';

part 'meal_plan_model.freezed.dart';
part 'meal_plan_model.g.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// Modelos del Planificador de Comidas — Nexo V3
///
/// Estructura en Firestore:
///   /meal_plans/{planId}          → plan semanal (1 por semana)
///     └── meals: List<DayMeal>   → comidas por día de la semana
///
/// Cada DayMeal puede tener receta e ingredientes generados por IA
/// bajo demanda, que se persisten para consultas futuras.
/// ─────────────────────────────────────────────────────────────────────────────

/// Días de la semana
enum Weekday {
  @JsonValue('monday')
  monday,
  @JsonValue('tuesday')
  tuesday,
  @JsonValue('wednesday')
  wednesday,
  @JsonValue('thursday')
  thursday,
  @JsonValue('friday')
  friday,
  @JsonValue('saturday')
  saturday,
  @JsonValue('sunday')
  sunday,
}

/// Tipo de comida del día
enum MealSlot {
  @JsonValue('breakfast')
  breakfast,
  @JsonValue('lunch')
  lunch,
  @JsonValue('dinner')
  dinner,
  @JsonValue('snack')
  snack,
}

/// Dificultad de la receta
enum RecipeDifficulty {
  @JsonValue('easy')
  easy,
  @JsonValue('medium')
  medium,
  @JsonValue('hard')
  hard,
}

// ─────────────────────────────────────────────────────────────────────────────

@freezed
class NexoMealPlan with _$NexoMealPlan {
  const factory NexoMealPlan({
    required String id,

    /// UID del usuario propietario del plan
    required String ownerUid,

    /// Nombre del plan (ej: "Semana del 5 de mayo")
    required String name,

    /// Fecha del lunes de esta semana (clave para navegación entre semanas)
    @ServerTimestampConverter() DateTime? weekStartDate,

    /// Lista de comidas asignadas a cada día/slot
    @Default([]) List<DayMeal> meals,

    /// UIDs con acceso compartido al plan
    @Default([]) List<String> sharedWith,

    /// ¿Este plan fue generado por IA?
    @Default(false) bool isAiGenerated,

    /// Prompt usado para generar el plan (para auditoría/regeneración)
    String? aiPromptUsed,
    @ServerTimestampConverter() DateTime? createdAt,
    @ServerTimestampConverter() DateTime? updatedAt,
  }) = _NexoMealPlan;

  factory NexoMealPlan.fromJson(Map<String, dynamic> json) =>
      _$NexoMealPlanFromJson(json);

  factory NexoMealPlan.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NexoMealPlan.fromJson({...data, 'id': doc.id});
  }
}

// ─────────────────────────────────────────────────────────────────────────────

/// Comida asignada a un día y slot específico
@freezed
class DayMeal with _$DayMeal {
  const factory DayMeal({
    required String id,

    /// Día de la semana
    required Weekday weekday,

    /// Slot del día (desayuno, comida, cena, snack)
    required MealSlot slot,

    /// Receta asociada (puede ser manual o generada)
    required NexoRecipe recipe,

    /// ¿Está confirmada/preparada?
    @Default(false) bool isCompleted,

    /// Notas del usuario sobre esta comida
    String? userNotes,

    /// Receta generada por IA (JSON guardado para mostrar pasos estilizados)
    /// Estructura: {name, description, difficulty, prepTime, cookTime, steps: [...]}
    @Default(null) Map<String, dynamic>? aiGeneratedRecipe,

    /// Ingredientes generados por IA (JSON guardado para mostrar lista estilizada)
    /// Estructura: [{name, quantity, unit, category}]
    @Default(null) List<Map<String, dynamic>>? aiGeneratedIngredients,
  }) = _DayMeal;

  factory DayMeal.fromJson(Map<String, dynamic> json) =>
      _$DayMealFromJson(json);
}

// ─────────────────────────────────────────────────────────────────────────────

/// Receta completa con ingredientes e instrucciones
@freezed
class NexoRecipe with _$NexoRecipe {
  const factory NexoRecipe({
    required String id,

    /// Nombre de la receta
    required String name,

    /// Descripción corta (generada por Gemini)
    String? description,

    /// Dificultad de preparación
    @Default(RecipeDifficulty.easy) RecipeDifficulty difficulty,

    /// Tiempo de preparación en minutos
    @Default(0) int prepTimeMinutes,

    /// Tiempo de cocción en minutos
    @Default(0) int cookTimeMinutes,

    /// Número de raciones
    @Default(2) int servings,

    /// Lista de ingredientes
    @Default([]) List<NexoIngredient> ingredients,

    /// Pasos de la receta
    @Default([]) List<String> steps,

    /// Tags/categorías (vegetariano, sin gluten, etc.)
    @Default([]) List<String> tags,

    /// URL de imagen de la receta (puede ser generada o externa)
    String? imageUrl,

    /// Calorías estimadas por ración
    int? caloriesPerServing,
  }) = _NexoRecipe;

  factory NexoRecipe.fromJson(Map<String, dynamic> json) =>
      _$NexoRecipeFromJson(json);
}

// ─────────────────────────────────────────────────────────────────────────────

/// Ingrediente con cantidad, unidad y estado de compra
@freezed
class NexoIngredient with _$NexoIngredient {
  const factory NexoIngredient({
    required String id,

    /// Nombre del ingrediente
    required String name,

    /// Cantidad necesaria (puede ser decimal)
    required double quantity,

    /// Unidad de medida (gr, ml, uds, cucharadas, etc.)
    required String unit,

    /// ¿Está disponible en casa?
    @Default(false) bool isAvailable,

    /// ¿Ha sido comprado? (para la Lista de la Compra)
    @Default(false) bool isPurchased,

    /// Categoría del ingrediente (frutas, lácteos, carne, etc.)
    String? category,

    /// Notas adicionales (ej: "de temporada", "orgánico")
    String? notes,
  }) = _NexoIngredient;

  factory NexoIngredient.fromJson(Map<String, dynamic> json) =>
      _$NexoIngredientFromJson(json);
}
