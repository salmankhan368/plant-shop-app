import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: user?.photoURL != null
              ? NetworkImage(user!.photoURL!)
              : null,
          child: user?.photoURL == null
              ? const Icon(Icons.person, size: 50, color: Colors.grey)
              : null,
        ),

        const SizedBox(height: 15),

        Text(
          user?.displayName?.isNotEmpty == true ? user!.displayName! : 'User',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 5),

        Text(user?.email ?? '', style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}
