import 'package:e_commerce_project/App%20Assets/app_logo.dart';
import 'package:e_commerce_project/App%20Widgets/my_circular_progress_indicator.dart';
import 'package:e_commerce_project/App%20Widgets/next_button.dart';
import 'package:e_commerce_project/App%20Widgets/snack_bar.dart';
import 'package:e_commerce_project/Main%20Body/main_screen.dart';
import 'package:e_commerce_project/Networks/network_caller.dart';
import 'package:e_commerce_project/Networks/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  static const String route = '/login';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
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
        NetworkUtils.userLogin,
        body: {
          "email": _emailController.text,
          "password": _passwordController.text,
        },
      );

      if (response.isSuccess) {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen()
            ),
            (_) => false,
          );
          MySnackBar.showSnackBar(context, "Log In Successfully");
        }
      } else {
        if (mounted) {
          MySnackBar.showSnackBar(context, "Log In Failed");
        }
      }
    }
    _inProgress = false;
    setState(() {});
  }
}
