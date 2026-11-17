import 'package:material_ui/material_ui.dart';

import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_button.dart';
import 'app_bottom_nav.dart';

// Temporary until each screen is built.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.owner,
    this.links = const [],
    this.bottomNav,
  });

  final String title;
  final String owner;
  final List<(String, VoidCallback)> links;
  final NavTab? bottomNav;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: bottomNav == null ? null : AppBottomNav(current: bottomNav!),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            Text(title.toUpperCase(), style: AppTextStyles.screenTitle),
            const SizedBox(height: AppSpacing.s),
            Text('Placeholder · owner: $owner', style: AppTextStyles.label),
            const SizedBox(height: AppSpacing.xl),
            for (final (label, onTap) in links) ...[
              AppButton(label: label, onPressed: onTap, style: AppButtonStyle.secondary),
              const SizedBox(height: AppSpacing.s),
            ],
          ],
        ),
      ),
    );
  }
}
