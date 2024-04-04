import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:task_manager_app/presentation/controllers/delete_task_controller.dart';
import 'package:task_manager_app/presentation/controllers/email_verify_controller.dart';
import 'package:task_manager_app/presentation/controllers/otp_controller.dart';
import 'package:task_manager_app/presentation/controllers/profile_update_controller.dart';
import 'package:task_manager_app/presentation/controllers/set_pass_controller.dart';
import 'package:task_manager_app/presentation/controllers/sign_in_controller.dart';
import 'package:task_manager_app/presentation/controllers/sign_up_controller.dart';
import 'package:task_manager_app/presentation/controllers/task_content_controller.dart';
import 'package:task_manager_app/presentation/controllers/task_status_count_controller.dart';
import 'package:task_manager_app/presentation/controllers/task_status_list_controller.dart';
import 'package:task_manager_app/presentation/controllers/task_update_controller.dart';

class ControllersBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => TaskStatusCountController());
    Get.lazyPut(() => TaskStatusListController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => EmailVerifyController());
    Get.lazyPut(() => TaskContentController());
    Get.lazyPut(() => OtpController());
    Get.lazyPut(() => SetPassController());
    Get.lazyPut(() => TaskDeleteController());
    Get.lazyPut(() => TaskUpdateController());
    Get.lazyPut(() => ProfileUpdateController());
  }
}
