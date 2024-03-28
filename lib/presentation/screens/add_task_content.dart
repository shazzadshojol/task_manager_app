import 'package:flutter/material.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/presentation/widgets/screen_background.dart';
import 'package:task_manager_app/presentation/widgets/snack_bar_message.dart';

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
  bool _addNewTaskProgress = false;

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
                  'Add your task',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _subjectTextController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Subject',
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter subject';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _disTextController,
                  keyboardType: TextInputType.text,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _addNewTaskProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addNewTask();
                        }
                      },
                      child: const Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 35,
                      ),
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

  Future<void> _addNewTask() async {
    _addNewTaskProgress = true;
    setState(() {});
    Map<String, dynamic> inputParams = {
      "title": _subjectTextController.text.trim(),
      "description": _disTextController.text.trim(),
      "status": "New"
    };
    final response =
        await NetworkCaller.postRequest(Urls.createTask, inputParams);

    _addNewTaskProgress = false;
    setState(() {});

    if (response.isSuccess) {
      _subjectTextController.clear();
      _disTextController.clear();
      if (mounted) {
        showSnackBarMessage(context, 'Task added');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Task adding failed', true);
      }
    }
  }

  @override
  void dispose() {
    _subjectTextController.dispose();
    _disTextController.dispose();
    super.dispose();
  }
}
