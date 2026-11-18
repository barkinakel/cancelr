import 'package:material_ui/material_ui.dart';

import '../data/sample_data.dart';
import '../models/subscription.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/category_filter_row.dart';

// Owner: Barkın
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SubscriptionCategory? _filter;

  Future<void> _openDetail(Subscription s) async {
    await Navigator.pushNamed(context, AppRoutes.detail, arguments: s.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final entries = SampleData.upcoming
        .where((s) => _filter == null || s.category == _filter)
        .toList();

    return Scaffold(
      bottomNavigationBar: AppBottomNav(
        current: NavTab.home,
        onAdded: () => setState(() {}),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(
              onProfile: () => Navigator.pushNamed(context, AppRoutes.settings),
            ),
            CategoryFilterRow(
              selected: _filter,
              onChanged: (c) => setState(() => _filter = c),
            ),
            const SizedBox(height: AppSpacing.m),
            // Temporary list, replaced by the card stack in the next step.
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                children: [
                  for (final s in entries)
                    ListTile(
                      title: Text(s.name, style: AppTextStyles.bodyStrong),
                      subtitle: Text(s.category.label, style: AppTextStyles.label),
                      trailing: Text(
                        '${s.daysLeft()}d',
                        style: AppTextStyles.bodyStrong,
                      ),
                      onTap: () => _openDetail(s),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onProfile});

  final VoidCallback onProfile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenPadding,
        AppSpacing.l,
        AppSpacing.screenPadding,
        AppSpacing.m,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'CANCELR',
            style: AppTextStyles.screenTitle.copyWith(fontSize: 28),
          ),
          SizedBox(
            width: AppSpacing.minTapTarget,
            height: AppSpacing.minTapTarget,
            child: OutlinedButton(
              onPressed: onProfile,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: const CircleBorder(),
                side: const BorderSide(color: AppColors.outline),
                foregroundColor: AppColors.textPrimary,
              ),
              child: const Icon(Icons.person_outline, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}
