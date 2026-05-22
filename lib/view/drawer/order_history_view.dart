import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';

import '../../configs/color/app_colors.dart';
import '../../data/home_catalog_demo.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  static String _statusLabel(AppLocalizations l10n, String raw) {
    switch (raw) {
      case 'delivered':
        return l10n.statusDelivered;
      case 'processing':
        return l10n.orderStatusProcessing;
      case 'cancelled':
        return l10n.orderStatusCancelled;
      default:
        return raw;
    }
  }

  static Color _statusColor(String raw) {
    switch (raw) {
      case 'delivered':
        return AppColors.primary;
      case 'processing':
        return const Color(0xFF8D6E63);
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final orders = demoOrderHistory();
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: Text(l10n.screenOrderHistoryTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final o = orders[i];
          final statusText = _statusLabel(l10n, o.statusRaw);
          final statusColor = _statusColor(o.statusRaw);
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${l10n.orderHistoryOrder} ${o.id}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '${l10n.orderHistoryPlaced}: ${o.placedAt}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  o.productTitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  o.total,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
