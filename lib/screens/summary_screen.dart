import 'package:material_ui/material_ui.dart';

import '../data/sample_data.dart';
import '../models/subscription.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../utils/money.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/app_button.dart';

// Owner: Onat
class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  // Monthly cost of every entry still on Home, added up per category.
  // Yearly prices count as price / 12 (see Subscription.monthlyCost).
  Map<SubscriptionCategory, double> _totalsByCategory() {
    final totals = <SubscriptionCategory, double>{};
    for (final entry in SampleData.upcoming) {
      totals[entry.category] = (totals[entry.category] ?? 0) + entry.monthlyCost;
    }
    return totals;
  }

  Future<void> _openHistory() async {
    await Navigator.pushNamed(context, AppRoutes.history);
    if (!mounted) return;
    setState(() {}); // History can remove entries, so recalculate.
  }

  @override
  Widget build(BuildContext context) {
    final totals = _totalsByCategory();

    return Scaffold(
      // Stateful so the totals update after adding an entry with +.
      bottomNavigationBar: AppBottomNav(
        current: NavTab.summary,
        onAdded: () => setState(() {}),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            Text('You pay each month', style: AppTextStyles.label),
            // FittedBox shrinks the big amount if it does not fit the width.
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                formatMoney(SampleData.monthlyTotal),
                style: AppTextStyles.amount,
              ),
            ),
            const SizedBox(height: AppSpacing.l),
            if (totals.isEmpty)
              Text(
                'Nothing to pay yet. Add a trial or subscription with +.',
                style: AppTextStyles.body,
              )
            else
              // One band per category, stacked like the cards on Home.
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
                child: Column(
                  children: [
                    for (final category in SubscriptionCategory.values)
                      if (totals[category] != null)
                        _CategoryBand(category: category, amount: totals[category]!),
                  ],
                ),
              ),
            const SizedBox(height: AppSpacing.l),
            _SavedCard(amount: SampleData.savedTotal, onSeeHistory: _openHistory),
          ],
        ),
      ),
    );
  }
}

class _CategoryBand extends StatelessWidget {
  const _CategoryBand({required this.category, required this.amount});

  final SubscriptionCategory category;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: category.color,
      padding: const EdgeInsets.all(AppSpacing.l),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: Text(category.label, style: AppTextStyles.cardTitle)),
          Text(formatMoney(amount), style: AppTextStyles.bandNumber),
        ],
      ),
    );
  }
}

class _SavedCard extends StatelessWidget {
  const _SavedCard({required this.amount, required this.onSeeHistory});

  final double amount;
  final VoidCallback onSeeHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.l, AppSpacing.s, AppSpacing.l, AppSpacing.s,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.s),
                Text('Saved so far', style: AppTextStyles.title),
                AppButton(
                  label: 'See history',
                  style: AppButtonStyle.link,
                  onPressed: onSeeHistory,
                ),
              ],
            ),
          ),
          Text(
            formatMoney(amount),
            style: AppTextStyles.bandNumber.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}