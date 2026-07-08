import 'package:flutter/material.dart';

class InitialScreenState extends ChangeNotifier {
  final pageController = PageController();
  final nameController = TextEditingController();
  bool isLoading = false;

  int currentPage = 0;
  int pageCount = 3;
  int namePageIndex = 2;
  bool hasNavigatedToHome = false;

  bool get isOnNamePage => currentPage == namePageIndex;
  bool get canProceed => !isOnNamePage || nameController.text.trim().isNotEmpty;

  void onPageChanged(int page) {
    currentPage = page;
    notifyListeners();
  }

  void nextPage() {
    if (currentPage < pageCount - 1) {
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

  void markHomeNavigation() {
    hasNavigatedToHome = true;
    notifyListeners();
  }

  void goToHome(VoidCallback onNavigateToHome) {
    if (hasNavigatedToHome) return;

    markHomeNavigation();
    onNavigateToHome();
  }

  void handlePageChanged(int page, {required VoidCallback onNavigateToHome}) {
    currentPage = page;
    notifyListeners();

    if (page == namePageIndex) {
      Future.delayed(const Duration(milliseconds: 450), () {
        if (!hasNavigatedToHome) {
          goToHome(onNavigateToHome);
        }
      });
    }
  }

  void handlePrimaryAction({required VoidCallback onNavigateToHome}) {
    if (isOnNamePage) {
      goToHome(onNavigateToHome);
    } else {
      nextPage();
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    nameController.dispose();
    super.dispose();
  }
}