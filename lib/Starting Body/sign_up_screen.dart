import 'package:e_commerce_project/App%20Assets/app_logo.dart';
import 'package:e_commerce_project/App%20Widgets/my_circular_progress_indicator.dart';
import 'package:e_commerce_project/App%20Widgets/next_button.dart';
import 'package:e_commerce_project/App%20Widgets/snack_bar.dart';
import 'package:e_commerce_project/Networks/network_caller.dart';
import 'package:e_commerce_project/Networks/network_utils.dart';
import 'package:e_commerce_project/Starting%20Body/log_in_screen.dart';
import 'package:e_commerce_project/Starting%20Body/pin_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String route = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey();

  final NetworkCaller _networkCaller = NetworkCaller();

  bool _inProgress = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formState,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              spacing: 12,
              children: [
                const SizedBox(height: 100),
                SvgPicture.asset(
                  AppLogo.appLogo,
                  width: 116,
                ),
                Text(
                  "Welcome Back",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "Please Enter Your Email Address",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                TextFormField(
                  controller: _emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: Theme.of(context).inputDecorationTheme.border,
                    focusedBorder:
                        Theme.of(context).inputDecorationTheme.focusedBorder,
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.enabledBorder,
                    hintText: 'Enter your email',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: Theme.of(context).inputDecorationTheme.border,
                    focusedBorder:
                        Theme.of(context).inputDecorationTheme.focusedBorder,
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.enabledBorder,
                    hintText: 'Enter Password',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter Password';
                    }
                    return null;
                  },
                ),
                Visibility(
                  visible: !_inProgress,
                  replacement: const MyCircularProgressIndicator(),
                  child: MyButton(
                    buttonActionName: "Next",
                    onPressed: _onTapNext,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: _onTapLoginHere,
                      child: const Text("LogIn here"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapNext() async {
    _inProgress = true;
    setState(() {});
    if (_formState.currentState!.validate()) {
      final response = await _networkCaller.postRequest(
        NetworkUtils.userSignUp,
        body: {
          "first_name": "ABC",
          "last_name": "XYZ",
          "email": _emailController.text,
          "password": _passwordController.text,
          "phone": "01111111111",
          "city": "Dhaka"
        },
      );

      if (response.isSuccess) {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PinVerificationScreen(
                email: _emailController.text,
              ),
            ),
          );
          MySnackBar.showSnackBar(context, "Sign Up Successfully");
        }
      } else {
        if (mounted) {
          MySnackBar.showSnackBar(context, "Sign Up Failed");
        }
      }
    }
    _inProgress = false;
    setState(() {});
  }

  void _onTapLoginHere() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LogInScreen(),
      ),
    );
  }
}
