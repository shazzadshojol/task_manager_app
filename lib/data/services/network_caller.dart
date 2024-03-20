import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:task_manager_app/data/models/response_obj.dart';
import 'package:task_manager_app/presentation/controllers/auth_controller.dart';

class NetworkCaller {
  static Future<ResponseObj> getRequest(String url) async {
    try {
      final Response response = await get(Uri.parse(url),
          headers: {'token': AuthController.accessToken ?? ''});

      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        final decodeResponse = jsonDecode(response.body);
        return ResponseObj(
            isSuccess: true, statusCode: 200, responseBody: decodeResponse);
      } else if (response.statusCode == 401) {
        return ResponseObj(
            isSuccess: false,
            statusCode: response.statusCode,
            responseBody: '',
            errorMassage: 'Invalid input');
      } else {
        return ResponseObj(
            isSuccess: false,
            statusCode: response.statusCode,
            responseBody: '');
      }
    } catch (e) {
      log(e.toString());
      return ResponseObj(
          isSuccess: false,
          statusCode: -1,
          responseBody: '',
          errorMassage: e.toString());
    }
  }

  static Future<ResponseObj> postRequest(
      String url, Map<String, dynamic> body) async {
    try {
      final Response response = await post(Uri.parse(url),
          body: jsonEncode(body),
          headers: {
            'content-type': 'application/json',
            'token': AuthController.accessToken ?? ''
          });

      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        final decodeResponse = jsonDecode(response.body);
        return ResponseObj(
            isSuccess: true, statusCode: 200, responseBody: decodeResponse);
      } else {
        return ResponseObj(
            isSuccess: false,
            statusCode: response.statusCode,
            responseBody: '');
      }
    } catch (e) {
      log(e.toString());
      return ResponseObj(
          isSuccess: false,
          statusCode: -1,
          responseBody: '',
          errorMassage: e.toString());
    }
  }
}
