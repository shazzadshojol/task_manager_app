import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/task_item.dart';

class CardContext extends StatelessWidget {
  const CardContext({
    super.key,
    required this.taskItem,
    required this.onDelete,
    required this.onEdit,
  });

  final TaskItem taskItem;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskItem.title ?? ''),
            Text(taskItem.description ?? ''),
            Text('Date: ${taskItem.createdDate}'),
            Row(
              children: [
                Chip(label: Text(taskItem.status ?? '')),
                const Spacer(),
                IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
                IconButton(onPressed: onDelete, icon: const Icon(Icons.delete))
              ],
            )
          ],
        ),
      ),
    );
  }
}
