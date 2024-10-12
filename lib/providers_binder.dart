import 'package:provider/provider.dart';
import 'package:task_manager_app/presentation/providers/auth_provider.dart';
import 'package:task_manager_app/presentation/providers/signin_provider.dart';
import 'package:task_manager_app/presentation/providers/signup_provider.dart';

class ProvidersBinder {
  static getProvider() => [
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => SignInProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ];
}
