import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/presentation/widgets/card_context.dart';
import 'package:task_manager_app/presentation/widgets/common_appbar.dart';
import 'package:task_manager_app/presentation/widgets/screen_background.dart';

import '../controllers/delete_task_controller.dart';
import '../controllers/task_status_count_controller.dart';
import '../controllers/task_status_list_controller.dart';
import '../controllers/task_update_controller.dart';

class ProgressTask extends StatefulWidget {
  const ProgressTask({super.key});

  @override
  State<ProgressTask> createState() => _ProgressTaskState();
}

class _ProgressTaskState extends State<ProgressTask> {
  late final TaskStatusCountController _taskStatusCountController =
      Get.find<TaskStatusCountController>();
  late final TaskStatusListController _taskStatusListController =
      Get.find<TaskStatusListController>();
  late final TaskDeleteController _taskDeleteController =
      Get.find<TaskDeleteController>();
  late final TaskUpdateController _taskUpdateController =
      Get.find<TaskUpdateController>();

  @override
  void initState() {
    _taskStatusCountController.getTaskCount();
    _taskStatusListController.getTaskList();
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
            GetBuilder<TaskStatusListController>(
                builder: (taskStatusListController) {
              return Expanded(
                child: Visibility(
                  visible: taskStatusListController.inProgress == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      taskStatusListController.getTaskList();
                      _taskStatusCountController.getTaskCount();
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
                            _taskDeleteController.deleteTaskById(
                                taskStatusListController
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
              );
            })
          ],
        ),
      ),
    );
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
                        _taskUpdateController.updateTaskById(id, 'New');
                        Navigator.pop(context);
                      }),
                  ListTile(
                    title: const Text('Completed'),
                    onTap: () {
                      _taskUpdateController.updateTaskById(id, 'Completed');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                      title: const Text('Progress'),
                      trailing: const Icon(Icons.check),
                      onTap: () {
                        _taskUpdateController.updateTaskById(id, 'Progress');
                        Navigator.pop(context);
                      }),
                  ListTile(
                      title: const Text('Cancelled'),
                      onTap: () {
                        _taskUpdateController.updateTaskById(id, 'Cancelled');
                        Navigator.pop(context);
                      }),
                ],
              ),
            ));
  }
}
