// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NexoNote _$NexoNoteFromJson(Map<String, dynamic> json) {
  return _NexoNote.fromJson(json);
}

/// @nodoc
mixin _$NexoNote {
  /// ID del documento en Firestore
  String get id => throw _privateConstructorUsedError;

  /// UID del usuario creador
  String get ownerUid => throw _privateConstructorUsedError;

  /// Título de la nota
  String get title => throw _privateConstructorUsedError;

  /// Tipo de nota: text, list, itinerary
  NoteType get type => throw _privateConstructorUsedError;

  /// Contenido de texto (para tipo TEXT)
  String? get content => throw _privateConstructorUsedError;

  /// Lista de ítems (para tipo LIST e ITINERARY)
  List<NoteItem> get items => throw _privateConstructorUsedError;

  /// Tags/categorías asignadas por IA o manualmente
  List<String> get tags => throw _privateConstructorUsedError;

  /// Color de acento de la tarjeta (hex string, ej: "#6366F1")
  String? get accentColor => throw _privateConstructorUsedError;

  /// UIDs de usuarios con acceso compartido
  List<String> get sharedWith => throw _privateConstructorUsedError;

  /// Estado actual de la nota
  NoteStatus get status => throw _privateConstructorUsedError;

  /// Indica si la IA procesó y enriqueció esta nota
  bool get isAiEnhanced => throw _privateConstructorUsedError;

  /// Indica si la nota está fijada en la parte superior del tablón
  bool get isPinned => throw _privateConstructorUsedError;

  /// Subtipo de la nota (ej. 'post_it', 'shopping_principal', 'default')
  String? get noteSubType => throw _privateConstructorUsedError;

  /// Contenido enriquecido en formato JSON de flutter_quill
  String? get richContent => throw _privateConstructorUsedError;

  /// Indica si esta nota es la lista de la compra principal
  bool get isPrimaryShoppingList => throw _privateConstructorUsedError;

  /// Resumen generado por Gemini (para notas largas)
  String? get aiSummary => throw _privateConstructorUsedError;

  /// Patrón de fondo del editor (dots, grid, lines, waves, confetti, paper, stars, null=liso)
  String? get backgroundPattern => throw _privateConstructorUsedError;

  /// Timestamp de creación
  @ServerTimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Timestamp de última modificación
  @ServerTimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this NexoNote to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NexoNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NexoNoteCopyWith<NexoNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NexoNoteCopyWith<$Res> {
  factory $NexoNoteCopyWith(NexoNote value, $Res Function(NexoNote) then) =
      _$NexoNoteCopyWithImpl<$Res, NexoNote>;
  @useResult
  $Res call(
      {String id,
      String ownerUid,
      String title,
      NoteType type,
      String? content,
      List<NoteItem> items,
      List<String> tags,
      String? accentColor,
      List<String> sharedWith,
      NoteStatus status,
      bool isAiEnhanced,
      bool isPinned,
      String? noteSubType,
      String? richContent,
      bool isPrimaryShoppingList,
      String? aiSummary,
      String? backgroundPattern,
      @ServerTimestampConverter() DateTime? createdAt,
      @ServerTimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class _$NexoNoteCopyWithImpl<$Res, $Val extends NexoNote>
    implements $NexoNoteCopyWith<$Res> {
  _$NexoNoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NexoNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerUid = null,
    Object? title = null,
    Object? type = null,
    Object? content = freezed,
    Object? items = null,
    Object? tags = null,
    Object? accentColor = freezed,
    Object? sharedWith = null,
    Object? status = null,
    Object? isAiEnhanced = null,
    Object? isPinned = null,
    Object? noteSubType = freezed,
    Object? richContent = freezed,
    Object? isPrimaryShoppingList = null,
    Object? aiSummary = freezed,
    Object? backgroundPattern = freezed,
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NoteType,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<NoteItem>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      accentColor: freezed == accentColor
          ? _value.accentColor
          : accentColor // ignore: cast_nullable_to_non_nullable
              as String?,
      sharedWith: null == sharedWith
          ? _value.sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NoteStatus,
      isAiEnhanced: null == isAiEnhanced
          ? _value.isAiEnhanced
          : isAiEnhanced // ignore: cast_nullable_to_non_nullable
              as bool,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
      noteSubType: freezed == noteSubType
          ? _value.noteSubType
          : noteSubType // ignore: cast_nullable_to_non_nullable
              as String?,
      richContent: freezed == richContent
          ? _value.richContent
          : richContent // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrimaryShoppingList: null == isPrimaryShoppingList
          ? _value.isPrimaryShoppingList
          : isPrimaryShoppingList // ignore: cast_nullable_to_non_nullable
              as bool,
      aiSummary: freezed == aiSummary
          ? _value.aiSummary
          : aiSummary // ignore: cast_nullable_to_non_nullable
              as String?,
      backgroundPattern: freezed == backgroundPattern
          ? _value.backgroundPattern
          : backgroundPattern // ignore: cast_nullable_to_non_nullable
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
abstract class _$$NexoNoteImplCopyWith<$Res>
    implements $NexoNoteCopyWith<$Res> {
  factory _$$NexoNoteImplCopyWith(
          _$NexoNoteImpl value, $Res Function(_$NexoNoteImpl) then) =
      __$$NexoNoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String ownerUid,
      String title,
      NoteType type,
      String? content,
      List<NoteItem> items,
      List<String> tags,
      String? accentColor,
      List<String> sharedWith,
      NoteStatus status,
      bool isAiEnhanced,
      bool isPinned,
      String? noteSubType,
      String? richContent,
      bool isPrimaryShoppingList,
      String? aiSummary,
      String? backgroundPattern,
      @ServerTimestampConverter() DateTime? createdAt,
      @ServerTimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class __$$NexoNoteImplCopyWithImpl<$Res>
    extends _$NexoNoteCopyWithImpl<$Res, _$NexoNoteImpl>
    implements _$$NexoNoteImplCopyWith<$Res> {
  __$$NexoNoteImplCopyWithImpl(
      _$NexoNoteImpl _value, $Res Function(_$NexoNoteImpl) _then)
      : super(_value, _then);

  /// Create a copy of NexoNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerUid = null,
    Object? title = null,
    Object? type = null,
    Object? content = freezed,
    Object? items = null,
    Object? tags = null,
    Object? accentColor = freezed,
    Object? sharedWith = null,
    Object? status = null,
    Object? isAiEnhanced = null,
    Object? isPinned = null,
    Object? noteSubType = freezed,
    Object? richContent = freezed,
    Object? isPrimaryShoppingList = null,
    Object? aiSummary = freezed,
    Object? backgroundPattern = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$NexoNoteImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerUid: null == ownerUid
          ? _value.ownerUid
          : ownerUid // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NoteType,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<NoteItem>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      accentColor: freezed == accentColor
          ? _value.accentColor
          : accentColor // ignore: cast_nullable_to_non_nullable
              as String?,
      sharedWith: null == sharedWith
          ? _value._sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NoteStatus,
      isAiEnhanced: null == isAiEnhanced
          ? _value.isAiEnhanced
          : isAiEnhanced // ignore: cast_nullable_to_non_nullable
              as bool,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
      noteSubType: freezed == noteSubType
          ? _value.noteSubType
          : noteSubType // ignore: cast_nullable_to_non_nullable
              as String?,
      richContent: freezed == richContent
          ? _value.richContent
          : richContent // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrimaryShoppingList: null == isPrimaryShoppingList
          ? _value.isPrimaryShoppingList
          : isPrimaryShoppingList // ignore: cast_nullable_to_non_nullable
              as bool,
      aiSummary: freezed == aiSummary
          ? _value.aiSummary
          : aiSummary // ignore: cast_nullable_to_non_nullable
              as String?,
      backgroundPattern: freezed == backgroundPattern
          ? _value.backgroundPattern
          : backgroundPattern // ignore: cast_nullable_to_non_nullable
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
class _$NexoNoteImpl implements _NexoNote {
  const _$NexoNoteImpl(
      {required this.id,
      required this.ownerUid,
      required this.title,
      this.type = NoteType.text,
      this.content,
      final List<NoteItem> items = const [],
      final List<String> tags = const [],
      this.accentColor,
      final List<String> sharedWith = const [],
      this.status = NoteStatus.active,
      this.isAiEnhanced = false,
      this.isPinned = false,
      this.noteSubType,
      this.richContent,
      this.isPrimaryShoppingList = false,
      this.aiSummary,
      this.backgroundPattern,
      @ServerTimestampConverter() this.createdAt,
      @ServerTimestampConverter() this.updatedAt})
      : _items = items,
        _tags = tags,
        _sharedWith = sharedWith;

  factory _$NexoNoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$NexoNoteImplFromJson(json);

  /// ID del documento en Firestore
  @override
  final String id;

  /// UID del usuario creador
  @override
  final String ownerUid;

  /// Título de la nota
  @override
  final String title;

  /// Tipo de nota: text, list, itinerary
  @override
  @JsonKey()
  final NoteType type;

  /// Contenido de texto (para tipo TEXT)
  @override
  final String? content;

  /// Lista de ítems (para tipo LIST e ITINERARY)
  final List<NoteItem> _items;

  /// Lista de ítems (para tipo LIST e ITINERARY)
  @override
  @JsonKey()
  List<NoteItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Tags/categorías asignadas por IA o manualmente
  final List<String> _tags;

  /// Tags/categorías asignadas por IA o manualmente
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  /// Color de acento de la tarjeta (hex string, ej: "#6366F1")
  @override
  final String? accentColor;

  /// UIDs de usuarios con acceso compartido
  final List<String> _sharedWith;

  /// UIDs de usuarios con acceso compartido
  @override
  @JsonKey()
  List<String> get sharedWith {
    if (_sharedWith is EqualUnmodifiableListView) return _sharedWith;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sharedWith);
  }

  /// Estado actual de la nota
  @override
  @JsonKey()
  final NoteStatus status;

  /// Indica si la IA procesó y enriqueció esta nota
  @override
  @JsonKey()
  final bool isAiEnhanced;

  /// Indica si la nota está fijada en la parte superior del tablón
  @override
  @JsonKey()
  final bool isPinned;

  /// Subtipo de la nota (ej. 'post_it', 'shopping_principal', 'default')
  @override
  final String? noteSubType;

  /// Contenido enriquecido en formato JSON de flutter_quill
  @override
  final String? richContent;

  /// Indica si esta nota es la lista de la compra principal
  @override
  @JsonKey()
  final bool isPrimaryShoppingList;

  /// Resumen generado por Gemini (para notas largas)
  @override
  final String? aiSummary;

  /// Patrón de fondo del editor (dots, grid, lines, waves, confetti, paper, stars, null=liso)
  @override
  final String? backgroundPattern;

  /// Timestamp de creación
  @override
  @ServerTimestampConverter()
  final DateTime? createdAt;

  /// Timestamp de última modificación
  @override
  @ServerTimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'NexoNote(id: $id, ownerUid: $ownerUid, title: $title, type: $type, content: $content, items: $items, tags: $tags, accentColor: $accentColor, sharedWith: $sharedWith, status: $status, isAiEnhanced: $isAiEnhanced, isPinned: $isPinned, noteSubType: $noteSubType, richContent: $richContent, isPrimaryShoppingList: $isPrimaryShoppingList, aiSummary: $aiSummary, backgroundPattern: $backgroundPattern, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NexoNoteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ownerUid, ownerUid) ||
                other.ownerUid == ownerUid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.accentColor, accentColor) ||
                other.accentColor == accentColor) &&
            const DeepCollectionEquality()
                .equals(other._sharedWith, _sharedWith) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isAiEnhanced, isAiEnhanced) ||
                other.isAiEnhanced == isAiEnhanced) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.noteSubType, noteSubType) ||
                other.noteSubType == noteSubType) &&
            (identical(other.richContent, richContent) ||
                other.richContent == richContent) &&
            (identical(other.isPrimaryShoppingList, isPrimaryShoppingList) ||
                other.isPrimaryShoppingList == isPrimaryShoppingList) &&
            (identical(other.aiSummary, aiSummary) ||
                other.aiSummary == aiSummary) &&
            (identical(other.backgroundPattern, backgroundPattern) ||
                other.backgroundPattern == backgroundPattern) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        ownerUid,
        title,
        type,
        content,
        const DeepCollectionEquality().hash(_items),
        const DeepCollectionEquality().hash(_tags),
        accentColor,
        const DeepCollectionEquality().hash(_sharedWith),
        status,
        isAiEnhanced,
        isPinned,
        noteSubType,
        richContent,
        isPrimaryShoppingList,
        aiSummary,
        backgroundPattern,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of NexoNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NexoNoteImplCopyWith<_$NexoNoteImpl> get copyWith =>
      __$$NexoNoteImplCopyWithImpl<_$NexoNoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NexoNoteImplToJson(
      this,
    );
  }
}

