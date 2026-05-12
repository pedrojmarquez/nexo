// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_plan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NexoMealPlan _$NexoMealPlanFromJson(Map<String, dynamic> json) {
  return _NexoMealPlan.fromJson(json);
}

/// @nodoc
mixin _$NexoMealPlan {
  String get id => throw _privateConstructorUsedError;

  /// UID del usuario propietario del plan
  String get ownerUid => throw _privateConstructorUsedError;

  /// Nombre del plan (ej: "Semana del 5 de mayo")
  String get name => throw _privateConstructorUsedError;

  /// Fecha del lunes de esta semana (clave para navegación entre semanas)
  @ServerTimestampConverter()
  DateTime? get weekStartDate => throw _privateConstructorUsedError;

  /// Lista de comidas asignadas a cada día/slot
  List<DayMeal> get meals => throw _privateConstructorUsedError;

  /// UIDs con acceso compartido al plan
  List<String> get sharedWith => throw _privateConstructorUsedError;

  /// ¿Este plan fue generado por IA?
  bool get isAiGenerated => throw _privateConstructorUsedError;

  /// Prompt usado para generar el plan (para auditoría/regeneración)
  String? get aiPromptUsed => throw _privateConstructorUsedError;
  @ServerTimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @ServerTimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this NexoMealPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NexoMealPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NexoMealPlanCopyWith<NexoMealPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NexoMealPlanCopyWith<$Res> {
  factory $NexoMealPlanCopyWith(
          NexoMealPlan value, $Res Function(NexoMealPlan) then) =
      _$NexoMealPlanCopyWithImpl<$Res, NexoMealPlan>;
  @useResult
  $Res call(
      {String id,
      String ownerUid,
      String name,
      @ServerTimestampConverter() DateTime? weekStartDate,
      List<DayMeal> meals,
      List<String> sharedWith,
      bool isAiGenerated,
      String? aiPromptUsed,
      @ServerTimestampConverter() DateTime? createdAt,
      @ServerTimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class _$NexoMealPlanCopyWithImpl<$Res, $Val extends NexoMealPlan>
    implements $NexoMealPlanCopyWith<$Res> {
  _$NexoMealPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NexoMealPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerUid = null,
    Object? name = null,
    Object? weekStartDate = freezed,
    Object? meals = null,
    Object? sharedWith = null,
    Object? isAiGenerated = null,
    Object? aiPromptUsed = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerUid: null == ownerUid
          ? _value.ownerUid
          : ownerUid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      weekStartDate: freezed == weekStartDate
          ? _value.weekStartDate
          : weekStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      meals: null == meals
          ? _value.meals
          : meals // ignore: cast_nullable_to_non_nullable
              as List<DayMeal>,
      sharedWith: null == sharedWith
          ? _value.sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isAiGenerated: null == isAiGenerated
          ? _value.isAiGenerated
          : isAiGenerated // ignore: cast_nullable_to_non_nullable
              as bool,
      aiPromptUsed: freezed == aiPromptUsed
          ? _value.aiPromptUsed
          : aiPromptUsed // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NexoMealPlanImplCopyWith<$Res>
    implements $NexoMealPlanCopyWith<$Res> {
  factory _$$NexoMealPlanImplCopyWith(
          _$NexoMealPlanImpl value, $Res Function(_$NexoMealPlanImpl) then) =
      __$$NexoMealPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String ownerUid,
      String name,
      @ServerTimestampConverter() DateTime? weekStartDate,
      List<DayMeal> meals,
      List<String> sharedWith,
      bool isAiGenerated,
      String? aiPromptUsed,
      @ServerTimestampConverter() DateTime? createdAt,
      @ServerTimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class __$$NexoMealPlanImplCopyWithImpl<$Res>
    extends _$NexoMealPlanCopyWithImpl<$Res, _$NexoMealPlanImpl>
    implements _$$NexoMealPlanImplCopyWith<$Res> {
  __$$NexoMealPlanImplCopyWithImpl(
      _$NexoMealPlanImpl _value, $Res Function(_$NexoMealPlanImpl) _then)
      : super(_value, _then);

  /// Create a copy of NexoMealPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerUid = null,
    Object? name = null,
    Object? weekStartDate = freezed,
    Object? meals = null,
    Object? sharedWith = null,
    Object? isAiGenerated = null,
    Object? aiPromptUsed = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$NexoMealPlanImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerUid: null == ownerUid
          ? _value.ownerUid
          : ownerUid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      weekStartDate: freezed == weekStartDate
          ? _value.weekStartDate
          : weekStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      meals: null == meals
          ? _value._meals
          : meals // ignore: cast_nullable_to_non_nullable
              as List<DayMeal>,
      sharedWith: null == sharedWith
          ? _value._sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isAiGenerated: null == isAiGenerated
          ? _value.isAiGenerated
          : isAiGenerated // ignore: cast_nullable_to_non_nullable
              as bool,
      aiPromptUsed: freezed == aiPromptUsed
          ? _value.aiPromptUsed
          : aiPromptUsed // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NexoMealPlanImpl implements _NexoMealPlan {
  const _$NexoMealPlanImpl(
      {required this.id,
      required this.ownerUid,
      required this.name,
      @ServerTimestampConverter() this.weekStartDate,
      final List<DayMeal> meals = const [],
      final List<String> sharedWith = const [],
      this.isAiGenerated = false,
      this.aiPromptUsed,
      @ServerTimestampConverter() this.createdAt,
      @ServerTimestampConverter() this.updatedAt})
      : _meals = meals,
        _sharedWith = sharedWith;

  factory _$NexoMealPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$NexoMealPlanImplFromJson(json);

  @override
  final String id;

  /// UID del usuario propietario del plan
  @override
  final String ownerUid;

  /// Nombre del plan (ej: "Semana del 5 de mayo")
  @override
  final String name;

  /// Fecha del lunes de esta semana (clave para navegación entre semanas)
  @override
  @ServerTimestampConverter()
  final DateTime? weekStartDate;

  /// Lista de comidas asignadas a cada día/slot
  final List<DayMeal> _meals;

  /// Lista de comidas asignadas a cada día/slot
  @override
  @JsonKey()
  List<DayMeal> get meals {
    if (_meals is EqualUnmodifiableListView) return _meals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_meals);
  }

  /// UIDs con acceso compartido al plan
  final List<String> _sharedWith;

  /// UIDs con acceso compartido al plan
  @override
  @JsonKey()
  List<String> get sharedWith {
    if (_sharedWith is EqualUnmodifiableListView) return _sharedWith;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sharedWith);
  }

  /// ¿Este plan fue generado por IA?
  @override
  @JsonKey()
  final bool isAiGenerated;

  /// Prompt usado para generar el plan (para auditoría/regeneración)
  @override
  final String? aiPromptUsed;
  @override
  @ServerTimestampConverter()
  final DateTime? createdAt;
  @override
  @ServerTimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'NexoMealPlan(id: $id, ownerUid: $ownerUid, name: $name, weekStartDate: $weekStartDate, meals: $meals, sharedWith: $sharedWith, isAiGenerated: $isAiGenerated, aiPromptUsed: $aiPromptUsed, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NexoMealPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ownerUid, ownerUid) ||
                other.ownerUid == ownerUid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.weekStartDate, weekStartDate) ||
                other.weekStartDate == weekStartDate) &&
            const DeepCollectionEquality().equals(other._meals, _meals) &&
            const DeepCollectionEquality()
                .equals(other._sharedWith, _sharedWith) &&
            (identical(other.isAiGenerated, isAiGenerated) ||
                other.isAiGenerated == isAiGenerated) &&
            (identical(other.aiPromptUsed, aiPromptUsed) ||
                other.aiPromptUsed == aiPromptUsed) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      ownerUid,
      name,
      weekStartDate,
      const DeepCollectionEquality().hash(_meals),
      const DeepCollectionEquality().hash(_sharedWith),
      isAiGenerated,
      aiPromptUsed,
      createdAt,
      updatedAt);

  /// Create a copy of NexoMealPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NexoMealPlanImplCopyWith<_$NexoMealPlanImpl> get copyWith =>
      __$$NexoMealPlanImplCopyWithImpl<_$NexoMealPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NexoMealPlanImplToJson(
      this,
    );
  }
}

