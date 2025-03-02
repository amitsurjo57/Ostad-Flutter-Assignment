import 'package:e_commerce_project/App%20Widgets/next_button.dart';
import 'package:e_commerce_project/Main%20Body/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../App Assets/app_logo.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key, required this.token});

  final String token;
  static const String route = '/complete_profile';

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
          key: _globalKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 16,
                children: [
                  SvgPicture.asset(
                    AppLogo.appLogo,
                    width: 100,
                  ),
                  const Text(
                    "Complete Profile",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Get started with us with your details",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(hintText: "First Name"),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter your First Name";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(hintText: "Last Name"),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter your Last Name";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(hintText: "Mobile"),
                    keyboardType: TextInputType.phone,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter your Mobile Number";
                      }

                      if (RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$')
                              .hasMatch(value!) ==
                          false) {
                        return "Enter valid Mobile Number";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(hintText: "City"),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter your City";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      hintText: "Shipping Address",
                    ),
                    maxLines: 3,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter your Shipping Address";
                      }
                      return null;
                    },
                  ),
                  MyButton(
                    buttonActionName: "Next",
                    onPressed: () {
                      Navigator.pushNamed(context, MainScreen.route);
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
