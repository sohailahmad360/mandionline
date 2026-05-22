import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';
import 'package:mandionline/l10n/demo_notification_strings.dart';
import 'package:provider/provider.dart';

import '../../configs/color/app_colors.dart';
import '../../model/notification/demo_notification_kind.dart';
import '../../view_model/notifications/notifications_view_model.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  IconData _iconFor(DemoNotificationKind k) {
    switch (k) {
      case DemoNotificationKind.dealUpdate:
        return Icons.handshake_outlined;
      case DemoNotificationKind.newMessage:
        return Icons.chat_bubble_outline;
      case DemoNotificationKind.payment:
        return Icons.account_balance_wallet_outlined;
      case DemoNotificationKind.shipment:
        return Icons.local_shipping_outlined;
      case DemoNotificationKind.reminder:
        return Icons.notifications_outlined;
    }
  }

  String _timeLabel(DateTime at) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${at.year}-${two(at.month)}-${two(at.day)} ${two(at.hour)}:${two(at.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vm = context.watch<NotificationsViewModel>();
    final items = vm.items;
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: Text(l10n.notificationsTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        actions: [
          if (vm.unreadCount > 0)
            TextButton(
              onPressed: () => vm.markAllRead(),
              child: Text(
                l10n.notificationsMarkAllRead,
                style: const TextStyle(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: items.isEmpty
          ? Center(
              child: Text(
                l10n.notificationsEmpty,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final n = items[i];
                final copy = demoNotificationCopy(l10n, n.kind);
                return Material(
                  color: n.read ? null : AppColors.primary.withValues(alpha: 0.04),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                      child: Icon(
                        _iconFor(n.kind),
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ),
                    title: Text(
                      copy.title,
                      style: TextStyle(
                        fontWeight: n.read ? FontWeight.w600 : FontWeight.w800,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(copy.body),
                          const SizedBox(height: 6),
                          Text(
                            _timeLabel(n.createdAt),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: n.read
                        ? null
                        : Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: AppColors.accentAmber,
                              shape: BoxShape.circle,
                            ),
                          ),
                    isThreeLine: true,
                    onTap: () => vm.markRead(n.id),
                  ),
                );
              },
            ),
    );
  }
}
