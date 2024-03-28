import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_manager_app/data/models/task_status_count.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utility/urls.dart';

class TaskStatusCountController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  TaskStatusCount _taskStatusCount = TaskStatusCount();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? 'Task getting failed';

  TaskStatusCount get taskStatusCount => _taskStatusCount;

  Future<void> getTaskCount() async {
    _inProgress = true;
    update();
    final response = await NetworkCaller.getRequest(Urls.taskStatusCountUrl);

    if (response.isSuccess) {
      _taskStatusCount = TaskStatusCount.fromJson(response.responseBody);
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
  }
}
