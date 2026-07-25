import 'package:demo_proj/core/utils/utils/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(AppImages.splash, height: 260),

              const SizedBox(height: 20),

              Text(
                "Plantify",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Grow your green life",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),

              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}
