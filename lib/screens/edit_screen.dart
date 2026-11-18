import 'package:material_ui/material_ui.dart';

import '../data/sample_data.dart';
import '../widgets/placeholder_screen.dart';

// Owner: Zeynep
class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final entry = SampleData.byId(id);

    return PlaceholderScreen(
      title: 'Edit ${entry?.name ?? ''}',
      owner: 'Zeynep',
      links: [
        ('Save changes', () => Navigator.pop(context)),
      ],
    );
  }
}
