import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/login_response.dart';
import 'package:task_manager_app/data/models/response_obj.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/presentation/controllers/auth_controller.dart';
import 'package:task_manager_app/presentation/screens/bottom_nav_screen.dart';
import 'package:task_manager_app/presentation/widgets/screen_background.dart';

import 'package:task_manager_app/presentation/screens/auth/sign_up_screen.dart';
import 'package:task_manager_app/presentation/widgets/snack_bar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    super.key,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passTextController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoginInProgress = false;

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
                  'Get Started With',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailTextController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passTextController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _isLoginInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _signIn();
                        }
                      },
                      child: const Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 35,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.blueGrey),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
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
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign up',
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

  Future<void> _signIn() async {
    _isLoginInProgress = true;
    setState(() {});
    Map<String, dynamic> inputParams = {
      "email": _emailTextController.text.trim(),
      "password": _passTextController.text,
    };
    final ResponseObj response =
        await NetworkCaller.postRequest(Urls.login, inputParams);
    _isLoginInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      if (!mounted) {
        return;
      }

      LoginResponse loginResponse =
          LoginResponse.fromJson(response.responseBody);
      //Save data to local cache
      AuthController.saveUserData(loginResponse.userData!);
      AuthController.saveUserToken(loginResponse.token!);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavScreen()),
          (route) => false);
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMassage ?? 'Login failed');
      }
    }
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();
    super.dispose();
  }
}
