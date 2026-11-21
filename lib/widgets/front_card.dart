import 'package:material_ui/material_ui.dart';

import '../models/subscription.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../utils/date_utils.dart';
import 'service_logo.dart';

// The big card at the top of the Home stack.
class FrontCard extends StatelessWidget {
  const FrontCard({
    super.key,
    required this.entry,
    required this.onDetails,
    this.onRemove,
  });

  final Subscription entry;
  final VoidCallback onDetails;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final days = entry.daysLeft();

    return Card(
      color: entry.category.color,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.l, AppSpacing.m, AppSpacing.xs, AppSpacing.l,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ServiceLogo(name: entry.name, url: entry.logoUrl),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.name, style: AppTextStyles.cardTitle),
                      Text(
                        '${entry.type.label} · ${entry.category.label}',
                        style: AppTextStyles.label.copyWith(color: AppColors.onCard),
                      ),
                    ],
                  ),
                ),
                if (onRemove != null)
                  IconButton(
                    onPressed: onRemove,
                    tooltip: 'Remove',
                    color: AppColors.onCard,
                    icon: const Icon(Icons.close),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.m),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  days < 0 ? '0' : '$days',
                  style: AppTextStyles.countdown.copyWith(fontSize: 110),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.m),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      days < 0 ? 'CHARGED? DECIDE' : 'DAYS TO DECIDE',
                      style: AppTextStyles.displayLabel.copyWith(fontSize: 22),
                    ),
                  ),
                  Text(
                    '${entry.priceLabel} on ${shortDate(entry.endDate)}',
                    style: AppTextStyles.bodyStrong.copyWith(color: AppColors.onCard),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.m),
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.m),
              child: OutlinedButton(
                onPressed: onDetails,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.onCard,
                  minimumSize: const Size(double.infinity, AppSpacing.minTapTarget),
                  side: const BorderSide(color: AppColors.onCard),
                  shape: const StadiumBorder(),
                ),
                child: Text(
                  'Details',
                  style: AppTextStyles.bodyStrong.copyWith(color: AppColors.onCard),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
