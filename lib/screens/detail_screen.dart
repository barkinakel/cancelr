import 'package:material_ui/material_ui.dart';

import '../data/sample_data.dart';
import '../models/subscription.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_button.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/service_logo.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Future<void> _openEdit(String id) async {
    await Navigator.pushNamed(context, AppRoutes.edit, arguments: id);
    if (!mounted) return;
    setState(() {});
  }

  void _markCancelled(Subscription entry) {
    SampleData.markCancelled(entry.id);
    _closeWithMessage('${entry.name} moved to History');
  }

  void _keep(Subscription entry) {
    SampleData.update(entry.copyWith(
      status: EntryStatus.kept,
      type: EntryType.subscription,
      endDate: _nextBillingDate(entry),
    ));
    _closeWithMessage('Keeping ${entry.name}');
  }

  Future<void> _delete(Subscription entry) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Delete ${entry.name}?',
      message: 'This entry and its reminder will be removed.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    
    if (!confirmed || !mounted) return;
    SampleData.remove(entry.id);
    _closeWithMessage('${entry.name} deleted');
  }

  void _closeWithMessage(String message) {
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    messenger.showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
   
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final entry = SampleData.byId(id);
    if (entry == null) return const Scaffold(); 

    return Scaffold(
      bottomNavigationBar: _DetailActions(
        isCancelled: entry.status == EntryStatus.cancelled,
        onCancelled: () => _markCancelled(entry),
        onKeep: () => _keep(entry),
        onDelete: () => _delete(entry),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DetailHeader(
              entry: entry,
              onBack: () => Navigator.pop(context),
              onEdit: () => _openEdit(id),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: _DetailInfo(entry: entry),
            ),
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

class _DetailInfo extends StatelessWidget {
  const _DetailInfo({required this.entry});

  final Subscription entry;

  @override
  Widget build(BuildContext context) {
    final url = entry.cancellationUrl;
    final notes = entry.notes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _InfoRow(label: 'Type', value: '${entry.type.label} · ${entry.category.label}'),
        _InfoRow(label: 'Price', value: '${entry.priceLabel} · ${entry.billingPeriod.label}'),
        _InfoRow(label: 'Started', value: _formatDate(entry.startDate)),
        _InfoRow(label: 'Reminder', value: '${entry.reminderDaysBefore} days before'),
        if (notes != null && notes.isNotEmpty)
          _InfoRow(label: 'Notes', value: notes),
        if (url != null) ...[
          const SizedBox(height: AppSpacing.s),
          Center(
            child: AppButton(
              label: 'Go to cancellation page',
              style: AppButtonStyle.link,
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(url)),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.label),
          const SizedBox(width: AppSpacing.l),
          Expanded(
            child: Text(value, style: AppTextStyles.bodyStrong, textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}

class _DetailActions extends StatelessWidget {
  const _DetailActions({
    required this.isCancelled,
    required this.onCancelled,
    required this.onKeep,
    required this.onDelete,
  });

  final bool isCancelled;
  final VoidCallback onCancelled;
  final VoidCallback onKeep;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenPadding, AppSpacing.s,
          AppSpacing.screenPadding, AppSpacing.l,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isCancelled) ...[
              AppButton(label: 'I cancelled it', onPressed: onCancelled),
              const SizedBox(height: AppSpacing.s),
            ],
            Row(
              children: [
                if (!isCancelled) ...[
                  Expanded(
                    child: AppButton(
                      label: 'Keep it',
                      style: AppButtonStyle.secondary,
                      onPressed: onKeep,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s),
                ],
                Expanded(
                  child: AppButton(
                    label: 'Delete',
                    style: AppButtonStyle.danger,
                    onPressed: onDelete,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String _formatDate(DateTime date) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return '${date.day} ${months[date.month - 1]} ${date.year}';
}

DateTime _nextBillingDate(Subscription entry) {
  final months = entry.billingPeriod == BillingPeriod.yearly ? 12 : 1;
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  var date = entry.endDate;
  while (date.isBefore(today)) {
    date = _addMonths(date, months);
  }
  return date;
}

DateTime _addMonths(DateTime date, int months) {
  final target = DateTime(date.year, date.month + months, 1);
  final lastDay = DateTime(target.year, target.month + 1, 0).day;
  final day = date.day > lastDay ? lastDay : date.day;
  return DateTime(target.year, target.month, day);
}