class ResponseObj {
  final bool isSuccess;
  final int statusCode;
  final dynamic responseBody;
  final String? errorMassage;

  ResponseObj(
      {required this.isSuccess,
      required this.statusCode,
      required this.responseBody,
      this.errorMassage});
}
