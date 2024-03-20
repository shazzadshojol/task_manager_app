import 'package:flutter/material.dart';
import 'package:task_manager_app/presentation/widgets/card_context.dart';
import 'package:task_manager_app/presentation/widgets/common_appbar.dart';
import 'package:task_manager_app/presentation/widgets/screen_background.dart';

class ProgressTask extends StatefulWidget {
  const ProgressTask({super.key});

  @override
  State<ProgressTask> createState() => _ProgressTaskState();
}

class _ProgressTaskState extends State<ProgressTask> {
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
