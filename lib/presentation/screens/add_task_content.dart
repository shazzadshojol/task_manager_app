import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/presentation/screens/bottom_nav_screen.dart';
import 'package:task_manager_app/presentation/screens/auth/email_verify_screen.dart';
import 'package:task_manager_app/presentation/widgets/screen_background.dart';

import 'package:task_manager_app/presentation/screens/auth/sign_up_screen.dart';

class AddTaskContent extends StatefulWidget {
  const AddTaskContent({
    super.key,
  });

  @override
  State<AddTaskContent> createState() => _AddTaskContentState();
}

class _AddTaskContentState extends State<AddTaskContent> {
  final TextEditingController _subjectTextController = TextEditingController();
  final TextEditingController _disTextController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text(
                  'Get Started With',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _subjectTextController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Subject',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _disTextController,
                  keyboardType: TextInputType.text,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_circle_right_outlined,
                      size: 35,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    _subjectTextController.dispose();
    _disTextController.dispose();
    super.dispose();
  }
}