abstract class _NexoMealPlan implements NexoMealPlan {
  const factory _NexoMealPlan(
          {required final String id,
          required final String ownerUid,
          required final String name,
          @ServerTimestampConverter() final DateTime? weekStartDate,
          final List<DayMeal> meals,
          final List<String> sharedWith,
          final bool isAiGenerated,
          final String? aiPromptUsed,
          @ServerTimestampConverter() final DateTime? createdAt,
          @ServerTimestampConverter() final DateTime? updatedAt}) =
      _$NexoMealPlanImpl;

  factory _NexoMealPlan.fromJson(Map<String, dynamic> json) =
      _$NexoMealPlanImpl.fromJson;

  @override
  String get id;

  /// UID del usuario propietario del plan
  @override
  String get ownerUid;

  /// Nombre del plan (ej: "Semana del 5 de mayo")
  @override
  String get name;

  /// Fecha del lunes de esta semana (clave para navegación entre semanas)
  @override
  @ServerTimestampConverter()
  DateTime? get weekStartDate;

  /// Lista de comidas asignadas a cada día/slot
  @override
  List<DayMeal> get meals;

  /// UIDs con acceso compartido al plan
  @override
  List<String> get sharedWith;

  /// ¿Este plan fue generado por IA?
  @override
  bool get isAiGenerated;

