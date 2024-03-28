import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager_app/data/models/task_list_By_Status.dart';
import 'package:task_manager_app/data/models/task_status_count.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/presentation/controllers/task_status_count_controller.dart';
import 'package:task_manager_app/presentation/controllers/task_status_list_controller.dart';
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
  final TaskStatusCountController taskStatusCountController =
      Get.find<TaskStatusCountController>();
  final TaskStatusListController taskStatusListController =
      Get.find<TaskStatusListController>();

  @override
  void initState() {
    super.initState();
    taskStatusCountController.getTaskCount();
    taskStatusListController.getTaskList();
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
            GetBuilder<TaskStatusCountController>(
                builder: (taskStatusCountController) {
              return Visibility(
                visible: taskStatusCountController.inProgress == false,
                replacement: const LinearProgressIndicator(),
                child: SizedBox(
                  height: 100,
                  child: ListView.separated(
                    itemCount: taskStatusCountController
                            .taskStatusCount.data?.length ??
                        0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        title: taskStatusCountController
                                .taskStatusCount.data![index].sId ??
                            '',
                        amount: taskStatusCountController
                                .taskStatusCount.data![index].sum ??
                            0,
                      );
                    },
                    separatorBuilder: (_, __) {
                      return const SizedBox(width: 8);
                    },
                  ),
                ),
              );
            }),
            Expanded(
              child: Visibility(
                visible: taskStatusListController.inProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: () async {
                    taskStatusCountController.getTaskCount();
                    taskStatusListController.getTaskList();
                  },
                  child: ListView.builder(
                    itemCount: taskStatusListController
                            .taskListByStatus.taskList?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return CardContext(
                        taskItem: taskStatusListController
                            .taskListByStatus.taskList![index],
                        onDelete: () {
                          _deleteTaskById(taskStatusListController
                              .taskListByStatus.taskList![index].sId!);
                        },
                        onEdit: () {
                          _showUpdateStatusDialog(taskStatusListController
                              .taskListByStatus.taskList![index].sId!);
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

  Future<void> _deleteTaskById(String id) async {
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.deleteTaskById(id));
    setState(() {});
    if (response.isSuccess) {
      taskStatusCountController.getTaskCount();
      taskStatusListController.getTaskList();
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Delete task failed');
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
    setState(() {});
    final response =
        await NetworkCaller.getRequest(Urls.updateTaskStatus(id, status));

    if (response.isSuccess) {
      taskStatusCountController.getTaskCount();
      taskStatusListController.getTaskList();
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Task update task failed');
      }
    }
  }
}
