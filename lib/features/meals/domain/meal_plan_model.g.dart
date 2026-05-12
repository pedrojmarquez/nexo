// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NexoMealPlanImpl _$$NexoMealPlanImplFromJson(Map<String, dynamic> json) =>
    _$NexoMealPlanImpl(
      id: json['id'] as String,
      ownerUid: json['ownerUid'] as String,
      name: json['name'] as String,
      weekStartDate:
          const ServerTimestampConverter().fromJson(json['weekStartDate']),
      meals: (json['meals'] as List<dynamic>?)
              ?.map((e) => DayMeal.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      sharedWith: (json['sharedWith'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isAiGenerated: json['isAiGenerated'] as bool? ?? false,
      aiPromptUsed: json['aiPromptUsed'] as String?,
      createdAt: const ServerTimestampConverter().fromJson(json['createdAt']),
      updatedAt: const ServerTimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$NexoMealPlanImplToJson(_$NexoMealPlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerUid': instance.ownerUid,
      'name': instance.name,
      'weekStartDate':
          const ServerTimestampConverter().toJson(instance.weekStartDate),
      'meals': instance.meals,
      'sharedWith': instance.sharedWith,
      'isAiGenerated': instance.isAiGenerated,
      'aiPromptUsed': instance.aiPromptUsed,
      'createdAt': const ServerTimestampConverter().toJson(instance.createdAt),
      'updatedAt': const ServerTimestampConverter().toJson(instance.updatedAt),
    };

_$DayMealImpl _$$DayMealImplFromJson(Map<String, dynamic> json) =>
    _$DayMealImpl(
      id: json['id'] as String,
      weekday: $enumDecode(_$WeekdayEnumMap, json['weekday']),
      slot: $enumDecode(_$MealSlotEnumMap, json['slot']),
      recipe: NexoRecipe.fromJson(json['recipe'] as Map<String, dynamic>),
      isCompleted: json['isCompleted'] as bool? ?? false,
      userNotes: json['userNotes'] as String?,
      aiGeneratedRecipe:
          json['aiGeneratedRecipe'] as Map<String, dynamic>? ?? null,
      aiGeneratedIngredients: (json['aiGeneratedIngredients'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          null,
    );

Map<String, dynamic> _$$DayMealImplToJson(_$DayMealImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weekday': _$WeekdayEnumMap[instance.weekday]!,
      'slot': _$MealSlotEnumMap[instance.slot]!,
      'recipe': instance.recipe,
      'isCompleted': instance.isCompleted,
      'userNotes': instance.userNotes,
      'aiGeneratedRecipe': instance.aiGeneratedRecipe,
      'aiGeneratedIngredients': instance.aiGeneratedIngredients,
    };

const _$WeekdayEnumMap = {
  Weekday.monday: 'monday',
  Weekday.tuesday: 'tuesday',
  Weekday.wednesday: 'wednesday',
  Weekday.thursday: 'thursday',
  Weekday.friday: 'friday',
  Weekday.saturday: 'saturday',
  Weekday.sunday: 'sunday',
};

const _$MealSlotEnumMap = {
  MealSlot.breakfast: 'breakfast',
  MealSlot.lunch: 'lunch',
  MealSlot.dinner: 'dinner',
  MealSlot.snack: 'snack',
};

_$NexoRecipeImpl _$$NexoRecipeImplFromJson(Map<String, dynamic> json) =>
    _$NexoRecipeImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      difficulty:
          $enumDecodeNullable(_$RecipeDifficultyEnumMap, json['difficulty']) ??
              RecipeDifficulty.easy,
      prepTimeMinutes: (json['prepTimeMinutes'] as num?)?.toInt() ?? 0,
      cookTimeMinutes: (json['cookTimeMinutes'] as num?)?.toInt() ?? 0,
      servings: (json['servings'] as num?)?.toInt() ?? 2,
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((e) => NexoIngredient.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      steps:
          (json['steps'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      imageUrl: json['imageUrl'] as String?,
      caloriesPerServing: (json['caloriesPerServing'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$NexoRecipeImplToJson(_$NexoRecipeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'difficulty': _$RecipeDifficultyEnumMap[instance.difficulty]!,
      'prepTimeMinutes': instance.prepTimeMinutes,
      'cookTimeMinutes': instance.cookTimeMinutes,
      'servings': instance.servings,
      'ingredients': instance.ingredients,
      'steps': instance.steps,
      'tags': instance.tags,
      'imageUrl': instance.imageUrl,
      'caloriesPerServing': instance.caloriesPerServing,
    };

const _$RecipeDifficultyEnumMap = {
  RecipeDifficulty.easy: 'easy',
  RecipeDifficulty.medium: 'medium',
  RecipeDifficulty.hard: 'hard',
};

_$NexoIngredientImpl _$$NexoIngredientImplFromJson(Map<String, dynamic> json) =>
    _$NexoIngredientImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] as String,
      isAvailable: json['isAvailable'] as bool? ?? false,
      isPurchased: json['isPurchased'] as bool? ?? false,
      category: json['category'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$NexoIngredientImplToJson(
        _$NexoIngredientImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'isAvailable': instance.isAvailable,
      'isPurchased': instance.isPurchased,
      'category': instance.category,
      'notes': instance.notes,
    };
