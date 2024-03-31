import 'package:get/get.dart';
import 'package:task_manager_app/data/models/response_obj.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/presentation/screens/auth/sign_in_screen.dart';

class OtpController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? 'Wrong OTP';

  Future<bool> otpFromController(String otp) async {
    _inProgress = true;
    update();

    final ResponseObj response =
        await NetworkCaller.getRequest(Urls.otpVerify(otp));

    if (response.isSuccess) {
      Get.to(() => const SignInScreen());

      return true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return false;
  }
}
