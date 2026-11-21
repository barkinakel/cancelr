import 'package:material_ui/material_ui.dart';

import '../data/sample_data.dart';
import '../models/subscription.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../utils/money.dart';
import '../widgets/service_logo.dart';

// Owner: Onat
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Future<void> _openDetail(Subscription entry) async {
    await Navigator.pushNamed(context, AppRoutes.detail, arguments: entry.id);
    if (!mounted) return;
    setState(() {}); // Detail can delete the entry, so rebuild the list.
  }

  @override
  Widget build(BuildContext context) {
    final cancelled = SampleData.cancelled; // newest first

    return Scaffold(
      appBar: AppBar(), // shows the back arrow
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            Text('HISTORY', style: AppTextStyles.screenTitle),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'You saved ${formatMoney(SampleData.savedTotal)} by cancelling on time',
              style: AppTextStyles.label,
            ),
            const SizedBox(height: AppSpacing.l),
            for (final entry in cancelled) ...[
              _HistoryCard(entry: entry, onTap: () => _openDetail(entry)),
              const SizedBox(height: AppSpacing.s),
            ],
          ],
        ),
      ),
    );
  }
}

// One cancelled entry, shown as a Card in its category color.
class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.entry, required this.onTap});

  final Subscription entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: entry.category.color,
      clipBehavior: Clip.antiAlias, // keeps the tap ripple inside the rounded corners
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.l),
          child: Row(
            children: [
              ServiceLogo(name: entry.name, url: entry.logoUrl),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.name,
                      style: AppTextStyles.cardTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Cancelled · ${entry.priceLabel}',
                      style: AppTextStyles.body.copyWith(color: AppColors.onCard),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}