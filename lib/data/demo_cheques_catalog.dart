import '../model/cheques/cheque_models.dart';

List<ChequeItem> cloneDemoCheques() {
  return _seeds.map(_cloneCheque).toList();
}

ChequeItem _cloneCheque(ChequeItem c) {
  return ChequeItem(
    id: c.id,
    chequeNumber: c.chequeNumber,
    bankName: c.bankName,
    partyName: c.partyName,
    direction: c.direction,
    status: c.status,
    amount: c.amount,
    issueDateLabel: c.issueDateLabel,
    maturityDateLabel: c.maturityDateLabel,
    events: c.events.map(_cloneEvent).toList(),
  );
}

ChequeEvent _cloneEvent(ChequeEvent e) {
  return ChequeEvent(
    id: e.id,
    at: e.at,
    kind: e.kind,
    title: e.title,
    note: e.note,
  );
}

final List<ChequeItem> _seeds = [
  ChequeItem(
    id: 'CH-8801',
    chequeNumber: '44102',
    bankName: 'Allied Bank · Garden Town',
    partyName: 'Lahore Dry Fruit House',
    direction: ChequeDirection.issued,
    status: ChequeStatus.depositedClearing,
    amount: 200000,
    issueDateLabel: '2026-04-10',
    maturityDateLabel: '2026-04-24',
    events: [
      ChequeEvent(
        id: 'ev1',
        at: '2026-04-10 11:20',
        kind: ChequeEventKind.registered,
        title: 'Cheque registered in Mandi Online.',
      ),
      ChequeEvent(
        id: 'ev2',
        at: '2026-04-14 09:05',
        kind: ChequeEventKind.sentToBank,
        title: 'Beneficiary presented cheque — clearing.',
      ),
    ],
  ),
  ChequeItem(
    id: 'CH-8802',
    chequeNumber: '99231',
    bankName: 'Meezan Bank · I I Chundrigar',
    partyName: 'Karachi Wholesale',
    direction: ChequeDirection.received,
    status: ChequeStatus.pending,
    amount: 150000,
    issueDateLabel: '2026-04-18',
    maturityDateLabel: '2026-05-02',
    events: [
      ChequeEvent(
        id: 'ev1',
        at: '2026-04-18 16:40',
        kind: ChequeEventKind.registered,
        title: 'Received cheque logged.',
      ),
    ],
  ),
  ChequeItem(
    id: 'CH-8790',
    chequeNumber: '77301',
    bankName: 'HBL · Multan Cantt',
    partyName: 'Multan Spices Co.',
    direction: ChequeDirection.received,
    status: ChequeStatus.cleared,
    amount: 88000,
    issueDateLabel: '2026-03-28',
    maturityDateLabel: '2026-04-12',
    events: [
      ChequeEvent(
        id: 'ev1',
        at: '2026-03-28 10:00',
        kind: ChequeEventKind.registered,
        title: 'Received cheque logged.',
      ),
      ChequeEvent(
        id: 'ev2',
        at: '2026-04-01 09:15',
        kind: ChequeEventKind.sentToBank,
        title: 'Deposited for clearing.',
      ),
      ChequeEvent(
        id: 'ev3',
        at: '2026-04-03 14:22',
        kind: ChequeEventKind.cleared,
        title: 'Funds cleared to operating account.',
      ),
    ],
  ),
  ChequeItem(
    id: 'CH-8785',
    chequeNumber: '22015',
    bankName: 'UBL · Saddar',
    partyName: 'Sindh Traders',
    direction: ChequeDirection.issued,
    status: ChequeStatus.bounced,
    amount: 45000,
    issueDateLabel: '2026-03-15',
    maturityDateLabel: '2026-03-29',
    events: [
      ChequeEvent(
        id: 'ev1',
        at: '2026-03-15 12:00',
        kind: ChequeEventKind.registered,
        title: 'Cheque issued against dates purchase.',
      ),
      ChequeEvent(
        id: 'ev2',
        at: '2026-03-22 10:30',
        kind: ChequeEventKind.sentToBank,
        title: 'Presented by payee.',
      ),
      ChequeEvent(
        id: 'ev3',
        at: '2026-03-25 11:02',
        kind: ChequeEventKind.bounced,
        title: 'Insufficient funds — dishonoured.',
      ),
    ],
  ),
  ChequeItem(
    id: 'CH-8772',
    chequeNumber: '55600',
    bankName: 'Bank Alfalah · Gulberg',
    partyName: 'Kashmir Dry Fruits',
    direction: ChequeDirection.received,
    status: ChequeStatus.cancelled,
    amount: 120000,
    issueDateLabel: '2026-02-20',
    maturityDateLabel: '2026-03-06',
    events: [
      ChequeEvent(
        id: 'ev1',
        at: '2026-02-20 09:00',
        kind: ChequeEventKind.registered,
        title: 'PDC received for walnut lot.',
      ),
      ChequeEvent(
        id: 'ev2',
        at: '2026-02-28 15:10',
        kind: ChequeEventKind.cancelled,
        title: 'Deal restructured — cheque voided with mutual consent.',
      ),
    ],
  ),
  ChequeItem(
    id: 'CH-8810',
    chequeNumber: '118804',
    bankName: 'MCB · Johar Town',
    partyName: 'Punjabi Store (self)',
    direction: ChequeDirection.issued,
    status: ChequeStatus.pending,
    amount: 95000,
    issueDateLabel: '2026-04-22',
    maturityDateLabel: '2026-05-06',
    events: [
      ChequeEvent(
        id: 'ev1',
        at: '2026-04-22 08:45',
        kind: ChequeEventKind.registered,
        title: 'Post-dated cheque for logistics advance.',
      ),
    ],
  ),
];
