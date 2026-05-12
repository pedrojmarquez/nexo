import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nexo/features/auth/presentation/providers/auth_provider.dart';
import 'package:nexo/features/notes/data/notes_repository.dart';
import 'package:nexo/features/notes/domain/note_model.dart';
import 'package:nexo/features/auth/data/auth_repository.dart';

part 'notes_provider.g.dart';

@riverpod
NotesRepository notesRepository(Ref ref) => NotesRepository();

/// Stream de todas las notas activas del usuario actual
@riverpod
Stream<List<NexoNote>> userNotes(Ref ref) {
  final user = ref.watch(authStateChangesProvider).valueOrNull;
  if (user == null) return const Stream.empty();

  return ref.watch(notesRepositoryProvider).watchUserNotes(user.uid);
}

/// Controlador para crear/editar notas de forma asíncrona
@riverpod
class NotesController extends _$NotesController {
  @override
  FutureOr<void> build() {}

  Future<void> createTextNote(
    String title,
    String content, {
    String? color,
    String? richContent,
    bool isPinned = false,
    String noteSubType = 'text',
  }) async {
    final user = ref.read(authStateChangesProvider).valueOrNull;
    if (user == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final note = NexoNote(
        id: '', // Firestore genera el ID
        ownerUid: user.uid,
        title: title.isEmpty ? 'Sin título' : title,
        content: content,
        type: NoteType.text,
        accentColor: color,
        richContent: richContent,
        isPinned: isPinned,
        noteSubType: noteSubType,
      );
      await ref.read(notesRepositoryProvider).createNote(note);
    });
  }

  Future<void> createListNote(
    String title,
    List<NoteItem> items, {
    bool isPrimary = false,
    String? color,
  }) async {
    final user = ref.read(authStateChangesProvider).valueOrNull;
    if (user == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final note = NexoNote(
        id: '',
        ownerUid: user.uid,
        title: title.isEmpty ? 'Lista sin título' : title,
        type: NoteType.list,
        items: items,
        accentColor: color,
        isPrimaryShoppingList: isPrimary,
        noteSubType: isPrimary ? 'shopping_principal' : 'list',
      );
      await ref.read(notesRepositoryProvider).createNote(note);
    });
  }

  Future<void> toggleNoteStatus(String noteId, NoteStatus newStatus) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // Optamos por actualizar solo el campo usando una transacción o un update directo
      // Para simplificar, usamos deleteNote si el nuevo estado es deleted.
      if (newStatus == NoteStatus.deleted) {
        await ref.read(notesRepositoryProvider).deleteNote(noteId);
      }
    });
  }

  Future<void> updateNote(NexoNote note) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(notesRepositoryProvider).updateNote(note);
    });
  }

  Future<void> deleteNote(String noteId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = ref.read(authStateChangesProvider).valueOrNull;
      if (user == null) return;

      final repo = ref.read(notesRepositoryProvider);
      final allNotes = await repo.getUserNotes(user.uid);
      final note = allNotes.cast<NexoNote?>().firstWhere(
            (n) => n?.id == noteId,
            orElse: () => null,
          );

      if (note == null) return;

      // Si soy usuario compartido (no soy el dueño), solo me quito del array
      if (note.ownerUid != user.uid) {
        await repo.removeUserFromSharedNote(noteId, user.uid);
      } else {
        // Soy el dueño → borrado lógico normal
        await repo.deleteNote(noteId);
      }
    });
  }

  Future<void> setPrimaryShoppingList(String noteId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(notesRepositoryProvider);
      final user = ref.read(authStateChangesProvider).valueOrNull;
      if (user == null) return;

      // 1. Buscar todas las notas del usuario
      final notes = await repo.getUserNotes(user.uid);

      // 2. Desactivar el flag en todas las listas de compra
      for (final note in notes) {
        if (note.isPrimaryShoppingList) {
          await repo.updateNote(note.copyWith(isPrimaryShoppingList: false));
        }
      }

      // 3. Activar el flag en la seleccionada
      final selectedNote = notes.firstWhere((n) => n.id == noteId);
      await repo.updateNote(selectedNote.copyWith(
        isPrimaryShoppingList: true,
        noteSubType: 'shopping_principal', // Aseguramos el subtipo
      ));
    });
  }

  Future<void> shareNoteWithUser(String noteId, String email) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authRepo = ref.read(authRepositoryProvider);
      final notesRepo = ref.read(notesRepositoryProvider);
      final currentUser = ref.read(authStateChangesProvider).value;
      if (currentUser == null) return;

      // 1. Buscar usuario por email
      final targetUser = await authRepo.findUserByEmail(email);
      if (targetUser == null) {
        throw Exception('No se encontró ningún usuario con ese email.');
      }

      // 2. Obtener nota actual
      final allNotes = await notesRepo.getUserNotes(currentUser.uid);
      final note = allNotes.firstWhere((n) => n.id == noteId);

      // 3. Añadir al array sharedWith si no está
      if (note.sharedWith.contains(targetUser.uid)) {
        throw Exception('Esta nota ya está compartida con este usuario.');
      }

      if (targetUser.uid == currentUser.uid) {
        throw Exception('No puedes compartir una nota contigo mismo.');
      }

      final updatedNote = note.copyWith(
        sharedWith: [...note.sharedWith, targetUser.uid],
        updatedAt: DateTime.now(),
      );

      await notesRepo.updateNote(updatedNote);
    });
  }
}
