import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:nexo/core/router/app_router.dart';
import 'package:nexo/core/theme/app_theme.dart';
import 'package:nexo/features/notes/presentation/providers/notes_provider.dart';
import 'package:nexo/features/meals/presentation/providers/meals_provider.dart';
import 'package:nexo/core/services/home_widget_service.dart';
import 'package:nexo/core/theme/theme_provider.dart';
import 'package:home_widget/home_widget.dart';
import 'package:nexo/features/notes/domain/note_model.dart';
import 'package:nexo/features/meals/domain/meal_plan_model.dart';

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

  Future<void> _handleHomeWidgetClick(Uri? uri) async {
    if (uri == null) return;
    debugPrint('HomeWidget Clicked: $uri');
    
    final router = ref.read(appRouterProvider);

    // Esperar a que los datos estén cargados si es necesario
    int retries = 0;
    while (ref.read(userNotesProvider).isLoading && retries < 10) {
      await Future.delayed(const Duration(milliseconds: 200));
      retries++;
    }

    // nexo://add_note
    if (uri.host == 'add_note' || uri.path.contains('add_note')) {
      router.push('/notas/postit');
      return;
    }

    // nexo://shopping_list
    if (uri.host == 'shopping_list' || uri.path.contains('shopping_list')) {
      router.push('/notas/lista');
      return;
    }

    // nexo://meals
    if (uri.host == 'meals' || uri.path.contains('meals')) {
      router.push('/comidas');
      return;
    }

    // nexo://notes/invite?id=... o nexo://notes/view?id=...
    if (uri.host == 'notes' && (uri.path.contains('view') || uri.path.contains('invite'))) {
      final noteId = uri.queryParameters['id'];
      if (noteId != null) {
        final notes = ref.read(userNotesProvider).valueOrNull ?? [];
        final note = notes.where((n) => n.id == noteId).firstOrNull;
        
        if (note != null) {
          if (note.noteSubType == 'post_it') {
            router.push('/notas/postit', extra: note);
          } else if (note.noteSubType == 'shopping_principal' || note.noteSubType == 'list') {
            router.push('/notas/lista', extra: note);
          } else {
            router.push('/notas/detalle', extra: note);
          }
        } else {
          // Si no existe, al menos ir al tablón
          router.go('/notas');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sincronización de Widgets
    ref.listen(userNotesProvider, (prev, next) {
      if (next.hasValue) {
        final notes = next.value!;
        final postit = notes.where((n) => n.noteSubType == 'post_it').firstOrNull;
        HomeWidgetService.updatePostItWidget(postit);
        final shopping = notes.where((n) => n.isPrimaryShoppingList).firstOrNull;
        HomeWidgetService.updateShoppingListWidget(shopping);
        HomeWidgetService.updateDailyBoardWidget(notes);
      }
    });

    ref.listen(activeMealPlanProvider, (prev, next) {
      if (next.hasValue) {
        HomeWidgetService.updateMealCalendarWidget(next.value);
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
      supportedLocales: const [Locale('es')],
    );
  }
}
