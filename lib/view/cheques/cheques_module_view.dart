import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../configs/color/app_colors.dart';
import '../../configs/utils.dart';
import '../../configs/validator/app_validator.dart';
import '../../model/cheques/cheque_models.dart';
import '../../view_model/cheques/cheques_view_model.dart';

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

String formatChequeMoney(double value) {
  final r = value.round();
  final sign = r < 0 ? '-' : '';
  return 'Rs $sign${_commaGrouping(r.abs())}';
}

double? parseChequeAmount(String raw) {
  var s = raw.trim().toLowerCase();
  s = s.replaceAll('rs', '').replaceAll(',', '').replaceAll(' ', '');
  if (s.isEmpty) return null;
  return double.tryParse(s);
}

/// Post-dated / received cheques — track clearing, outcomes, and register new (demo).
class ChequesModuleView extends StatelessWidget {
  const ChequesModuleView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChequesViewModel>();
    if (vm.selectedCheque != null) {
      return const _ChequeDetailScaffold();
    }
    return const _ChequesListScaffold();
  }
}

class _ChequesListScaffold extends StatelessWidget {
  const _ChequesListScaffold();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vm = context.watch<ChequesViewModel>();
    final rows = vm.filteredItems;

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: Text(l10n.drawerItemCheques),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text(
              l10n.chequesSubtitle,
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
                hintText: l10n.chequesSearchHint,
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
                  label: l10n.chequesFilterAll,
                  selected: vm.filter == ChequeListFilter.all,
                  onTap: () => vm.setFilter(ChequeListFilter.all),
                ),
                _FilterChip(
                  label: l10n.chequesFilterOutstanding,
                  selected: vm.filter == ChequeListFilter.outstanding,
                  onTap: () => vm.setFilter(ChequeListFilter.outstanding),
                ),
                _FilterChip(
                  label: l10n.chequesFilterClearing,
                  selected: vm.filter == ChequeListFilter.clearing,
                  onTap: () => vm.setFilter(ChequeListFilter.clearing),
                ),
                _FilterChip(
                  label: l10n.chequesFilterCleared,
                  selected: vm.filter == ChequeListFilter.cleared,
                  onTap: () => vm.setFilter(ChequeListFilter.cleared),
                ),
                _FilterChip(
                  label: l10n.chequesFilterBouncedOrCancelled,
                  selected: vm.filter == ChequeListFilter.bouncedOrCancelled,
                  onTap: () => vm.setFilter(ChequeListFilter.bouncedOrCancelled),
                ),
              ],
            ),
          ),
          Expanded(
            child: rows.isEmpty
                ? Center(
                    child: Text(
                      l10n.chequesEmptyList,
                      style: const TextStyle(color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 88),
                    itemCount: rows.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) {
                      final c = rows[i];
                      return _ChequeListCard(
                        cheque: c,
                        l10n: l10n,
                        onTap: () => context.read<ChequesViewModel>().openCheque(c),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showRegisterSheet(context),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        icon: const Icon(Icons.add),
        label: Text(l10n.chequesRegisterFab),
      ),
    );
  }

  static void _showRegisterSheet(BuildContext context) {
    final vm = context.read<ChequesViewModel>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => ChangeNotifierProvider<ChequesViewModel>.value(
        value: vm,
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: MediaQuery.viewInsetsOf(ctx).bottom + 20,
          ),
          child: const _RegisterChequeForm(),
        ),
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
          fontSize: 12,
        ),
        backgroundColor: AppColors.chipInactive,
        side: const BorderSide(color: AppColors.border),
      ),
    );
  }
}

