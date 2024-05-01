import 'package:flutter/material.dart';
import 'package:task_manager_app/app.dart';
import 'package:task_manager_app/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager_app/presentation/screens/auth/update_profile.dart';
import 'package:task_manager_app/presentation/utils/app_color.dart';

PreferredSizeWidget get commonAppBar {
  return AppBar(
    backgroundColor: AppColor.themeColor,
    title: GestureDetector(
      onTap: () {
        Navigator.push(TaskManager.navigatorKey.currentState!.context,
            MaterialPageRoute(builder: (context) => const UpdateProfile()));
      },
      child: Row(
        children: [
          const CircleAvatar(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                Text(
                  '',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                )
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    TaskManager.navigatorKey.currentState!.context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()),
                    (route) => false);
              },
              icon: const Icon(Icons.logout_outlined)),
        ],
      ),
    ),
  );
}
