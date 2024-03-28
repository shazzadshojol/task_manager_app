import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:task_manager_app/presentation/controllers/sign_in_controller.dart';
import 'package:task_manager_app/presentation/controllers/task_status_count_controller.dart';
import 'package:task_manager_app/presentation/controllers/task_status_list_controller.dart';

class ControllersBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => TaskStatusCountController());
    Get.lazyPut(() => TaskStatusListController());
  }
}
