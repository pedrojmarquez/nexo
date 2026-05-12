import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:nexo/core/router/app_router.dart';
import 'package:nexo/core/theme/app_theme.dart';
import 'package:nexo/features/notes/domain/note_model.dart';
import 'package:nexo/features/notes/presentation/providers/notes_provider.dart';
import 'package:nexo/features/meals/presentation/providers/meals_provider.dart';
import 'package:nexo/core/services/home_widget_service.dart';
import 'package:nexo/core/theme/theme_provider.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// NexoApp — Widget raíz. Usa GoRouter generado por Riverpod.
/// ─────────────────────────────────────────────────────────────────────────────
class NexoApp extends ConsumerStatefulWidget {
  const NexoApp({super.key});

  @override
  ConsumerState<NexoApp> createState() => _NexoAppState();
}

class _NexoAppState extends ConsumerState<NexoApp> {
  @override
  void initState() {
    super.initState();
    _checkHomeWidgetLaunch();
  }

  void _checkHomeWidgetLaunch() {
    HomeWidget.initiallyLaunchedFromHomeWidget().then(_handleHomeWidgetClick);
    HomeWidget.widgetClicked.listen(_handleHomeWidgetClick);
  }

  void _handleHomeWidgetClick(Uri? uri) {
    if (uri?.host == 'add_note') {
      // Navegar a la pantalla de creación de post-it
      ref.read(appRouterProvider).push('/notes/post-it/new');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ── Sincronización con Home Widgets ────────────────────────────────
    ref.listen(userNotesProvider, (previous, next) {
      if (next.hasValue) {
        final notes = next.value!;

        // Post-it más reciente
        final postit =
            notes.where((n) => n.noteSubType == 'post_it').firstOrNull;
        HomeWidgetService.updatePostItWidget(postit);

        // Lista de la compra principal
        final shopping =
            notes.where((n) => n.isPrimaryShoppingList).firstOrNull;
        HomeWidgetService.updateShoppingListWidget(shopping);

        // Tablón diario (post-its programados)
        HomeWidgetService.updateDailyBoardWidget(notes);
      }
    });

    ref.listen(activeMealPlanProvider, (previous, next) {
      if (next.hasValue) {
        final weekStart = ref.read(selectedWeekProvider);
        HomeWidgetService.updateMealCalendarWidget(next.value, weekStart);
      }
    });

    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeControllerProvider);

    return MaterialApp.router(
      title: 'Nexo',
      debugShowCheckedModeBanner: false,
      theme: NexoTheme.light,
      darkTheme: NexoTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
      ],
    );
  }
}