  /// Prompt usado para generar el plan (para auditoría/regeneración)
  @override
  String? get aiPromptUsed;
  @override
  @ServerTimestampConverter()
  DateTime? get createdAt;
  @override
  @ServerTimestampConverter()
  DateTime? get updatedAt;

  /// Create a copy of NexoMealPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NexoMealPlanImplCopyWith<_$NexoMealPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DayMeal _$DayMealFromJson(Map<String, dynamic> json) {
  return _DayMeal.fromJson(json);
}

/// @nodoc
mixin _$DayMeal {
  String get id => throw _privateConstructorUsedError;

  /// Día de la semana
  Weekday get weekday => throw _privateConstructorUsedError;

  /// Slot del día (desayuno, comida, cena, snack)
  MealSlot get slot => throw _privateConstructorUsedError;

  /// Receta asociada (puede ser manual o generada)
  NexoRecipe get recipe => throw _privateConstructorUsedError;

  /// ¿Está confirmada/preparada?
  bool get isCompleted => throw _privateConstructorUsedError;

  /// Notas del usuario sobre esta comida
  String? get userNotes => throw _privateConstructorUsedError;

  /// Receta generada por IA (JSON guardado para mostrar pasos estilizados)
  /// Estructura: {name, description, difficulty, prepTime, cookTime, steps: [...]}
  Map<String, dynamic>? get aiGeneratedRecipe =>
      throw _privateConstructorUsedError;

  /// Ingredientes generados por IA (JSON guardado para mostrar lista estilizada)
  /// Estructura: [{name, quantity, unit, category}]
  List<Map<String, dynamic>>? get aiGeneratedIngredients =>
      throw _privateConstructorUsedError;

  /// Serializes this DayMeal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DayMeal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DayMealCopyWith<DayMeal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DayMealCopyWith<$Res> {
  factory $DayMealCopyWith(DayMeal value, $Res Function(DayMeal) then) =
      _$DayMealCopyWithImpl<$Res, DayMeal>;
  @useResult
  $Res call(
      {String id,
      Weekday weekday,
      MealSlot slot,
      NexoRecipe recipe,
      bool isCompleted,
      String? userNotes,
      Map<String, dynamic>? aiGeneratedRecipe,
      List<Map<String, dynamic>>? aiGeneratedIngredients});

  $NexoRecipeCopyWith<$Res> get recipe;
}

