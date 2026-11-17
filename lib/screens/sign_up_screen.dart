import 'package:material_ui/material_ui.dart';

import '../routes/app_routes.dart';
import '../widgets/placeholder_screen.dart';

// Owner: Boran
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: 'Sign up',
      owner: 'Boran',
      links: [
        ('Sign up', () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false)),
        ('Have an account? Log in', () => Navigator.pop(context)),
      ],
    );
  }
}
