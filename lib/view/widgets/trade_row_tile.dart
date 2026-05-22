import 'package:flutter/material.dart';
import 'package:mandionline/l10n/ui_strings.dart';

import '../../configs/color/app_colors.dart';
import '../../configs/components/safe_network_image.dart';
import '../../model/trade/trade_row.dart';

/// Full-width trade row (dashboard + “View all” list).
class TradeRowTile extends StatelessWidget {
  const TradeRowTile({super.key, required this.row, this.onTap});

  final TradeRow row;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final badgeColor = row.side == 'SELLING'
        ? AppColors.sellingBadge
        : AppColors.buyingBadge;
    final child = Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SafeNetworkImage(
              url: row.imageUrl,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        localizedTradeSide(context, row.side),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '#${row.id}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  row.product,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                Text(
                  row.trader,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                row.price,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 6),
              TradeStatusChip(
                rawStatus: row.status,
                displayLabel: localizedRowStatus(context, row.status),
              ),
            ],
          ),
        ],
      ),
    );
    if (onTap == null) return child;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: child,
      ),
    );
  }
}

/// Status pill using API-style [rawStatus] for colors and [displayLabel] for text.
class TradeStatusChip extends StatelessWidget {
  const TradeStatusChip({
    super.key,
    required this.rawStatus,
    required this.displayLabel,
    this.dense = false,
  });

  final String rawStatus;
  final String displayLabel;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    switch (rawStatus.toLowerCase()) {
      case 'active':
        bg = AppColors.sellingBadge;
        fg = AppColors.primary;
        break;
      case 'pending':
        bg = AppColors.pendingBg;
        fg = const Color(0xFF8D6E63);
        break;
      case 'completed':
        bg = AppColors.primary;
        fg = Colors.white;
        break;
      default:
        bg = AppColors.chipInactive;
        fg = AppColors.textPrimary;
    }
    final pad = dense
        ? const EdgeInsets.symmetric(horizontal: 8, vertical: 3)
        : const EdgeInsets.symmetric(horizontal: 10, vertical: 4);
    final fontSize = dense ? 10.0 : 11.0;
    return Container(
      padding: pad,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        displayLabel,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }
}
