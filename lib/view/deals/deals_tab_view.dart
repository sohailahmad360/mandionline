import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../configs/color/app_colors.dart';
import '../../configs/components/safe_network_image.dart';
import '../../view_model/deals/deals_view_model.dart';

class DealsTabView extends StatelessWidget {
  const DealsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vm = context.watch<DealsViewModel>();
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
      children: [
        Text(
          l10n.dealsTitle,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.dealsScreenSubtitle,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _SummaryPill(
                title: l10n.dealSellingSummary,
                value: '${vm.sellingCount}',
                filled: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SummaryPill(
                title: l10n.dealBuyingSummary,
                value: '${vm.buyingCount}',
                filled: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...vm.deals.map((d) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _DealCard(deal: d),
            )),
      ],
    );
  }
}

class _SummaryPill extends StatelessWidget {
  const _SummaryPill({
    required this.title,
    required this.value,
    required this.filled,
  });

  final String title;
  final String value;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: filled ? AppColors.primary : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: filled ? null : Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: filled ? Colors.white70 : AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: filled ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _DealCard extends StatelessWidget {
  const _DealCard({required this.deal});

  final DealUiModel deal;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SafeNetworkImage(
                  url: deal.imageUrl,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${deal.id} · ${deal.date}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      deal.product,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      deal.location,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                deal.total,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              deal.qtyRate,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(height: 24),
          Row(
            children: [
              Expanded(
                child: _StatusColumn(
                  icon: Icons.account_balance_wallet_outlined,
                  label: l10n.paymentLabel,
                  pill: deal.payment == DealPaymentStatus.paid
                      ? l10n.statusPaid
                      : l10n.statusUnpaid,
                  good: deal.payment == DealPaymentStatus.paid,
                ),
              ),
              Expanded(
                child: _StatusColumn(
                  icon: Icons.local_shipping_outlined,
                  label: l10n.shippingLabel,
                  pill: deal.shipping == DealShippingStatus.delivered
                      ? l10n.statusDelivered
                      : l10n.statusPending,
                  good: deal.shipping == DealShippingStatus.delivered,
                ),
              ),
              Expanded(
                child: _StatusColumn(
                  icon: Icons.description_outlined,
                  label: l10n.invoiceLabel,
                  pill: deal.invoice == DealInvoiceStatus.completed
                      ? l10n.statusCompleted
                      : l10n.statusPending,
                  good: deal.invoice == DealInvoiceStatus.completed,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download),
                  label: Text(l10n.downloadInvoice),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.sellingBadge,
                  foregroundColor: AppColors.primary,
                ),
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(l10n.dealMessagesButton),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward, size: 16),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                l10n.raiseDispute,
                style: const TextStyle(color: AppColors.error),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusColumn extends StatelessWidget {
  const _StatusColumn({
    required this.icon,
    required this.label,
    required this.pill,
    required this.good,
  });

  final IconData icon;
  final String label;
  final String pill;
  final bool good;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: good ? AppColors.sellingBadge : AppColors.pendingBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            pill,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: good ? AppColors.primary : const Color(0xFF8D6E63),
            ),
          ),
        ),
      ],
    );
  }
}
