import 'package:material_ui/material_ui.dart';

import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../utils/validation_utils.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/confirm_dialog.dart';

// Owner: Boran
// UI only in Step 2.2: no email is sent yet.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendLink() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await showConfirmDialog(
      context,
      title: 'Check your email',
      message: 'If an account exists for ${_emailController.text.trim()}, '
          'we sent a link to reset your password.',
      confirmLabel: 'OK',
      cancelLabel: null,
    );

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('RESET PASSWORD', style: AppTextStyles.screenTitle),
                const SizedBox(height: AppSpacing.s),
                Text(
                  'Enter your email and we will send you a reset link.',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: AppSpacing.xl),
                AppTextField(
                  label: 'Email',
                  hint: 'name@email.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: ValidationUtils.validateEmail,
                ),
                const SizedBox(height: AppSpacing.xl),
                AppButton(label: 'Send reset link', onPressed: _sendLink),
                const SizedBox(height: AppSpacing.m),
                Center(
                  child: AppButton(
                    label: 'Back to login',
                    style: AppButtonStyle.link,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
