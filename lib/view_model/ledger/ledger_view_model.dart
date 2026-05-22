import 'package:flutter/foundation.dart';

import '../../data/demo_ledger_catalog.dart';
import '../../model/ledger/ledger_models.dart';

class LedgerViewModel extends ChangeNotifier {
  LedgerViewModel() {
    _accounts = cloneDemoLedgerAccounts();
  }

  static const double _settledEpsilon = 0.5;

  late final List<LedgerAccount> _accounts;
  LedgerListFilter _filter = LedgerListFilter.all;
  String _searchQuery = '';
  LedgerAccount? _selected;

  List<LedgerAccount> get allAccounts => List.unmodifiable(_accounts);

  LedgerListFilter get filter => _filter;

  String get searchQuery => _searchQuery;

  LedgerAccount? get selectedAccount => _selected;

  List<LedgerAccount> get filteredAccounts {
    Iterable<LedgerAccount> rows = _accounts;

    switch (_filter) {
      case LedgerListFilter.all:
        break;
      case LedgerListFilter.receivable:
        rows = rows.where((a) => a.currentBalance > _settledEpsilon);
        break;
      case LedgerListFilter.payable:
        rows = rows.where((a) => a.currentBalance < -_settledEpsilon);
        break;
      case LedgerListFilter.settled:
        rows = rows.where((a) => a.currentBalance.abs() <= _settledEpsilon);
        break;
    }

    final q = _searchQuery.trim().toLowerCase();
    if (q.isNotEmpty) {
      rows = rows.where((a) {
        if (a.partyName.toLowerCase().contains(q)) return true;
        final sub = a.partySubtitle;
        return sub != null && sub.toLowerCase().contains(q);
      });
    }

    return rows.toList();
  }

  void setFilter(LedgerListFilter f) {
    if (_filter == f) return;
    _filter = f;
    notifyListeners();
  }

  void setSearchQuery(String q) {
    if (_searchQuery == q) return;
    _searchQuery = q;
    notifyListeners();
  }

  void openAccount(LedgerAccount account) {
    _selected = _accounts.firstWhere((a) => a.id == account.id);
    notifyListeners();
  }

  void closeDetail() {
    _selected = null;
    notifyListeners();
  }

  void _replaceAccount(LedgerAccount next) {
    final i = _accounts.indexWhere((a) => a.id == next.id);
    if (i < 0) return;
    _accounts[i] = next;
    if (_selected?.id == next.id) {
      _selected = next;
    }
    notifyListeners();
  }

  static String _timestampNow() {
    final d = DateTime.now();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${d.year}-${two(d.month)}-${two(d.day)} ${two(d.hour)}:${two(d.minute)}';
  }

  static double _deltaFor(LedgerEntryKind kind, double amount) {
    assert(amount > 0);
    switch (kind) {
      case LedgerEntryKind.opening:
        return 0;
      case LedgerEntryKind.saleOnCredit:
      case LedgerEntryKind.creditNote:
      case LedgerEntryKind.paymentSent:
        return amount;
      case LedgerEntryKind.purchaseOnCredit:
      case LedgerEntryKind.debitNote:
      case LedgerEntryKind.paymentReceived:
        return -amount;
    }
  }

  /// Append a movement to the selected account and recompute balances.
  void addMovement({
    required LedgerEntryKind kind,
    required double amount,
    required String title,
    String? note,
  }) {
    final acc = _selected;
    if (acc == null || amount <= 0) return;
    if (kind == LedgerEntryKind.opening) return;

    final delta = _deltaFor(kind, amount);
    if (delta == 0) return;

    final entry = LedgerEntry(
      id: 'e-${DateTime.now().millisecondsSinceEpoch}',
      at: _timestampNow(),
      kind: kind,
      title: title,
      note: note,
      delta: delta,
      balanceAfter: 0,
    );

    final merged = recalcLedgerBalances(
      acc.copyWith(entries: [...acc.entries, entry]),
    );
    _replaceAccount(merged);
  }
}
