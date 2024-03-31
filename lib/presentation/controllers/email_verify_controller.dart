import 'package:get/get.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/presentation/screens/auth/otp_verify_screen.dart';

import '../../data/models/response_obj.dart';
import '../../data/utility/urls.dart';

class EmailVerifyController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? 'Input valid email';

  Future<bool> emailVerify(String email) async {
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": email,
    };

    final ResponseObj response =
        await NetworkCaller.postRequest(Urls.registration, inputParams);
    if (response.isSuccess) {
      Get.to(() => const OtpVerifyScreen());
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
