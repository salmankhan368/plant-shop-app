import 'package:demo_proj/core/utils/enum/auth_status.dart';
import 'package:demo_proj/features/auth/controller/auth_controller.dart';
import 'package:demo_proj/features/auth/repository/share_pref_repo.dart';
import 'package:demo_proj/features/auth/screen/home/home_page.dart';
import 'package:demo_proj/features/auth/screen/login/login_screen.dart';
import 'package:demo_proj/features/auth/screen/onboarding/onBoard.dart';
import 'package:demo_proj/features/auth/screen/splash/widgets/splash_body.dart';
import 'package:demo_proj/features/auth/screen/verification/verify_email.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    // Splash animation delay
    await Future.delayed(const Duration(seconds: 3));

    final sharedPrefRepository = context.read<SharedPrefRepository>();
    final authController = context.read<AuthController>();

    // ==============================
    // Step 1 : Check Onboarding
    // ==============================

    final isOnboardingCompleted = await sharedPrefRepository.getOnboardStatus();

    if (!isOnboardingCompleted) {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnBoard()),
      );
      return;
    }

    // ==============================
    // Step 2 : Check Firebase Session
    // ==============================

    final status = await authController.checkUserSession();

    if (!mounted) return;

    switch (status) {
      case AuthStatus.loggedOut:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
        break;

      case AuthStatus.emailNotVerfied:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const VerifyEmailPage()),
        );
        break;

      case AuthStatus.authenticated:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: SplashBody());
  }
}
