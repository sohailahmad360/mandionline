import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../configs/color/app_colors.dart';
import '../../configs/utils.dart';
import '../../configs/validator/app_validator.dart';
import '../../model/ledger/ledger_models.dart';
import '../../view_model/ledger/ledger_view_model.dart';

String _commaGrouping(int n) {
  var s = n.abs().toString();
  final parts = <String>[];
  while (s.length > 3) {
    parts.insert(0, s.substring(s.length - 3));
    s = s.substring(0, s.length - 3);
  }
  if (s.isNotEmpty) parts.insert(0, s);
  return parts.join(',');
}

String formatLedgerMoney(double value) {
  final r = value.round();
  final sign = r < 0 ? '-' : '';
  return 'Rs $sign${_commaGrouping(r.abs())}';
}

String formatLedgerSignedDelta(double delta) {
  if (delta >= 0) return '+${formatLedgerMoney(delta)}';
  return '-${formatLedgerMoney(delta.abs())}';
}

double? parseLedgerAmountInput(String raw) {
  var s = raw.trim().toLowerCase();
  s = s.replaceAll('rs', '').replaceAll(',', '').replaceAll(' ', '');
  if (s.isEmpty) return null;
  return double.tryParse(s);
}

/// Drawer module: party ledgers, filters, search, statement detail, record movement.
class LedgerModuleView extends StatelessWidget {
  const LedgerModuleView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LedgerViewModel>();
    if (vm.selectedAccount != null) {
      return const _LedgerDetailScaffold();
    }
    return const _LedgerListScaffold();
  }
}

