import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nexo/core/utils/firestore_converters.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// NexoUser — Modelo del perfil de usuario en Firestore
///
/// Colección: /users/{uid}
///
/// Campos:
///   uid           → ID del usuario (mismo que Firebase Auth UID)
///   email         → Email de Google
///   displayName   → Nombre completo
///   photoUrl      → Avatar de Google
///   createdAt     → Timestamp de registro
///   updatedAt     → Última modificación
///   sharedWith    → Lista de UIDs con quien comparte workspace (Nexo Notas)
///   settings      → Preferencias del usuario (tema, notificaciones, etc.)
/// ─────────────────────────────────────────────────────────────────────────────

@freezed
class NexoUser with _$NexoUser {
  const factory NexoUser({
    required String uid,
    required String email,
    required String displayName,
    String? photoUrl,

    /// Timestamp de creación de la cuenta en Nexo
    @ServerTimestampConverter() DateTime? createdAt,

    /// Última vez que se actualizó el perfil
    @ServerTimestampConverter() DateTime? updatedAt,

    /// UIDs de otros usuarios con quienes se comparte el workspace
    @Default([]) List<String> sharedWith,

    /// Configuración personal del usuario
    @Default(NexoUserSettings()) NexoUserSettings settings,
  }) = _NexoUser;

  factory NexoUser.fromJson(Map<String, dynamic> json) =>
      _$NexoUserFromJson(json);

  /// Construye el modelo desde un DocumentSnapshot de Firestore
  factory NexoUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NexoUser.fromJson({...data, 'uid': doc.id});
  }
}

/// Configuración personal del usuario
@freezed
class NexoUserSettings with _$NexoUserSettings {
  const factory NexoUserSettings({
    /// Modo de tema: 'system' | 'light' | 'dark'
    @Default('system') String themeMode,

    /// Activar notificaciones de comidas con ingredientes faltantes
    @Default(true) bool mealNotificationsEnabled,

    /// Activar notificaciones de eventos del calendario
    @Default(true) bool calendarNotificationsEnabled,

    /// Idioma preferido: 'es' | 'en'
    @Default('es') String language,
  }) = _NexoUserSettings;

  factory NexoUserSettings.fromJson(Map<String, dynamic> json) =>
      _$NexoUserSettingsFromJson(json);
}