/// @nodoc
class _$DayMealCopyWithImpl<$Res, $Val extends DayMeal>
    implements $DayMealCopyWith<$Res> {
  _$DayMealCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DayMeal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weekday = null,
    Object? slot = null,
    Object? recipe = null,
    Object? isCompleted = null,
    Object? userNotes = freezed,
    Object? aiGeneratedRecipe = freezed,
    Object? aiGeneratedIngredients = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      weekday: null == weekday
          ? _value.weekday
          : weekday // ignore: cast_nullable_to_non_nullable
              as Weekday,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as MealSlot,
      recipe: null == recipe
          ? _value.recipe
          : recipe // ignore: cast_nullable_to_non_nullable
              as NexoRecipe,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      userNotes: freezed == userNotes
          ? _value.userNotes
          : userNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      aiGeneratedRecipe: freezed == aiGeneratedRecipe
          ? _value.aiGeneratedRecipe
          : aiGeneratedRecipe // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      aiGeneratedIngredients: freezed == aiGeneratedIngredients
          ? _value.aiGeneratedIngredients
          : aiGeneratedIngredients // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
    ) as $Val);
  }

  /// Create a copy of DayMeal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NexoRecipeCopyWith<$Res> get recipe {
    return $NexoRecipeCopyWith<$Res>(_value.recipe, (value) {
      return _then(_value.copyWith(recipe: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DayMealImplCopyWith<$Res> implements $DayMealCopyWith<$Res> {
  factory _$$DayMealImplCopyWith(
          _$DayMealImpl value, $Res Function(_$DayMealImpl) then) =
      __$$DayMealImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Weekday weekday,
      MealSlot slot,
      NexoRecipe recipe,
      bool isCompleted,
      String? userNotes,
      Map<String, dynamic>? aiGeneratedRecipe,
      List<Map<String, dynamic>>? aiGeneratedIngredients});

  @override
  $NexoRecipeCopyWith<$Res> get recipe;
}

/// @nodoc
class __$$DayMealImplCopyWithImpl<$Res>
    extends _$DayMealCopyWithImpl<$Res, _$DayMealImpl>
    implements _$$DayMealImplCopyWith<$Res> {
  __$$DayMealImplCopyWithImpl(
      _$DayMealImpl _value, $Res Function(_$DayMealImpl) _then)
      : super(_value, _then);

  /// Create a copy of DayMeal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weekday = null,
    Object? slot = null,
    Object? recipe = null,
    Object? isCompleted = null,
    Object? userNotes = freezed,
    Object? aiGeneratedRecipe = freezed,
    Object? aiGeneratedIngredients = freezed,
  }) {
    return _then(_$DayMealImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      weekday: null == weekday
          ? _value.weekday
          : weekday // ignore: cast_nullable_to_non_nullable
              as Weekday,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as MealSlot,
      recipe: null == recipe
          ? _value.recipe
          : recipe // ignore: cast_nullable_to_non_nullable
              as NexoRecipe,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      userNotes: freezed == userNotes
          ? _value.userNotes
          : userNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      aiGeneratedRecipe: freezed == aiGeneratedRecipe
          ? _value._aiGeneratedRecipe
          : aiGeneratedRecipe // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      aiGeneratedIngredients: freezed == aiGeneratedIngredients
          ? _value._aiGeneratedIngredients
          : aiGeneratedIngredients // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DayMealImpl implements _DayMeal {
  const _$DayMealImpl(
      {required this.id,
      required this.weekday,
      required this.slot,
      required this.recipe,
      this.isCompleted = false,
      this.userNotes,
      final Map<String, dynamic>? aiGeneratedRecipe = null,
      final List<Map<String, dynamic>>? aiGeneratedIngredients = null})
      : _aiGeneratedRecipe = aiGeneratedRecipe,
        _aiGeneratedIngredients = aiGeneratedIngredients;

  factory _$DayMealImpl.fromJson(Map<String, dynamic> json) =>
      _$$DayMealImplFromJson(json);

  @override
  final String id;

  /// Día de la semana
  @override
  final Weekday weekday;

  /// Slot del día (desayuno, comida, cena, snack)
  @override
  final MealSlot slot;

  /// Receta asociada (puede ser manual o generada)
  @override
  final NexoRecipe recipe;

  /// ¿Está confirmada/preparada?
  @override
  @JsonKey()
  final bool isCompleted;

  /// Notas del usuario sobre esta comida
  @override
  final String? userNotes;

  /// Receta generada por IA (JSON guardado para mostrar pasos estilizados)
  /// Estructura: {name, description, difficulty, prepTime, cookTime, steps: [...]}
  final Map<String, dynamic>? _aiGeneratedRecipe;

  /// Receta generada por IA (JSON guardado para mostrar pasos estilizados)
  /// Estructura: {name, description, difficulty, prepTime, cookTime, steps: [...]}
  @override
  @JsonKey()
  Map<String, dynamic>? get aiGeneratedRecipe {
    final value = _aiGeneratedRecipe;
    if (value == null) return null;
    if (_aiGeneratedRecipe is EqualUnmodifiableMapView)
      return _aiGeneratedRecipe;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Ingredientes generados por IA (JSON guardado para mostrar lista estilizada)
  /// Estructura: [{name, quantity, unit, category}]
  final List<Map<String, dynamic>>? _aiGeneratedIngredients;

  /// Ingredientes generados por IA (JSON guardado para mostrar lista estilizada)
  /// Estructura: [{name, quantity, unit, category}]
  @override
  @JsonKey()
  List<Map<String, dynamic>>? get aiGeneratedIngredients {
    final value = _aiGeneratedIngredients;
    if (value == null) return null;
    if (_aiGeneratedIngredients is EqualUnmodifiableListView)
      return _aiGeneratedIngredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'DayMeal(id: $id, weekday: $weekday, slot: $slot, recipe: $recipe, isCompleted: $isCompleted, userNotes: $userNotes, aiGeneratedRecipe: $aiGeneratedRecipe, aiGeneratedIngredients: $aiGeneratedIngredients)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DayMealImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.weekday, weekday) || other.weekday == weekday) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            (identical(other.recipe, recipe) || other.recipe == recipe) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.userNotes, userNotes) ||
                other.userNotes == userNotes) &&
            const DeepCollectionEquality()
                .equals(other._aiGeneratedRecipe, _aiGeneratedRecipe) &&
            const DeepCollectionEquality().equals(
                other._aiGeneratedIngredients, _aiGeneratedIngredients));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      weekday,
      slot,
      recipe,
      isCompleted,
      userNotes,
      const DeepCollectionEquality().hash(_aiGeneratedRecipe),
      const DeepCollectionEquality().hash(_aiGeneratedIngredients));

  /// Create a copy of DayMeal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DayMealImplCopyWith<_$DayMealImpl> get copyWith =>
      __$$DayMealImplCopyWithImpl<_$DayMealImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DayMealImplToJson(
      this,
    );
  }
}

