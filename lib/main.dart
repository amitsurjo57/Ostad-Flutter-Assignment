import 'package:e_commerce_project/App%20Assets/app_theme.dart';
import 'package:e_commerce_project/Main%20Body/category_screen.dart';
import 'package:e_commerce_project/Main%20Body/create_review_screen.dart';
import 'package:e_commerce_project/Main%20Body/electronics_screen.dart';
import 'package:e_commerce_project/Main%20Body/main_screen.dart';
import 'package:e_commerce_project/Main%20Body/product_details.dart';
import 'package:e_commerce_project/Main%20Body/review_screen.dart';
import 'package:e_commerce_project/Starting%20Body/complete_profile_screen.dart';
import 'package:e_commerce_project/Starting%20Body/sign_up_screen.dart';
import 'package:e_commerce_project/Starting%20Body/pin_verification_screen.dart';
import 'package:e_commerce_project/Starting%20Body/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: SplashScreen.route,
      onGenerateRoute: (settings){
        late Widget widget;
        if (settings.name == SplashScreen.route){
          widget = const SplashScreen();
        }else if (settings.name == SignUpScreen.route){
          widget = const SignUpScreen();
        }else if (settings.name == PinVerificationScreen.route){
          String email = settings.arguments as String;
          widget = PinVerificationScreen(email: email);
        }else if (settings.name == CompleteProfileScreen.route){
          String token = settings.arguments as String;
          widget = CompleteProfileScreen(token: token);
        }else if (settings.name == MainScreen.route){
          widget = const MainScreen();
        }else if (settings.name == ProductDetails.route){
          widget = const ProductDetails();
        }else if (settings.name == CategoryScreen.route){
          widget = const CategoryScreen();
        }else if (settings.name == ElectronicsScreen.route){
          widget = const ElectronicsScreen();
        }else if (settings.name == ReviewScreen.route){
          widget = const ReviewScreen();
        }else if (settings.name == CreateReviewScreen.route){
          widget = CreateReviewScreen();
        }

        return MaterialPageRoute(
          builder: (_){
            return widget;
          }
        );
      },
    );
  }
}
