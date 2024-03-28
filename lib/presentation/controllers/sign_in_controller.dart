import 'package:get/get.dart';
import 'package:task_manager_app/data/models/login_response.dart';
import 'package:task_manager_app/data/models/response_obj.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/presentation/controllers/auth_controller.dart';

import '../../data/services/network_caller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;

  bool get inProgress => _inProgress;

  String get errorMassage => _errorMassage ?? 'Login failed';

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
    _inProgress = false;

    if (response.isSuccess) {
      LoginResponse loginResponse =
          LoginResponse.fromJson(response.responseBody);

      AuthController.saveUserData(loginResponse.userData!);
      AuthController.saveUserToken(loginResponse.token!);
      update();
      return true;
    } else {
      _errorMassage = response.errorMessage;
      update();
      return false;
    }
  }
}
