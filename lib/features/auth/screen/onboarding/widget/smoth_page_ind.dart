import 'package:demo_proj/features/auth/controller/controller.onboarding/onBoard_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmothPageInd extends StatelessWidget {
  const SmothPageInd({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<OnboardController>();
    return Positioned(
      left: 24,
      bottom: 40,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        count: 3,
        effect: ExpandingDotsEffect(activeDotColor: Colors.green, dotWidth: 6),
      ),
    );
  }
}
