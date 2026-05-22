import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';

import '../../configs/components/primary_button.dart';
import '../../configs/routes/routes_name.dart';
import '../../injection/di.dart';
import '../../view_model/services/onboarding/onboarding_prefs.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.onboardingTitle)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.onboardingTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            PrimaryButton(
              label: l10n.loginTitle,
              onPressed: () async {
                await getIt<OnboardingPrefs>().setComplete();
                if (!context.mounted) return;
                Navigator.pushReplacementNamed(context, RoutesName.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
