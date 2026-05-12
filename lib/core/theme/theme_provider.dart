import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeController extends _$ThemeController {
  static const _themeKey = 'app_theme_mode';

  @override
  ThemeMode build() {
    // Intentamos cargar el tema de forma asíncrona pero sin bloquear el build
    SharedPreferences.getInstance().then((prefs) {
      final index = prefs.getInt(_themeKey);
      if (index != null) {
        state = ThemeMode.values[index];
      }
    });
    return ThemeMode.system;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, mode.index);
  }
}
