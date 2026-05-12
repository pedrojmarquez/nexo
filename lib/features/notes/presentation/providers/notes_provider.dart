import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nexo/features/auth/presentation/providers/auth_provider.dart';
import 'package:nexo/features/notes/data/notes_repository.dart';
import 'package:nexo/core/services/home_widget_service.dart';
import 'package:nexo/features/notes/domain/note_model.dart';
import 'package:nexo/core/services/notification_service.dart';
import 'package:share_plus/share_plus.dart';

part 'notes_provider.g.dart';

@riverpod
NotesRepository notesRepository(Ref ref) => NotesRepository();

@riverpod
Stream<List<NexoNote>> userNotes(Ref ref) {
  final user = ref.watch(authStateChangesProvider).valueOrNull;
  if (user == null) return const Stream.empty();
  return ref.watch(notesRepositoryProvider).watchUserNotes(user.uid);
}

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
    DateTime? scheduledDate,
  }) async {
    final user = ref.read(authStateChangesProvider).valueOrNull;
    if (user == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final note = NexoNote(
        id: '', 
        ownerUid: user.uid,
        title: title.isEmpty ? 'Sin título' : title,
        content: content,
        type: NoteType.text,
        accentColor: color,
        richContent: richContent,
        isPinned: isPinned,
        noteSubType: noteSubType,
        scheduledDate: scheduledDate,
      );
      
      
      final newId = await ref.read(notesRepositoryProvider).createNote(note);

      // Sincronizar widgets
      final updatedNotes = [...ref.read(userNotesProvider).valueOrNull ?? <NexoNote>[], note.copyWith(id: newId)];
      HomeWidgetService.updateDailyBoardWidget(updatedNotes);
      if (noteSubType == 'post_it') {
        HomeWidgetService.updatePostItWidget(note.copyWith(id: newId));
      }

      if (scheduledDate != null) {
        await NotificationService().scheduleNotification(
          id: newId.hashCode,
          title: 'Recordatorio de Nexo',
          body: title.isEmpty ? (content.isEmpty ? 'Post-it' : content) : title,
          scheduledDate: scheduledDate,
        );
      }
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
      final newId = await ref.read(notesRepositoryProvider).createNote(note);

      // Sincronizar widgets
      final updatedNotes = [...ref.read(userNotesProvider).valueOrNull ?? <NexoNote>[], note.copyWith(id: newId)];
      HomeWidgetService.updateDailyBoardWidget(updatedNotes);
      if (isPrimary) {
        HomeWidgetService.updateShoppingListWidget(note.copyWith(id: newId));
      }
    });
  }

  Future<void> updateNote(NexoNote note) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(notesRepositoryProvider).updateNote(note);

      // Sincronizar widgets
      final currentNotes = ref.read(userNotesProvider).valueOrNull ?? <NexoNote>[];
      final updatedNotes = currentNotes.map((n) => n.id == note.id ? note : n).toList();
      HomeWidgetService.updateDailyBoardWidget(updatedNotes);
      if (note.noteSubType == 'post_it') {
        HomeWidgetService.updatePostItWidget(note);
      }
      if (note.isPrimaryShoppingList) {
        HomeWidgetService.updateShoppingListWidget(note);
      }

      if (note.scheduledDate != null) {
        await NotificationService().scheduleNotification(
          id: note.id.hashCode,
          title: 'Recordatorio de Nexo',
          body: note.title.isEmpty ? (note.content ?? 'Post-it') : note.title,
          scheduledDate: note.scheduledDate!,
        );
      } else {
        await NotificationService().cancelNotification(note.id.hashCode);
      }
    });
  }

  Future<void> deleteNote(String noteId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = ref.read(authStateChangesProvider).valueOrNull;
      if (user == null) return;

      final repo = ref.read(notesRepositoryProvider);
      
      // Intentamos obtener la nota de la lista actual en memoria para saber si somos dueños
      final currentNotes = ref.read(userNotesProvider).valueOrNull ?? [];
      final note = currentNotes.where((n) => n.id == noteId).firstOrNull;

      await NotificationService().cancelNotification(noteId.hashCode);
      
      if (note != null && note.ownerUid == user.uid) {
        await repo.deleteNote(noteId);
      } else if (note != null) {
        await repo.removeUserFromSharedNote(noteId, user.uid);
      } else {
        // Si no está en memoria, intentamos borrarla directamente (el repo fallará si no existe)
        await repo.deleteNote(noteId);
      }

      // Sincronizar widgets después de borrar
      final updatedNotes = (ref.read(userNotesProvider).valueOrNull ?? <NexoNote>[]).where((n) => n.id != noteId).toList();
      HomeWidgetService.updateDailyBoardWidget(updatedNotes);
      if (note?.noteSubType == 'post_it') {
        HomeWidgetService.updatePostItWidget(null);
      }
    });
  }

  Future<void> shareNoteWithUser(String noteId, String email) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authRepo = ref.read(authRepositoryProvider);
      final notesRepo = ref.read(notesRepositoryProvider);
      final currentUser = ref.read(authStateChangesProvider).value;
      if (currentUser == null) return;

      final targetUser = await authRepo.findUserByEmail(email);
      if (targetUser == null) {
        throw Exception('No se encontró ningún usuario con ese email.');
      }

      final notes = await notesRepo.getUserNotes(currentUser.uid);
      final note = notes.firstWhere((n) => n.id == noteId);

      if (note.sharedWith.contains(targetUser.uid)) {
        throw Exception('Esta nota ya está compartida con este usuario.');
      }

      final updatedNote = note.copyWith(
        sharedWith: [...note.sharedWith, targetUser.uid],
        updatedAt: DateTime.now(),
      );

      await notesRepo.updateNote(updatedNote);
    });
  }
  
  Future<void> setPrimaryShoppingList(String noteId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(notesRepositoryProvider);
      final user = ref.read(authStateChangesProvider).valueOrNull;
      if (user == null) return;
      final notes = await repo.getUserNotes(user.uid);
      for (final note in notes) {
        if (note.isPrimaryShoppingList) {
          await repo.updateNote(note.copyWith(isPrimaryShoppingList: false));
        }
      }
      final selectedNote = notes.firstWhere((n) => n.id == noteId);
      await repo.updateNote(selectedNote.copyWith(
        isPrimaryShoppingList: true,
        noteSubType: 'shopping_principal',
      ));

      // Sincronizar widgets
      final currentNotes = ref.read(userNotesProvider).valueOrNull ?? <NexoNote>[];
      final updatedNotes = currentNotes.map((n) => n.id == noteId ? selectedNote.copyWith(isPrimaryShoppingList: true) : n.copyWith(isPrimaryShoppingList: false)).toList();
      HomeWidgetService.updateDailyBoardWidget(updatedNotes);
      HomeWidgetService.updateShoppingListWidget(selectedNote.copyWith(isPrimaryShoppingList: true));
    });
  }

  Future<void> addItemsToPrimaryShoppingList(List<NoteItem> newItems) async {
    final user = ref.read(authStateChangesProvider).valueOrNull;
    if (user == null) return;

    final repo = ref.read(notesRepositoryProvider);
    final notes = await repo.getUserNotes(user.uid);
    
    NexoNote? primaryList = notes.cast<NexoNote?>().firstWhere(
      (n) => n?.isPrimaryShoppingList == true && n?.type == NoteType.list,
      orElse: () => null,
    );

    if (primaryList == null) {
      primaryList = notes.cast<NexoNote?>().firstWhere(
        (n) => n?.noteSubType == 'shopping_principal' || n?.noteSubType == 'list',
        orElse: () => null,
      );
    }

    if (primaryList != null) {
      final existingTexts = primaryList.items.map((i) => i.text.toLowerCase().trim()).toSet();
      final filteredNewItems = newItems.where((ni) => !existingTexts.contains(ni.text.toLowerCase().trim())).toList();
      
      if (filteredNewItems.isEmpty) return;

      final updatedItems = [...primaryList.items, ...filteredNewItems];
      await updateNote(primaryList.copyWith(items: updatedItems));
    } else {
      await createListNote('Lista de la Compra', newItems, isPrimary: true);
    }
  }

  Future<void> shareNoteViaLink(NexoNote note) async {
    final link = 'nexo://notes/invite?id=${note.id}';
    final text = '¡Hola! Te invito a colaborar en mi nota "${note.title}" en Nexo. Haz clic aquí para verla: $link';
    
    await ref.read(notesRepositoryProvider).updateNote(note.copyWith(
      isPublic: true, 
    ));

    await Share.share(text);
  }
}
