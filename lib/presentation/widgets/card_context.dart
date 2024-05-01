import 'package:flutter/material.dart';

class CardContext extends StatelessWidget {
  const CardContext({
    super.key,
  });

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
            Text(''),
            Text(''),
            Text('Date: '),
            Row(
              children: [
                Chip(label: Text('')),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
              ],
            )
          ],
        ),
      ),
    );
  }
}
