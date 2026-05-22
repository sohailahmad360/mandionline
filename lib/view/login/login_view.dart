import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../configs/color/app_colors.dart';
import '../../configs/routes/routes_name.dart';
import '../../data/response/status.dart';
import '../../injection/di.dart';
import '../../repository/auth_api/auth_repository.dart';
import '../../repository/auth_api/static_auth_config.dart';
import '../../view_model/locale/locale_controller.dart';
import '../../view_model/login/login_view_model.dart';
import '../../view_model/services/storage/local_storage.dart';
import 'widgets/login_form_fields.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(
        authRepository: getIt<AuthRepository>(),
        localStorage: getIt<LocalStorage>(),
      ),
      child: const _LoginScaffold(),
    );
  }
}

class _LoginScaffold extends StatelessWidget {
  const _LoginScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const _LoginBody(),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, top: 4),
                child: Material(
                  color: Colors.transparent,
                  child: _LanguagePill(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguagePill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = context.watch<LocaleController>();
    final isUr = locale.locale.languageCode == 'ur';
    return FilledButton.tonal(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      onPressed: () {
        locale.toggleUrdu();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.language, size: 18),
          const SizedBox(width: 6),
          Text(
            isUr ? l10n.languageSwitchToEnglish : l10n.languageSwitchToUrdu,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _LoginBody extends StatefulWidget {
  const _LoginBody();

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill static demo so Sign In works without retyping (still editable).
    _email.text = StaticAuthConfig.demoEmail;
    _password.text = StaticAuthConfig.demoPassword;
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _maybeNavigate(LoginViewModel vm) {
    if (!_navigated && vm.loginState.status == Status.completed) {
      _navigated = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, RoutesName.home);
      });
    }
    if (vm.loginState.status == Status.error) {
      _navigated = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer<LoginViewModel>(
      builder: (context, vm, _) {
        _maybeNavigate(vm);
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 56, 24, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.accentAmber,
                            AppColors.primary.withValues(alpha: 0.85),
                          ],
                        ),
                      ),
                      child: const Icon(Icons.eco, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      l10n.appTitle,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  l10n.loginTitle,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.loginSubtitle,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.loginDemoCredentials(
                    StaticAuthConfig.demoEmail,
                    StaticAuthConfig.demoPassword,
                  ),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                LoginFormFields(
                  emailController: _email,
                  passwordController: _password,
                ),
                if (vm.loginState.message != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    vm.loginState.message ==
                            LoginViewModel.invalidCredentialsFormMessage
                        ? l10n.loginErrorInvalidCredentials
                        : vm.loginState.message!,
                    style: const TextStyle(color: AppColors.error),
                  ),
                ],
                const SizedBox(height: 20),
                SizedBox(
                  height: 52,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: vm.loginState.status == Status.loading
                        ? null
                        : () {
                            if (!(_formKey.currentState?.validate() ?? false)) {
                              return;
                            }
                            vm.submit(
                              email: _email.text.trim(),
                              password: _password.text,
                            );
                          },
                    child: vm.loginState.status == Status.loading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                l10n.signInCta,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary, width: 1.4),
                      foregroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: vm.loginState.status == Status.loading
                        ? null
                        : () => vm.loginAsGuest(),
                    child: Text(
                      l10n.loginAsGuest,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
