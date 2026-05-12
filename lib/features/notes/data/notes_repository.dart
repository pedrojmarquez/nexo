import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexo/core/constants/app_constants.dart';
import 'package:nexo/features/notes/domain/note_model.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// NotesRepository — Acceso a datos para Nexo Notas
/// ─────────────────────────────────────────────────────────────────────────────
class NotesRepository {
  final FirebaseFirestore _firestore;

  NotesRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<NexoNote> get _notesRef => _firestore
      .collection(AppConstants.notesCollection)
      .withConverter<NexoNote>(
        fromFirestore: (doc, _) => NexoNote.fromFirestore(doc),
        toFirestore: (note, _) {
          final json = note.toJson();
          json['items'] = note.items.map((item) => item.toJson()).toList();
          json.remove('id');
          return json;
        },
      );

  /// Obtiene un Stream de todas las notas activas del usuario (propias + compartidas)
  Stream<List<NexoNote>> watchUserNotes(String uid) {
    // Buscamos notas donde el usuario es dueño, o está en el array sharedWith.
    // Como Firestore no permite "OR" simple entre arrays y campos igualados en streams tan fáciles sin índices complejos,
    // filtramos primero por ownerUid y luego (en una app real escalada) uniremos streams o usaremos un índice `Filter.or`.
    // Usaremos Filter.or para máxima eficiencia. Requiere índice compuesto si se combina con orderBy.
    return _notesRef
        .where(
          Filter.or(
            Filter('ownerUid', isEqualTo: uid),
            Filter('sharedWith', arrayContains: uid),
          ),
        )
        .where('status', isEqualTo: NoteStatus.active.name)
        // orderBy('updatedAt', descending: true) requeriría un índice compuesto en Firestore
        .snapshots()
        .map((snapshot) {
      final notes = snapshot.docs.map((doc) => doc.data()).toList();
      // Ordenamos en cliente para evitar requerir el índice de Firestore inmediatamente
      notes.sort((a, b) {
        final dateA = a.updatedAt ??
            a.createdAt ??
            DateTime.fromMillisecondsSinceEpoch(0);
        final dateB = b.updatedAt ??
            b.createdAt ??
            DateTime.fromMillisecondsSinceEpoch(0);
        return dateB.compareTo(dateA); // Descendente
      });
      return notes;
    });
  }

  /// Obtiene una lista estática de notas del usuario (propias + compartidas)
  Future<List<NexoNote>> getUserNotes(String uid) async {
    final snapshot = await _notesRef
        .where(
          Filter.or(
            Filter('ownerUid', isEqualTo: uid),
            Filter('sharedWith', arrayContains: uid),
          ),
        )
        .where('status', isEqualTo: NoteStatus.active.name)
        .get();

    final notes = snapshot.docs.map((doc) => doc.data()).toList();
    notes.sort((a, b) {
      final dateA =
          a.updatedAt ?? a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final dateB =
          b.updatedAt ?? b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return dateB.compareTo(dateA);
    });
    return notes;
  }

  /// Crea una nueva nota
  Future<void> createNote(NexoNote note) async {
    final docRef = _notesRef.doc();
    final newNote = note.copyWith(
      id: docRef.id,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await docRef.set(newNote);
  }

  /// Actualiza una nota existente
  Future<void> updateNote(NexoNote note) async {
    final updatedNote = note.copyWith(updatedAt: DateTime.now());
    await _notesRef.doc(note.id).set(updatedNote, SetOptions(merge: true));
  }

  /// Borrado lógico de una nota (cambia status a deleted)
  Future<void> deleteNote(String noteId) async {
    await _firestore
        .collection(AppConstants.notesCollection)
        .doc(noteId)
        .update({
      'status': NoteStatus.deleted.name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Quita a un usuario del array sharedWith (para borrado selectivo)
  Future<void> removeUserFromSharedNote(String noteId, String uid) async {
    await _firestore
        .collection(AppConstants.notesCollection)
        .doc(noteId)
        .update({
      'sharedWith': FieldValue.arrayRemove([uid]),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
