// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NexoUser _$NexoUserFromJson(Map<String, dynamic> json) {
  return _NexoUser.fromJson(json);
}

/// @nodoc
mixin _$NexoUser {
  String get uid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;

  /// Timestamp de creación de la cuenta en Nexo
  @ServerTimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Última vez que se actualizó el perfil
  @ServerTimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// UIDs de otros usuarios con quienes se comparte el workspace
  List<String> get sharedWith => throw _privateConstructorUsedError;

  /// Configuración personal del usuario
  NexoUserSettings get settings => throw _privateConstructorUsedError;

  /// Serializes this NexoUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NexoUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NexoUserCopyWith<NexoUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NexoUserCopyWith<$Res> {
  factory $NexoUserCopyWith(NexoUser value, $Res Function(NexoUser) then) =
      _$NexoUserCopyWithImpl<$Res, NexoUser>;
  @useResult
  $Res call(
      {String uid,
      String email,
      String displayName,
      String? photoUrl,
      @ServerTimestampConverter() DateTime? createdAt,
      @ServerTimestampConverter() DateTime? updatedAt,
      List<String> sharedWith,
      NexoUserSettings settings});

  $NexoUserSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class _$NexoUserCopyWithImpl<$Res, $Val extends NexoUser>
    implements $NexoUserCopyWith<$Res> {
  _$NexoUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NexoUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? displayName = null,
    Object? photoUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? sharedWith = null,
    Object? settings = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sharedWith: null == sharedWith
          ? _value.sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as NexoUserSettings,
    ) as $Val);
  }

  /// Create a copy of NexoUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NexoUserSettingsCopyWith<$Res> get settings {
    return $NexoUserSettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NexoUserImplCopyWith<$Res>
    implements $NexoUserCopyWith<$Res> {
  factory _$$NexoUserImplCopyWith(
          _$NexoUserImpl value, $Res Function(_$NexoUserImpl) then) =
      __$$NexoUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String email,
      String displayName,
      String? photoUrl,
      @ServerTimestampConverter() DateTime? createdAt,
      @ServerTimestampConverter() DateTime? updatedAt,
      List<String> sharedWith,
      NexoUserSettings settings});

  @override
  $NexoUserSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class __$$NexoUserImplCopyWithImpl<$Res>
    extends _$NexoUserCopyWithImpl<$Res, _$NexoUserImpl>
    implements _$$NexoUserImplCopyWith<$Res> {
  __$$NexoUserImplCopyWithImpl(
      _$NexoUserImpl _value, $Res Function(_$NexoUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of NexoUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? displayName = null,
    Object? photoUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? sharedWith = null,
    Object? settings = null,
  }) {
    return _then(_$NexoUserImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sharedWith: null == sharedWith
          ? _value._sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as NexoUserSettings,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NexoUserImpl implements _NexoUser {
  const _$NexoUserImpl(
      {required this.uid,
      required this.email,
      required this.displayName,
      this.photoUrl,
      @ServerTimestampConverter() this.createdAt,
      @ServerTimestampConverter() this.updatedAt,
      final List<String> sharedWith = const [],
      this.settings = const NexoUserSettings()})
      : _sharedWith = sharedWith;

  factory _$NexoUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$NexoUserImplFromJson(json);

  @override
  final String uid;
  @override
  final String email;
  @override
  final String displayName;
  @override
  final String? photoUrl;

  /// Timestamp de creación de la cuenta en Nexo
  @override
  @ServerTimestampConverter()
  final DateTime? createdAt;

  /// Última vez que se actualizó el perfil
  @override
  @ServerTimestampConverter()
  final DateTime? updatedAt;

  /// UIDs de otros usuarios con quienes se comparte el workspace
  final List<String> _sharedWith;

  /// UIDs de otros usuarios con quienes se comparte el workspace
  @override
  @JsonKey()
  List<String> get sharedWith {
    if (_sharedWith is EqualUnmodifiableListView) return _sharedWith;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sharedWith);
  }

  /// Configuración personal del usuario
  @override
  @JsonKey()
  final NexoUserSettings settings;

  @override
  String toString() {
    return 'NexoUser(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl, createdAt: $createdAt, updatedAt: $updatedAt, sharedWith: $sharedWith, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NexoUserImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other._sharedWith, _sharedWith) &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      email,
      displayName,
      photoUrl,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_sharedWith),
      settings);

  /// Create a copy of NexoUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NexoUserImplCopyWith<_$NexoUserImpl> get copyWith =>
      __$$NexoUserImplCopyWithImpl<_$NexoUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NexoUserImplToJson(
      this,
    );
  }
}

