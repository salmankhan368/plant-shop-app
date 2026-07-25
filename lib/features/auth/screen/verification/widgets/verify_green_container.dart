import 'package:flutter/material.dart';

class VerifyGreenContainer extends StatelessWidget {
  const VerifyGreenContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green.shade400,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: const SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 25, right: 25, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Verify Email",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "One last step to activate your account.",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
