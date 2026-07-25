import 'package:demo_proj/core/utils/flush/app_flushbar.dart';
import 'package:demo_proj/features/auth/controller/auth_controller.dart';
import 'package:demo_proj/features/auth/screen/login/widget/custom_field.dart';
import 'package:demo_proj/features/auth/screen/verification/verify_email.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SignupWhiteContainer extends StatefulWidget {
  const SignupWhiteContainer({super.key});

  @override
  State<SignupWhiteContainer> createState() => _SignupWhiteContainerState();
}

class _SignupWhiteContainerState extends State<SignupWhiteContainer> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool agreeTerms = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// Full Name
              CustomTextField(
                controller: nameController,
                hintText: "Full Name",
                prefixIcon: Iconsax.user,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Full name is required";
                  }
                  if (value.trim().length < 3) {
                    return "Enter a valid name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              /// Email
              CustomTextField(
                controller: emailController,
                hintText: "Email",
                prefixIcon: Iconsax.direct_right,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }

                  if (!RegExp(
                    r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value.trim())) {
                    return "Enter valid email";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              /// Password
              CustomTextField(
                controller: passwordController,
                hintText: "Password",
                prefixIcon: Iconsax.lock,
                obscureText: obscurePassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  icon: Icon(obscurePassword ? Iconsax.eye_slash : Iconsax.eye),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }

                  if (value.length < 6) {
                    return "Minimum 6 characters";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              /// Confirm Password
              CustomTextField(
                controller: confirmPasswordController,
                hintText: "Confirm Password",
                prefixIcon: Iconsax.lock,
                obscureText: obscureConfirmPassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    });
                  },
                  icon: Icon(
                    obscureConfirmPassword ? Iconsax.eye_slash : Iconsax.eye,
                  ),
                ),
                validator: (value) {
                  if (value != passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              CheckboxListTile(
                value: agreeTerms,
                activeColor: Colors.green,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  "I agree to Terms & Conditions",
                  style: TextStyle(fontSize: 14),
                ),
                onChanged: (value) {
                  setState(() {
                    agreeTerms = value!;
                  });
                },
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: authController.isLoading
                      ? null
                      : () async {
                          if (!_formKey.currentState!.validate()) return;

                          if (!agreeTerms) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please accept Terms & Conditions",
                                ),
                              ),
                            );
                            return;
                          }
                          await authController.signup(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                          if (authController.error == null) {
                            await authController.sendEmailVerification();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerifyEmailPage(),
                              ),
                            );
                          } else {
                            AppFlushBar.showError(
                              context,
                              authController.error.toString(),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    overlayColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
