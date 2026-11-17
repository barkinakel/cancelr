import 'package:material_ui/material_ui.dart';

import '../models/subscription.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

// null selected = All. Scrolls sideways so it never overflows.
class CategoryFilterRow extends StatelessWidget {
  const CategoryFilterRow({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final SubscriptionCategory? selected;
  final ValueChanged<SubscriptionCategory?> onChanged;

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[
      _chip(label: 'All', isSelected: selected == null, onTap: () => onChanged(null)),
      for (final category in SubscriptionCategory.values)
        _chip(
          label: category.label,
          dotColor: category.color,
          isSelected: selected == category,
          onTap: () => onChanged(category),
        ),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: Row(
        children: [
          for (final chip in chips)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.s),
              child: chip,
            ),
        ],
      ),
    );
  }

  Widget _chip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    Color? dotColor,
  }) {
    return Material(
      color: isSelected ? AppColors.textPrimary : Colors.transparent,
      shape: StadiumBorder(
        side: BorderSide(
          color: isSelected ? AppColors.textPrimary : AppColors.outline,
        ),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: AppSpacing.minTapTarget),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (dotColor != null) ...[
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
                ),
                const SizedBox(width: AppSpacing.s),
              ],
              Text(
                label,
                style: AppTextStyles.label.copyWith(
                  color: isSelected ? AppColors.onCard : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
