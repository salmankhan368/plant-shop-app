import 'package:demo_proj/app.dart';

import 'package:demo_proj/core/services/shared_ref.dart';
import 'package:demo_proj/features/auth/controller/auth_controller.dart';
import 'package:demo_proj/features/auth/controller/controller.onboarding/onBoard_controller.dart';
import 'package:demo_proj/features/auth/repository/auth_repo.dart';
import 'package:demo_proj/features/auth/repository/share_pref_repo.dart';
import 'package:demo_proj/features/auth/services/auth_services.dart';
import 'package:demo_proj/features/data/models/cart/cart_model.dart';
import 'package:demo_proj/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        // Shared Preferences
        Provider<SharedPrefServices>(
          create: (_) => SharedPrefServices(),
        ),

        Provider<SharedPrefRepository>(
          create: (context) => SharedPrefRepository(
            context.read<SharedPrefServices>(),
          ),
        ),

        // Onboarding
        ChangeNotifierProvider(
          create: (context) => OnboardController(
            context.read<SharedPrefRepository>(),
          ),
        ),

        // Cart
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),

        // Firebase Auth
        Provider<AuthServices>(
          create: (_) => AuthServices(),
        ),

        Provider<AuthRepository>(
          create: (context) => AuthRepository(
            context.read<AuthServices>(),
          ),
        ),

        ChangeNotifierProvider<AuthController>(
          create: (context) => AuthController(
            context.read<AuthRepository>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}