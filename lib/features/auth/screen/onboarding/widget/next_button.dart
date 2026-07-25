import 'package:demo_proj/features/auth/controller/controller.onboarding/onBoard_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OnboardController>();

    return Positioned(
      left: 30,
      right: 30,
      bottom: 40,
      child: controller.isLastPage
          ? SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  context.read<OnboardController>().nextPage(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 60,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<OnboardController>().nextPage(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: const CircleBorder(),
                  ),
                  child: Center(
                    child: const Icon(
                      Iconsax.arrow_right_3,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
