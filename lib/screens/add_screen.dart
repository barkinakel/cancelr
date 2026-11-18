import 'package:material_ui/material_ui.dart';

import '../data/sample_data.dart';
import '../models/subscription.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../widgets/subscription_form.dart';

// Owner: Zeynep
class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  Future<void> _save(BuildContext context, Subscription entry) async {
    SampleData.add(entry);

    final days = entry.reminderDaysBefore;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'SAVED',
          style: AppTextStyles.title.copyWith(color: AppColors.onCard),
        ),
        content: Text(
          "${entry.name} was added. We'll remind you "
              "$days ${days == 1 ? 'day' : 'days'} before it ends.",
          style: AppTextStyles.body.copyWith(color: AppColors.onCard),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'OK',
              style: AppTextStyles.bodyStrong.copyWith(color: AppColors.onCard),
            ),
          ),
        ],
      ),
    );

    // Back to Home once the dialog is closed.
    if (context.mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormHeader(
                title: 'NEW CARD',
                onClose: () => Navigator.pop(context),
              ),
              const SizedBox(height: AppSpacing.l),
              SubscriptionForm(
                submitLabel: 'Save',
                onSubmit: (entry) => _save(context, entry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}