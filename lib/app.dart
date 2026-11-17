import 'package:material_ui/material_ui.dart';

import 'data/subscription_store.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

class CancelrApp extends StatefulWidget {
  const CancelrApp({super.key, this.store});

  final SubscriptionStore? store;

  @override
  State<CancelrApp> createState() => _CancelrAppState();
}

class _CancelrAppState extends State<CancelrApp> {
  late final SubscriptionStore _store = widget.store ?? SubscriptionStore();

  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SubscriptionScope(
      store: _store,
      child: MaterialApp(
        title: 'Cancelr',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