abstract class _NexoUser implements NexoUser {
  const factory _NexoUser(
      {required final String uid,
      required final String email,
      required final String displayName,
      final String? photoUrl,
      @ServerTimestampConverter() final DateTime? createdAt,
      @ServerTimestampConverter() final DateTime? updatedAt,
      final List<String> sharedWith,
      final NexoUserSettings settings}) = _$NexoUserImpl;

  factory _NexoUser.fromJson(Map<String, dynamic> json) =
      _$NexoUserImpl.fromJson;

  @override
  String get uid;
  @override
  String get email;
  @override
  String get displayName;
  @override
  String? get photoUrl;

  /// Timestamp de creación de la cuenta en Nexo
  @override
  @ServerTimestampConverter()
  DateTime? get createdAt;

  /// Última vez que se actualizó el perfil
  @override
  @ServerTimestampConverter()
  DateTime? get updatedAt;

  /// UIDs de otros usuarios con quienes se comparte el workspace
  @override
  List<String> get sharedWith;

  /// Configuración personal del usuario
  @override
  NexoUserSettings get settings;

  /// Create a copy of NexoUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NexoUserImplCopyWith<_$NexoUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NexoUserSettings _$NexoUserSettingsFromJson(Map<String, dynamic> json) {
  return _NexoUserSettings.fromJson(json);
}

/// @nodoc
mixin _$NexoUserSettings {
  /// Modo de tema: 'system' | 'light' | 'dark'
  String get themeMode => throw _privateConstructorUsedError;

  /// Activar notificaciones de comidas con ingredientes faltantes
  bool get mealNotificationsEnabled => throw _privateConstructorUsedError;

  /// Activar notificaciones de eventos del calendario
  bool get calendarNotificationsEnabled => throw _privateConstructorUsedError;

  /// Idioma preferido: 'es' | 'en'
  String get language => throw _privateConstructorUsedError;

  /// Serializes this NexoUserSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NexoUserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NexoUserSettingsCopyWith<NexoUserSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NexoUserSettingsCopyWith<$Res> {
  factory $NexoUserSettingsCopyWith(
          NexoUserSettings value, $Res Function(NexoUserSettings) then) =
      _$NexoUserSettingsCopyWithImpl<$Res, NexoUserSettings>;
  @useResult
  $Res call(
      {String themeMode,
      bool mealNotificationsEnabled,
      bool calendarNotificationsEnabled,
      String language});
}