class _LedgerListScaffold extends StatelessWidget {
  const _LedgerListScaffold();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vm = context.watch<LedgerViewModel>();
    final rows = vm.filteredAccounts;

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: Text(l10n.drawerItemLedgers),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text(
              l10n.ledgerSubtitle,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
            child: TextField(
              onChanged: vm.setSearchQuery,
              decoration: InputDecoration(
                hintText: l10n.ledgerSearchHint,
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Row(
              children: [
                _FilterChip(
                  label: l10n.ledgerFilterAll,
                  selected: vm.filter == LedgerListFilter.all,
                  onTap: () => vm.setFilter(LedgerListFilter.all),
                ),
                _FilterChip(
                  label: l10n.ledgerFilterReceivable,
                  selected: vm.filter == LedgerListFilter.receivable,
                  onTap: () => vm.setFilter(LedgerListFilter.receivable),
                ),
                _FilterChip(
                  label: l10n.ledgerFilterPayable,
                  selected: vm.filter == LedgerListFilter.payable,
                  onTap: () => vm.setFilter(LedgerListFilter.payable),
                ),
                _FilterChip(
                  label: l10n.ledgerFilterSettled,
                  selected: vm.filter == LedgerListFilter.settled,
                  onTap: () => vm.setFilter(LedgerListFilter.settled),
                ),
              ],
            ),
          ),
          Expanded(
            child: rows.isEmpty
                ? Center(
                    child: Text(
                      l10n.ledgerEmptyList,
                      style: const TextStyle(color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: rows.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) {
                      final a = rows[i];
                      return _LedgerListCard(
                        account: a,
                        l10n: l10n,
                        onTap: () => context.read<LedgerViewModel>().openAccount(a),
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

class _LedgerListCard extends StatelessWidget {
  const _LedgerListCard({
    required this.account,
    required this.l10n,
    required this.onTap,
  });

  final LedgerAccount account;
  final AppLocalizations l10n;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final b = account.currentBalance;
    return Material(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      account.partyName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  _BalanceSideChip(balance: b, l10n: l10n),
                ],
              ),
              if (account.partySubtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  account.partySubtitle!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                account.id,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const Divider(height: 18),
              Text(
                l10n.ledgerCardBalanceLabel,
                style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 2),
              Text(
                _balanceCaption(l10n, b),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _balanceCaption(AppLocalizations l10n, double b) {
    if (b.abs() < 0.5) return l10n.ledgerBalanceSettledShort;
    if (b > 0) {
      return l10n.ledgerBalanceTheyOwe(formatLedgerMoney(b));
    }
    return l10n.ledgerBalanceYouOwe(formatLedgerMoney(b.abs()));
  }
}

class _BalanceSideChip extends StatelessWidget {
  const _BalanceSideChip({required this.balance, required this.l10n});

  final double balance;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    late String label;
    late Color fg;
    late Color bg;
    if (balance.abs() < 0.5) {
      label = l10n.ledgerSideSettled;
      fg = AppColors.textSecondary;
      bg = AppColors.chipInactive;
    } else if (balance > 0) {
      label = l10n.ledgerSideReceivable;
      fg = const Color(0xFF1565C0);
      bg = const Color(0xFFE3F2FD);
    } else {
      label = l10n.ledgerSidePayable;
      fg = AppColors.error;
      bg = const Color(0xFFFFEBEE);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: fg,
        ),
      ),
    );
  }
}

class _LedgerDetailScaffold extends StatelessWidget {
  const _LedgerDetailScaffold();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vm = context.watch<LedgerViewModel>();
    final a = vm.selectedAccount!;

    final entriesNewestFirst = a.entries.reversed.toList();

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: vm.closeDetail,
        ),
        title: Text(a.partyName),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              children: [
                if (a.partySubtitle != null)
                  Text(
                    a.partySubtitle!,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                const SizedBox(height: 6),
                Text(
                  a.id,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.ledgerDetailCurrentTitle,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _balanceCaption(l10n, a.currentBalance),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.ledgerDetailOpeningLine(formatLedgerMoney(a.openingBalance)),
                  style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.ledgerDetailStatementTitle,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                for (final e in entriesNewestFirst) _EntryTile(entry: e, l10n: l10n),
              ],
            ),
          ),
          _DetailActionsBar(onRecord: () => _showRecordSheet(context)),
        ],
      ),
    );
  }

  static String _balanceCaption(AppLocalizations l10n, double b) {
    if (b.abs() < 0.5) return l10n.ledgerBalanceSettledShort;
    if (b > 0) return l10n.ledgerBalanceTheyOwe(formatLedgerMoney(b));
    return l10n.ledgerBalanceYouOwe(formatLedgerMoney(b.abs()));
  }

  static void _showRecordSheet(BuildContext context) {
    final vm = context.read<LedgerViewModel>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => ChangeNotifierProvider<LedgerViewModel>.value(
        value: vm,
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: MediaQuery.viewInsetsOf(ctx).bottom + 20,
          ),
          child: const _RecordMovementForm(),
        ),
      ),
    );
  }
}

class _EntryTile extends StatelessWidget {
  const _EntryTile({required this.entry, required this.l10n});

  final LedgerEntry entry;
  final AppLocalizations l10n;

  String _kindLabel() {
    switch (entry.kind) {
      case LedgerEntryKind.opening:
        return l10n.ledgerKindOpening;
      case LedgerEntryKind.saleOnCredit:
        return l10n.ledgerKindSaleOnCredit;
      case LedgerEntryKind.purchaseOnCredit:
        return l10n.ledgerKindPurchaseOnCredit;
      case LedgerEntryKind.paymentReceived:
        return l10n.ledgerKindPaymentReceived;
      case LedgerEntryKind.paymentSent:
        return l10n.ledgerKindPaymentSent;
      case LedgerEntryKind.creditNote:
        return l10n.ledgerKindCreditNote;
      case LedgerEntryKind.debitNote:
        return l10n.ledgerKindDebitNote;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deltaColor = entry.delta >= 0 ? AppColors.sellingBadge : AppColors.error;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      entry.at,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  Text(
                    _kindLabel(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                entry.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (entry.note != null && entry.note!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  entry.note!,
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.ledgerEntryDeltaLabel(formatLedgerSignedDelta(entry.delta)),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: deltaColor,
                      ),
                    ),
                  ),
                  Text(
                    l10n.ledgerEntryBalanceAfter(formatLedgerMoney(entry.balanceAfter)),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
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

class _DetailActionsBar extends StatelessWidget {
  const _DetailActionsBar({required this.onRecord});

  final VoidCallback onRecord;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Material(
      elevation: 8,
      color: AppColors.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onRecord,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.add_chart_outlined, size: 22),
              label: Text(l10n.ledgerActionRecordMovement),
            ),
          ),
        ),
      ),
    );
  }
}

