import 'package:material_ui/material_ui.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final fieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusField),
      borderSide: BorderSide.none,
    );

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: AppTextStyles.bodyFont,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        onPrimary: AppColors.onCard,
        surface: AppColors.background,
        onSurface: AppColors.textPrimary,
        error: AppColors.error,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        titleTextStyle: AppTextStyles.title,
      ),
      cardTheme: CardThemeData(
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
        errorStyle: AppTextStyles.error,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.m,
          vertical: AppSpacing.m,
        ),
        border: fieldBorder,
        enabledBorder: fieldBorder,
        focusedBorder: fieldBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.accent, width: 2),
        ),
        errorBorder: fieldBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.errorBorder, width: 2),
        ),
        focusedErrorBorder: fieldBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.errorBorder, width: 2),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.textPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surface,
        contentTextStyle: AppTextStyles.body,
      ),
    );
  }
}
