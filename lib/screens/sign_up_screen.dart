import 'package:material_ui/material_ui.dart';

import '../data/user_settings.dart';
import '../routes/app_routes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../utils/validation_utils.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/confirm_dialog.dart';

// Owner: Boran
// Sign up is UI only in Step 2.2: no account is created yet.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    UserSettings.name = _nameController.text.trim();
    UserSettings.email = _emailController.text.trim();

    await showConfirmDialog(
      context,
      title: 'Welcome',
      message: 'Your account is ready, ${UserSettings.name}. '
          'Add your first trial and we will remind you before you are charged.',
      confirmLabel: 'OK',
      cancelLabel: null,
    );

    // The screen may be gone after the dialog, so check before navigating.
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
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
                Text('CREATE ACCOUNT', style: AppTextStyles.screenTitle),
                const SizedBox(height: AppSpacing.xl),
                AppTextField(
                  label: 'Name',
                  hint: 'Your name',
                  controller: _nameController,
                  validator: ValidationUtils.validateName,
                ),
                const SizedBox(height: AppSpacing.l),
                AppTextField(
                  label: 'Email',
                  hint: 'name@email.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: ValidationUtils.validateEmail,
                ),
                const SizedBox(height: AppSpacing.l),
                AppTextField(
                  label: 'Password',
                  hint: 'At least ${ValidationUtils.minPasswordLength} characters',
                  controller: _passwordController,
                  obscureText: true,
                  validator: ValidationUtils.validatePassword,
                ),
                const SizedBox(height: AppSpacing.l),
                AppTextField(
                  label: 'Confirm password',
                  hint: 'Type your password again',
                  controller: _confirmController,
                  obscureText: true,
                  validator: (value) => ValidationUtils.validateConfirmPassword(
                    value,
                    _passwordController.text,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                AppButton(label: 'Sign up', onPressed: _signUp),
                const SizedBox(height: AppSpacing.m),
                Center(
                  child: AppButton(
                    label: 'Have an account? Log in',
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
