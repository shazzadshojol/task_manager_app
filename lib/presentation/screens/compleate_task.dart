import 'package:flutter/material.dart';
import 'package:task_manager_app/presentation/widgets/card_context.dart';
import 'package:task_manager_app/presentation/widgets/common_appbar.dart';
import 'package:task_manager_app/presentation/widgets/screen_background.dart';

class CompleteTask extends StatefulWidget {
  const CompleteTask({super.key});

  @override
  State<CompleteTask> createState() => _CompleteTaskState();
}

class _CompleteTaskState extends State<CompleteTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar,
      body: ScreenBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
