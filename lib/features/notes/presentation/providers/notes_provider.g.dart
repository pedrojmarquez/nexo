// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notesRepositoryHash() => r'd9603278b6cc3a7a49c222d950c73798883335e4';

/// See also [notesRepository].
@ProviderFor(notesRepository)
final notesRepositoryProvider = AutoDisposeProvider<NotesRepository>.internal(
  notesRepository,
  name: r'notesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotesRepositoryRef = AutoDisposeProviderRef<NotesRepository>;
String _$userNotesHash() => r'a9ef4f585ace4a8aeb4d83bf012c17f2e11360af';

/// Stream de todas las notas activas del usuario actual
///
/// Copied from [userNotes].
@ProviderFor(userNotes)
final userNotesProvider = AutoDisposeStreamProvider<List<NexoNote>>.internal(
  userNotes,
  name: r'userNotesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userNotesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserNotesRef = AutoDisposeStreamProviderRef<List<NexoNote>>;
String _$notesControllerHash() => r'8f08828b62477ba8d7a26ef0703994e20cacfa43';

/// Controlador para crear/editar notas de forma asíncrona
///
/// Copied from [NotesController].
@ProviderFor(NotesController)
final notesControllerProvider =
    AutoDisposeAsyncNotifierProvider<NotesController, void>.internal(
  NotesController.new,
  name: r'notesControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notesControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NotesController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
