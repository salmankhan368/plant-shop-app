import 'package:demo_proj/features/auth/controller/controller.onboarding/onBoard_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      right: 20,

      child: TextButton(
        onPressed: () {
          context.read<OnboardController>().pageController.jumpToPage(2);
        },
        child: Text('Skip'),
      ),
    );
  }
}
