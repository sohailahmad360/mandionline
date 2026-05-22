import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';

import '../../../configs/color/app_colors.dart';
import '../../../configs/validator/app_validator.dart';
import '../../../repository/auth_api/static_auth_config.dart';

class LoginFormFields extends StatefulWidget {
  const LoginFormFields({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LoginFormFields> createState() => _LoginFormFieldsState();
}

class _LoginFormFieldsState extends State<LoginFormFields> {
  bool _obscurePassword = true;

  OutlineInputBorder _border([Color? c]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: c ?? AppColors.border),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.emailOrPhoneLabel,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.emailController,
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [
            AutofillHints.email,
            AutofillHints.telephoneNumber,
          ],
          decoration: InputDecoration(
            hintText: StaticAuthConfig.demoEmail,
            hintStyle: const TextStyle(color: AppColors.textSecondary),
            prefixIcon:
                const Icon(Icons.mail_outline, color: AppColors.textSecondary),
            filled: true,
            fillColor: AppColors.surface,
            enabledBorder: _border(),
            focusedBorder: _border(AppColors.primary),
            errorBorder: _border(AppColors.error),
            focusedErrorBorder: _border(AppColors.error),
          ),
          validator: AppValidator.emailOrPhone,
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.passwordLabel,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            TextButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.forgotPasswordComingSoon)),
              ),
              child: Text(
                l10n.forgotPassword,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.passwordController,
          obscureText: _obscurePassword,
          autofillHints: const [AutofillHints.password],
          decoration: InputDecoration(
            hintText: StaticAuthConfig.demoPassword,
            hintStyle: const TextStyle(color: AppColors.textSecondary),
            prefixIcon:
                const Icon(Icons.lock_outline, color: AppColors.textSecondary),
            suffixIcon: IconButton(
              tooltip: _obscurePassword ? l10n.showPassword : l10n.hidePassword,
              onPressed: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
              icon: Icon(
                _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: AppColors.textSecondary,
              ),
            ),
            filled: true,
            fillColor: AppColors.surface,
            enabledBorder: _border(),
            focusedBorder: _border(AppColors.primary),
            errorBorder: _border(AppColors.error),
            focusedErrorBorder: _border(AppColors.error),
          ),
          validator: (v) => AppValidator.required(v, l10n.passwordLabel),
        ),
      ],
    );
  }
}
