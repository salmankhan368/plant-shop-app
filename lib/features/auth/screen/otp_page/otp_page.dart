import 'package:demo_proj/features/auth/screen/otp_page/widget/otp_green_container.dart';
import 'package:demo_proj/features/auth/screen/otp_page/widget/otp_white_container.dart';
import 'package:flutter/material.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade400,
      body: const Column(
        children: [
          Expanded(flex: 2, child: OtpGreenContainer()),
          Expanded(flex: 5, child: OtpWhiteContainer()),
        ],
      ),
    );
  }
}
