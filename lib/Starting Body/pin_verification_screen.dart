import 'dart:async';
import 'package:e_commerce_project/App%20Assets/app_logo.dart';
import 'package:e_commerce_project/App%20Widgets/my_circular_progress_indicator.dart';
import 'package:e_commerce_project/App%20Widgets/next_button.dart';
import 'package:e_commerce_project/App%20Widgets/snack_bar.dart';
import 'package:e_commerce_project/Main%20Body/main_screen.dart';
import 'package:e_commerce_project/Networks/network_caller.dart';
import 'package:e_commerce_project/Networks/network_response.dart';
import 'package:e_commerce_project/Networks/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinVerificationScreen extends StatefulWidget {
  final String email;
  static const String route = '/pinVerifyScreen';

  const PinVerificationScreen({super.key, required this.email});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final GlobalKey<FormState> _formState = GlobalKey();
  final TextEditingController _otpController = TextEditingController();
  final NetworkCaller _networkCaller = NetworkCaller();

  bool _inProgress = false;

  int pinResendTimer = 120;
  bool isPinExpired = false;

  @override
  void initState() {
    _timerOn();
    super.initState();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
          key: _formState,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                const SizedBox(height: 100),
                SvgPicture.asset(
                  AppLogo.appLogo,
                  width: 116,
                ),
                const SizedBox(height: 20),
                Text(
                  "Enter OTP Code",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  "A 4 Digit OTP Code has been Sent",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 20),
                PinCodeTextField(
                  controller: _otpController,
                  appContext: context,
                  length: 4,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    activeColor: Theme.of(context).colorScheme.primary,
                    selectedColor: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter pin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Visibility(
                  visible: !_inProgress,
                  replacement: const MyCircularProgressIndicator(),
                  child: MyButton(
                    buttonActionName: "Next",
                    onPressed: _onTapNext,
                  ),
                ),
                const SizedBox(height: 30),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'This code will expire in ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: '${pinResendTimer}s',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    if (isPinExpired) {
                      _timerOn();
                      isPinExpired = false;
                      setState(() {});
                      _onTapNext();
                    }
                  },
                  child: Text(
                    "Resend Code",
                    style: TextStyle(
                      fontWeight: isPinExpired ? FontWeight.bold : null,
                      color: isPinExpired
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                    ),
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
      final NetworkResponse response = await _networkCaller.postRequest(
        NetworkUtils.verifyLogin,
        body: {
          'email': widget.email,
          'otp': _otpController.text.toString(),
        },
      );
      if (response.isSuccess) {
        // await UserAuth()
        //     .saveUserData(response.responseData['data']['token']);
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            MainScreen.route,
            (_) => false,
          );
          MySnackBar.showSnackBar(context, "Pin Verified Successfully");
        }
      } else {
        if (mounted) {
          MySnackBar.showSnackBar(context, "Pin Verification failed");
        }
      }
    }
    _inProgress = false;
    setState(() {});
  }

  Future<void> _timerOn() async {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(
          () {
            pinResendTimer--;
            if (pinResendTimer == 0) {
              isPinExpired = true;
              pinResendTimer = 120;
              timer.cancel();
            }
          },
        );
      },
    );
  }
}
