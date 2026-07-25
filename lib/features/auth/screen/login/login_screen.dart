import 'package:flutter/material.dart';
import 'package:demo_proj/features/auth/screen/login/widget/green_container.dart';
import 'package:demo_proj/features/auth/screen/login/widget/white_container.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(height: 240, child: GreenContainer()),

          Expanded(child: WhiteContainer()),
        ],
      ),
    );
  }
}