abstract class _NexoNote implements NexoNote {
  const factory _NexoNote(
      {required final String id,
      required final String ownerUid,
      required final String title,
      final NoteType type,
      final String? content,
      final List<NoteItem> items,
      final List<String> tags,
      final String? accentColor,
      final List<String> sharedWith,
      final NoteStatus status,
      final bool isAiEnhanced,
      final bool isPinned,
      final String? noteSubType,
      final String? richContent,
      final bool isPrimaryShoppingList,
      final String? aiSummary,
      final String? backgroundPattern,
      @ServerTimestampConverter() final DateTime? createdAt,
      @ServerTimestampConverter() final DateTime? updatedAt}) = _$NexoNoteImpl;

  factory _NexoNote.fromJson(Map<String, dynamic> json) =
      _$NexoNoteImpl.fromJson;

  /// ID del documento en Firestore
  @override
  String get id;

  /// UID del usuario creador
  @override
  String get ownerUid;

  /// Título de la nota
  @override
  String get title;

  /// Tipo de nota: text, list, itinerary
  @override
  NoteType get type;

  /// Contenido de texto (para tipo TEXT)
  @override
  String? get content;

  /// Lista de ítems (para tipo LIST e ITINERARY)
  @override
  List<NoteItem> get items;

  /// Tags/categorías asignadas por IA o manualmente
  @override
  List<String> get tags;