class _DirectionLabel {
  static String of(AppLocalizations l10n, ChequeDirection d) {
    switch (d) {
      case ChequeDirection.received:
        return l10n.chequesDirectionReceived;
      case ChequeDirection.issued:
        return l10n.chequesDirectionIssued;
    }
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status, required this.l10n});

  final ChequeStatus status;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    late String label;
    late Color fg;
    late Color bg;
    switch (status) {
      case ChequeStatus.pending:
        label = l10n.chequesStatusPending;
        fg = const Color(0xFF1565C0);
        bg = const Color(0xFFE3F2FD);
        break;
      case ChequeStatus.depositedClearing:
        label = l10n.chequesStatusClearing;
        fg = const Color(0xFF6D4C41);
        bg = AppColors.pendingBg;
        break;
      case ChequeStatus.cleared:
        label = l10n.chequesStatusCleared;
        fg = AppColors.primary;
        bg = AppColors.sellingBadge;
        break;
      case ChequeStatus.bounced:
        label = l10n.chequesStatusBounced;
        fg = AppColors.error;
        bg = const Color(0xFFFFEBEE);
        break;
      case ChequeStatus.cancelled:
        label = l10n.chequesStatusCancelled;
        fg = AppColors.textSecondary;
        bg = AppColors.chipInactive;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: fg,
        ),
      ),
    );
  }
}

class _ChequeListCard extends StatelessWidget {
  const _ChequeListCard({
    required this.cheque,
    required this.l10n,
    required this.onTap,
  });

