import 'package:material_ui/material_ui.dart';

import '../data/subscription_store.dart';
import '../widgets/placeholder_screen.dart';

// Owner: Zeynep
class EditScreen extends StatelessWidget {
  const EditScreen({super.key, required this.entryId});

  final String entryId;

  @override
  Widget build(BuildContext context) {
    final entry = SubscriptionStore.of(context).byId(entryId);

    return PlaceholderScreen(
      title: 'Edit ${entry?.name ?? ''}',
      owner: 'Zeynep',
      links: [
        ('Save changes', () => Navigator.pop(context)),
      ],
    );
  }
}
