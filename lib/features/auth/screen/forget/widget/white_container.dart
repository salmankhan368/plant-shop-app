import 'package:demo_proj/core/utils/flush/app_flushbar.dart';
import 'package:demo_proj/features/auth/controller/auth_controller.dart';
import 'package:demo_proj/features/auth/screen/login/widget/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class FWhiteContainer extends StatefulWidget {
  const FWhiteContainer({super.key});

  @override
  State<FWhiteContainer> createState() => _WhiteContainerState();
}

class _WhiteContainerState extends State<FWhiteContainer> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.all(25),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),

            CustomTextField(
              controller: emailController,
              hintText: "Enter your email",
              prefixIcon: Iconsax.direct_right,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email is required";
                }

                if (!RegExp(
                  r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value.trim())) {
                  return "Enter a valid email";
                }

                return null;
              },
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: authController.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          // Firebase Reset Password
                          authController.forgetPassword(
                            email: emailController.text.trim(),
                          );
                          if (authController.error == null) {
                            AppFlushBar.showSuccess(
                              context,
                              "Password reset email sent successfully.",
                              '',
                            );

                            await Future.delayed(const Duration(seconds: 2));

                            Navigator.pop(context);
                          } else {
                            AppFlushBar.showError(
                              context,
                              authController.error!,
                            );
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: authController.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.2,
                        ),
                      )
                    : Text(
                        "Send Reset Link",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 25),

            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.green),
              label: const Text(
                "Back to Login",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
