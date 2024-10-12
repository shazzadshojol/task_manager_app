class Urls {
  static const String _baseUrl = 'http://152.42.163.176:2006/api/v1';
  static String registration = '$_baseUrl/Registration';
  static String login = '$_baseUrl/Login';
  static String createTask = '$_baseUrl/CreateTask';
  static String profileUpdate = '$_baseUrl/ProfileUpdate';
  static String taskStatusCountUrl = '$_baseUrl/TaskStatusCount';
  static String newTaskStatusUrl = '$_baseUrl/ListTaskByStatus/New';
  static String completedTaskList = '$_baseUrl/ListTaskByStatus/Completed';
  static String progressTaskList = '$_baseUrl/ListTaskByStatus/Progress';
  static String cancelledTask = '$_baseUrl/ListTaskByStatus/Cancelled';
  static String resetPassword = '$_baseUrl/RecoverResetPass';

  static String deleteTaskById(String id) => '$_baseUrl/DeleteTask/$id';

  static String emailVerify(String email, Map<String, dynamic> inputParams) =>
      '$_baseUrl/RecoverVerifyEmail/$email';

  static String otpVerify(String otp) => '$_baseUrl/RecoverVerifyEmail/$otp';

  static String updateTaskStatus(String id, String status) =>
      '$_baseUrl/UpdateTaskStatus/$id/$status';
}
