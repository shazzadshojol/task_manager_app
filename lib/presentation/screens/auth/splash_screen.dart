import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/presentation/controllers/auth_controller.dart';
import 'package:task_manager_app/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager_app/presentation/screens/bottom_nav_screen.dart';
import 'package:task_manager_app/presentation/utils/assets_path.dart';
import '../../widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToSignInScreen();
  }

  Future<void> _moveToSignInScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    bool loginState = await AuthController.isUserLoggedIn();
    if (mounted) {
      if (loginState) {
        Get.offAll(() => const BottomNavScreen());
      } else {
        Get.offAll(() => const SignInScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
            child: Center(child: SvgPicture.asset(AssetsPath.logoSvg))));
  }
}
