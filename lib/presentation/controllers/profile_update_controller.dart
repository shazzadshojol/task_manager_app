import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/data/models/user_data.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/presentation/controllers/auth_controller.dart';

import '../screens/add_new_task.dart';

class ProfileUpdateController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? 'Updating failed';

  Future<void> updateProfile(
    TextEditingController emailTextController,
    TextEditingController firstNameTextController,
    TextEditingController lastNameTextController,
    TextEditingController mobileTextController,
    TextEditingController passTextController,
    XFile? pickedImage, {
    required BuildContext context,
  }) async {
    String? photo;
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": emailTextController.text,
      "firstName": firstNameTextController.text,
      "lastName": lastNameTextController.text,
      "mobile": mobileTextController.text,
    };

    if (passTextController.text.isNotEmpty) {
      inputParams['password'] = passTextController.text;
    }

    if (pickedImage != null) {
      List<int> bytes = File(pickedImage.path).readAsBytesSync();
      photo = base64Encode(bytes);
      inputParams['photo'] = photo;
    }

    final response =
        await NetworkCaller.postRequest(Urls.profileUpdate, inputParams);
    _inProgress = false;
    update();
    if (response.isSuccess) {
      if (response.responseBody['status'] == 'success') {
        UserData userData = UserData(
          email: emailTextController.text,
          firstName: firstNameTextController.text.trim(),
          lastName: lastNameTextController.text.trim(),
          mobile: mobileTextController.text.trim(),
          photo: photo,
        );
        await AuthController.saveUserData(userData);
      }

      Get.offAll(() => const AddNewTask());
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
  }
}
