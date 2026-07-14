import 'package:flutter/material.dart';
import 'package:look_back/domain/presentation/screen/home/home_screen.dart';
import 'package:look_back/domain/presentation/screen/profile/profile_screen.dart';
import 'package:look_back/domain/presentation/screen/settings/settings_screen.dart';

class NavigatePageState extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  Widget get currentPage {
    switch (_currentIndex) {
      case 1:
        return const ProfileScreen();
      case 2:
        return const SettingsScreen();
      case 0:
      default:
        return const HomeScreen();
    }
  }

  void setIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }
}
