import 'package:flutter/foundation.dart';

import '../../data/demo_bargaining_catalog.dart';
import '../../model/bargaining/bargaining_models.dart';

class BargainingViewModel extends ChangeNotifier {
  BargainingViewModel() {
    _threads = cloneDemoBargainingThreads();
  }

  late final List<BargainingThread> _threads;
  BargainingListFilter _filter = BargainingListFilter.all;
  BargainingThread? _selected;

  List<BargainingThread> get allThreads => List.unmodifiable(_threads);

  BargainingListFilter get filter => _filter;

  BargainingThread? get selectedThread => _selected;

  List<BargainingThread> get filteredThreads {
    switch (_filter) {
      case BargainingListFilter.all:
        return List<BargainingThread>.from(_threads);
      case BargainingListFilter.active:
        return _threads
            .where((t) => t.status == BargainingThreadStatus.active)
            .toList();
      case BargainingListFilter.agreed:
        return _threads
            .where((t) => t.status == BargainingThreadStatus.agreed)
            .toList();
      case BargainingListFilter.declined:
        return _threads
            .where((t) => t.status == BargainingThreadStatus.declined)
            .toList();
    }
  }

  void setFilter(BargainingListFilter f) {
    if (_filter == f) return;
    _filter = f;
    notifyListeners();
  }

  void openThread(BargainingThread thread) {
    _selected = _threads.firstWhere((t) => t.id == thread.id);
    notifyListeners();
  }

  void closeDetail() {
    _selected = null;
    notifyListeners();
  }

  void _replaceThread(BargainingThread next) {
    final i = _threads.indexWhere((t) => t.id == next.id);
    if (i < 0) return;
    _threads[i] = next;
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

  /// Append your counter-offer (active threads only).
  void submitCounterOffer({
    required String amountDisplay,
    required String eventBody,
  }) {
    final t = _selected;
    if (t == null || t.status != BargainingThreadStatus.active) return;

    final kind = t.yourRole == BargainingPartyRole.youBuy
        ? BargainingEventKind.counterBuyer
        : BargainingEventKind.counterSeller;

    final event = BargainingEvent(
      id: 'e-${DateTime.now().millisecondsSinceEpoch}',
      kind: kind,
      actorLabel: 'You',
      body: eventBody,
      at: _timestampNow(),
      amountHighlight: amountDisplay,
    );

    final newEvents = [...t.events, event];
    final nextBidding = t.yourRole == BargainingPartyRole.youBuy
        ? 'Your last: $amountDisplay'
        : 'Your last: $amountDisplay';

    _replaceThread(
      t.copyWith(
        events: newEvents,
        biddingLine: nextBidding,
      ),
    );
  }

  /// Accept the latest terms (active only).
  void acceptLatest() {
    final t = _selected;
    if (t == null || t.status != BargainingThreadStatus.active) return;

    final event = BargainingEvent(
      id: 'e-${DateTime.now().millisecondsSinceEpoch}',
      kind: BargainingEventKind.accepted,
      actorLabel: 'You',
      body: 'You accepted the latest terms.',
      at: _timestampNow(),
    );

    _replaceThread(
      t.copyWith(
        status: BargainingThreadStatus.agreed,
        events: [...t.events, event],
      ),
    );
  }

  /// Decline / walk away (active only).
  void declineNegotiation() {
    final t = _selected;
    if (t == null || t.status != BargainingThreadStatus.active) return;

    final event = BargainingEvent(
      id: 'e-${DateTime.now().millisecondsSinceEpoch}',
      kind: BargainingEventKind.declined,
      actorLabel: 'You',
      body: 'You ended this negotiation.',
      at: _timestampNow(),
    );

    _replaceThread(
      t.copyWith(
        status: BargainingThreadStatus.declined,
        events: [...t.events, event],
      ),
    );
  }
}
