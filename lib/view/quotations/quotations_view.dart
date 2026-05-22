import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';

import '../../configs/color/app_colors.dart';
import '../../data/demo_quotations_catalog.dart';

class QuotationsView extends StatefulWidget {
  const QuotationsView({super.key});

  @override
  State<QuotationsView> createState() => _QuotationsViewState();
}

class _QuotationsViewState extends State<QuotationsView> {
  /// null = all; otherwise filter by status.
  DemoQuotationStatus? _filter;

  static String _statusLabel(AppLocalizations l, DemoQuotationStatus s) {
    switch (s) {
      case DemoQuotationStatus.draft:
        return l.quotationStatusDraft;
      case DemoQuotationStatus.sent:
        return l.quotationStatusSent;
      case DemoQuotationStatus.accepted:
        return l.quotationStatusAccepted;
      case DemoQuotationStatus.rejected:
        return l.quotationStatusRejected;
      case DemoQuotationStatus.expired:
        return l.quotationStatusExpired;
    }
  }

  static Color _statusColor(DemoQuotationStatus s) {
    switch (s) {
      case DemoQuotationStatus.draft:
        return AppColors.textSecondary;
      case DemoQuotationStatus.sent:
        return const Color(0xFF1565C0);
      case DemoQuotationStatus.accepted:
        return AppColors.primary;
      case DemoQuotationStatus.rejected:
        return AppColors.error;
      case DemoQuotationStatus.expired:
        return const Color(0xFF6D4C41);
    }
  }

  static Color _statusBg(DemoQuotationStatus s) {
    switch (s) {
      case DemoQuotationStatus.draft:
        return AppColors.chipInactive;
      case DemoQuotationStatus.sent:
        return const Color(0xFFE3F2FD);
      case DemoQuotationStatus.accepted:
        return AppColors.sellingBadge;
      case DemoQuotationStatus.rejected:
        return const Color(0xFFFFEBEE);
      case DemoQuotationStatus.expired:
        return AppColors.pendingBg;
    }
  }

  List<DemoQuotation> _visible(List<DemoQuotation> all) {
    if (_filter == null) return all;
    return all.where((q) => q.status == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final all = demoQuotations();
    final visible = _visible(all);

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: Text(l10n.drawerItemQuotations),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text(
              l10n.quotationsScreenSubtitle,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Row(
              children: [
                _FilterChip(
                  label: l10n.quotationsFilterAll,
                  selected: _filter == null,
                  onTap: () => setState(() => _filter = null),
                ),
                _FilterChip(
                  label: l10n.quotationStatusDraft,
                  selected: _filter == DemoQuotationStatus.draft,
                  onTap: () => setState(
                    () => _filter = DemoQuotationStatus.draft,
                  ),
                ),
                _FilterChip(
                  label: l10n.quotationStatusSent,
                  selected: _filter == DemoQuotationStatus.sent,
                  onTap: () => setState(
                    () => _filter = DemoQuotationStatus.sent,
                  ),
                ),
                _FilterChip(
                  label: l10n.quotationStatusAccepted,
                  selected: _filter == DemoQuotationStatus.accepted,
                  onTap: () => setState(
                    () => _filter = DemoQuotationStatus.accepted,
                  ),
                ),
                _FilterChip(
                  label: l10n.quotationStatusRejected,
                  selected: _filter == DemoQuotationStatus.rejected,
                  onTap: () => setState(
                    () => _filter = DemoQuotationStatus.rejected,
                  ),
                ),
                _FilterChip(
                  label: l10n.quotationStatusExpired,
                  selected: _filter == DemoQuotationStatus.expired,
                  onTap: () => setState(
                    () => _filter = DemoQuotationStatus.expired,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: visible.isEmpty
                ? Center(
                    child: Text(
                      l10n.quotationsEmptyFilter,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: visible.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) {
                      return _QuotationCard(
                        q: visible[i],
                        statusLabel: _statusLabel(l10n, visible[i].status),
                        statusColor: _statusColor(visible[i].status),
                        statusBg: _statusBg(visible[i].status),
                        l10n: l10n,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.primary,
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(
          color: selected ? Colors.white : AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        backgroundColor: AppColors.chipInactive,
        side: const BorderSide(color: AppColors.border),
      ),
    );
  }
}

class _QuotationCard extends StatelessWidget {
  const _QuotationCard({
    required this.q,
    required this.statusLabel,
    required this.statusColor,
    required this.statusBg,
    required this.l10n,
  });

  final DemoQuotation q;
  final String statusLabel;
  final Color statusColor;
  final Color statusBg;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${l10n.quotationIdPrefix} ${q.id}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      statusLabel,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                q.productLine,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              _MetaRow(icon: Icons.calendar_today_outlined, text: '${l10n.quotationIssued}: ${q.issuedDate}'),
              const SizedBox(height: 4),
              _MetaRow(icon: Icons.event_outlined, text: '${l10n.quotationValidUntil}: ${q.validUntilDate}'),
              const SizedBox(height: 4),
              _MetaRow(icon: Icons.north_east, text: '${l10n.quotationFrom}: ${q.fromParty}'),
              const SizedBox(height: 4),
              _MetaRow(icon: Icons.south_west, text: '${l10n.quotationTo}: ${q.toParty}'),
              const Divider(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      q.amountLine,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Text(
                    q.qtyLine,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
