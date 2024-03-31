import 'package:get/get.dart';
import 'package:task_manager_app/data/models/login_response.dart';
import 'package:task_manager_app/data/models/response_obj.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/presentation/controllers/auth_controller.dart';

import '../../data/services/network_caller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? 'Login failed';

  Future<bool> signIn(String email, String password) async {
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": email,
      "password": password,
    };
    final ResponseObj response = await NetworkCaller.postRequest(
        Urls.login, inputParams,
        fromSignIn: true);

    if (response.isSuccess) {
      LoginResponse loginResponse =
          LoginResponse.fromJson(response.responseBody);

      AuthController.saveUserData(loginResponse.userData!);
      AuthController.saveUserToken(loginResponse.token!);
      _inProgress = false;
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
