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
      appBar: commonAppBar,
      body: ScreenBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 0,
                itemBuilder: (context, index) {
                  return CardContext();
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
            ListTile(
              title: const Text('New'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Completed'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Progress'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Cancelled'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
