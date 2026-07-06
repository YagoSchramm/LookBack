import 'package:flutter/material.dart';

class InitialScreenState extends ChangeNotifier {
  final pageController = PageController();

  bool isLoading = false;

  int currentPage = 0;

  void onPageChanged(int page) {
    currentPage = page;
    notifyListeners();
  }

  void nextPage() {
    if (currentPage < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}