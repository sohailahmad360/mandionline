/// Cheque you hold from a party vs one you issued.
enum ChequeDirection {
  received,
  issued,
}

/// Lifecycle for demo tracking.
enum ChequeStatus {
  /// Not yet sent to your bank (received) or still outstanding on your books (issued).
  pending,

  /// With bank / clearing cycle.
  depositedClearing,

  cleared,
  bounced,
  cancelled,
}

enum ChequeEventKind {
  registered,
  sentToBank,
  cleared,
  bounced,
  cancelled,
  note,
}

class ChequeEvent {
  const ChequeEvent({
    required this.id,
    required this.at,
    required this.kind,
    required this.title,
    this.note,
  });

  final String id;
  final String at;
  final ChequeEventKind kind;
  final String title;
  final String? note;

  ChequeEvent copyWith({
    String? id,
    String? at,
    ChequeEventKind? kind,
    String? title,
    String? note,
  }) {
    return ChequeEvent(
      id: id ?? this.id,
      at: at ?? this.at,
      kind: kind ?? this.kind,
      title: title ?? this.title,
      note: note ?? this.note,
    );
  }
}

class ChequeItem {
  const ChequeItem({
    required this.id,
    required this.chequeNumber,
    required this.bankName,
    required this.partyName,
    required this.direction,
    required this.status,
    required this.amount,
    required this.issueDateLabel,
    required this.maturityDateLabel,
    required this.events,
  });

  final String id;
  final String chequeNumber;
  final String bankName;
  final String partyName;
  final ChequeDirection direction;
  final ChequeStatus status;
  final double amount;
  final String issueDateLabel;
  final String maturityDateLabel;
  final List<ChequeEvent> events;

  ChequeItem copyWith({
    String? id,
    String? chequeNumber,
    String? bankName,
    String? partyName,
    ChequeDirection? direction,
    ChequeStatus? status,
    double? amount,
    String? issueDateLabel,
    String? maturityDateLabel,
    List<ChequeEvent>? events,
  }) {
    return ChequeItem(
      id: id ?? this.id,
      chequeNumber: chequeNumber ?? this.chequeNumber,
      bankName: bankName ?? this.bankName,
      partyName: partyName ?? this.partyName,
      direction: direction ?? this.direction,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      issueDateLabel: issueDateLabel ?? this.issueDateLabel,
      maturityDateLabel: maturityDateLabel ?? this.maturityDateLabel,
      events: events ?? List<ChequeEvent>.from(this.events),
    );
  }
}

enum ChequeListFilter {
  all,
  outstanding,
  clearing,
  cleared,
  bouncedOrCancelled,
}
