import 'package:material_ui/material_ui.dart';

import '../routes/app_routes.dart';
import '../widgets/placeholder_screen.dart';

// Owner: Boran
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: 'Login',
      owner: 'Boran',
      links: [
        ('Log in', () => Navigator.pushReplacementNamed(context, AppRoutes.home)),
        ('No account? Sign up', () => Navigator.pushNamed(context, AppRoutes.signUp)),
        ('Forgot password?', () => Navigator.pushNamed(context, AppRoutes.forgotPassword)),
      ],
    );
  }
}
