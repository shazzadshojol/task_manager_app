import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/data/models/user_data.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/presentation/controllers/auth_controller.dart';
import 'package:task_manager_app/presentation/screens/bottom_nav_screen.dart';
import 'package:task_manager_app/presentation/widgets/common_appbar.dart';
import 'package:task_manager_app/presentation/widgets/screen_background.dart';
import 'package:task_manager_app/presentation/widgets/snack_bar_message.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _firstNameTextController =
      TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _mobileTextController = TextEditingController();
  final TextEditingController _passTextController = TextEditingController();
  XFile? _pickedImage;
  bool _updateProfileInProgress = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailTextController.text = AuthController.userData?.email ?? '';
    _firstNameTextController.text = AuthController.userData?.firstName ?? '';
    _lastNameTextController.text = AuthController.userData?.lastName ?? '';
    _mobileTextController.text = AuthController.userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar,
      body: ScreenBackground(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Text('Update profile',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    imagePickerMethod(),
                    const SizedBox(height: 10),
                    TextFormField(
                      enabled: false,
                      controller: _emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _firstNameTextController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _lastNameTextController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _mobileTextController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Mobile',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passTextController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _updateProfileInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            _updateProfile();
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
      )),
    );
  }

  imagePickerMethod() {
    return GestureDetector(
      onTap: () {
        _selectImage();
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
                child: const Text('Photo')),
            const SizedBox(width: 8),
            Text(_pickedImage?.name ?? ''),
          ],
        ),
      ),
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

  Future<void> _selectImage() async {
    ImagePicker imagePicker = ImagePicker();
    _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  Future<void> _updateProfile() async {
    String? photo;

    _updateProfileInProgress = true;
    setState(() {});
    Map<String, dynamic> inputParams = {
      "email": _emailTextController.text,
      "firstName": _firstNameTextController.text,
      "lastName": _lastNameTextController.text,
      "mobile": _mobileTextController.text,
    };

    if (_passTextController.text.isNotEmpty) {
      inputParams['password'] = _passTextController.text;
    }

    if (_pickedImage != null) {
      List<int> bytes = File(_pickedImage!.path).readAsBytesSync();
      photo = base64Encode(bytes);
      inputParams['photo'] = photo;
    }
    final response =
        await NetworkCaller.postRequest(Urls.profileUpdate, inputParams);

    _updateProfileInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      if (response.responseBody['status'] == 'success') {
        UserData userData = UserData(
          email: _emailTextController.text,
          firstName: _firstNameTextController.text.trim(),
          lastName: _lastNameTextController.text.trim(),
          mobile: _mobileTextController.text.trim(),
          photo: photo,
        );
        await AuthController.saveUserData(userData);
      }
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavScreen()),
            (route) => false);
      }
    } else {
      if (!mounted) {
        return;
      }
      setState(() {});

      showSnackBarMessage(context, 'Updating failed');
    }
  }
}