  /// Color de acento de la tarjeta (hex string, ej: "#6366F1")
  @override
  String? get accentColor;

  /// UIDs de usuarios con acceso compartido
  @override
  List<String> get sharedWith;

  /// Estado actual de la nota
  @override
  NoteStatus get status;

  /// Indica si la IA procesó y enriqueció esta nota
  @override
  bool get isAiEnhanced;

  /// Indica si la nota está fijada en la parte superior del tablón
  @override
  bool get isPinned;

  /// Subtipo de la nota (ej. 'post_it', 'shopping_principal', 'default')
  @override
  String? get noteSubType;

  /// Contenido enriquecido en formato JSON de flutter_quill
  @override
  String? get richContent;

  /// Indica si esta nota es la lista de la compra principal
  @override
  bool get isPrimaryShoppingList;

  /// Resumen generado por Gemini (para notas largas)
  @override
  String? get aiSummary;

  /// Patrón de fondo del editor (dots, grid, lines, waves, confetti, paper, stars, null=liso)
  @override
  String? get backgroundPattern;

  /// Timestamp de creación
  @override
  @ServerTimestampConverter()
  DateTime? get createdAt;

  /// Timestamp de última modificación
  @override
  @ServerTimestampConverter()
  DateTime? get updatedAt;

  /// Create a copy of NexoNote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NexoNoteImplCopyWith<_$NexoNoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NoteItem _$NoteItemFromJson(Map<String, dynamic> json) {
  return _NoteItem.fromJson(json);
}

