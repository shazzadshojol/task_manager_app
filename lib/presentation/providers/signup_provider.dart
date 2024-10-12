import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/data/wrapper_class/response_object.dart';

class SignUpProvider extends ChangeNotifier {
  bool _inProgress = false;
  String? _errorMessage;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _firstNameTextController =
      TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _mobileTextController = TextEditingController();
  final TextEditingController _passTextController = TextEditingController();

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  TextEditingController get emailTextController => _emailTextController;

  TextEditingController get firstNameTextController => _firstNameTextController;

  TextEditingController get lastNameTextController => _lastNameTextController;

  TextEditingController get mobileTextController => _mobileTextController;

  TextEditingController get passTextController => _passTextController;

  Future<void> registration(String email, String firstName, String lastName,
      String mobile, String password) async {
    _inProgress = true;
    notifyListeners();

    Map<String, dynamic> inputData = {
      'email': emailTextController.text.trim(),
      'firstName': firstNameTextController.text.trim(),
      'lastName': lastNameTextController.text.trim(),
      'mobile': mobileTextController.text.trim(),
      'password': passTextController.text
    };

    try {
      final ResponseObject response =
          await NetworkCaller.postRequest(Urls.registration, inputData);
      print('Request URL: ${Urls.registration}');
     
      if (response.isSuccess) {
        Get.snackbar('Success', 'SignUp success');
      } else {
        Get.snackbar('Success', 'SignUp success');
      }
    } catch (e) {
      log('Try Catch: error $e');
      _errorMessage = 'something went wrong';
    } finally {
      _inProgress = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailTextController.dispose();
    firstNameTextController.dispose();
    lastNameTextController.dispose();
    mobileTextController.dispose();
    passTextController.dispose();
    super.dispose();
  }
}
