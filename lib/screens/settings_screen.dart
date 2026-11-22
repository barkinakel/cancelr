import 'package:material_ui/material_ui.dart';

import '../data/user_settings.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_button.dart';
import '../widgets/confirm_dialog.dart';

// Owner: Boran
// Values are kept in UserSettings until Firebase is added in Step 3.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _logOut() async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Log out?',
      message: 'You can log back in at any time.',
      confirmLabel: 'Log out',
      destructive: true,
    );

    if (!confirmed || !mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
  }

  Widget _reminderOption(int days) {
    return _ReminderOption(
      days: days,
      selected: UserSettings.defaultReminderDays == days,
      onTap: () {
        setState(() {
          UserSettings.defaultReminderDays = days;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            Text('SETTINGS', style: AppTextStyles.screenTitle),
            const SizedBox(height: AppSpacing.xl),
            _ProfileCard(name: UserSettings.name, email: UserSettings.email),
            const SizedBox(height: AppSpacing.xl),
            Text('Default reminder', style: AppTextStyles.title),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'How many days before a charge new entries remind you.',
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: AppSpacing.m),
            Row(
              children: [
                Expanded(child: _reminderOption(1)),
                const SizedBox(width: AppSpacing.s),
                Expanded(child: _reminderOption(3)),
                const SizedBox(width: AppSpacing.s),
                Expanded(child: _reminderOption(7)),
              ],
            ),
            const SizedBox(height: AppSpacing.l),
            const Divider(color: AppColors.divider),
            const SizedBox(height: AppSpacing.s),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Notifications', style: AppTextStyles.title),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Remind me before a trial ends or a payment is due.',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.m),
                Switch(
                  value: UserSettings.notificationsOn,
                  activeTrackColor: AppColors.accent,
                  onChanged: (bool value) {
                    setState(() {
                      UserSettings.notificationsOn = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s),
            const Divider(color: AppColors.divider),
            const SizedBox(height: AppSpacing.xxl),
            AppButton(
              label: 'Log out',
              style: AppButtonStyle.danger,
              onPressed: _logOut,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.name, required this.email});

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.l),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusField),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.accent,
            child: Text(
              name.isEmpty ? '?' : name[0].toUpperCase(),
              style: AppTextStyles.title.copyWith(color: AppColors.onCard),
            ),
          ),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.title),
                const SizedBox(height: AppSpacing.xs),
                Text(email, style: AppTextStyles.label),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReminderOption extends StatelessWidget {
  const _ReminderOption({
    required this.days,
    required this.selected,
    required this.onTap,
  });

  final int days;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        minimumSize: const Size(0, AppSpacing.minTapTarget),
        backgroundColor: selected ? AppColors.accent : AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusField),
        ),
      ),
      child: Text(
        days == 1 ? '1 day' : '$days days',
        style: AppTextStyles.bodyStrong.copyWith(
          color: selected ? AppColors.onCard : AppColors.textPrimary,
        ),
      ),
    );
  }
}
