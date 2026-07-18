import 'package:flutter/material.dart';
import 'package:look_back/domain/services/theme_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _ThemeService implements ThemeService {
  final _prefs=SharedPreferencesAsync();
  final _themeModeKey = 'theme_mode';
  _ThemeService();


  @override
  Future<void> clear() async {
    await _prefs.clear();
  }
  
  @override
  Future<ThemeMode> getThemeMode() async {
    final themeModeName = await _prefs.getString(_themeModeKey);

    return ThemeMode.values.firstWhere(
      (themeMode) => themeMode.name == themeModeName,
      orElse: () => ThemeMode.system,
    );
  }
  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _prefs.setString(_themeModeKey, themeMode.name);
  }
}

ThemeService newThemeService() {
  return _ThemeService();
}
