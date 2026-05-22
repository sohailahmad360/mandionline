import 'package:flutter/material.dart';

import '../../../configs/routes/routes_name.dart';

/// Post-splash routing: **login** (no session) or **home** (existing session).
///
/// Onboarding is optional and not shown on cold start so users land on the real
/// login screen with email/password. Use [RoutesName.onboarding] manually if needed.
class SplashNavigation {
  const SplashNavigation();

  Future<void> goNext(
    BuildContext context, {
    required bool hasToken,
  }) async {
    if (!context.mounted) return;
    if (hasToken) {
      Navigator.pushReplacementNamed(context, RoutesName.home);
    } else {
      Navigator.pushReplacementNamed(context, RoutesName.login);
    }
  }
}
