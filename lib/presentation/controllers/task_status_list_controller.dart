import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:task_manager_app/data/models/task_list_By_Status.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utility/urls.dart';

class TaskStatusListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  TaskListByStatus _taskListByStatus = TaskListByStatus();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? 'Task getting failed';

  TaskListByStatus get taskListByStatus => _taskListByStatus;

  Future<void> getTaskList() async {
    _inProgress = true;
    update();
    final response = await NetworkCaller.getRequest(Urls.newTaskStatusUrl);

    if (response.isSuccess) {
      _taskListByStatus = TaskListByStatus.fromJson(response.responseBody);
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
  }
}
