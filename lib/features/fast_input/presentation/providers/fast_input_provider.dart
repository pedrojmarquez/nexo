import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nexo/features/auth/presentation/providers/auth_provider.dart';
import 'package:nexo/features/fast_input/data/ai_repository.dart';
import 'package:nexo/features/notes/domain/note_model.dart';
import 'package:nexo/features/notes/presentation/providers/notes_provider.dart';

part 'fast_input_provider.g.dart';

@riverpod
AiRepository aiRepository(Ref ref) => AiRepository();

@riverpod
class FastInputController extends _$FastInputController {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  /// Procesa la entrada cruda usando Gemini y la guarda en Firestore como una Nota
  Future<void> processAndSaveInput(String rawInput) async {
    final user = ref.read(authStateChangesProvider).valueOrNull;
    if (user == null) {
      state = AsyncValue.error('Usuario no autenticado', StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();

    try {
      // 1. Llamar a la IA
      final aiRepo = ref.read(aiRepositoryProvider);
      final structuredDataList = await aiRepo.parseUserInput(rawInput);

      // 2. Procesar cada nota resultante
      for (final structuredData in structuredDataList) {
        final isList = structuredData['type'] == 'list';

        if (isList) {
          // Buscar lista de compra principal
          final allNotes =
              await ref.read(notesRepositoryProvider).getUserNotes(user.uid);
          final primaryList = allNotes.cast<NexoNote?>().firstWhere(
              (n) => n?.isPrimaryShoppingList == true,
              orElse: () => null);

          if (primaryList != null) {
            // Añadir items a la lista existente
            final newItems =
                (structuredData['items'] as List<dynamic>).map((itemMap) {
              return NoteItem.fromJson(itemMap as Map<String, dynamic>);
            }).toList();

            final updatedNote = primaryList.copyWith(
              items: [...primaryList.items, ...newItems],
              updatedAt: DateTime.now(),
            );
            await ref.read(notesRepositoryProvider).updateNote(updatedNote);
            continue; // Saltar a la siguiente nota del AI
          }
        }

        // Crear nueva nota si no es lista o no hay principal
        final type = isList ? NoteType.list : NoteType.text;
        final items = (structuredData['items'] as List<dynamic>).map((itemMap) {
          return NoteItem.fromJson(itemMap as Map<String, dynamic>);
        }).toList();

        final note = NexoNote(
          id: '',
          ownerUid: user.uid,
          title: structuredData['title'] as String,
          type: type,
          content: structuredData['content'] as String?,
          items: items,
          isAiEnhanced: true,
          accentColor: '#93C5FD',
        );

        await ref.read(notesRepositoryProvider).createNote(note);
      }

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
