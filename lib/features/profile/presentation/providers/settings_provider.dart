
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsController extends _$SettingsController {
  static const String _notificationsKey = 'notifications_enabled';

  @override
  bool build() {
    // Valor inicial temporal mientras carga SharedPreferences
    _loadSettings();
    return true; 
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_notificationsKey) ?? true;
  }

  Future<void> toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsKey, value);
    state = value;
  }
}
