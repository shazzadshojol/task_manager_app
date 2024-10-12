import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/data/wrapper_class/response_object.dart';

class SignInProvider extends ChangeNotifier {
  bool _inProgress = false;
  String? _errorMessage;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passTextController = TextEditingController();

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  TextEditingController get emailTextController => _emailTextController;

  TextEditingController get passTextController => _passTextController;

  Future<void> login(String email, String password) async {
    _inProgress = true;
    notifyListeners();

    Map<String, dynamic> inputData = {
      'email': emailTextController.text.trim(),
      'password': passTextController.text
    };

    try {
      final ResponseObject response =
          await NetworkCaller.postRequest(Urls.login, inputData);

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
    passTextController.dispose();
    super.dispose();
  }
}
