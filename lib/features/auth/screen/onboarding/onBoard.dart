import 'package:demo_proj/features/auth/controller/controller.onboarding/onBoard_controller.dart';
import 'package:demo_proj/features/auth/screen/onboarding/widget/next_button.dart';
import 'package:demo_proj/features/auth/screen/onboarding/widget/onBoard.page.dart';
import 'package:demo_proj/features/auth/screen/onboarding/widget/skip_button.dart';
import 'package:demo_proj/features/auth/screen/onboarding/widget/smoth_page_ind.dart';
import 'package:demo_proj/core/utils/utils/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OnboardController>(context);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePage,
            children: [
              OnBoardPage(
                image: AppImages.logo1,
                title: 'Find Your Perfect Plant',
                subtitle:
                    'Browse hundreds of indoor and outdoor plants for every space.',
              ),

              OnBoardPage(
                image: AppImages.logo2,
                title: 'Easy Plant Care',
                subtitle:
                    'Learn how to water, fertilize, and care for your plants effortlessly.',
              ),

              OnBoardPage(
                image: AppImages.logo3,
                title: 'Green Your Home',
                subtitle:
                    'Order your favorite plants and make your home fresh and beautiful.',
              ),
            ],
          ),
          SkipButton(),
          SmothPageInd(),
          NextButton(),
        ],
      ),
    );
  }
}
