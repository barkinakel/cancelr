import 'package:material_ui/material_ui.dart';

import '../data/subscription_store.dart';
import '../routes/app_routes.dart';
import '../widgets/placeholder_screen.dart';

// Owner: Onat
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.entryId});

  final String entryId;

  @override
  Widget build(BuildContext context) {
    final entry = SubscriptionStore.of(context).byId(entryId);

    return PlaceholderScreen(
      title: entry?.name ?? 'Detail',
      owner: 'Onat',
      links: [
        ('Edit', () => Navigator.pushNamed(context, AppRoutes.edit, arguments: entryId)),
        ('Back', () => Navigator.pop(context)),
      ],
    );
  }
}
