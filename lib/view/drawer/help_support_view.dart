import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mandionline/l10n/app_localizations.dart';

import '../../configs/color/app_colors.dart';
import '../../configs/utils.dart';

class HelpSupportView extends StatelessWidget {
  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: Text(l10n.screenHelpSupportTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            l10n.helpContactSection,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: AppColors.border),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.email_outlined),
                  title: Text(l10n.helpSupportEmail),
                  onTap: () async {
                    await Clipboard.setData(
                      ClipboardData(text: l10n.helpSupportEmail),
                    );
                    if (context.mounted) {
                      showAppSnackBar(context, l10n.snackCopiedToClipboard);
                    }
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.phone_outlined),
                  title: Text(l10n.helpSupportPhone),
                  onTap: () async {
                    await Clipboard.setData(
                      ClipboardData(text: l10n.helpSupportPhone),
                    );
                    if (context.mounted) {
                      showAppSnackBar(context, l10n.snackCopiedToClipboard);
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.helpFaqHeading,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          _FaqTile(title: l10n.helpFaqOrdersTitle, body: l10n.helpFaqOrdersBody),
          _FaqTile(
            title: l10n.helpFaqPaymentsTitle,
            body: l10n.helpFaqPaymentsBody,
          ),
          _FaqTile(
            title: l10n.helpFaqDisputesTitle,
            body: l10n.helpFaqDisputesBody,
          ),
        ],
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: AppColors.textPrimary,
          ),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              body,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
