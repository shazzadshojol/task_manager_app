import 'package:flutter/material.dart';
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
            SizedBox(
              height: 100,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const TaskCard(
                      title: 'New',
                      amount: 24,
                    );
                  },
                  separatorBuilder: (_, __) {
                    return const SizedBox(width: 8);
                  },
                  itemCount: 4),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const CardContext();
                    }))
          ],
        ),
      ),
    );
  }
}
