import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:nexo/firebase_options.dart';
import 'package:nexo/features/notes/domain/note_model.dart';
import 'package:nexo/features/meals/domain/meal_plan_model.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// HomeWidgetService — Sincroniza datos de la app con los widgets nativos
/// ─────────────────────────────────────────────────────────────────────────────
class HomeWidgetService {
  static const String androidAppWidgetGroup = 'NexoWidgetProvider';

  static Future<void> updatePostItWidget(NexoNote? note) async {
    try {
      if (note != null) {
        await HomeWidget.saveWidgetData<String>('postit_title', note.title);
        await HomeWidget.saveWidgetData<String>(
            'postit_content', note.content ?? '');
        await HomeWidget.saveWidgetData<String>(
            'postit_color', note.accentColor ?? '#FFF176');
      } else {
        await HomeWidget.saveWidgetData<String>(
            'postit_title', 'Sin post-it rápido');
        await HomeWidget.saveWidgetData<String>(
            'postit_content', 'Pulsa + para añadir un post-it en Nexo');
        await HomeWidget.saveWidgetData<String>('postit_color', '#FFF176');
      }
      await HomeWidget.updateWidget(name: 'PostItWidgetProvider');
    } catch (e) {
      debugPrint('Error updating PostIt Widget: $e');
    }
  }

  static Future<void> updateShoppingListWidget(NexoNote? note) async {
    try {
      if (note != null) {
        // Importante: guardamos también el `id` de cada item para que el
        // toggle desde el widget pueda identificar qué item alternar.
        final items = note.items.map((i) {
          return {
            'id': i.id,
            'text': i.text,
            'isChecked': i.isChecked,
          };
        }).toList();

        final itemsJson = jsonEncode(items);
        final checked = note.items.where((i) => i.isChecked).length;
        final total = note.items.length;

        await HomeWidget.saveWidgetData<String>('shopping_title', note.title);
        await HomeWidget.saveWidgetData<String>('shopping_id', note.id);
        await HomeWidget.saveWidgetData<String>('shopping_items', itemsJson);
        await HomeWidget.saveWidgetData<String>(
            'shopping_progress', '$checked/$total');
      } else {
        await HomeWidget.saveWidgetData<String>(
            'shopping_title', 'Lista de la compra');
        await HomeWidget.saveWidgetData<String>('shopping_id', '');
        await HomeWidget.saveWidgetData<String>('shopping_items', '[]');
        await HomeWidget.saveWidgetData<String>('shopping_progress', '0/0');
      }
      await HomeWidget.updateWidget(name: 'ShoppingWidgetProvider');
    } catch (e) {
      debugPrint('Error updating shopping widget: $e');
    }
  }

  static Future<void> updateMealCalendarWidget(NexoMealPlan? plan) async {
    try {
      if (plan != null) {
        final now = DateTime.now();
        final todayWeekday = Weekday.values[(now.weekday - 1).clamp(0, 6)];

        final todayMeals =
            plan.meals.where((m) => m.weekday == todayWeekday).toList();
        todayMeals.sort((a, b) => a.slot.index.compareTo(b.slot.index));

        final mealsJson = jsonEncode(todayMeals
            .map((m) => {
                  'name': m.recipe.name,
                  'slot': m.slot.name,
                })
            .toList());

        await HomeWidget.saveWidgetData<String>(
            'meal_today_name', _getDayName(todayWeekday));
        await HomeWidget.saveWidgetData<String>('meal_today_items', mealsJson);
      } else {
        await HomeWidget.saveWidgetData<String>('meal_today_name', 'Hoy');
        await HomeWidget.saveWidgetData<String>('meal_today_items', '[]');
      }
      await HomeWidget.updateWidget(name: 'MealCalendarWidgetProvider');
    } catch (e) {
      debugPrint('Error updating Meal Widget: $e');
    }
  }

  static Future<void> updateDailyBoardWidget(List<NexoNote> allNotes) async {
    try {
      final now = DateTime.now();
      final todayReminders = allNotes.where((n) {
        if (n.noteSubType != 'post_it' || n.scheduledDate == null) return false;
        final date = n.scheduledDate!;
        return date.year == now.year && date.month == now.month && date.day == now.day;
      }).toList();

      // Ordenar por hora
      todayReminders.sort((a, b) => a.scheduledDate!.compareTo(b.scheduledDate!));

      final items = todayReminders.map((n) {
        final time = '${n.scheduledDate!.hour.toString().padLeft(2, '0')}:${n.scheduledDate!.minute.toString().padLeft(2, '0')}';
        return {
          'text': n.content ?? n.title,
          'time': time,
        };
      }).toList();

      final itemsJson = jsonEncode(items);
      await HomeWidget.saveWidgetData<String>('daily_board_items', itemsJson);
      await HomeWidget.updateWidget(name: 'DailyBoardWidgetProvider');
    } catch (e) {
      debugPrint('Error updating daily board widget: $e');
    }
  }

  static String _getDayName(Weekday day) {
    switch (day) {
      case Weekday.monday: return 'Lunes';
      case Weekday.tuesday: return 'Martes';
      case Weekday.wednesday: return 'Miércoles';
      case Weekday.thursday: return 'Jueves';
      case Weekday.friday: return 'Viernes';
      case Weekday.saturday: return 'Sábado';
      case Weekday.sunday: return 'Domingo';
    }
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Callback en background invocado desde el widget nativo cuando el usuario
/// toca un item de la lista de la compra. Persiste el cambio en Firestore.
///
/// Debe ser top-level y estar anotado con @pragma('vm:entry-point') para que
/// el aislado en background pueda encontrarlo tras un cold start.
/// ─────────────────────────────────────────────────────────────────────────────
@pragma('vm:entry-point')
Future<void> shoppingWidgetBackgroundCallback(Uri? uri) async {
  if (uri == null) return;
  if (uri.host != 'shopping_toggle') return;

  final itemId = uri.queryParameters['itemId'];
  if (itemId == null || itemId.isEmpty) return;

  try {
    // Asegurar que Firebase está inicializado en este aislado.
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      debugPrint('[ShoppingWidget] Toggle ignorado: usuario no autenticado.');
      return;
    }

    final firestore = FirebaseFirestore.instance;

    // Localizar la lista principal del usuario (propia o compartida)
    final query = await firestore
        .collection('notes')
        .where(Filter.or(
          Filter('ownerUid', isEqualTo: user.uid),
          Filter('sharedWith', arrayContains: user.uid),
        ))
        .where('isPrimaryShoppingList', isEqualTo: true)
        .where('status', isEqualTo: 'active')
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      debugPrint('[ShoppingWidget] No hay lista principal para sincronizar.');
      return;
    }

    final doc = query.docs.first;
    final raw = doc.data();
    final rawItems = (raw['items'] as List<dynamic>? ?? []);

    bool didChange = false;
    final updatedItems = rawItems.map<Map<String, dynamic>>((it) {
      final m = Map<String, dynamic>.from(it as Map);
      if (m['id'] == itemId) {
        m['isChecked'] = !(m['isChecked'] as bool? ?? false);
        didChange = true;
      }
      return m;
    }).toList();

    if (!didChange) return;

    await doc.reference.update({
      'items': updatedItems,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    debugPrint('[ShoppingWidget] Item $itemId sincronizado con Firestore.');
  } catch (e, st) {
    debugPrint('[ShoppingWidget] Error sincronizando toggle: $e\n$st');
  }
}
