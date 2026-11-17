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

// Detail and Edit take the entry id as arguments.
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

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final Widget page;
    switch (settings.name) {
      case login:
        page = const LoginScreen();
      case signUp:
        page = const SignUpScreen();
      case forgotPassword:
        page = const ForgotPasswordScreen();
      case home:
        page = const HomeScreen();
      case detail:
        page = DetailScreen(entryId: settings.arguments as String);
      case add:
        page = const AddScreen();
      case edit:
        page = EditScreen(entryId: settings.arguments as String);
      case summary:
        page = const SummaryScreen();
      case history:
        page = const HistoryScreen();
      case AppRoutes.settings:
        page = const SettingsScreen();
      default:
        page = const LoginScreen();
    }
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}
