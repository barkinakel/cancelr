import 'package:material_ui/material_ui.dart';

import '../data/sample_data.dart';
import '../models/subscription.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../widgets/service_logo.dart';

// Owner: Onat
class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // Stateful so the screen can refresh after coming back from Edit.
  Future<void> _openEdit(String id) async {
    await Navigator.pushNamed(context, AppRoutes.edit, arguments: id);
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Home opens this screen with the entry's id as the argument.
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final entry = SampleData.byId(id);
    if (entry == null) return const Scaffold(); // entry was deleted

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DetailHeader(
              entry: entry,
              onBack: () => Navigator.pop(context),
              onEdit: () => _openEdit(id),
            ),
            // Info rows come in commit 2.
          ],
        ),
      ),
    );
  }
}

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({
    required this.entry,
    required this.onBack,
    required this.onEdit,
  });

  final Subscription entry;
  final VoidCallback onBack;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final days = entry.daysLeft();
    final shownDays = days < 0 ? 0 : days;
    final dayWord = shownDays == 1 ? 'DAY' : 'DAYS';
    final onCardBold = AppTextStyles.bodyStrong.copyWith(color: AppColors.onCard);

    return Container(
      decoration: BoxDecoration(
        color: entry.category.color,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(AppSpacing.radiusCard),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s, AppSpacing.s, AppSpacing.s, AppSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_back, color: AppColors.onCard),
                    label: Text('Back', style: onCardBold),
                  ),
                  TextButton(
                    onPressed: onEdit,
                    child: Text('Edit', style: onCardBold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.s),
                    ServiceLogo(name: entry.name, url: entry.logoUrl, size: 48),
                    // FittedBox shrinks the big number on small screens.
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text('$shownDays', style: AppTextStyles.countdown),
                    ),
                    Text(
                      '$dayWord LEFT ON ${entry.name.toUpperCase()}',
                      style: AppTextStyles.displayLabel,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      "You'll pay ${entry.priceLabel} on ${_formatDate(entry.endDate)}",
                      style: AppTextStyles.body.copyWith(color: AppColors.onCard),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// e.g. 20 Nov 2026 (the project has no date-formatting package).
String _formatDate(DateTime date) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return '${date.day} ${months[date.month - 1]} ${date.year}';
}