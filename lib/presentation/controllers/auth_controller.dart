import 'dart:convert';

import 'package:task_manager_app/data/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static String? accessToken;

  static Future<void> saveUserData(UserData userData) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(
        'userData', jsonEncode(userData.toJson()));
  }

  static Future<UserData?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? result = sharedPreferences.getString('userData');
    if (result == null) {
      return null;
    }
    return UserData.fromJson(jsonDecode(result));
  }

  static Future<void> saveUserToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', token);
    accessToken = token;
  }

  static Future<String?> getUserToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  static Future<bool> isUserLoggedIn() async {
    final result = await getUserToken();
    accessToken = result;
    return result != null;
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
