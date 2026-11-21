import 'package:material_ui/material_ui.dart';

import '../data/sample_data.dart';
import '../models/subscription.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/band_card.dart';
import '../widgets/category_filter_row.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/front_card.dart';

// Owner: Barkın
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SubscriptionCategory? _filter;
  String? _openId;

  Future<void> _openDetail(Subscription s) async {
    await Navigator.pushNamed(context, AppRoutes.detail, arguments: s.id);
    setState(() {});
  }

  Future<void> _remove(Subscription s) async {
    final ok = await showConfirmDialog(
      context,
      title: 'Delete ${s.name}?',
      message: 'It will be removed from your list.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (ok) setState(() => SampleData.remove(s.id));
  }

  @override
  Widget build(BuildContext context) {
    final entries = SampleData.upcoming
        .where((s) => _filter == null || s.category == _filter)
        .toList();

    // The open card falls back to the nearest one.
    var openId = entries.isEmpty ? null : entries.first.id;
    if (entries.any((s) => s.id == _openId)) openId = _openId;

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
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenPadding,
                  0,
                  AppSpacing.screenPadding,
                  AppSpacing.l,
                ),
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final s = entries[index];
                  if (s.id == openId) {
                    return FrontCard(
                      entry: s,
                      onDetails: () => _openDetail(s),
                      onRemove: () => _remove(s),
                    );
                  }
                  final isLast = index == entries.length - 1;
                  // A band takes 75% of its height, so the next card covers the rest.
                  return Align(
                    alignment: Alignment.topCenter,
                    heightFactor: isLast ? 1 : 0.75,
                    child: BandCard(
                      entry: s,
                      onTap: () => setState(() => _openId = s.id),
                      onRemove: () => _remove(s),
                    ),
                  );
                },
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
