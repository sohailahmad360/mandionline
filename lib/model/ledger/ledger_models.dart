/// Net position: positive = counterparty owes you (receivable),
/// negative = you owe them (payable).
enum LedgerListFilter {
  all,
  receivable,
  payable,
  settled,
}

/// Single line on a party ledger (chronological order: oldest → newest in storage).
enum LedgerEntryKind {
  /// Carried opening position (seed / migration only).
  opening,

  /// You sold on credit — increases receivable.
  saleOnCredit,

  /// You bought on credit — increases payable (negative net).
  purchaseOnCredit,

  /// They paid you — reduces receivable (or moves balance toward zero).
  paymentReceived,

  /// You paid them — reduces payable (moves balance toward zero).
  paymentSent,

  /// Manual credit in your favour.
  creditNote,

  /// Manual debit against you.
  debitNote,
}

class LedgerEntry {
  const LedgerEntry({
    required this.id,
    required this.at,
    required this.kind,
    required this.title,
    this.note,
    required this.delta,
    required this.balanceAfter,
  });

  final String id;
  final String at;
  final LedgerEntryKind kind;
  final String title;
  final String? note;

  /// Effect on signed net balance (receivable − payable).
  final double delta;

  /// Running balance after this line (same sign convention as account).
  final double balanceAfter;

  LedgerEntry copyWith({
    String? id,
    String? at,
    LedgerEntryKind? kind,
    String? title,
    String? note,
    double? delta,
    double? balanceAfter,
  }) {
    return LedgerEntry(
      id: id ?? this.id,
      at: at ?? this.at,
      kind: kind ?? this.kind,
      title: title ?? this.title,
      note: note ?? this.note,
      delta: delta ?? this.delta,
      balanceAfter: balanceAfter ?? this.balanceAfter,
    );
  }
}

class LedgerAccount {
  const LedgerAccount({
    required this.id,
    required this.partyName,
    this.partySubtitle,
    required this.openingBalance,
    required this.entries,
  });

  final String id;
  final String partyName;
  final String? partySubtitle;

  /// Balance before the first stored entry.
  final double openingBalance;
  final List<LedgerEntry> entries;

  double get currentBalance {
    if (entries.isEmpty) return openingBalance;
    return entries.last.balanceAfter;
  }

  LedgerAccount copyWith({
    String? id,
    String? partyName,
    String? partySubtitle,
    double? openingBalance,
    List<LedgerEntry>? entries,
  }) {
    return LedgerAccount(
      id: id ?? this.id,
      partyName: partyName ?? this.partyName,
      partySubtitle: partySubtitle ?? this.partySubtitle,
      openingBalance: openingBalance ?? this.openingBalance,
      entries: entries ?? List<LedgerEntry>.from(this.entries),
    );
  }
}

/// Kinds the user can post from the “Record movement” sheet.
const List<LedgerEntryKind> ledgerUserPostableKinds = [
  LedgerEntryKind.saleOnCredit,
  LedgerEntryKind.purchaseOnCredit,
  LedgerEntryKind.paymentReceived,
  LedgerEntryKind.paymentSent,
  LedgerEntryKind.creditNote,
  LedgerEntryKind.debitNote,
];
