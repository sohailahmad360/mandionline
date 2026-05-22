import 'package:flutter/foundation.dart';

import '../../data/demo_cheques_catalog.dart';
import '../../model/cheques/cheque_models.dart';

class ChequesViewModel extends ChangeNotifier {
  ChequesViewModel() {
    _items = cloneDemoCheques();
  }

  late List<ChequeItem> _items;
  ChequeListFilter _filter = ChequeListFilter.all;
  String _searchQuery = '';
  ChequeItem? _selected;

  List<ChequeItem> get allItems => List.unmodifiable(_items);

  ChequeListFilter get filter => _filter;

  String get searchQuery => _searchQuery;

  ChequeItem? get selectedCheque => _selected;

  List<ChequeItem> get filteredItems {
    Iterable<ChequeItem> rows = _items;

    switch (_filter) {
      case ChequeListFilter.all:
        break;
      case ChequeListFilter.outstanding:
        rows = rows.where((c) => c.status == ChequeStatus.pending);
        break;
      case ChequeListFilter.clearing:
        rows = rows.where((c) => c.status == ChequeStatus.depositedClearing);
        break;
      case ChequeListFilter.cleared:
        rows = rows.where((c) => c.status == ChequeStatus.cleared);
        break;
      case ChequeListFilter.bouncedOrCancelled:
        rows = rows.where(
          (c) =>
              c.status == ChequeStatus.bounced ||
              c.status == ChequeStatus.cancelled,
        );
        break;
    }

    final q = _searchQuery.trim().toLowerCase();
    if (q.isNotEmpty) {
      rows = rows.where((c) {
        if (c.partyName.toLowerCase().contains(q)) return true;
        if (c.bankName.toLowerCase().contains(q)) return true;
        if (c.chequeNumber.toLowerCase().contains(q)) return true;
        if (c.id.toLowerCase().contains(q)) return true;
        return false;
      });
    }

    return rows.toList();
  }

  void setFilter(ChequeListFilter f) {
    if (_filter == f) return;
    _filter = f;
    notifyListeners();
  }

  void setSearchQuery(String q) {
    if (_searchQuery == q) return;
    _searchQuery = q;
    notifyListeners();
  }

  void openCheque(ChequeItem item) {
    _selected = _items.firstWhere((c) => c.id == item.id);
    notifyListeners();
  }

  void closeDetail() {
    _selected = null;
    notifyListeners();
  }

  void _replaceCheque(ChequeItem next) {
    final i = _items.indexWhere((c) => c.id == next.id);
    if (i < 0) return;
    _items[i] = next;
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

  ChequeItem _appendEvent(
    ChequeItem c,
    ChequeStatus newStatus,
    ChequeEventKind kind,
    String title, {
    String? note,
  }) {
    final ev = ChequeEvent(
      id: 'ev-${DateTime.now().millisecondsSinceEpoch}',
      at: _timestampNow(),
      kind: kind,
      title: title,
      note: note,
    );
    return c.copyWith(
      status: newStatus,
      events: [...c.events, ev],
    );
  }

  /// Pending → clearing (deposit received cheque or counterparty presented yours).
  void sendToBank({required String eventTitle}) {
    final c = _selected;
    if (c == null || c.status != ChequeStatus.pending) return;
    _replaceCheque(
      _appendEvent(
        c,
        ChequeStatus.depositedClearing,
        ChequeEventKind.sentToBank,
        eventTitle,
      ),
    );
  }

  /// Clearing → cleared.
  void markCleared({required String eventTitle}) {
    final c = _selected;
    if (c == null || c.status != ChequeStatus.depositedClearing) return;
    _replaceCheque(
      _appendEvent(
        c,
        ChequeStatus.cleared,
        ChequeEventKind.cleared,
        eventTitle,
      ),
    );
  }

  /// Pending or clearing → bounced.
  void markBounced({required String eventTitle}) {
    final c = _selected;
    if (c == null) return;
    if (c.status != ChequeStatus.pending &&
        c.status != ChequeStatus.depositedClearing) {
      return;
    }
    _replaceCheque(
      _appendEvent(
        c,
        ChequeStatus.bounced,
        ChequeEventKind.bounced,
        eventTitle,
      ),
    );
  }

  /// Pending → cancelled (void before bank action).
  void cancelCheque({required String eventTitle}) {
    final c = _selected;
    if (c == null || c.status != ChequeStatus.pending) return;
    _replaceCheque(
      _appendEvent(
        c,
        ChequeStatus.cancelled,
        ChequeEventKind.cancelled,
        eventTitle,
      ),
    );
  }

  /// Append a free-form note without changing status.
  void addNote({required String noteBody, required String eventTitle}) {
    final c = _selected;
    if (c == null || noteBody.trim().isEmpty) return;
    _replaceCheque(
      _appendEvent(
        c,
        c.status,
        ChequeEventKind.note,
        eventTitle,
        note: noteBody.trim(),
      ),
    );
  }

  void registerCheque({
    required ChequeDirection direction,
    required String partyName,
    required String bankName,
    required String chequeNumber,
    required double amount,
    required String issueDateLabel,
    required String maturityDateLabel,
    required String registeredEventTitle,
    String? initialNote,
  }) {
    if (partyName.trim().isEmpty ||
        bankName.trim().isEmpty ||
        chequeNumber.trim().isEmpty ||
        amount <= 0) {
      return;
    }
    final id = 'CH-${DateTime.now().millisecondsSinceEpoch % 900000 + 10000}';
    final noteTrim = initialNote?.trim();
    final firstNote =
        (noteTrim == null || noteTrim.isEmpty) ? null : noteTrim;
    final events = <ChequeEvent>[
      ChequeEvent(
        id: 'ev-${DateTime.now().microsecondsSinceEpoch}',
        at: _timestampNow(),
        kind: ChequeEventKind.registered,
        title: registeredEventTitle,
        note: firstNote,
      ),
    ];
    final item = ChequeItem(
      id: id,
      chequeNumber: chequeNumber.trim(),
      bankName: bankName.trim(),
      partyName: partyName.trim(),
      direction: direction,
      status: ChequeStatus.pending,
      amount: amount,
      issueDateLabel: issueDateLabel.trim(),
      maturityDateLabel: maturityDateLabel.trim(),
      events: events,
    );
    _items.insert(0, item);
    notifyListeners();
  }
}