class _RecordMovementForm extends StatefulWidget {
  const _RecordMovementForm();

  @override
  State<_RecordMovementForm> createState() => _RecordMovementFormState();
}

class _RecordMovementFormState extends State<_RecordMovementForm> {
  final _formKey = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _note = TextEditingController();
  LedgerEntryKind _kind = LedgerEntryKind.saleOnCredit;

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  String _titleForKind(AppLocalizations l10n, LedgerEntryKind k) {
    switch (k) {
      case LedgerEntryKind.opening:
        return l10n.ledgerKindOpening;
      case LedgerEntryKind.saleOnCredit:
        return l10n.ledgerMoveTitleSaleOnCredit;
      case LedgerEntryKind.purchaseOnCredit:
        return l10n.ledgerMoveTitlePurchaseOnCredit;
      case LedgerEntryKind.paymentReceived:
        return l10n.ledgerMoveTitlePaymentReceived;
      case LedgerEntryKind.paymentSent:
        return l10n.ledgerMoveTitlePaymentSent;
      case LedgerEntryKind.creditNote:
        return l10n.ledgerMoveTitleCreditNote;
      case LedgerEntryKind.debitNote:
        return l10n.ledgerMoveTitleDebitNote;
    }
  }

  String? _amountValidator(AppLocalizations l10n, String? v) {
    final req = AppValidator.required(v, l10n.ledgerFormAmountLabel);
    if (req != null) return req;
    final n = parseLedgerAmountInput(v!);
    if (n == null || n <= 0) return l10n.ledgerFormAmountInvalid;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.ledgerRecordSheetTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          InputDecorator(
            decoration: InputDecoration(
              labelText: l10n.ledgerFormKindLabel,
              border: const OutlineInputBorder(),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<LedgerEntryKind>(
                isExpanded: true,
                value: _kind,
                items: [
                  for (final k in ledgerUserPostableKinds)
                    DropdownMenuItem(
                      value: k,
                      child: Text(_dropdownLabel(l10n, k)),
                    ),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _kind = v);
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _amount,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: l10n.ledgerFormAmountLabel,
              hintText: l10n.ledgerFormAmountHint,
            ),
            validator: (v) => _amountValidator(l10n, v),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _note,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: l10n.ledgerFormNoteLabel,
              hintText: l10n.ledgerFormNoteHint,
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.ledgerFormCancel),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    if (!(_formKey.currentState?.validate() ?? false)) return;
                    final n = parseLedgerAmountInput(_amount.text)!;
                    final title = _titleForKind(l10n, _kind);
                    final note = _note.text.trim().isEmpty ? null : _note.text.trim();
                    context.read<LedgerViewModel>().addMovement(
                          kind: _kind,
                          amount: n,
                          title: title,
                          note: note,
                        );
                    Navigator.pop(context);
                    showAppSnackBar(context, l10n.ledgerSnackRecorded);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                  ),
                  child: Text(l10n.ledgerFormSave),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _dropdownLabel(AppLocalizations l10n, LedgerEntryKind k) {
    switch (k) {
      case LedgerEntryKind.opening:
        return l10n.ledgerKindOpening;
      case LedgerEntryKind.saleOnCredit:
        return l10n.ledgerDropdownSaleOnCredit;
      case LedgerEntryKind.purchaseOnCredit:
        return l10n.ledgerDropdownPurchaseOnCredit;
      case LedgerEntryKind.paymentReceived:
        return l10n.ledgerDropdownPaymentReceived;
      case LedgerEntryKind.paymentSent:
        return l10n.ledgerDropdownPaymentSent;
      case LedgerEntryKind.creditNote:
        return l10n.ledgerDropdownCreditNote;
      case LedgerEntryKind.debitNote:
        return l10n.ledgerDropdownDebitNote;
    }
  }
}
