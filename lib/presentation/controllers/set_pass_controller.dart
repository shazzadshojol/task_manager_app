import 'package:get/get.dart';
import 'package:task_manager_app/data/models/response_obj.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/presentation/screens/auth/sign_in_screen.dart';

import '../../data/utility/urls.dart';

class SetPassController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? 'Input valid Password';

  Future<bool> setPasswordFromController(
      String password, String confirmPassword) async {
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {"password": password};

    final ResponseObj response =
        await NetworkCaller.postRequest(Urls.resetPassword, inputParams);
    if (response.isSuccess) {
      Get.to(() => const SignInScreen());
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      _inProgress = false;
      update();
      return false;
    }
  }
}
