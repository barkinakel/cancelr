import 'package:material_ui/material_ui.dart';

import '../data/user_settings.dart';
import '../routes/app_routes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../utils/validation_utils.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

// Owner: Boran
// Login is UI only in Step 2.2: any valid email and password opens Home.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _logIn() {
    if (_formKey.currentState!.validate()) {
      UserSettings.email = _emailController.text.trim();
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 96,
                      height: 96,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.l),
                  Text(
                    'CANCELR',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.screenTitle,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Never pay for a trial you forgot.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.label,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
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
                    hint: 'Your password',
                    controller: _passwordController,
                    obscureText: true,
                    validator: ValidationUtils.validatePassword,
                  ),
                  const SizedBox(height: AppSpacing.s),
                  Center(
                    child: AppButton(
                      label: 'Forgot password?',
                      style: AppButtonStyle.link,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.forgotPassword);
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.l),
                  AppButton(label: 'Log in', onPressed: _logIn),
                  const SizedBox(height: AppSpacing.m),
                  Center(
                    child: AppButton(
                      label: 'No account? Sign up',
                      style: AppButtonStyle.link,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.signUp);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
