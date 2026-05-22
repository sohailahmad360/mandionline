import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../configs/color/app_colors.dart';
import '../../configs/utils.dart';
import '../../configs/validator/app_validator.dart';
import '../../model/bargaining/bargaining_models.dart';
import '../../view_model/bargaining/bargaining_view_model.dart';

/// Drawer module: list → thread detail, filters, counter-offer, accept / decline.
class BargainingModuleView extends StatelessWidget {
  const BargainingModuleView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BargainingViewModel>();
    if (vm.selectedThread != null) {
      return const _BargainingDetailScaffold();
    }
    return const _BargainingListScaffold();
  }
}

class _BargainingListScaffold extends StatelessWidget {
  const _BargainingListScaffold();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vm = context.watch<BargainingViewModel>();
    final rows = vm.filteredThreads;

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: Text(l10n.drawerItemBargaining),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text(
              l10n.bargainingSubtitle,
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
                  label: l10n.bargainingFilterAll,
                  selected: vm.filter == BargainingListFilter.all,
                  onTap: () => vm.setFilter(BargainingListFilter.all),
                ),
                _FilterChip(
                  label: l10n.bargainingFilterActive,
                  selected: vm.filter == BargainingListFilter.active,
                  onTap: () => vm.setFilter(BargainingListFilter.active),
                ),
                _FilterChip(
                  label: l10n.bargainingFilterAgreed,
                  selected: vm.filter == BargainingListFilter.agreed,
                  onTap: () => vm.setFilter(BargainingListFilter.agreed),
                ),
                _FilterChip(
                  label: l10n.bargainingFilterDeclined,
                  selected: vm.filter == BargainingListFilter.declined,
                  onTap: () => vm.setFilter(BargainingListFilter.declined),
                ),
              ],
            ),
          ),
          Expanded(
            child: rows.isEmpty
                ? Center(
                    child: Text(
                      l10n.bargainingEmptyFilter,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: rows.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) {
                      final t = rows[i];
                      return _ThreadListCard(
                        thread: t,
                        onTap: () =>
                            context.read<BargainingViewModel>().openThread(t),
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

class _ThreadListCard extends StatelessWidget {
  const _ThreadListCard({required this.thread, required this.onTap});

  final BargainingThread thread;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                      thread.id,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  _StatusChip(status: thread.status, l10n: l10n),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                thread.productTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${l10n.bargainingWith}: ${thread.counterparty}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                thread.yourRole == BargainingPartyRole.youBuy
                    ? l10n.bargainingRoleBuying
                    : l10n.bargainingRoleSelling,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const Divider(height: 18),
              Text(
                thread.askingLine,
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 2),
              Text(
                thread.biddingLine,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status, required this.l10n});

  final BargainingThreadStatus status;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    late String label;
    late Color fg;
    late Color bg;
    switch (status) {
      case BargainingThreadStatus.active:
        label = l10n.bargainingStatusActive;
        fg = const Color(0xFF1565C0);
        bg = const Color(0xFFE3F2FD);
        break;
      case BargainingThreadStatus.agreed:
        label = l10n.bargainingStatusAgreed;
        fg = AppColors.primary;
        bg = AppColors.sellingBadge;
        break;
      case BargainingThreadStatus.declined:
        label = l10n.bargainingStatusDeclined;
        fg = AppColors.error;
        bg = const Color(0xFFFFEBEE);
        break;
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

class _BargainingDetailScaffold extends StatelessWidget {
  const _BargainingDetailScaffold();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vm = context.watch<BargainingViewModel>();
    final t = vm.selectedThread!;

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => vm.closeDetail(),
        ),
        title: Text(t.id),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              children: [
                Text(
                  t.productTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${l10n.bargainingWith}: ${t.counterparty}',
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 4),
                Text(
                  t.yourRole == BargainingPartyRole.youBuy
                      ? l10n.bargainingRoleBuying
                      : l10n.bargainingRoleSelling,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                _SummaryRow(label: t.askingLine),
                const SizedBox(height: 4),
                _SummaryRow(label: t.biddingLine),
                const SizedBox(height: 20),
                Text(
                  l10n.bargainingTimelineTitle,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                for (final e in t.events) _EventTile(event: e, l10n: l10n),
              ],
            ),
          ),
          if (t.status == BargainingThreadStatus.active)
            _DetailActionsBar(
              onCounter: () => _showCounterSheet(context),
              onAccept: () {
                vm.acceptLatest();
                showAppSnackBar(context, l10n.bargainingSnackAccepted);
              },
              onDecline: () {
                vm.declineNegotiation();
                showAppSnackBar(context, l10n.bargainingSnackDeclined);
              },
            ),
        ],
      ),
    );
  }

  static void _showCounterSheet(BuildContext context) {
    final vm = context.read<BargainingViewModel>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => ChangeNotifierProvider<BargainingViewModel>.value(
        value: vm,
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: MediaQuery.viewInsetsOf(ctx).bottom + 20,
          ),
          child: const _CounterOfferForm(),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
    );
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.event, required this.l10n});

  final BargainingEvent event;
  final AppLocalizations l10n;

  String _actorDisplay() {
    if (event.actorLabel == 'You') return l10n.bargainingActorYou;
    return event.actorLabel;
  }

  String _kindLabel() {
    switch (event.kind) {
      case BargainingEventKind.openingAsk:
        return l10n.bargainingEventOpening;
      case BargainingEventKind.counterBuyer:
        return l10n.bargainingEventCounterBuyer;
      case BargainingEventKind.counterSeller:
        return l10n.bargainingEventCounterSeller;
      case BargainingEventKind.accepted:
        return l10n.bargainingEventAccepted;
      case BargainingEventKind.declined:
        return l10n.bargainingEventDeclined;
      case BargainingEventKind.system:
        return l10n.bargainingEventSystem;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mine = event.actorLabel == 'You';
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Material(
            color: mine ? AppColors.chatOutgoing : AppColors.chatIncoming,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: mine
                  ? BorderSide.none
                  : const BorderSide(color: AppColors.border),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _kindLabel(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: mine
                          ? Colors.white.withValues(alpha: 0.85)
                          : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _actorDisplay(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: mine ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                  if (event.amountHighlight != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      event.amountHighlight!,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: mine ? Colors.white : AppColors.primary,
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Text(
                    event.body,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.35,
                      color: mine ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    event.at,
                    style: TextStyle(
                      fontSize: 11,
                      color: mine
                          ? Colors.white.withValues(alpha: 0.75)
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailActionsBar extends StatelessWidget {
  const _DetailActionsBar({
    required this.onCounter,
    required this.onAccept,
    required this.onDecline,
  });

  final VoidCallback onCounter;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onCounter,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  label: Text(l10n.bargainingActionCounter),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onDecline,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(l10n.bargainingActionDecline),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton(
                      onPressed: onAccept,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.sellingBadge,
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(l10n.bargainingActionAccept),
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

class _CounterOfferForm extends StatefulWidget {
  const _CounterOfferForm();

  @override
  State<_CounterOfferForm> createState() => _CounterOfferFormState();
}

class _CounterOfferFormState extends State<_CounterOfferForm> {
  final _formKey = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _note = TextEditingController();

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    super.dispose();
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
            l10n.bargainingCounterTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _amount,
            decoration: InputDecoration(
              labelText: l10n.bargainingCounterAmountLabel,
              hintText: l10n.bargainingCounterAmountHint,
            ),
            validator: (v) => AppValidator.required(v, l10n.bargainingCounterAmountLabel),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _note,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: l10n.bargainingCounterNoteLabel,
              hintText: l10n.bargainingCounterNoteHint,
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.bargainingCounterCancel),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    if (!(_formKey.currentState?.validate() ?? false)) return;
                    final body = _note.text.trim().isEmpty
                        ? l10n.bargainingCounterDefaultNote
                        : _note.text.trim();
                    context.read<BargainingViewModel>().submitCounterOffer(
                          amountDisplay: _amount.text.trim(),
                          eventBody: body,
                        );
                    Navigator.pop(context);
                    showAppSnackBar(context, l10n.bargainingSnackCounterPosted);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                  ),
                  child: Text(l10n.bargainingCounterSubmit),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
