class ResponseObj {
  final bool isSuccess;
  final int statusCode;
  final dynamic responseBody;
  final String? errorMessage;

  ResponseObj(
      {required this.isSuccess,
      required this.statusCode,
      required this.responseBody,
      this.errorMessage});
}
