import 'package:demo_proj/app.dart';
import 'package:demo_proj/core/services/shared_ref.dart';
import 'package:demo_proj/features/ai/controller/ai_controller.dart';
import 'package:demo_proj/features/ai/repository/ai_repository.dart';
import 'package:demo_proj/features/ai/services/ai_service.dart';
import 'package:demo_proj/features/auth/controller/auth_controller.dart';
import 'package:demo_proj/features/auth/controller/controller.onboarding/onBoard_controller.dart';
import 'package:demo_proj/features/auth/repository/auth_repo.dart';
import 'package:demo_proj/features/auth/repository/share_pref_repo.dart';
import 'package:demo_proj/features/auth/screen/home/controller/category_controller.dart';
import 'package:demo_proj/features/auth/screen/home/controller/home_controller.dart';
import 'package:demo_proj/features/auth/screen/home/controller/order_controller.dart';
import 'package:demo_proj/features/auth/screen/home/repository/category_repository.dart';
import 'package:demo_proj/features/auth/screen/home/repository/order_repository.dart';
import 'package:demo_proj/features/auth/screen/home/repository/product_repository.dart';
import 'package:demo_proj/features/auth/screen/home/services/category_service.dart';
import 'package:demo_proj/features/auth/screen/home/services/firestore_services.dart';
import 'package:demo_proj/features/auth/screen/home/services/order_service.dart';
import 'package:demo_proj/features/auth/services/auth_services.dart';
import 'package:demo_proj/features/data/models/cart/cart_model.dart';
import 'package:demo_proj/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );

  runApp(
    MultiProvider(
      providers: [
        // AI
        Provider<AiService>(create: (_) => AiService()),

        Provider<AiRepository>(
          create: (context) => AiRepository(context.read<AiService>()),
        ),

        ChangeNotifierProvider<AiController>(
          create: (context) => AiController(context.read<AiRepository>()),
        ),
        // Shared Preferences
        Provider<SharedPrefServices>(create: (_) => SharedPrefServices()),

        Provider<SharedPrefRepository>(
          create: (context) =>
              SharedPrefRepository(context.read<SharedPrefServices>()),
        ),

        // Onboarding
        ChangeNotifierProvider(
          create: (context) =>
              OnboardController(context.read<SharedPrefRepository>()),
        ),

        // Cart
        ChangeNotifierProvider(create: (_) => CartProvider()),

        // Firebase Auth
        Provider<AuthServices>(create: (_) => AuthServices()),

        Provider<AuthRepository>(
          create: (context) => AuthRepository(context.read<AuthServices>()),
        ),

        ChangeNotifierProvider<AuthController>(
          create: (context) => AuthController(context.read<AuthRepository>()),
        ),

        //for home fireStoreServices
        Provider<FirestoreService>(create: (context) => FirestoreService()),

        //product repo
        Provider<ProductRepository>(
          create: (context) =>
              ProductRepository(context.read<FirestoreService>()),
        ),
        ChangeNotifierProvider<HomeController>(
          create: (context) =>
              HomeController(context.read<ProductRepository>()),
        ),

        //fetch category
        Provider<CategoryService>(create: (_) => CategoryService()),
        Provider<CategoryRepository>(
          create: (context) =>
              CategoryRepository(context.read<CategoryService>()),
        ),
        ChangeNotifierProvider<CategoryController>(
          create: (context) =>
              CategoryController(context.read<CategoryRepository>()),
        ),

        //register order repo
        Provider<OrderService>(create: (_) => OrderService()),
        Provider<OrderRepository>(
          create: (context) => OrderRepository(context.read<OrderService>()),
        ),
        ChangeNotifierProvider<OrderController>(
          create: (context) => OrderController(context.read<OrderRepository>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
