import 'package:flutter/material.dart';
import 'package:task_manager_app/presentation/widgets/common_appbar.dart';
import 'package:task_manager_app/presentation/widgets/screen_background.dart';

import '../widgets/card_context.dart';

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
              child: RefreshIndicator(
                onRefresh: () async {},
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return CardContext();
                  },
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
                  ListTile(title: const Text('New'), onTap: () {}),
                  ListTile(
                    title: const Text('Completed'),
                    onTap: () {},
                  ),
                  ListTile(
                      title: const Text('Progress'),
                      trailing: const Icon(Icons.check),
                      onTap: () {}),
                  ListTile(title: const Text('Cancelled'), onTap: () {}),
                ],
              ),
            ));
  }
}
