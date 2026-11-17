import 'package:material_ui/material_ui.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

// Returns true if confirmed. cancelLabel: null gives a single OK button.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  String? cancelLabel = 'Cancel',
  bool destructive = false,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title.toUpperCase(),
        style: AppTextStyles.displayLabel,
      ),
      content: Text(
        message,
        style: AppTextStyles.body.copyWith(color: AppColors.onCard),
      ),
      actions: [
        if (cancelLabel != null)
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              cancelLabel,
              style: AppTextStyles.bodyStrong.copyWith(color: AppColors.onCard),
            ),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            confirmLabel,
            style: AppTextStyles.bodyStrong.copyWith(
              color: destructive ? const Color(0xFFB3261E) : AppColors.onCard,
            ),
          ),
        ),
      ],
    ),
  );
  return result ?? false;
}
