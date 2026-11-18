import 'package:material_ui/material_ui.dart';

import '../screens/add_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/edit_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/history_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/sign_up_screen.dart';
import '../screens/summary_screen.dart';

// Detail and Edit get the entry id: pushNamed(context, AppRoutes.detail, arguments: id)
class AppRoutes {
  AppRoutes._();

  static const String login = '/';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String detail = '/detail';
  static const String add = '/add';
  static const String edit = '/edit';
  static const String summary = '/summary';
  static const String history = '/history';
  static const String settings = '/settings';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    signUp: (context) => const SignUpScreen(),
    forgotPassword: (context) => const ForgotPasswordScreen(),
    home: (context) => const HomeScreen(),
    detail: (context) => const DetailScreen(),
    add: (context) => const AddScreen(),
    edit: (context) => const EditScreen(),
    summary: (context) => const SummaryScreen(),
    history: (context) => const HistoryScreen(),
    settings: (context) => const SettingsScreen(),
  };
}
