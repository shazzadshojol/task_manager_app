import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/presentation/screens/add_task_content.dart';
import 'package:task_manager_app/presentation/utils/app_color.dart';
import 'package:task_manager_app/presentation/widgets/card_context.dart';
import 'package:task_manager_app/presentation/widgets/common_appbar.dart';
import 'package:task_manager_app/presentation/widgets/screen_background.dart';
import 'package:task_manager_app/presentation/widgets/task_card.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
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
            SizedBox(
              height: 100,
              child: ListView.separated(
                itemCount: 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const TaskCard(
                    title: '',
                    amount: 0,
                  );
                },
                separatorBuilder: (_, __) {
                  return const SizedBox(width: 8);
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 0,
                itemBuilder: (context, index) {
                  return const CardContext();
                },
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
                  ListTile(title: const Text('Completed'), onTap: () {}),
                  ListTile(title: const Text('Progress'), onTap: () {}),
                  ListTile(title: const Text('Cancelled'), onTap: () {}),
                ],
              ),
            ));
  }
}
