import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/presentation/controllers/task_update_controller.dart';
import 'package:task_manager_app/presentation/widgets/card_context.dart';
import 'package:task_manager_app/presentation/widgets/common_appbar.dart';
import 'package:task_manager_app/presentation/widgets/screen_background.dart';

import '../controllers/delete_task_controller.dart';
import '../controllers/task_status_count_controller.dart';
import '../controllers/task_status_list_controller.dart';

class CancelledTask extends StatefulWidget {
  const CancelledTask({super.key});

  @override
  State<CancelledTask> createState() => _CancelledTaskState();
}

class _CancelledTaskState extends State<CancelledTask> {
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
            Expanded(
              child: Visibility(
                visible: _taskStatusListController.inProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: () async {
                    _taskStatusListController.getTaskList();
                    _taskStatusCountController.getTaskCount();
                  },
                  child: ListView.builder(
                    itemCount: _taskStatusListController
                            .taskListByStatus.taskList?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return CardContext(
                        taskItem: _taskStatusListController
                            .taskListByStatus.taskList![index],
                        onDelete: () {
                          _taskDeleteController.deleteTaskById(
                              _taskStatusListController
                                  .taskListByStatus.taskList![index].sId!);
                        },
                        onEdit: () {
                          _showUpdateStatusDialog(_taskStatusListController
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
              },
            ),
            ListTile(
              title: const Text('Completed'),
              onTap: () {
                _taskUpdateController.updateTaskById(id, 'Completed');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Progress'),
              onTap: () {
                _taskUpdateController.updateTaskById(id, 'Progress');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Cancelled'),
              onTap: () {
                _taskUpdateController.updateTaskById(
                    id, 'Cancelled'); // Corrected status here
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
