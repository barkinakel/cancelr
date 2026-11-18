import 'package:material_ui/material_ui.dart';

import '../data/sample_data.dart';
import '../routes/app_routes.dart';
import '../widgets/placeholder_screen.dart';

// Owner: Onat
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final entry = SampleData.byId(id);

    return PlaceholderScreen(
      title: entry?.name ?? 'Detail',
      owner: 'Onat',
      links: [
        ('Edit', () => Navigator.pushNamed(context, AppRoutes.edit, arguments: id)),
        ('Back', () => Navigator.pop(context)),
      ],
    );
  }
}