  final ChequeItem cheque;
  final AppLocalizations l10n;
  final VoidCallback onTap;

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
                      cheque.id,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  _StatusChip(status: cheque.status, l10n: l10n),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                formatChequeMoney(cheque.amount),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${l10n.chequesCardChequeNumber}: ${cheque.chequeNumber}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                cheque.partyName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                cheque.bankName,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.drawerIconBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _DirectionLabel.of(l10n, cheque.direction),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    l10n.chequesCardMatures(cheque.maturityDateLabel),
                    style: const TextStyle(
                      fontSize: 11,
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

class _ChequeDetailScaffold extends StatelessWidget {
  const _ChequeDetailScaffold();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vm = context.watch<ChequesViewModel>();
    final c = vm.selectedCheque!;

    final eventsNewest = c.events.reversed.toList();

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: vm.closeDetail,
        ),
        title: Text(c.id),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              children: [
                Row(
                  children: [
                    _StatusChip(status: c.status, l10n: l10n),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.drawerIconBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _DirectionLabel.of(l10n, c.direction),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  formatChequeMoney(c.amount),
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${l10n.chequesCardChequeNumber}: ${c.chequeNumber}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  c.partyName,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(c.bankName, style: const TextStyle(color: AppColors.textSecondary)),
                const SizedBox(height: 8),
                Text(
                  l10n.chequesDetailDates(c.issueDateLabel, c.maturityDateLabel),
                  style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.chequesTimelineTitle,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                for (final e in eventsNewest) _TimelineTile(event: e, l10n: l10n),
              ],
            ),
          ),
          _DetailActionsBar(cheque: c, l10n: l10n),
        ],
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  const _TimelineTile({required this.event, required this.l10n});

  final ChequeEvent event;
  final AppLocalizations l10n;

  String _kindLabel() {
    switch (event.kind) {
      case ChequeEventKind.registered:
        return l10n.chequesEventKindRegistered;
      case ChequeEventKind.sentToBank:
        return l10n.chequesEventKindSentToBank;
      case ChequeEventKind.cleared:
        return l10n.chequesEventKindCleared;
      case ChequeEventKind.bounced:
        return l10n.chequesEventKindBounced;
      case ChequeEventKind.cancelled:
        return l10n.chequesEventKindCancelled;
      case ChequeEventKind.note:
        return l10n.chequesEventKindNote;
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Text(
                event.at,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _kindLabel(),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                event.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (event.note != null && event.note!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  event.note!,
                  style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailActionsBar extends StatelessWidget {
  const _DetailActionsBar({required this.cheque, required this.l10n});

  final ChequeItem cheque;
  final AppLocalizations l10n;

  bool get _canSendToBank => cheque.status == ChequeStatus.pending;

  bool get _canMarkCleared => cheque.status == ChequeStatus.depositedClearing;

  bool get _canBounce =>
      cheque.status == ChequeStatus.pending ||
      cheque.status == ChequeStatus.depositedClearing;

  bool get _canCancel => cheque.status == ChequeStatus.pending;

  bool get _canAddNote => true;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ChequesViewModel>();
    final showPrimaryRow = _canSendToBank || _canMarkCleared || _canBounce || _canCancel;

    return Material(
      elevation: 8,
      color: AppColors.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_canSendToBank)
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      final title = cheque.direction == ChequeDirection.received
                          ? l10n.chequesEventDepositTitle
                          : l10n.chequesEventPresentedTitle;
                      vm.sendToBank(eventTitle: title);
                      showAppSnackBar(context, l10n.chequesSnackSentToBank);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: const Icon(Icons.account_balance_outlined, size: 20),
                    label: Text(l10n.chequesActionSendToBank),
                  ),
                ),
              if (_canMarkCleared) ...[
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      vm.markCleared(eventTitle: l10n.chequesEventClearedTitle);
                      showAppSnackBar(context, l10n.chequesSnackCleared);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.sellingBadge,
                      foregroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: const Icon(Icons.check_circle_outline, size: 20),
                    label: Text(l10n.chequesActionMarkCleared),
                  ),
                ),
              ],
              if (showPrimaryRow && (_canBounce || _canCancel)) const SizedBox(height: 8),
              if (_canBounce || _canCancel)
                Row(
                  children: [
                    if (_canCancel)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            final ok = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text(l10n.chequesDialogCancelTitle),
                                content: Text(l10n.chequesDialogCancelBody),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, false),
                                    child: Text(l10n.chequesDialogNo),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, true),
                                    child: Text(l10n.chequesDialogYesCancel),
                                  ),
                                ],
                              ),
                            );
                            if (ok == true && context.mounted) {
                              vm.cancelCheque(eventTitle: l10n.chequesEventCancelledTitle);
                              showAppSnackBar(context, l10n.chequesSnackCancelled);
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textSecondary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(l10n.chequesActionCancelCheque),
                        ),
                      ),
                    if (_canCancel && _canBounce) const SizedBox(width: 8),
                    if (_canBounce)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            final ok = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text(l10n.chequesDialogBounceTitle),
                                content: Text(l10n.chequesDialogBounceBody),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, false),
                                    child: Text(l10n.chequesDialogNo),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, true),
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppColors.error,
                                    ),
                                    child: Text(l10n.chequesDialogYesBounce),
                                  ),
                                ],
                              ),
                            );
                            if (ok == true && context.mounted) {
                              vm.markBounced(eventTitle: l10n.chequesEventBouncedTitle);
                              showAppSnackBar(context, l10n.chequesSnackBounced);
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.error,
                            side: const BorderSide(color: AppColors.error),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(l10n.chequesActionMarkBounced),
                        ),
                      ),
                  ],
                ),
              if (_canAddNote) ...[
                if (showPrimaryRow) const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () => _showChequeNoteSheet(context),
                    icon: const Icon(Icons.note_add_outlined, size: 20),
                    label: Text(l10n.chequesActionAddNote),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

void _showChequeNoteSheet(BuildContext context) {
  final vm = context.read<ChequesViewModel>();
  final l10n = AppLocalizations.of(context)!;
  final note = TextEditingController();
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) => ChangeNotifierProvider<ChequesViewModel>.value(
      value: vm,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
          bottom: MediaQuery.viewInsetsOf(ctx).bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.chequesNoteSheetTitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: note,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: l10n.chequesNoteHint,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: Text(l10n.chequesRegisterCancel),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      if (note.text.trim().isEmpty) return;
                      vm.addNote(
                        noteBody: note.text,
                        eventTitle: l10n.chequesEventNoteTitle,
                      );
                      Navigator.pop(ctx);
                      showAppSnackBar(context, l10n.chequesSnackNoteAdded);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onPrimary,
                    ),
                    child: Text(l10n.chequesNoteSave),
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

class _RegisterChequeForm extends StatefulWidget {
  const _RegisterChequeForm();

  @override
  State<_RegisterChequeForm> createState() => _RegisterChequeFormState();
}

class _RegisterChequeFormState extends State<_RegisterChequeForm> {
  final _formKey = GlobalKey<FormState>();
  final _party = TextEditingController();
  final _bank = TextEditingController();
  final _number = TextEditingController();
  final _amount = TextEditingController();
  final _issue = TextEditingController();
  final _maturity = TextEditingController();
  final _note = TextEditingController();
  ChequeDirection _direction = ChequeDirection.received;

  @override
  void dispose() {
    _party.dispose();
    _bank.dispose();
    _number.dispose();
    _amount.dispose();
    _issue.dispose();
    _maturity.dispose();
    _note.dispose();
    super.dispose();
  }

  String? _amountValidator(AppLocalizations l10n, String? v) {
    final req = AppValidator.required(v, l10n.chequesRegisterAmount);
    if (req != null) return req;
    final n = parseChequeAmount(v!);
    if (n == null || n <= 0) return l10n.chequesRegisterAmountInvalid;
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
            l10n.chequesRegisterTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          InputDecorator(
            decoration: InputDecoration(
              labelText: l10n.chequesRegisterDirection,
              border: const OutlineInputBorder(),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<ChequeDirection>(
                isExpanded: true,
                value: _direction,
                items: [
                  DropdownMenuItem(
                    value: ChequeDirection.received,
                    child: Text(l10n.chequesDirectionReceived),
                  ),
                  DropdownMenuItem(
                    value: ChequeDirection.issued,
                    child: Text(l10n.chequesDirectionIssued),
                  ),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _direction = v);
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _party,
            decoration: InputDecoration(labelText: l10n.chequesRegisterParty),
            validator: (v) => AppValidator.required(v, l10n.chequesRegisterParty),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _bank,
            decoration: InputDecoration(labelText: l10n.chequesRegisterBank),
            validator: (v) => AppValidator.required(v, l10n.chequesRegisterBank),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _number,
            decoration: InputDecoration(labelText: l10n.chequesRegisterNumber),
            validator: (v) => AppValidator.required(v, l10n.chequesRegisterNumber),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _amount,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: l10n.chequesRegisterAmount,
              hintText: l10n.chequesRegisterAmountHint,
            ),
            validator: (v) => _amountValidator(l10n, v),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _issue,
            decoration: InputDecoration(
              labelText: l10n.chequesRegisterIssueDate,
              hintText: l10n.chequesRegisterDateHint,
            ),
            validator: (v) => AppValidator.required(v, l10n.chequesRegisterIssueDate),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _maturity,
            decoration: InputDecoration(
              labelText: l10n.chequesRegisterMaturityDate,
              hintText: l10n.chequesRegisterDateHint,
            ),
            validator: (v) => AppValidator.required(v, l10n.chequesRegisterMaturityDate),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _note,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: l10n.chequesRegisterNote,
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.chequesRegisterCancel),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    if (!(_formKey.currentState?.validate() ?? false)) return;
                    context.read<ChequesViewModel>().registerCheque(
                          direction: _direction,
                          partyName: _party.text,
                          bankName: _bank.text,
                          chequeNumber: _number.text,
                          amount: parseChequeAmount(_amount.text)!,
                          issueDateLabel: _issue.text.trim(),
                          maturityDateLabel: _maturity.text.trim(),
                          registeredEventTitle: l10n.chequesRegisterEventLogged,
                          initialNote: _note.text.trim().isEmpty ? null : _note.text,
                        );
                    Navigator.pop(context);
                    showAppSnackBar(context, l10n.chequesSnackRegistered);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                  ),
                  child: Text(l10n.chequesRegisterSubmit),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
