import 'package:material_ui/material_ui.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

// Shows the first letter while loading or if the image fails.
class ServiceLogo extends StatelessWidget {
  const ServiceLogo({super.key, required this.name, this.url, this.size = 36});

  final String name;
  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) {
    final fallback = Center(
      child: Text(
        name.isEmpty ? '?' : name[0].toUpperCase(),
        style: AppTextStyles.title.copyWith(
          color: AppColors.onCard,
          fontSize: size * 0.45,
        ),
      ),
    );

    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.15),
      decoration: BoxDecoration(
        color: AppColors.textPrimary,
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      child: url == null
          ? fallback
          : Image.network(
              url!,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stack) => fallback,
              loadingBuilder: (context, child, progress) =>
                  progress == null ? child : fallback,
            ),
    );
  }
}
