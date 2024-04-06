import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/presentation/screens/add_new_task.dart';
import 'package:task_manager_app/presentation/screens/cancelled_task.dart';
import 'package:task_manager_app/presentation/screens/complete_task.dart';
import 'package:task_manager_app/presentation/screens/progress_task.dart';
import 'package:task_manager_app/presentation/utils/app_color.dart';

import '../controllers/task_status_count_controller.dart';
import '../controllers/task_status_list_controller.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}



class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const AddNewTask(),
    const CompleteTask(),
    const ProgressTask(),
    const CancelledTask(),
  ];

  @override
  void initState() {

    super.initState();

    Get.put(TaskStatusCountController());
    Get.put(TaskStatusListController());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.themeColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          _selectedIndex = index;
          if (mounted) {
            setState(() {});
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.add_chart), label: 'Add task'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_all), label: 'Completed'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_alarm), label: 'Progress'),
          BottomNavigationBarItem(
              icon: Icon(Icons.delete_forever_outlined), label: 'Cancelled')
        ],
      ),
    );
  }
}
