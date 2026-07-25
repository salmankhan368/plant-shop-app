import 'package:demo_proj/features/auth/screen/forget/widget/green_container.dart';
import 'package:demo_proj/features/auth/screen/forget/widget/white_container.dart';

import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade400,
      body: Column(
        children: const [
          Expanded(flex: 2, child: FGreenContainer()),
          Expanded(flex: 5, child: FWhiteContainer()),
        ],
      ),
    );
  }
}
