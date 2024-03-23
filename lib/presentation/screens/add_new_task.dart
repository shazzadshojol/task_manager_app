import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/task_list_By_Status.dart';
import 'package:task_manager_app/data/models/task_status_count.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/presentation/screens/add_task_content.dart';
import 'package:task_manager_app/presentation/utils/app_color.dart';
import 'package:task_manager_app/presentation/widgets/card_context.dart';
import 'package:task_manager_app/presentation/widgets/common_appbar.dart';
import 'package:task_manager_app/presentation/widgets/screen_background.dart';
import 'package:task_manager_app/presentation/widgets/snack_bar_message.dart';
import 'package:task_manager_app/presentation/widgets/task_card.dart';

import '../../data/utility/urls.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({Key? key}) : super(key: key);

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  // important
  bool _getAllTaskStatusCountProgress = false;
  bool _getTaskListInProgress = false;
  bool _deleteTaskInProgress = false;
  bool _updateTaskInProgress = false;
  TaskStatusCount? _taskStatusCount = TaskStatusCount();
  TaskListByStatus _taskListByStatus = TaskListByStatus();

  @override
  void initState() {
    super.initState();
    _fetchTaskListByStatus();
    _getAllTaskCountStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskContent()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: AppColor.themeColor,
      ),
      body: ScreenBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Visibility(
              visible: _getAllTaskStatusCountProgress == false,
              replacement: const LinearProgressIndicator(),
              child: SizedBox(
                height: 100,
                child: ListView.separated(
                  itemCount: _taskStatusCount?.data?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      title: _taskStatusCount?.data![index].sId ?? '',
                      amount: _taskStatusCount?.data![index].sum ?? 0,
                    );
                  },
                  separatorBuilder: (_, __) {
                    return const SizedBox(width: 8);
                  },
                ),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: _getTaskListInProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: () async {
                    _fetchTaskListByStatus();
                    // _getAllTaskCountStatus();
                  },
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
                    },
                  ),
                ),
              ),
            )
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

  Future<void> _fetchTaskListByStatus() async {
    _getTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.newTaskStatusUrl);
    if (response.isSuccess) {
      _taskListByStatus = TaskListByStatus.fromJson(response.responseBody);
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMassage ?? 'Get task failed');
      }
    }
    _getTaskListInProgress = false;
    setState(() {});
  }

  Future<void> _deleteTaskById(String id) async {
    _deleteTaskInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.deleteTaskById(id));
    _deleteTaskInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _fetchTaskListByStatus();
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
                  const ListTile(
                    title: Text('New'),
                    trailing: Icon(Icons.check),
                  ),
                  ListTile(
                      title: const Text('Completed'),
                      onTap: () {
                        _updateTaskById(id, 'Completed');
                        Navigator.pop(context);
                      }),
                  ListTile(
                      title: const Text('Progress'),
                      onTap: () {
                        _updateTaskById(id, 'Progress');
                        Navigator.pop(context);
                      }),
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
      _fetchTaskListByStatus();
      _getAllTaskCountStatus();
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMassage ?? 'Task update task failed');
      }
    }
  }
}
