import 'package:demo_proj/features/auth/screen/signup/widgets/siginup_white_container.dart';
import 'package:demo_proj/features/auth/screen/signup/widgets/signup_green_container.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.green.shade400,
      body: Column(
        children: [
          SizedBox(height: 240, child: SignupGreenContainer()),

          Expanded(child: SignupWhiteContainer()),
        ],
      ),
    );
  }
}
