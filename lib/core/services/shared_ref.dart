import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  static const String _onboardKey = 'onboarding_completed';

  Future<void> savedOnboardStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardKey, true);
  }

  Future<bool> getOnboardStatus() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_onboardKey) ?? false;
  }
}