abstract class _DayMeal implements DayMeal {
  const factory _DayMeal(
          {required final String id,
          required final Weekday weekday,
          required final MealSlot slot,
          required final NexoRecipe recipe,
          final bool isCompleted,
          final String? userNotes,
          final Map<String, dynamic>? aiGeneratedRecipe,
          final List<Map<String, dynamic>>? aiGeneratedIngredients}) =
      _$DayMealImpl;

  factory _DayMeal.fromJson(Map<String, dynamic> json) = _$DayMealImpl.fromJson;

  @override
  String get id;

  /// Día de la semana
  @override
  Weekday get weekday;

  /// Slot del día (desayuno, comida, cena, snack)
  @override
  MealSlot get slot;

  /// Receta asociada (puede ser manual o generada)
  @override
  NexoRecipe get recipe;

  /// ¿Está confirmada/preparada?
  @override
  bool get isCompleted;

  /// Notas del usuario sobre esta comida
  @override
  String? get userNotes;

  /// Receta generada por IA (JSON guardado para mostrar pasos estilizados)
  /// Estructura: {name, description, difficulty, prepTime, cookTime, steps: [...]}
  @override
  Map<String, dynamic>? get aiGeneratedRecipe;

  /// Ingredientes generados por IA (JSON guardado para mostrar lista estilizada)
  /// Estructura: [{name, quantity, unit, category}]
  @override
  List<Map<String, dynamic>>? get aiGeneratedIngredients;

  /// Create a copy of DayMeal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DayMealImplCopyWith<_$DayMealImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NexoRecipe _$NexoRecipeFromJson(Map<String, dynamic> json) {
  return _NexoRecipe.fromJson(json);
}

/// @nodoc
mixin _$NexoRecipe {
  String get id => throw _privateConstructorUsedError;

  /// Nombre de la receta
  String get name => throw _privateConstructorUsedError;

  /// Descripción corta (generada por Gemini)
  String? get description => throw _privateConstructorUsedError;

  /// Dificultad de preparación
  RecipeDifficulty get difficulty => throw _privateConstructorUsedError;

  /// Tiempo de preparación en minutos
  int get prepTimeMinutes => throw _privateConstructorUsedError;

  /// Tiempo de cocción en minutos
  int get cookTimeMinutes => throw _privateConstructorUsedError;

  /// Número de raciones
  int get servings => throw _privateConstructorUsedError;

  /// Lista de ingredientes
  List<NexoIngredient> get ingredients => throw _privateConstructorUsedError;

  /// Pasos de la receta
  List<String> get steps => throw _privateConstructorUsedError;

  /// Tags/categorías (vegetariano, sin gluten, etc.)
  List<String> get tags => throw _privateConstructorUsedError;

  /// URL de imagen de la receta (puede ser generada o externa)
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Calorías estimadas por ración
  int? get caloriesPerServing => throw _privateConstructorUsedError;

  /// Serializes this NexoRecipe to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NexoRecipe
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NexoRecipeCopyWith<NexoRecipe> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NexoRecipeCopyWith<$Res> {
  factory $NexoRecipeCopyWith(
          NexoRecipe value, $Res Function(NexoRecipe) then) =
      _$NexoRecipeCopyWithImpl<$Res, NexoRecipe>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      RecipeDifficulty difficulty,
      int prepTimeMinutes,
      int cookTimeMinutes,
      int servings,
      List<NexoIngredient> ingredients,
      List<String> steps,
      List<String> tags,
      String? imageUrl,
      int? caloriesPerServing});
}

