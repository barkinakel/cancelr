import 'package:material_ui/material_ui.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String displayFont = 'Anton';
  static const String bodyFont = 'SpaceGrotesk';

  // Space Grotesk is a variable font, so the weight is also set as a variation.
  static TextStyle _body(double size, FontWeight weight, Color color) {
    return TextStyle(
      fontFamily: bodyFont,
      fontSize: size,
      fontWeight: weight,
      fontVariations: [FontVariation('wght', weight.value.toDouble())],
      color: color,
    );
  }

  static TextStyle _display(double size, Color color) {
    return TextStyle(
      fontFamily: displayFont,
      fontSize: size,
      height: 1.15,
      color: color,
    );
  }

  static final TextStyle countdown = _display(140, AppColors.onCard);
  static final TextStyle bandNumber = _display(44, AppColors.onCard);
  static final TextStyle screenTitle = _display(34, AppColors.textPrimary);
  static final TextStyle displayLabel = _display(26, AppColors.onCard);
  static final TextStyle amount = _display(100, AppColors.textPrimary);

  static final TextStyle cardTitle = _body(20, FontWeight.w700, AppColors.onCard);
  static final TextStyle title = _body(16, FontWeight.w700, AppColors.textPrimary);
  static final TextStyle body = _body(15, FontWeight.w400, AppColors.textPrimary);
  static final TextStyle bodyStrong = _body(15, FontWeight.w700, AppColors.textPrimary);
  static final TextStyle label = _body(13, FontWeight.w500, AppColors.textSecondary);
  static final TextStyle caption = _body(12, FontWeight.w400, AppColors.textSecondary);
  static final TextStyle button = _body(16, FontWeight.w700, AppColors.onCard);
  static final TextStyle error = _body(13, FontWeight.w500, AppColors.error);
}
