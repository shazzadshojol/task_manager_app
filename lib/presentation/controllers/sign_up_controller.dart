import 'package:get/get.dart';
import 'package:task_manager_app/data/models/response_obj.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utility/urls.dart';

class SignUpController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? 'Registration failed';

  Future<bool> signUp(String email, String firstName, String lastName,
      String mobile, String password) async {
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password
    };

    final ResponseObj response =
        await NetworkCaller.postRequest(Urls.registration, inputParams);
    _inProgress = false;
    update();
    if (response.isSuccess) {
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
