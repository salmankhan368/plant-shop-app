import 'package:demo_proj/features/auth/screen/verification/widgets/verify_green_container.dart';
import 'package:demo_proj/features/auth/screen/verification/widgets/verify_white_container.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.green.shade400,
      body: Column(
        children: const [
          SizedBox(height: 220, child: VerifyGreenContainer()),

          Expanded(flex: 5, child: VerifyWhiteContainer()),
        ],
      ),
    );
  }
}
