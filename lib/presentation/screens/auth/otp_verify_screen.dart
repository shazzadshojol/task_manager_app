import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utility/urls.dart';

import 'package:task_manager_app/presentation/utils/app_color.dart';

import 'package:task_manager_app/presentation/widgets/screen_background.dart';

import 'package:task_manager_app/presentation/screens/auth/set_pass_screen.dart';
import 'package:task_manager_app/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager_app/presentation/widgets/snack_bar_message.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({
    super.key,
  });

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final TextEditingController _pinEditingController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _otpVerifyProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text(
                  'Pin Verification',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Please enter your six digit pin number',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      inactiveColor: AppColor.themeColor),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  controller: _pinEditingController,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {},
                  beforeTextPaste: (text) {
                    return true;
                  },
                  appContext: context,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        _otpVerify();
                      },
                      child: Visibility(
                        visible: _otpVerifyProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: const Text(
                          'verify',
                          style: TextStyle(fontSize: 20),
                        ),
                      )),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Have account!',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.blueGrey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign in',
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    _pinEditingController.dispose();

    super.dispose();
  }

  Future<void> _otpVerify() async {
    _otpVerifyProgress = true;
    setState(() {});
    final otp = _pinEditingController.text;
    final response = await NetworkCaller.getRequest(Urls.otpVerify(otp));

    if (response.isSuccess && mounted) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PassSetScreen()));
    } else {
      if (mounted) {
        showSnackBarMessage(context, 'Verification failed');
      }
    }
    _otpVerifyProgress = false;
    setState(() {});
  }
}
