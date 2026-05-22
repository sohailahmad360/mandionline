import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../configs/color/app_colors.dart';
import '../../../view_model/locale/locale_controller.dart';

class MandiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MandiAppBar({
    super.key,
    required this.onOpenDrawer,
    required this.onOpenNotifications,
    this.notificationUnreadCount = 0,
  });

  final VoidCallback onOpenDrawer;
  final VoidCallback onOpenNotifications;
  final int notificationUnreadCount;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = context.watch<LocaleController>();
    final isUr = locale.locale.languageCode == 'ur';
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.primary,
      leadingWidth: 120,
      leading: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.onPrimary),
            onPressed: onOpenDrawer,
          ),
          _MiniLogo(),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 4, top: 10, bottom: 10),
          child: FilledButton.tonal(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white.withValues(alpha: 0.18),
              foregroundColor: AppColors.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: () => locale.toggleUrdu(),
            child: Row(
              children: [
                const Icon(Icons.language, size: 18),
                const SizedBox(width: 6),
                Text(
                  isUr ? l10n.languageSwitchToEnglish : l10n.languageSwitchToUrdu,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none,
                  color: AppColors.onPrimary),
              onPressed: onOpenNotifications,
            ),
            if (notificationUnreadCount > 0)
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.accentAmber,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}

class _MiniLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColors.accentAmber,
            AppColors.primary.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Icon(Icons.eco, size: 16, color: Colors.white),
    );
  }
}
