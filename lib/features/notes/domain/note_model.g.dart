// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NexoNoteImpl _$$NexoNoteImplFromJson(Map<String, dynamic> json) =>
    _$NexoNoteImpl(
      id: json['id'] as String,
      ownerUid: json['ownerUid'] as String,
      title: json['title'] as String,
      type:
          $enumDecodeNullable(_$NoteTypeEnumMap, json['type']) ?? NoteType.text,
      content: json['content'] as String?,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => NoteItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      accentColor: json['accentColor'] as String?,
      sharedWith: (json['sharedWith'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      status: $enumDecodeNullable(_$NoteStatusEnumMap, json['status']) ??
          NoteStatus.active,
      isAiEnhanced: json['isAiEnhanced'] as bool? ?? false,
      isPinned: json['isPinned'] as bool? ?? false,
      noteSubType: json['noteSubType'] as String?,
      richContent: json['richContent'] as String?,
      isPrimaryShoppingList: json['isPrimaryShoppingList'] as bool? ?? false,
      aiSummary: json['aiSummary'] as String?,
      backgroundPattern: json['backgroundPattern'] as String?,
      scheduledDate:
          const ServerTimestampConverter().fromJson(json['scheduledDate']),
      isPublic: json['isPublic'] as bool? ?? false,
      createdAt: const ServerTimestampConverter().fromJson(json['createdAt']),
      updatedAt: const ServerTimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$NexoNoteImplToJson(_$NexoNoteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerUid': instance.ownerUid,
      'title': instance.title,
      'type': _$NoteTypeEnumMap[instance.type]!,
      'content': instance.content,
      'items': instance.items,
      'tags': instance.tags,
      'accentColor': instance.accentColor,
      'sharedWith': instance.sharedWith,
      'status': _$NoteStatusEnumMap[instance.status]!,
      'isAiEnhanced': instance.isAiEnhanced,
      'isPinned': instance.isPinned,
      'noteSubType': instance.noteSubType,
      'richContent': instance.richContent,
      'isPrimaryShoppingList': instance.isPrimaryShoppingList,
      'aiSummary': instance.aiSummary,
      'backgroundPattern': instance.backgroundPattern,
      'scheduledDate':
          const ServerTimestampConverter().toJson(instance.scheduledDate),
      'isPublic': instance.isPublic,
      'createdAt': const ServerTimestampConverter().toJson(instance.createdAt),
      'updatedAt': const ServerTimestampConverter().toJson(instance.updatedAt),
    };

const _$NoteTypeEnumMap = {
  NoteType.text: 'text',
  NoteType.list: 'list',
  NoteType.itinerary: 'itinerary',
};

const _$NoteStatusEnumMap = {
  NoteStatus.active: 'active',
  NoteStatus.archived: 'archived',
  NoteStatus.deleted: 'deleted',
};

_$NoteItemImpl _$$NoteItemImplFromJson(Map<String, dynamic> json) =>
    _$NoteItemImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      isChecked: json['isChecked'] as bool? ?? false,
      order: (json['order'] as num?)?.toInt() ?? 0,
      scheduledAt:
          const ServerTimestampConverter().fromJson(json['scheduledAt']),
      location: json['location'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$NoteItemImplToJson(_$NoteItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'isChecked': instance.isChecked,
      'order': instance.order,
      'scheduledAt':
          const ServerTimestampConverter().toJson(instance.scheduledAt),
      'location': instance.location,
      'notes': instance.notes,
    };
