import 'package:flutter/material.dart';
import 'package:look_back/global.dart';

class AppState with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  Future<void> loadTheme() async {
    final theme = await themeService.getThemeMode();
    themeMode = theme;
    notifyListeners();
  }

  Future<void> changeTheme(ThemeMode newTheme) async {
    themeMode = newTheme;
    notifyListeners();
    await themeService.setThemeMode(newTheme);
  }
}
