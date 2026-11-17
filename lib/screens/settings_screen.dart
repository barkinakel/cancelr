import 'package:material_ui/material_ui.dart';

import '../routes/app_routes.dart';
import '../widgets/placeholder_screen.dart';

// Owner: Boran
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: 'Settings',
      owner: 'Boran',
      links: [
        ('Log out', () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false)),
        ('Back', () => Navigator.pop(context)),
      ],
    );
  }
}
