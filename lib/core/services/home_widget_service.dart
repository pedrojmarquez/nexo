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

        final activeItems =
            listNote.items.where((i) => !i.isChecked).take(5).toList();
        final total = listNote.items.length;
        final completed = listNote.items.where((i) => i.isChecked).length;

        final itemsJson = jsonEncode(activeItems.map((e) => e.text).toList());

        await HomeWidget.saveWidgetData<String>('shopping_items', itemsJson);
        await HomeWidget.saveWidgetData<String>(
            'shopping_progress', '$completed/$total');
        await HomeWidget.saveWidgetData<int>(
            'shopping_remaining_count', activeItems.length);
      } else {
        await HomeWidget.saveWidgetData<String>(
            'shopping_title', 'Lista de la compra');
        await HomeWidget.saveWidgetData<String>('shopping_items', '[]');
        await HomeWidget.saveWidgetData<String>('shopping_progress', '0/0');
        await HomeWidget.saveWidgetData<int>('shopping_remaining_count', 0);
      }
      await HomeWidget.updateWidget(name: 'ShoppingWidgetProvider');
    } catch (e) {
      debugPrint('Error updating Shopping Widget: $e');
    }
  }

  static Future<void> updateMealCalendarWidget(
      NexoMealPlan? plan, DateTime weekStart) async {
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