/// @nodoc
class _$NexoRecipeCopyWithImpl<$Res, $Val extends NexoRecipe>
    implements $NexoRecipeCopyWith<$Res> {
  _$NexoRecipeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NexoRecipe
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? difficulty = null,
    Object? prepTimeMinutes = null,
    Object? cookTimeMinutes = null,
    Object? servings = null,
    Object? ingredients = null,
    Object? steps = null,
    Object? tags = null,
    Object? imageUrl = freezed,
    Object? caloriesPerServing = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as RecipeDifficulty,
      prepTimeMinutes: null == prepTimeMinutes
          ? _value.prepTimeMinutes
          : prepTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      cookTimeMinutes: null == cookTimeMinutes
          ? _value.cookTimeMinutes
          : cookTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      servings: null == servings
          ? _value.servings
          : servings // ignore: cast_nullable_to_non_nullable
              as int,
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<NexoIngredient>,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      caloriesPerServing: freezed == caloriesPerServing
          ? _value.caloriesPerServing
          : caloriesPerServing // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NexoRecipeImplCopyWith<$Res>
    implements $NexoRecipeCopyWith<$Res> {
  factory _$$NexoRecipeImplCopyWith(
          _$NexoRecipeImpl value, $Res Function(_$NexoRecipeImpl) then) =
      __$$NexoRecipeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      RecipeDifficulty difficulty,
      int prepTimeMinutes,
      int cookTimeMinutes,
      int servings,
      List<NexoIngredient> ingredients,
      List<String> steps,
      List<String> tags,
      String? imageUrl,
      int? caloriesPerServing});
}

/// @nodoc
class __$$NexoRecipeImplCopyWithImpl<$Res>
    extends _$NexoRecipeCopyWithImpl<$Res, _$NexoRecipeImpl>
    implements _$$NexoRecipeImplCopyWith<$Res> {
  __$$NexoRecipeImplCopyWithImpl(
      _$NexoRecipeImpl _value, $Res Function(_$NexoRecipeImpl) _then)
      : super(_value, _then);

  /// Create a copy of NexoRecipe
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? difficulty = null,
    Object? prepTimeMinutes = null,
    Object? cookTimeMinutes = null,
    Object? servings = null,
    Object? ingredients = null,
    Object? steps = null,
    Object? tags = null,
    Object? imageUrl = freezed,
    Object? caloriesPerServing = freezed,
  }) {
    return _then(_$NexoRecipeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as RecipeDifficulty,
      prepTimeMinutes: null == prepTimeMinutes
          ? _value.prepTimeMinutes
          : prepTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      cookTimeMinutes: null == cookTimeMinutes
          ? _value.cookTimeMinutes
          : cookTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      servings: null == servings
          ? _value.servings
          : servings // ignore: cast_nullable_to_non_nullable
              as int,
      ingredients: null == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<NexoIngredient>,
      steps: null == steps
          ? _value._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      caloriesPerServing: freezed == caloriesPerServing
          ? _value.caloriesPerServing
          : caloriesPerServing // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NexoRecipeImpl implements _NexoRecipe {
  const _$NexoRecipeImpl(
      {required this.id,
      required this.name,
      this.description,
      this.difficulty = RecipeDifficulty.easy,
      this.prepTimeMinutes = 0,
      this.cookTimeMinutes = 0,
      this.servings = 2,
      final List<NexoIngredient> ingredients = const [],
      final List<String> steps = const [],
      final List<String> tags = const [],
      this.imageUrl,
      this.caloriesPerServing})
      : _ingredients = ingredients,
        _steps = steps,
        _tags = tags;

  factory _$NexoRecipeImpl.fromJson(Map<String, dynamic> json) =>
      _$$NexoRecipeImplFromJson(json);

  @override
  final String id;

  /// Nombre de la receta
  @override
  final String name;

  /// Descripción corta (generada por Gemini)
  @override
  final String? description;

  /// Dificultad de preparación
  @override
  @JsonKey()
  final RecipeDifficulty difficulty;

  /// Tiempo de preparación en minutos
  @override
  @JsonKey()
  final int prepTimeMinutes;

  /// Tiempo de cocción en minutos
  @override
  @JsonKey()
  final int cookTimeMinutes;

  /// Número de raciones
  @override
  @JsonKey()
  final int servings;

  /// Lista de ingredientes
  final List<NexoIngredient> _ingredients;

  /// Lista de ingredientes
  @override
  @JsonKey()
  List<NexoIngredient> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  /// Pasos de la receta
  final List<String> _steps;

  /// Pasos de la receta
  @override
  @JsonKey()
  List<String> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  /// Tags/categorías (vegetariano, sin gluten, etc.)
  final List<String> _tags;

  /// Tags/categorías (vegetariano, sin gluten, etc.)
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  /// URL de imagen de la receta (puede ser generada o externa)
  @override
  final String? imageUrl;

  /// Calorías estimadas por ración
  @override
  final int? caloriesPerServing;

  @override
  String toString() {
    return 'NexoRecipe(id: $id, name: $name, description: $description, difficulty: $difficulty, prepTimeMinutes: $prepTimeMinutes, cookTimeMinutes: $cookTimeMinutes, servings: $servings, ingredients: $ingredients, steps: $steps, tags: $tags, imageUrl: $imageUrl, caloriesPerServing: $caloriesPerServing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NexoRecipeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.prepTimeMinutes, prepTimeMinutes) ||
                other.prepTimeMinutes == prepTimeMinutes) &&
            (identical(other.cookTimeMinutes, cookTimeMinutes) ||
                other.cookTimeMinutes == cookTimeMinutes) &&
            (identical(other.servings, servings) ||
                other.servings == servings) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.caloriesPerServing, caloriesPerServing) ||
                other.caloriesPerServing == caloriesPerServing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      difficulty,
      prepTimeMinutes,
      cookTimeMinutes,
      servings,
      const DeepCollectionEquality().hash(_ingredients),
      const DeepCollectionEquality().hash(_steps),
      const DeepCollectionEquality().hash(_tags),
      imageUrl,
      caloriesPerServing);

  /// Create a copy of NexoRecipe
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NexoRecipeImplCopyWith<_$NexoRecipeImpl> get copyWith =>
      __$$NexoRecipeImplCopyWithImpl<_$NexoRecipeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NexoRecipeImplToJson(
      this,
    );
  }
}

