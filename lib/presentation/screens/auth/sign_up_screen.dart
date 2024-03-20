import 'package:flutter/material.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/presentation/widgets/screen_background.dart';
import 'package:task_manager_app/presentation/widgets/snack_bar_message.dart';

import '../../../data/models/response_obj.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _firstNameTextController =
      TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _mobileTextController = TextEditingController();
  final TextEditingController _passTextController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isRegistrationInProgress = false;

  @override
  Widget build(BuildContext context) {
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
                        controller: _firstNameTextController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'First Name',
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _lastNameTextController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Last Name',
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _mobileTextController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Mobile',
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter mobile';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passTextController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter password';
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
                        child: Visibility(
                          visible: isRegistrationInProgress == false,
                          replacement:
                              const Center(child: CircularProgressIndicator()),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                isRegistrationInProgress = true;
                                setState(() {});

                                Map<String, dynamic> inputParams = {
                                  "email": _emailTextController.text.trim(),
                                  "firstName":
                                      _firstNameTextController.text.trim(),
                                  "lastName":
                                      _lastNameTextController.text.trim(),
                                  "mobile": _mobileTextController.text.trim(),
                                  "password": _passTextController.text
                                };
                                final ResponseObj response =
                                    await NetworkCaller.postRequest(
                                        Urls.registration, inputParams);
                                isRegistrationInProgress = false;
                                setState(() {});
                                if (response.isSuccess) {
                                  if (mounted) {
                                    showSnackBarMessage(
                                        context, 'Registration completed');
                                    Navigator.pop(context);
                                  }
                                } else {
                                  if (mounted) {
                                    showSnackBarMessage(
                                        context, 'Registration failed', true);
                                  }
                                }
                              }
                            },
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 35,
                            ),
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
                              Navigator.pop(context);
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

  @override
  void dispose() {
    _emailTextController.dispose();
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();
    _mobileTextController.dispose();
    _passTextController.dispose();
    super.dispose();
  }
}
