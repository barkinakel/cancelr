import 'package:material_ui/material_ui.dart';

import '../widgets/placeholder_screen.dart';

// Owner: Boran
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: 'Reset password',
      owner: 'Boran',
      links: [
        ('Back to login', () => Navigator.pop(context)),
      ],
    );
  }
}
