import 'dart:async';
import 'package:e_commerce_project/Starting%20Body/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../App Assets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String route = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () async {
        Navigator.pushReplacementNamed(context, SignUpScreen.route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(AppLogo.appLogo),
              const Spacer(),
              const CircularProgressIndicator(),
              const SizedBox(height: 12),
              const Text("Version: 1.0"),
            ],
          ),
        ),
      ),
    );
  }
}
