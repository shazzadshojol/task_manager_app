class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String registration = '$_baseUrl/registration';
  static String login = '$_baseUrl/login';
  static String createTask = '$_baseUrl/createTask';
  static String profileUpdate = '$_baseUrl/profileUpdate';
  static String taskStatusCountUrl = '$_baseUrl/taskStatusCount';
  static String newTaskStatusUrl = '$_baseUrl/listTaskByStatus/New';
  static String completedTaskList = '$_baseUrl/listTaskByStatus/Completed';
  static String progressTaskList = '$_baseUrl/listTaskByStatus/Progress';
  static String cancelledTask = '$_baseUrl/listTaskByStatus/Cancelled';

  static String deleteTaskById(String id) => '$_baseUrl/deleteTask/$id';

  static String updateTaskStatus(String id, String status) =>
      '$_baseUrl/updateTaskStatus/$id/$status';
}
