import '../model/ledger/ledger_models.dart';

/// Deep clone + recompute [LedgerEntry.balanceAfter] for every account.
List<LedgerAccount> cloneDemoLedgerAccounts() {
  return _seeds.map(_cloneAccount).map(recalcLedgerBalances).toList();
}

LedgerAccount _cloneAccount(LedgerAccount a) {
  return LedgerAccount(
    id: a.id,
    partyName: a.partyName,
    partySubtitle: a.partySubtitle,
    openingBalance: a.openingBalance,
    entries: a.entries.map(_cloneEntry).toList(),
  );
}

LedgerEntry _cloneEntry(LedgerEntry e) {
  return LedgerEntry(
    id: e.id,
    at: e.at,
    kind: e.kind,
    title: e.title,
    note: e.note,
    delta: e.delta,
    balanceAfter: e.balanceAfter,
  );
}

/// Recompute running balances from [openingBalance] and entry deltas (oldest first).
LedgerAccount recalcLedgerBalances(LedgerAccount a) {
  double running = a.openingBalance;
  final out = <LedgerEntry>[];
  for (final e in a.entries) {
    running += e.delta;
    out.add(e.copyWith(balanceAfter: running));
  }
  return a.copyWith(entries: out);
}

final List<LedgerAccount> _seeds = [
  LedgerAccount(
    id: 'LG-2044',
    partyName: 'Karachi Wholesale',
    partySubtitle: 'Spices · bulk buyer',
    openingBalance: 0,
    entries: [
      LedgerEntry(
        id: 'e1',
        at: '2026-03-18 09:10',
        kind: LedgerEntryKind.opening,
        title: 'Opening balance',
        note: 'Start of season',
        delta: 0,
        balanceAfter: 0,
      ),
      LedgerEntry(
        id: 'e2',
        at: '2026-03-22 11:20',
        kind: LedgerEntryKind.saleOnCredit,
        title: 'Invoice · dried red chilies 500 kg',
        note: 'Lot BR-12',
        delta: 390000,
        balanceAfter: 0,
      ),
      LedgerEntry(
        id: 'e3',
        at: '2026-04-02 16:45',
        kind: LedgerEntryKind.paymentReceived,
        title: 'Bank transfer (partial)',
        delta: -150000,
        balanceAfter: 0,
      ),
      LedgerEntry(
        id: 'e4',
        at: '2026-04-12 10:05',
        kind: LedgerEntryKind.saleOnCredit,
        title: 'Invoice · turmeric 200 kg',
        delta: 88000,
        balanceAfter: 0,
      ),
    ],
  ),
  LedgerAccount(
    id: 'LG-2031',
    partyName: 'Multan Spices Co.',
    partySubtitle: 'Cardamom · regular',
    openingBalance: 120000,
    entries: [
      LedgerEntry(
        id: 'e1',
        at: '2026-04-01 08:00',
        kind: LedgerEntryKind.opening,
        title: 'Opening balance',
        note: 'Brought forward',
        delta: 0,
        balanceAfter: 0,
      ),
      LedgerEntry(
        id: 'e2',
        at: '2026-04-05 14:30',
        kind: LedgerEntryKind.paymentReceived,
        title: 'Cash deposit',
        delta: -80000,
        balanceAfter: 0,
      ),
    ],
  ),
  LedgerAccount(
    id: 'LG-2018',
    partyName: 'Lahore Dry Fruit House',
    partySubtitle: 'Walnuts · retail chain',
    openingBalance: 0,
    entries: [
      LedgerEntry(
        id: 'e1',
        at: '2026-04-08 12:00',
        kind: LedgerEntryKind.purchaseOnCredit,
        title: 'Purchase · premium walnuts 80 kg',
        delta: -364000,
        balanceAfter: 0,
      ),
      LedgerEntry(
        id: 'e2',
        at: '2026-04-14 09:20',
        kind: LedgerEntryKind.paymentSent,
        title: 'Cheque #44102',
        delta: 200000,
        balanceAfter: 0,
      ),
    ],
  ),
  LedgerAccount(
    id: 'LG-2002',
    partyName: 'Sindh Traders',
    partySubtitle: 'Dates · seasonal',
    openingBalance: -45000,
    entries: [
      LedgerEntry(
        id: 'e1',
        at: '2026-03-28 15:00',
        kind: LedgerEntryKind.opening,
        title: 'Opening balance',
        delta: 0,
        balanceAfter: 0,
      ),
      LedgerEntry(
        id: 'e2',
        at: '2026-04-03 11:40',
        kind: LedgerEntryKind.paymentSent,
        title: 'Online transfer',
        delta: 45000,
        balanceAfter: 0,
      ),
    ],
  ),
  LedgerAccount(
    id: 'LG-1995',
    partyName: 'Kashmir Dry Fruits',
    partySubtitle: 'Closed lot · Q1',
    openingBalance: 0,
    entries: [
      LedgerEntry(
        id: 'e1',
        at: '2026-02-10 10:00',
        kind: LedgerEntryKind.saleOnCredit,
        title: 'Invoice · shelled walnuts 200 kg',
        delta: 364000,
        balanceAfter: 0,
      ),
      LedgerEntry(
        id: 'e2',
        at: '2026-02-18 16:00',
        kind: LedgerEntryKind.paymentReceived,
        title: 'Full settlement',
        delta: -364000,
        balanceAfter: 0,
      ),
    ],
  ),
];
