import 'package:demo_proj/features/auth/repository/share_pref_repo.dart';
import 'package:demo_proj/features/auth/screen/login/login_screen.dart';
import 'package:flutter/material.dart';

class OnboardController extends ChangeNotifier {
  final SharedPrefRepository _repository;

  OnboardController(this._repository);

  int currentPage = 0;

  final PageController pageController = PageController();

  bool get isLastPage => currentPage == 2;

  void updatePage(int index) {
    currentPage = index;
    notifyListeners();
  }

  Future<void> nextPage(BuildContext context) async {
    if (!isLastPage) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Save onboarding status
      await completeOnboarding();

      // Navigate to Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  Future<void> skipPage(BuildContext context) async {
    // Save onboarding status
    await completeOnboarding();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  Future<void> completeOnboarding() async {
    await _repository.savedOnboardStatus();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
