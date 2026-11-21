import 'package:material_ui/material_ui.dart';

import '../data/sample_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../widgets/subscription_form.dart';

// Owner: Zeynep
class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The id of the card to edit comes from the Detail screen.
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final entry = SampleData.byId(id);

    return Scaffold(
      body: SafeArea(
        // Scrollable so the form does not overflow on small screens.
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title and close (X) button. X goes back without saving.
              FormHeader(
                title: entry == null
                    ? 'EDIT'
                    : 'EDIT ${entry.name.toUpperCase()}',
                onClose: () => Navigator.pop(context),
              ),
              const SizedBox(height: AppSpacing.l),
              if (entry == null)
                Text('This entry no longer exists.', style: AppTextStyles.body)
              else
              // Same form as Add, but it opens filled with the card's info.
                SubscriptionForm(
                  initial: entry,
                  submitLabel: 'Save changes',
                  // After a valid save: updates the card, shows a short message, goes back.
                  onSubmit: (updated) {
                    SampleData.update(updated);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Changes saved')),
                    );
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}