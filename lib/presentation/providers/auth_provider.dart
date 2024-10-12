import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/data/models/login_response.dart';
import 'package:task_manager_app/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager_app/presentation/screens/bottom_nav_screen.dart';

class AuthProvider extends ChangeNotifier {
  static String? token;
  static Data? userData;

  static Future<void> saveUserData(Data? data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (token != null) {
      await prefs.setString('token', token!);
    }

    if (data != null) {
      await prefs.setString('userData', jsonEncode(data.toJson()));
      userData = data;
    }
  }

  static Future<String?> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<bool> isTokenValid() async {
    token = await getUserToken();
    return token != null;
  }

  static Future<Data?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = prefs.getString('userData');
    if (result != null) {
      return Data.fromJson(jsonDecode(result));
    }
    return null;
  }

  static Future<void> checkLoggedStatus() async {
    bool tokenStatus = await AuthProvider.isTokenValid();
    if (tokenStatus) {
      Get.to(() => BottomNavScreen());
    } else {
      Get.to(() => SignInScreen());
    }
  }
}