abstract class _NexoRecipe implements NexoRecipe {
  const factory _NexoRecipe(
      {required final String id,
      required final String name,
      final String? description,
      final RecipeDifficulty difficulty,
      final int prepTimeMinutes,
      final int cookTimeMinutes,
      final int servings,
      final List<NexoIngredient> ingredients,
      final List<String> steps,
      final List<String> tags,
      final String? imageUrl,
      final int? caloriesPerServing}) = _$NexoRecipeImpl;

  factory _NexoRecipe.fromJson(Map<String, dynamic> json) =
      _$NexoRecipeImpl.fromJson;

  @override
  String get id;

  /// Nombre de la receta
  @override
  String get name;

  /// Descripción corta (generada por Gemini)
  @override
  String? get description;

  /// Dificultad de preparación
  @override
  RecipeDifficulty get difficulty;

  /// Tiempo de preparación en minutos
  @override
  int get prepTimeMinutes;

  /// Tiempo de cocción en minutos
  @override
  int get cookTimeMinutes;

  /// Número de raciones
  @override
  int get servings;

  /// Lista de ingredientes
  @override
  List<NexoIngredient> get ingredients;

  /// Pasos de la receta
  @override
  List<String> get steps;

  /// Tags/categorías (vegetariano, sin gluten, etc.)
  @override
  List<String> get tags;

  /// URL de imagen de la receta (puede ser generada o externa)
  @override
  String? get imageUrl;

  /// Calorías estimadas por ración
  @override
  int? get caloriesPerServing;

