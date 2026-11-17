import 'package:material_ui/material_ui.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

enum AppButtonStyle { primary, secondary, danger, link }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.style = AppButtonStyle.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonStyle style;

  @override
  Widget build(BuildContext context) {
    if (style == AppButtonStyle.link) {
      return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          minimumSize: const Size(0, AppSpacing.minTapTarget),
          foregroundColor: AppColors.textPrimary,
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyStrong.copyWith(
            decoration: TextDecoration.underline,
            decorationColor: AppColors.textPrimary,
          ),
        ),
      );
    }

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
    );
    const size = Size(double.infinity, 52);

    if (style == AppButtonStyle.primary) {
      return FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.onCard,
          minimumSize: size,
          shape: shape,
        ),
        child: Text(label, style: AppTextStyles.button),
      );
    }

    final color =
        style == AppButtonStyle.danger ? AppColors.error : AppColors.textPrimary;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        minimumSize: size,
        shape: shape,
        side: const BorderSide(color: AppColors.outline),
      ),
      child: Text(label, style: AppTextStyles.button.copyWith(color: color)),
    );
  }
}
