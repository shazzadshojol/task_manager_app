import 'package:flutter/material.dart';
import 'package:task_manager_app/presentation/widgets/card_context.dart';
import 'package:task_manager_app/presentation/widgets/common_appbar.dart';
import 'package:task_manager_app/presentation/widgets/screen_background.dart';

class CancelledTask extends StatefulWidget {
  const CancelledTask({super.key});

  @override
  State<CancelledTask> createState() => _CancelledTaskState();
}

class _CancelledTaskState extends State<CancelledTask> {
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
