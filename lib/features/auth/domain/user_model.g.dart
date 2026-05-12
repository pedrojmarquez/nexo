// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NexoUserImpl _$$NexoUserImplFromJson(Map<String, dynamic> json) =>
    _$NexoUserImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String,
      photoUrl: json['photoUrl'] as String?,
      createdAt: const ServerTimestampConverter().fromJson(json['createdAt']),
      updatedAt: const ServerTimestampConverter().fromJson(json['updatedAt']),
      sharedWith: (json['sharedWith'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      settings: json['settings'] == null
          ? const NexoUserSettings()
          : NexoUserSettings.fromJson(json['settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$NexoUserImplToJson(_$NexoUserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'createdAt': const ServerTimestampConverter().toJson(instance.createdAt),
      'updatedAt': const ServerTimestampConverter().toJson(instance.updatedAt),
      'sharedWith': instance.sharedWith,
      'settings': instance.settings,
    };

_$NexoUserSettingsImpl _$$NexoUserSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$NexoUserSettingsImpl(
      themeMode: json['themeMode'] as String? ?? 'system',
      mealNotificationsEnabled:
          json['mealNotificationsEnabled'] as bool? ?? true,
      calendarNotificationsEnabled:
          json['calendarNotificationsEnabled'] as bool? ?? true,
      language: json['language'] as String? ?? 'es',
    );

Map<String, dynamic> _$$NexoUserSettingsImplToJson(
        _$NexoUserSettingsImpl instance) =>
    <String, dynamic>{
      'themeMode': instance.themeMode,
      'mealNotificationsEnabled': instance.mealNotificationsEnabled,
      'calendarNotificationsEnabled': instance.calendarNotificationsEnabled,
      'language': instance.language,
    };
