import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:task_manager_app/data/wrapper_class/response_object.dart';

class NetworkCaller {
  static Future<ResponseObject> getRequest(String url) async {
    try {
      final Response response = await get(Uri.parse(url),
          headers: {'Content-type': 'application/json'});

      log('Response: ${response.body}');
      log('Response: ${response.statusCode}');

      print('Response: ${response.body}');
      print('Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final decodedResponse = await jsonDecode(response.body);
        return ResponseObject(
            isSuccess: true, statusCode: 200, responseBody: decodedResponse);
      } else {
        return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            responseBody: '');
      }
    } catch (e) {
      return ResponseObject(
          isSuccess: false,
          statusCode: -1,
          responseBody: '',
          errorMessage: 'Network caller${e.toString()}');
    }
  }

  static Future<ResponseObject> postRequest(
      String url, Map<String, dynamic> body) async {
    try {
      final Response response = await post(Uri.parse(url),
          headers: {'Content-type': 'application/json'},
          body: jsonEncode(body));

      log('Response: ${response.body}');
      log('Response: ${response.statusCode}');

      print('Response: ${response.body}');
      print('Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final decodedResponse = await jsonDecode(response.body);
        return ResponseObject(
            isSuccess: true, statusCode: 200, responseBody: decodedResponse);
      } else {
        return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            responseBody: '');
      }
    } catch (e) {
      return ResponseObject(
          isSuccess: false,
          statusCode: -1,
          responseBody: '',
          errorMessage: 'Network caller${e.toString()}');
    }
  }
}
