import 'package:material_ui/material_ui.dart';

import '../data/subscription_store.dart';
import '../routes/app_routes.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/placeholder_screen.dart';

// Owner: Barkın
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = SubscriptionStore.of(context);
    final first = store.upcoming.isEmpty ? null : store.upcoming.first;

    return PlaceholderScreen(
      title: 'Home',
      owner: 'Barkın',
      bottomNav: NavTab.home,
      links: [
        if (first != null)
          ('Details: ${first.name}', () => Navigator.pushNamed(context, AppRoutes.detail, arguments: first.id)),
        ('Profile icon: Settings', () => Navigator.pushNamed(context, AppRoutes.settings)),
      ],
    );
  }
}
