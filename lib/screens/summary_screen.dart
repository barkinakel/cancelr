import 'package:material_ui/material_ui.dart';

import '../data/sample_data.dart';
import '../models/subscription.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_bottom_nav.dart';

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
                _money(SampleData.monthlyTotal),
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
          Text(_money(amount), style: AppTextStyles.bandNumber),
        ],
      ),
    );
  }
}

// $48 for whole amounts, $12.50 otherwise. The form only uses dollars in Step 2.2.
String _money(double amount) {
  final whole = amount == amount.roundToDouble();
  return '\$${whole ? amount.toStringAsFixed(0) : amount.toStringAsFixed(2)}';
}