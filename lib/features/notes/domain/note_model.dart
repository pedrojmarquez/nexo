import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nexo/core/utils/firestore_converters.dart';

part 'note_model.freezed.dart';
part 'note_model.g.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// NexoNote — Modelo de Nota/Lista compartida en Firestore
///
/// Colección: /notes/{noteId}
///
/// Una nota puede ser:
///   - tipo TEXT → nota de texto libre
///   - tipo LIST → lista de ítems (compra, tareas, etc.)
///   - tipo ITINERARY → lista enriquecida con fechas (generada por Gemini)
///
/// Compartición: el campo `sharedWith` contiene UIDs de usuarios que tienen
/// acceso de lectura/escritura. Las reglas de Firestore validan esto.
/// ─────────────────────────────────────────────────────────────────────────────

/// Tipos de nota disponibles en Nexo
enum NoteType {
  @JsonValue('text')
  text,

  @JsonValue('list')
  list,

  @JsonValue('itinerary')
  itinerary,
}

/// Estado de una nota
enum NoteStatus {
  @JsonValue('active')
  active,

  @JsonValue('archived')
  archived,

  @JsonValue('deleted')
  deleted,
}

@freezed
class NexoNote with _$NexoNote {
  const factory NexoNote({
    /// ID del documento en Firestore
    required String id,

    /// UID del usuario creador
    required String ownerUid,

    /// Título de la nota
    required String title,

    /// Tipo de nota: text, list, itinerary
    @Default(NoteType.text) NoteType type,

    /// Contenido de texto (para tipo TEXT)
    String? content,

    /// Lista de ítems (para tipo LIST e ITINERARY)
    @Default([]) List<NoteItem> items,

    /// Tags/categorías asignadas por IA o manualmente
    @Default([]) List<String> tags,

    /// Color de acento de la tarjeta (hex string, ej: "#6366F1")
    String? accentColor,

    /// UIDs de usuarios con acceso compartido
    @Default([]) List<String> sharedWith,

    /// Estado actual de la nota
    @Default(NoteStatus.active) NoteStatus status,

    /// Indica si la IA procesó y enriqueció esta nota
    @Default(false) bool isAiEnhanced,

    /// Indica si la nota está fijada en la parte superior del tablón
    @Default(false) bool isPinned,

    /// Subtipo de la nota (ej. 'post_it', 'shopping_principal', 'default')
    String? noteSubType,

    /// Contenido enriquecido en formato JSON de flutter_quill
    String? richContent,

    /// Indica si esta nota es la lista de la compra principal
    @Default(false) bool isPrimaryShoppingList,

    /// Resumen generado por Gemini (para notas largas)
    String? aiSummary,

    /// Patrón de fondo del editor (dots, grid, lines, waves, confetti, paper, stars, null=liso)
    String? backgroundPattern,

    /// Fecha programada (para notificaciones y tablón diario)
    @ServerTimestampConverter() DateTime? scheduledDate,

    /// Timestamp de creación
    @ServerTimestampConverter() DateTime? createdAt,

    /// Timestamp de última modificación
    @ServerTimestampConverter() DateTime? updatedAt,
  }) = _NexoNote;

  factory NexoNote.fromJson(Map<String, dynamic> json) =>
      _$NexoNoteFromJson(json);

  factory NexoNote.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NexoNote.fromJson({...data, 'id': doc.id});
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// NoteItem — Ítem individual dentro de una lista/itinerario
/// ─────────────────────────────────────────────────────────────────────────────
@freezed
class NoteItem with _$NoteItem {
  const factory NoteItem({
    /// ID único del ítem (UUID local)
    required String id,

    /// Texto del ítem
    required String text,

    /// ¿Está marcado como completado?
    @Default(false) bool isChecked,

    /// Orden de visualización
    @Default(0) int order,

    /// Para ítems de tipo ITINERARY: fecha/hora del evento
    @ServerTimestampConverter() DateTime? scheduledAt,

    /// Ubicación del ítem (para itinerarios)
    String? location,

    /// Notas adicionales del ítem
    String? notes,
  }) = _NoteItem;

  factory NoteItem.fromJson(Map<String, dynamic> json) =>
      _$NoteItemFromJson(json);
}
