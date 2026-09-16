import 'package:demo_proj/core/utils/flush/app_flushbar.dart';
import 'package:demo_proj/features/auth/controller/auth_controller.dart';
import 'package:demo_proj/features/auth/screen/login/login_screen.dart';
import 'package:demo_proj/features/auth/screen/orders/orders_screen.dart';
import 'package:demo_proj/features/auth/screen/profile/edit_profile_page.dart';
import 'package:demo_proj/features/auth/screen/profile/widgets/profile_header.dart';
import 'package:demo_proj/features/auth/screen/profile/widgets/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// Header
            const ProfileHeader(),

            const SizedBox(height: 30),

            /// Tiles
            ProfileTile(
              icon: Iconsax.user_edit,
              title: "Edit Profile",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditProfilePage()),
                );
              },
            ),

            ProfileTile(icon: Iconsax.heart, title: "Favorites", onTap: () {}),

            ProfileTile(
              icon: Iconsax.box,
              title: "My Orders",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => OrdersScreen()),
                );
              },
            ),

            ProfileTile(
              icon: Iconsax.location,
              title: "Shipping Address",
              onTap: () {},
            ),

            ProfileTile(
              icon: Iconsax.notification,
              title: "Notifications",
              onTap: () {},
            ),

            ProfileTile(
              icon: Iconsax.lock,
              title: "Change Password",
              onTap: () {},
            ),

            ProfileTile(
              icon: Iconsax.info_circle,
              title: "About",
              onTap: () {},
            ),

            const SizedBox(height: 10),

            const Divider(),

            const SizedBox(height: 10),

            ProfileTile(
              icon: Iconsax.logout,
              title: "Logout",
              iconColor: Colors.red,
              textColor: Colors.red,
              onTap: () async {
                await authController.logOut();

                if (authController.error == null) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                } else {
                  AppFlushBar.showError(context, authController.error!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
