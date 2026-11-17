import 'package:material_ui/material_ui.dart';

import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
  });

  final String label;
  final TextEditingController? controller;
  final String? hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          readOnly: readOnly,
          onTap: onTap,
          style: AppTextStyles.body,
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    );
  }
}