/// @nodoc
class _$NexoUserSettingsCopyWithImpl<$Res, $Val extends NexoUserSettings>
    implements $NexoUserSettingsCopyWith<$Res> {
  _$NexoUserSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NexoUserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? mealNotificationsEnabled = null,
    Object? calendarNotificationsEnabled = null,
    Object? language = null,
  }) {
    return _then(_value.copyWith(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as String,
      mealNotificationsEnabled: null == mealNotificationsEnabled
          ? _value.mealNotificationsEnabled
          : mealNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      calendarNotificationsEnabled: null == calendarNotificationsEnabled
          ? _value.calendarNotificationsEnabled
          : calendarNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NexoUserSettingsImplCopyWith<$Res>
    implements $NexoUserSettingsCopyWith<$Res> {
  factory _$$NexoUserSettingsImplCopyWith(_$NexoUserSettingsImpl value,
          $Res Function(_$NexoUserSettingsImpl) then) =
      __$$NexoUserSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String themeMode,
      bool mealNotificationsEnabled,
      bool calendarNotificationsEnabled,
      String language});
}

/// @nodoc
class __$$NexoUserSettingsImplCopyWithImpl<$Res>
    extends _$NexoUserSettingsCopyWithImpl<$Res, _$NexoUserSettingsImpl>
    implements _$$NexoUserSettingsImplCopyWith<$Res> {
  __$$NexoUserSettingsImplCopyWithImpl(_$NexoUserSettingsImpl _value,
      $Res Function(_$NexoUserSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of NexoUserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? mealNotificationsEnabled = null,
    Object? calendarNotificationsEnabled = null,
    Object? language = null,
  }) {
    return _then(_$NexoUserSettingsImpl(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as String,
      mealNotificationsEnabled: null == mealNotificationsEnabled
          ? _value.mealNotificationsEnabled
          : mealNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      calendarNotificationsEnabled: null == calendarNotificationsEnabled
          ? _value.calendarNotificationsEnabled
          : calendarNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NexoUserSettingsImpl implements _NexoUserSettings {
  const _$NexoUserSettingsImpl(
      {this.themeMode = 'system',
      this.mealNotificationsEnabled = true,
      this.calendarNotificationsEnabled = true,
      this.language = 'es'});

  factory _$NexoUserSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NexoUserSettingsImplFromJson(json);

  /// Modo de tema: 'system' | 'light' | 'dark'
  @override
  @JsonKey()
  final String themeMode;

  /// Activar notificaciones de comidas con ingredientes faltantes
  @override
  @JsonKey()
  final bool mealNotificationsEnabled;

  /// Activar notificaciones de eventos del calendario
  @override
  @JsonKey()
  final bool calendarNotificationsEnabled;

  /// Idioma preferido: 'es' | 'en'
  @override
  @JsonKey()
  final String language;

  @override
  String toString() {
    return 'NexoUserSettings(themeMode: $themeMode, mealNotificationsEnabled: $mealNotificationsEnabled, calendarNotificationsEnabled: $calendarNotificationsEnabled, language: $language)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NexoUserSettingsImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(
                    other.mealNotificationsEnabled, mealNotificationsEnabled) ||
                other.mealNotificationsEnabled == mealNotificationsEnabled) &&
            (identical(other.calendarNotificationsEnabled,
                    calendarNotificationsEnabled) ||
                other.calendarNotificationsEnabled ==
                    calendarNotificationsEnabled) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, themeMode,
      mealNotificationsEnabled, calendarNotificationsEnabled, language);

  /// Create a copy of NexoUserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NexoUserSettingsImplCopyWith<_$NexoUserSettingsImpl> get copyWith =>
      __$$NexoUserSettingsImplCopyWithImpl<_$NexoUserSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NexoUserSettingsImplToJson(
      this,
    );
  }
}

abstract class _NexoUserSettings implements NexoUserSettings {
  const factory _NexoUserSettings(
      {final String themeMode,
      final bool mealNotificationsEnabled,
      final bool calendarNotificationsEnabled,
      final String language}) = _$NexoUserSettingsImpl;

  factory _NexoUserSettings.fromJson(Map<String, dynamic> json) =
      _$NexoUserSettingsImpl.fromJson;

  /// Modo de tema: 'system' | 'light' | 'dark'
  @override
  String get themeMode;

  /// Activar notificaciones de comidas con ingredientes faltantes
  @override
  bool get mealNotificationsEnabled;

  /// Activar notificaciones de eventos del calendario
  @override
  bool get calendarNotificationsEnabled;

  /// Idioma preferido: 'es' | 'en'
  @override
  String get language;

  /// Create a copy of NexoUserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NexoUserSettingsImplCopyWith<_$NexoUserSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
