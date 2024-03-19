import 'package:flutter/material.dart';

import 'package:task_manager_app/presentation/screens/auth/otp_verify_screen.dart';
import 'package:task_manager_app/presentation/screens/auth/sign_in_screen.dart';

import 'package:task_manager_app/presentation/widgets/screen_background.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({
    super.key,
  });

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  final TextEditingController _emailTextController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  'Your Email Address',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                const Text(
                  'A 6 degits verification code will be sent to your email address',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailTextController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OtpVerifyScreen(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.arrow_circle_right_outlined,
                      size: 35,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
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
    _emailTextController.dispose();

    super.dispose();
  }
}
