import 'package:material_ui/material_ui.dart';

import '../widgets/placeholder_screen.dart';

// Owner: Zeynep
class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: 'New card',
      owner: 'Zeynep',
      links: [
        ('Close', () => Navigator.pop(context)),
      ],
    );
  }
}
