import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../configs/color/app_colors.dart';
import '../../view_model/locale/locale_controller.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _push = true;
  bool _digest = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = context.watch<LocaleController>();
    final isUr = locale.locale.languageCode == 'ur';
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: Text(l10n.screenSettingsTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 0,
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: AppColors.border),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  value: _push,
                  onChanged: (v) => setState(() => _push = v),
                  title: Text(l10n.settingsNotifications),
                  subtitle: Text(l10n.settingsNotificationsSubtitle),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  value: _digest,
                  onChanged: (v) => setState(() => _digest = v),
                  title: Text(l10n.settingsEmailDigest),
                  subtitle: Text(l10n.settingsEmailDigestSubtitle),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 0,
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: AppColors.border),
            ),
            child: ListTile(
              title: Text(l10n.settingsAppLanguage),
              subtitle: Text(
                isUr ? l10n.settingsLanguageUrdu : l10n.settingsLanguageEnglish,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => locale.toggleUrdu(),
            ),
          ),
        ],
      ),
    );
  }
}
