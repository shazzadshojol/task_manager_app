import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.amount,
    required this.title,
  });

  final int amount;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: taskCounter),
    );
  }

  Widget get taskCounter {
    return Column(
      children: [
        Text(
          '$amount',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        Text(
          '$title',
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
      ],
    );
  }
}
