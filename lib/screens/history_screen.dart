import 'package:material_ui/material_ui.dart';

import '../widgets/placeholder_screen.dart';

// Owner: Onat
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: 'History',
      owner: 'Onat',
      links: [
        ('Back', () => Navigator.pop(context)),
      ],
    );
  }
}
