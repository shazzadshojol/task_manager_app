import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/task_list_By_Status.dart';
import 'package:task_manager_app/data/models/task_status_count.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/presentation/widgets/card_context.dart';
import 'package:task_manager_app/presentation/widgets/common_appbar.dart';
import 'package:task_manager_app/presentation/widgets/screen_background.dart';
import 'package:task_manager_app/presentation/widgets/snack_bar_message.dart';

class ProgressTask extends StatefulWidget {
  const ProgressTask({super.key});

  @override
  State<ProgressTask> createState() => _ProgressTaskState();
}

class _ProgressTaskState extends State<ProgressTask> {
  bool _getAllTaskStatusCountProgress = false;
  bool _getCompleteTaskListInProgress = false;
  bool _deleteTaskInProgress = false;
  bool _updateTaskInProgress = false;
  TaskStatusCount? _taskStatusCount = TaskStatusCount();
  TaskListByStatus _taskListByStatus = TaskListByStatus();

  @override
  void initState() {
    _fetchCompleteTaskListByStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar,
      body: ScreenBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: _taskListByStatus.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return CardContext(
                        taskItem: _taskListByStatus.taskList![index],
                        onDelete: () {
                          _deleteTaskById(
                              _taskListByStatus.taskList![index].sId!);
                        },
                        onEdit: () {
                          _showUpdateStatusDialog(
                              _taskListByStatus.taskList![index].sId!);
                        },
                      );
                    }))
          ],
        ),
      ),
    );
  }

  Future<void> _getAllTaskCountStatus() async {
    _getAllTaskStatusCountProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.taskStatusCountUrl);
    if (response.isSuccess) {
      _taskStatusCount = TaskStatusCount.fromJson(response.responseBody);
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMassage ?? 'get task failed');
      }
    }
    _getAllTaskStatusCountProgress = false;
    setState(() {});
  }

  Future<void> _fetchCompleteTaskListByStatus() async {
    _getCompleteTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.progressTaskList);
    if (response.isSuccess) {
      _taskListByStatus = TaskListByStatus.fromJson(response.responseBody);
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMassage ?? 'Get task failed');
      }
    }
    _getCompleteTaskListInProgress = false;
    setState(() {});
  }

  Future<void> _deleteTaskById(String id) async {
    _deleteTaskInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.deleteTaskById(id));
    _deleteTaskInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _fetchCompleteTaskListByStatus();
      _getAllTaskCountStatus();
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMassage ?? 'Delete task failed');
      }
    }
  }

  void _showUpdateStatusDialog(String id) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Select Status'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      title: const Text('New'),
                      onTap: () {
                        _updateTaskById(id, 'New');
                        Navigator.pop(context);
                      }),
                  ListTile(
                    title: const Text('Completed'),
                    onTap: () {
                      _updateTaskById(id, 'Completed');
                      Navigator.pop(context);
                    },
                  ),
                  const ListTile(
                    title: Text('Progress'),
                    trailing: Icon(Icons.check),
                  ),
                  ListTile(
                      title: const Text('Cancelled'),
                      onTap: () {
                        _updateTaskById(id, 'Progress');
                        Navigator.pop(context);
                      }),
                ],
              ),
            ));
  }

  Future<void> _updateTaskById(String id, String status) async {
    _updateTaskInProgress = true;
    setState(() {});
    final response =
        await NetworkCaller.getRequest(Urls.updateTaskStatus(id, status));
    _updateTaskInProgress = false;

    if (response.isSuccess) {
      _fetchCompleteTaskListByStatus();
      _getAllTaskCountStatus();
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMassage ?? 'Task update task failed');
      }
    }
  }
}
