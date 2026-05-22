import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';

import '../../configs/color/app_colors.dart';

/// Placeholder for drawer modules that do not have a dedicated screen yet.
class ModulePlaceholderView extends StatelessWidget {
  const ModulePlaceholderView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            l10n.modulePlaceholderBody,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              height: 1.45,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
