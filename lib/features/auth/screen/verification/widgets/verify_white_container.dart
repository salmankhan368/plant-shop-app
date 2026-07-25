import 'package:demo_proj/core/utils/flush/app_flushbar.dart';
import 'package:demo_proj/features/auth/controller/auth_controller.dart';
import 'package:demo_proj/features/auth/screen/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class VerifyWhiteContainer extends StatelessWidget {
  const VerifyWhiteContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    final user = FirebaseAuth.instance.currentUser;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
        child: Column(
          children: [
            /// Email Icon
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.sms_notification,
                size: 45,
                color: Colors.green.shade600,
              ),
            ),

            const SizedBox(height: 30),

            /// Title
            const Text(
              "Verify Your Email",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            /// Description
            const Text(
              "We've sent a verification link to your email address. "
              "Please check your inbox and click the verification link before continuing.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.grey, height: 1.5),
            ),

            const SizedBox(height: 25),

            /// Email
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Icon(Icons.email_outlined, color: Colors.green),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      user?.email ?? "No Email Found",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            /// Verify Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: authController.isLoading
                    ? null
                    : () async {
                        bool verified = await authController
                            .checkEmailVerified();
                        if (verified) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const HomePage()),
                          );
                        } else {
                          AppFlushBar.showError(
                            context,
                            "Please verify your email first.",
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "I've Verified My Email",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Resend Email
            TextButton(
              onPressed: (authController.canResend || authController.isLoading)
                  ? null
                  : () async {
                      await authController.sendEmailVerification();
                      if (authController.error == null) {
                        AppFlushBar.showSuccess(
                          context,
                          'Verification Email sent successfully',
                          '',
                        );
                      } else {
                        AppFlushBar.showError(context, authController.error!);
                      }
                    },
              child: Text(
                authController.canResend
                    ? "Resend Email"
                    : "Resend in ${authController.countDown}s",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            /// Change Email
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Change Email",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
