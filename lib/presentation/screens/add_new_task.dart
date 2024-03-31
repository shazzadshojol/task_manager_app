import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/presentation/controllers/task_status_count_controller.dart';
import 'package:task_manager_app/presentation/controllers/task_status_list_controller.dart';
import 'package:task_manager_app/presentation/screens/add_task_content.dart';
import 'package:task_manager_app/presentation/utils/app_color.dart';
import 'package:task_manager_app/presentation/widgets/card_context.dart';
import 'package:task_manager_app/presentation/widgets/common_appbar.dart';
import 'package:task_manager_app/presentation/widgets/screen_background.dart';
import 'package:task_manager_app/presentation/widgets/task_card.dart';

import '../controllers/delete_task_controller.dart';
import '../controllers/task_update_controller.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TaskStatusCountController _taskStatusCountController =
      Get.find<TaskStatusCountController>();
  final TaskStatusListController _taskStatusListController =
      Get.find<TaskStatusListController>();
  final TaskDeleteController _taskDeleteController =
      Get.find<TaskDeleteController>();
  final TaskUpdateController _taskUpdateController =
      Get.find<TaskUpdateController>();

  @override
  void initState() {
    super.initState();
    _taskStatusListController.getTaskList();
    _taskStatusCountController.getTaskCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddTaskContent());
        },
        backgroundColor: AppColor.themeColor,
        child: const Icon(Icons.add),
      ),
      body: ScreenBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GetBuilder<TaskStatusCountController>(
                builder: (taskStatusCountController) {
              return Visibility(
                visible: _taskStatusCountController.inProgress == false,
                replacement: const LinearProgressIndicator(),
                child: SizedBox(
                  height: 100,
                  child: ListView.separated(
                    itemCount: _taskStatusCountController
                            .taskStatusCount.data?.length ??
                        0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        title: _taskStatusCountController
                                .taskStatusCount.data![index].sId ??
                            '',
                        amount: _taskStatusCountController
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
                  const ListTile(
                    title: Text('New'),
                    trailing: Icon(Icons.check),
                  ),
                  ListTile(
                      title: const Text('Completed'),
                      onTap: () {
                        _taskUpdateController.updateTaskById(id, 'Completed');
                        Navigator.pop(context);
                      }),
                  ListTile(
                      title: const Text('Progress'),
                      onTap: () {
                        _taskUpdateController.updateTaskById(id, 'Progress');
                        Navigator.pop(context);
                      }),
                  ListTile(
                      title: const Text('Cancelled'),
                      onTap: () {
                        _taskUpdateController.updateTaskById(id, 'Progress');
                        Navigator.pop(context);
                      }),
                ],
              ),
            ));
  }
}
