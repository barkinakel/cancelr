import 'package:material_ui/material_ui.dart';

import '../routes/app_routes.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/placeholder_screen.dart';

// Owner: Onat
class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: 'Summary',
      owner: 'Onat',
      bottomNav: NavTab.summary,
      links: [
        ('See history', () => Navigator.pushNamed(context, AppRoutes.history)),
      ],
    );
  }
}
