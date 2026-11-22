import 'package:material_ui/material_ui.dart';

import '../models/subscription.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'service_logo.dart';

// The short cards under the front card on Home.
class BandCard extends StatelessWidget {
  const BandCard({
    super.key,
    required this.entry,
    required this.onTap,
    this.onRemove,
  });

  final Subscription entry;
  final VoidCallback onTap;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final days = entry.daysLeft();

    return Card(
      color: entry.category.color,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.l,
            AppSpacing.s,
            AppSpacing.xs,
            AppSpacing.s + AppSpacing.stackOverlap,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 60,
                child: Text(
                  days < 0 ? '0' : '$days',
                  style: AppTextStyles.bandNumber,
                ),
              ),
              ServiceLogo(name: entry.name, url: entry.logoUrl, size: 32),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.name,
                      style: AppTextStyles.title.copyWith(color: AppColors.onCard),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${entry.type.label} · ${entry.priceLabel}',
                      style: AppTextStyles.caption.copyWith(color: AppColors.onCard),
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
        ),
      ),
    );
  }
}
