import 'package:task_manager_app/data/models/task_status_data.dart';

class TaskStatusCount {
  String? status;
  List<TaskByStatusData>? data;

  List<TaskByStatusData>? listOfTaskByStatusData;

  TaskStatusCount({this.status, this.data});

  TaskStatusCount.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TaskByStatusData>[];
      json['data'].forEach((v) {
        data!.add(TaskByStatusData.fromJson(v));
      });
    }
  }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> taskData = Map<String, dynamic>();
//     taskData['status'] = status;
//     if (data != null) {
//       taskData['taskData'] = data!.map((v) => v.toJson()).toList();
//     }
//     return taskData;
//   }
// }
}