  /// Create a copy of NexoRecipe
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NexoRecipeImplCopyWith<_$NexoRecipeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NexoIngredient _$NexoIngredientFromJson(Map<String, dynamic> json) {
  return _NexoIngredient.fromJson(json);
}

/// @nodoc
mixin _$NexoIngredient {
  String get id => throw _privateConstructorUsedError;

  /// Nombre del ingrediente
  String get name => throw _privateConstructorUsedError;

  /// Cantidad necesaria (puede ser decimal)
  double get quantity => throw _privateConstructorUsedError;

  /// Unidad de medida (gr, ml, uds, cucharadas, etc.)
  String get unit => throw _privateConstructorUsedError;

  /// ¿Está disponible en casa?
  bool get isAvailable => throw _privateConstructorUsedError;

  /// ¿Ha sido comprado? (para la Lista de la Compra)
  bool get isPurchased => throw _privateConstructorUsedError;

  /// Categoría del ingrediente (frutas, lácteos, carne, etc.)
  String? get category => throw _privateConstructorUsedError;

  /// Notas adicionales (ej: "de temporada", "orgánico")
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this NexoIngredient to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NexoIngredient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NexoIngredientCopyWith<NexoIngredient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NexoIngredientCopyWith<$Res> {
  factory $NexoIngredientCopyWith(
          NexoIngredient value, $Res Function(NexoIngredient) then) =
      _$NexoIngredientCopyWithImpl<$Res, NexoIngredient>;
  @useResult
  $Res call(
      {String id,
      String name,
      double quantity,
      String unit,
      bool isAvailable,
      bool isPurchased,
      String? category,
      String? notes});
}

/// @nodoc
class _$NexoIngredientCopyWithImpl<$Res, $Val extends NexoIngredient>
    implements $NexoIngredientCopyWith<$Res> {
  _$NexoIngredientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NexoIngredient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? quantity = null,
    Object? unit = null,
    Object? isAvailable = null,
    Object? isPurchased = null,
    Object? category = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      isPurchased: null == isPurchased
          ? _value.isPurchased
          : isPurchased // ignore: cast_nullable_to_non_nullable
              as bool,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NexoIngredientImplCopyWith<$Res>
    implements $NexoIngredientCopyWith<$Res> {
  factory _$$NexoIngredientImplCopyWith(_$NexoIngredientImpl value,
          $Res Function(_$NexoIngredientImpl) then) =
      __$$NexoIngredientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double quantity,
      String unit,
      bool isAvailable,
      bool isPurchased,
      String? category,
      String? notes});
}

/// @nodoc
class __$$NexoIngredientImplCopyWithImpl<$Res>
    extends _$NexoIngredientCopyWithImpl<$Res, _$NexoIngredientImpl>
    implements _$$NexoIngredientImplCopyWith<$Res> {
  __$$NexoIngredientImplCopyWithImpl(
      _$NexoIngredientImpl _value, $Res Function(_$NexoIngredientImpl) _then)
      : super(_value, _then);

  /// Create a copy of NexoIngredient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? quantity = null,
    Object? unit = null,
    Object? isAvailable = null,
    Object? isPurchased = null,
    Object? category = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$NexoIngredientImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      isPurchased: null == isPurchased
          ? _value.isPurchased
          : isPurchased // ignore: cast_nullable_to_non_nullable
              as bool,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NexoIngredientImpl implements _NexoIngredient {
  const _$NexoIngredientImpl(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.unit,
      this.isAvailable = false,
      this.isPurchased = false,
      this.category,
      this.notes});

  factory _$NexoIngredientImpl.fromJson(Map<String, dynamic> json) =>
      _$$NexoIngredientImplFromJson(json);

  @override
  final String id;

  /// Nombre del ingrediente
  @override
  final String name;

  /// Cantidad necesaria (puede ser decimal)
  @override
  final double quantity;

  /// Unidad de medida (gr, ml, uds, cucharadas, etc.)
  @override
  final String unit;

  /// ¿Está disponible en casa?
  @override
  @JsonKey()
  final bool isAvailable;

  /// ¿Ha sido comprado? (para la Lista de la Compra)
  @override
  @JsonKey()
  final bool isPurchased;

  /// Categoría del ingrediente (frutas, lácteos, carne, etc.)
  @override
  final String? category;

  /// Notas adicionales (ej: "de temporada", "orgánico")
  @override
  final String? notes;

  @override
  String toString() {
    return 'NexoIngredient(id: $id, name: $name, quantity: $quantity, unit: $unit, isAvailable: $isAvailable, isPurchased: $isPurchased, category: $category, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NexoIngredientImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.isPurchased, isPurchased) ||
                other.isPurchased == isPurchased) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, quantity, unit,
      isAvailable, isPurchased, category, notes);

  /// Create a copy of NexoIngredient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NexoIngredientImplCopyWith<_$NexoIngredientImpl> get copyWith =>
      __$$NexoIngredientImplCopyWithImpl<_$NexoIngredientImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NexoIngredientImplToJson(
      this,
    );
  }
}

abstract class _NexoIngredient implements NexoIngredient {
  const factory _NexoIngredient(
      {required final String id,
      required final String name,
      required final double quantity,
      required final String unit,
      final bool isAvailable,
      final bool isPurchased,
      final String? category,
      final String? notes}) = _$NexoIngredientImpl;

  factory _NexoIngredient.fromJson(Map<String, dynamic> json) =
      _$NexoIngredientImpl.fromJson;

  @override
  String get id;

  /// Nombre del ingrediente
  @override
  String get name;

  /// Cantidad necesaria (puede ser decimal)
  @override
  double get quantity;

  /// Unidad de medida (gr, ml, uds, cucharadas, etc.)
  @override
  String get unit;

  /// ¿Está disponible en casa?
  @override
  bool get isAvailable;

  /// ¿Ha sido comprado? (para la Lista de la Compra)
  @override
  bool get isPurchased;

  /// Categoría del ingrediente (frutas, lácteos, carne, etc.)
  @override
  String? get category;

  /// Notas adicionales (ej: "de temporada", "orgánico")
  @override
  String? get notes;

  /// Create a copy of NexoIngredient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NexoIngredientImplCopyWith<_$NexoIngredientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