/// @nodoc
mixin _$NoteItem {
  /// ID único del ítem (UUID local)
  String get id => throw _privateConstructorUsedError;

  /// Texto del ítem
  String get text => throw _privateConstructorUsedError;

  /// ¿Está marcado como completado?
  bool get isChecked => throw _privateConstructorUsedError;

  /// Orden de visualización
  int get order => throw _privateConstructorUsedError;

  /// Para ítems de tipo ITINERARY: fecha/hora del evento
  @ServerTimestampConverter()
  DateTime? get scheduledAt => throw _privateConstructorUsedError;

  /// Ubicación del ítem (para itinerarios)
  String? get location => throw _privateConstructorUsedError;

  /// Notas adicionales del ítem
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this NoteItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NoteItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoteItemCopyWith<NoteItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteItemCopyWith<$Res> {
  factory $NoteItemCopyWith(NoteItem value, $Res Function(NoteItem) then) =
      _$NoteItemCopyWithImpl<$Res, NoteItem>;
  @useResult
  $Res call(
      {String id,
      String text,
      bool isChecked,
      int order,
      @ServerTimestampConverter() DateTime? scheduledAt,
      String? location,
      String? notes});
}

/// @nodoc
class _$NoteItemCopyWithImpl<$Res, $Val extends NoteItem>
    implements $NoteItemCopyWith<$Res> {
  _$NoteItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoteItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? isChecked = null,
    Object? order = null,
    Object? scheduledAt = freezed,
    Object? location = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isChecked: null == isChecked
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      scheduledAt: freezed == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoteItemImplCopyWith<$Res>
    implements $NoteItemCopyWith<$Res> {
  factory _$$NoteItemImplCopyWith(
          _$NoteItemImpl value, $Res Function(_$NoteItemImpl) then) =
      __$$NoteItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String text,
      bool isChecked,
      int order,
      @ServerTimestampConverter() DateTime? scheduledAt,
      String? location,
      String? notes});
}

