import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nexo/features/auth/presentation/providers/auth_provider.dart';
import 'package:nexo/features/auth/presentation/login_page.dart';
import 'package:nexo/features/home/presentation/home_shell.dart';
import 'package:nexo/features/notes/presentation/notes_page.dart';
import 'package:nexo/features/fast_input/presentation/fast_input_page.dart';
import 'package:nexo/features/notes/presentation/note_editor_page.dart';
import 'package:nexo/features/notes/presentation/postit_editor_page.dart';
import 'package:nexo/features/notes/presentation/shopping_list_editor_page.dart';
import 'package:nexo/features/notes/domain/note_model.dart';
import 'package:nexo/features/profile/presentation/profile_page.dart';
import 'package:nexo/features/meals/presentation/meals_page.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/features/notes/presentation/share_note_page.dart';

part 'app_router.g.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// AppRouter — GoRouter configurado con redirección basada en auth state
/// ─────────────────────────────────────────────────────────────────────────────
@riverpod
GoRouter appRouter(Ref ref) {
  // ValueNotifier que GoRouter escucha para forzar re-evaluación de redirect
  final authNotifier = ValueNotifier<bool>(false);

  ref.listen(authStateChangesProvider, (_, next) {
    authNotifier.value = !authNotifier.value; // toggle para forzar refresh
  });

  ref.onDispose(authNotifier.dispose);

  return GoRouter(
    debugLogDiagnostics: false,
    refreshListenable: authNotifier,
    initialLocation: '/notas',
    // ── Redirección global basada en estado de auth ─────────────────────
    redirect: (context, state) {
      final authValue = ref.read(authStateChangesProvider);
      final isLoading = authValue.isLoading;
      if (isLoading) return null;

      final isLoggedIn = authValue.valueOrNull != null;
      final isOnLogin = state.matchedLocation == '/login';
      final isRoot = state.matchedLocation == '/';

      if (!isLoggedIn && !isOnLogin) return '/login';
      if (isLoggedIn && (isOnLogin || isRoot)) return '/notas';
      return null;
    },
    routes: [
      // ── Login ──────────────────────────────────────────────────────────
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginPage(),
          transitionsBuilder: (context, animation, _, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      // ── Shell con NavigationBar (3 módulos) ────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            HomeShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/notas',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: NotesPage(),
              ),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/comidas',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: MealsPage(),
              ),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/perfil',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ProfilePage(),
              ),
            ),
          ]),
        ],
      ),
      // ── Rutas fuera del Shell (Pantalla completa) ──────────────────
      GoRoute(
        path: '/notas/detalle',
        builder: (context, state) {
          final note = state.extra as NexoNote?;
          return NoteEditorPage(note: note);
        },
      ),
      GoRoute(
        path: '/notas/nuevo',
        builder: (context, state) => const NoteEditorPage(),
      ),
      GoRoute(
        path: '/notas/postit',
        pageBuilder: (context, state) {
          final note = state.extra as NexoNote?;
          return CustomTransitionPage(
            key: state.pageKey,
            child: PostItEditorPage(note: note),
            transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: '/notas/lista',
        pageBuilder: (context, state) {
          final note = state.extra as NexoNote?;
          return CustomTransitionPage(
            key: state.pageKey,
            child: ShoppingListEditorPage(note: note),
            transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
          );
        },
      ),
      GoRoute(
        path: '/notas/compartir',
        builder: (context, state) {
          final note = state.extra as NexoNote;
          return ShareNotePage(note: note);
        },
      ),
    ],
  );
}
