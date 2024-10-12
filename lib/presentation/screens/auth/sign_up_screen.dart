import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/presentation/methods/validation_checker.dart';
import 'package:task_manager_app/presentation/providers/signup_provider.dart';
import 'package:task_manager_app/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager_app/presentation/widgets/screen_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);
    return Scaffold(
      body: ScreenBackground(
          child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Text('Join With Us!',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: provider.emailTextController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        validator: (value) =>
                            validatorChecker(value, 'Enter Email'),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: provider.firstNameTextController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'First Name',
                        ),
                        validator: (value) =>
                            validatorChecker(value, 'Enter First Name'),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: provider.lastNameTextController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Last Name',
                        ),
                        validator: (value) =>
                            validatorChecker(value, 'Enter Last Name'),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: provider.mobileTextController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Mobile',
                        ),
                        validator: (value) =>
                            validatorChecker(value, 'Enter Mobile No'),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: provider.passTextController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        validator: (value) {
                          final error =
                              validatorChecker(value, 'Enter Password');
                          if (error != null) {
                            return error;
                          }
                          if (value!.length <= 6) {
                            return 'Minimum 6 letter password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            print('clicked');
                            if (_formKey.currentState!.validate() == true) {
                              await provider.registration(
                                  provider.emailTextController.text.trim(),
                                  provider.firstNameTextController.text.trim(),
                                  provider.lastNameTextController.text.trim(),
                                  provider.mobileTextController.text.trim(),
                                  provider.passTextController.text);

                              if (provider.inProgress == false &&
                                  provider.errorMessage == null) {
                                Get.offAll(() => const SignInScreen());
                              } else {
                                Get.snackbar(
                                    'Error',
                                    provider.errorMessage ??
                                        'Failed to register');
                              }
                            } else {
                              Get.snackbar('Failed', 'Input valid data');
                            }
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
                            'Have Account?',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.blueGrey),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
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
              )
            ],
          ),
        ),
      )),
    );
  }
}
