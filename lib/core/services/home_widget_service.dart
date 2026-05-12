import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  static Future<void> updateShoppingListWidget(NexoNote? listNote) async {
    try {
      if (listNote != null) {
        await HomeWidget.saveWidgetData<String>(
            'shopping_title', listNote.title);

        // Enviamos todos los items como JSON (el widget filtrará o mostrará los primeros)
        final itemsJson = jsonEncode(listNote.items.map((e) => {
          'text': e.text,
          'isChecked': e.isChecked,
        }).toList());

        await HomeWidget.saveWidgetData<String>('shopping_items', itemsJson);
      } else {
        await HomeWidget.saveWidgetData<String>(
            'shopping_title', 'Lista de la compra');
        await HomeWidget.saveWidgetData<String>('shopping_items', '[]');
      }
      await HomeWidget.updateWidget(name: 'ShoppingWidgetProvider');
    } catch (e) {
      debugPrint('Error updating Shopping Widget: $e');
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

  static Future<void> updateDailyBoardWidget(List<NexoNote> notes) async {
    try {
      final now = DateTime.now();
      final todayPostIts = notes.where((n) {
        if (n.noteSubType != 'post_it' || n.scheduledDate == null) return false;
        final d = n.scheduledDate!;
        return d.year == now.year && d.month == now.month && d.day == now.day;
      }).toList();

      // Ordenar por hora
      todayPostIts.sort((a, b) => a.scheduledDate!.compareTo(b.scheduledDate!));

      final itemsJson = jsonEncode(todayPostIts.map((n) {
        final time =
            '${n.scheduledDate!.hour.toString().padLeft(2, '0')}:${n.scheduledDate!.minute.toString().padLeft(2, '0')}';
        return {
          'text': n.title,
          'time': time,
        };
      }).toList());

      await HomeWidget.saveWidgetData<String>('daily_board_items', itemsJson);
      await HomeWidget.updateWidget(name: 'DailyBoardWidgetProvider');
    } catch (e) {
      debugPrint('Error updating Daily Board Widget: $e');
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
