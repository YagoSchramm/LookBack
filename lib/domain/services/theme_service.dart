import 'package:flutter/material.dart';

abstract class ThemeService {
  Future<void> setThemeMode(ThemeMode themeMode);

  Future<ThemeMode> getThemeMode();

  Future<void> clear();
}
