import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_manager_app/presentation/widgets/screen_background.dart';

import 'package:task_manager_app/presentation/screens/auth/sign_in_screen.dart';

import '../../controllers/set_pass_controller.dart';
import '../../widgets/snack_bar_message.dart';

class PassSetScreen extends StatefulWidget {
  const PassSetScreen({
    super.key,
  });

  @override
  State<PassSetScreen> createState() => _PassSetScreenState();
}

class _PassSetScreenState extends State<PassSetScreen> {
  final TextEditingController _passTextController = TextEditingController();
  final TextEditingController _confirmPassTextController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SetPassController _setPassController = SetPassController();

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
                  'Update password',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Minimum 8 length password with uppercase and number combination',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passTextController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _confirmPassTextController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Confirm password',
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        _setPassword();
                      },
                      child: const Text('Confirm')),
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

  Future<void> _setPassword() async {
    if (_formKey.currentState!.validate()) {
      final result = await _setPassController.setPasswordFromController(
          _passTextController.text, _confirmPassTextController.text);
      if (result) {
        Get.to(() => const SignInScreen());
      } else {
        showSnackBarMessage(Get.context!, _setPassController.errorMessage);
      }
    }
  }

  @override
  void dispose() {
    _passTextController.dispose();
    _confirmPassTextController.dispose();
    super.dispose();
  }
}
