import 'package:material_ui/material_ui.dart';

import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

enum NavTab { home, summary }

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.current});

  final NavTab current;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl, AppSpacing.s, AppSpacing.xl, AppSpacing.s,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tab(context, 'Home', NavTab.home, AppRoutes.home),
            SizedBox(
              width: 56,
              height: 56,
              child: FloatingActionButton(
                heroTag: null,
                elevation: 0,
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.onCard,
                shape: const CircleBorder(),
                tooltip: 'Add new',
                onPressed: () => Navigator.pushNamed(context, AppRoutes.add),
                child: const Icon(Icons.add, size: 28),
              ),
            ),
            _tab(context, 'Summary', NavTab.summary, AppRoutes.summary),
          ],
        ),
      ),
    );
  }

  Widget _tab(BuildContext context, String label, NavTab tab, String route) {
    final isCurrent = tab == current;
    return TextButton(
      onPressed: isCurrent
          ? null
          : () => Navigator.pushReplacementNamed(context, route),
      style: TextButton.styleFrom(
        minimumSize: const Size(72, AppSpacing.minTapTarget),
      ),
      child: Text(
        label,
        style: isCurrent
            ? AppTextStyles.bodyStrong
            : AppTextStyles.body.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}
