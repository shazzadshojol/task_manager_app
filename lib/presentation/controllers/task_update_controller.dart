import 'package:get/get.dart';
import 'package:task_manager_app/presentation/controllers/task_status_count_controller.dart';
import 'package:task_manager_app/presentation/controllers/task_status_list_controller.dart';

import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class TaskUpdateController extends GetxController {
  final RxBool _inProgress = false.obs;
  String? _errorMessage;

  bool get inProgress => _inProgress.value;

  String get errorMessage => _errorMessage ?? 'Update task failed';

  final TaskStatusListController _taskStatusListController =
      Get.find<TaskStatusListController>();
  final TaskStatusCountController _taskStatusCountController =
      Get.find<TaskStatusCountController>();

  Future<void> updateTaskById(String id, String status) async {
    _inProgress.value = true;
    update();
    final response =
        await NetworkCaller.getRequest(Urls.updateTaskStatus(id, status));

    if (response.isSuccess) {
      _taskStatusListController.getTaskList();
      _taskStatusCountController.getTaskCount();
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress.value = false;
    update();
  }
}
