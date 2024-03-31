import 'dart:ui';

import 'package:get/get.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'dart:async';
import '../../data/utility/urls.dart';

class TaskContentController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? 'Content getting failed';

  Future<void> fromTaskContentController(String title, String description,
      String status, VoidCallback clearTextFields) async {
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "title": title,
      "description": description,
      "status": status
    };
    final response =
        await NetworkCaller.postRequest(Urls.createTask, inputParams);

    if (response.isSuccess) {
      if (Get.isSnackbarOpen) {
        Get.back();
      }
      clearTextFields();
      Get.snackbar('Success', 'Task added');
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
  }
}