/// @nodoc
class __$$NoteItemImplCopyWithImpl<$Res>
    extends _$NoteItemCopyWithImpl<$Res, _$NoteItemImpl>
    implements _$$NoteItemImplCopyWith<$Res> {
  __$$NoteItemImplCopyWithImpl(
      _$NoteItemImpl _value, $Res Function(_$NoteItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of NoteItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? isChecked = null,
    Object? order = null,
    Object? scheduledAt = freezed,
    Object? location = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$NoteItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isChecked: null == isChecked
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      scheduledAt: freezed == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
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
class _$NoteItemImpl implements _NoteItem {
  const _$NoteItemImpl(
      {required this.id,
      required this.text,
      this.isChecked = false,
      this.order = 0,
      @ServerTimestampConverter() this.scheduledAt,
      this.location,
      this.notes});

  factory _$NoteItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoteItemImplFromJson(json);

  /// ID único del ítem (UUID local)
  @override
  final String id;

  /// Texto del ítem
  @override
  final String text;

  /// ¿Está marcado como completado?
  @override
  @JsonKey()
  final bool isChecked;

  /// Orden de visualización
  @override
  @JsonKey()
  final int order;

  /// Para ítems de tipo ITINERARY: fecha/hora del evento
  @override
  @ServerTimestampConverter()
  final DateTime? scheduledAt;

  /// Ubicación del ítem (para itinerarios)
  @override
  final String? location;

  /// Notas adicionales del ítem
  @override
  final String? notes;

  @override
  String toString() {
    return 'NoteItem(id: $id, text: $text, isChecked: $isChecked, order: $order, scheduledAt: $scheduledAt, location: $location, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoteItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isChecked, isChecked) ||
                other.isChecked == isChecked) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, text, isChecked, order, scheduledAt, location, notes);

  /// Create a copy of NoteItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteItemImplCopyWith<_$NoteItemImpl> get copyWith =>
      __$$NoteItemImplCopyWithImpl<_$NoteItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoteItemImplToJson(
      this,
    );
  }
}

abstract class _NoteItem implements NoteItem {
  const factory _NoteItem(
      {required final String id,
      required final String text,
      final bool isChecked,
      final int order,
      @ServerTimestampConverter() final DateTime? scheduledAt,
      final String? location,
      final String? notes}) = _$NoteItemImpl;

  factory _NoteItem.fromJson(Map<String, dynamic> json) =
      _$NoteItemImpl.fromJson;

  /// ID único del ítem (UUID local)
  @override
  String get id;

  /// Texto del ítem
  @override
  String get text;

  /// ¿Está marcado como completado?
  @override
  bool get isChecked;

  /// Orden de visualización
  @override
  int get order;

  /// Para ítems de tipo ITINERARY: fecha/hora del evento
  @override
  @ServerTimestampConverter()
  DateTime? get scheduledAt;

  /// Ubicación del ítem (para itinerarios)
  @override
  String? get location;

  /// Notas adicionales del ítem
  @override
  String? get notes;

  /// Create a copy of NoteItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoteItemImplCopyWith<_$NoteItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
