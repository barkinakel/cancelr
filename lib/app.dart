import 'package:material_ui/material_ui.dart';

import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

class CancelrApp extends StatelessWidget {
  const CancelrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cancelr',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}
