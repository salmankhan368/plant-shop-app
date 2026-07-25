import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
        ),

        const SizedBox(height: 15),

        const Text(
          "Salman Khan",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 5),

        Text(
          "salmankhan@gmail.com",
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
