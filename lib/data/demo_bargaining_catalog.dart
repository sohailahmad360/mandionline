import '../model/bargaining/bargaining_models.dart';

/// Deep-cloned demo threads for [BargainingViewModel].
List<BargainingThread> cloneDemoBargainingThreads() {
  return _seeds.map(_cloneThread).toList();
}

BargainingThread _cloneThread(BargainingThread t) {
  return BargainingThread(
    id: t.id,
    productTitle: t.productTitle,
    counterparty: t.counterparty,
    yourRole: t.yourRole,
    status: t.status,
    askingLine: t.askingLine,
    biddingLine: t.biddingLine,
    events: t.events.map(_cloneEvent).toList(),
  );
}

BargainingEvent _cloneEvent(BargainingEvent e) {
  return BargainingEvent(
    id: e.id,
    kind: e.kind,
    actorLabel: e.actorLabel,
    body: e.body,
    at: e.at,
    amountHighlight: e.amountHighlight,
  );
}

final List<BargainingThread> _seeds = [
  BargainingThread(
    id: 'BR-9012',
    productTitle: 'Dried red chilies · Grade A',
    counterparty: 'Karachi Wholesale',
    yourRole: BargainingPartyRole.youBuy,
    status: BargainingThreadStatus.active,
    askingLine: 'Their ask: Rs 800 / kg',
    biddingLine: 'Your last: Rs 720 / kg',
    events: [
      BargainingEvent(
        id: 'e1',
        kind: BargainingEventKind.system,
        actorLabel: 'System',
        body: 'Negotiation opened on this lot.',
        at: '2026-04-22 09:12',
      ),
      BargainingEvent(
        id: 'e2',
        kind: BargainingEventKind.openingAsk,
        actorLabel: 'Karachi Wholesale',
        body: 'Opening position for 500 kg lot.',
        at: '2026-04-22 09:14',
        amountHighlight: 'Rs 800 / kg',
      ),
      BargainingEvent(
        id: 'e3',
        kind: BargainingEventKind.counterBuyer,
        actorLabel: 'You',
        body: 'Counter — aligned with Lahore market this week.',
        at: '2026-04-22 10:02',
        amountHighlight: 'Rs 720 / kg',
      ),
      BargainingEvent(
        id: 'e4',
        kind: BargainingEventKind.counterSeller,
        actorLabel: 'Karachi Wholesale',
        body: 'Can meet halfway if pickup is this weekend.',
        at: '2026-04-22 11:30',
        amountHighlight: 'Rs 760 / kg',
      ),
    ],
  ),
  BargainingThread(
    id: 'BR-9008',
    productTitle: 'Green cardamom · 8mm',
    counterparty: 'Multan Spices Co.',
    yourRole: BargainingPartyRole.youSell,
    status: BargainingThreadStatus.active,
    askingLine: 'Your ask: Rs 4,400 / kg',
    biddingLine: 'Their last: Rs 4,150 / kg',
    events: [
      BargainingEvent(
        id: 'e1',
        kind: BargainingEventKind.openingAsk,
        actorLabel: 'You',
        body: 'Listed firm price for 40 kg.',
        at: '2026-04-21 14:00',
        amountHighlight: 'Rs 4,400 / kg',
      ),
      BargainingEvent(
        id: 'e2',
        kind: BargainingEventKind.counterBuyer,
        actorLabel: 'Multan Spices Co.',
        body: 'Bulk order next month — need softer price.',
        at: '2026-04-21 15:40',
        amountHighlight: 'Rs 4,150 / kg',
      ),
    ],
  ),
  BargainingThread(
    id: 'BR-8991',
    productTitle: 'Premium walnuts · shelled',
    counterparty: 'Kashmir Dry Fruits',
    yourRole: BargainingPartyRole.youBuy,
    status: BargainingThreadStatus.agreed,
    askingLine: 'Agreed at: Rs 1,820 / kg',
    biddingLine: 'Lot: 200 kg',
    events: [
      BargainingEvent(
        id: 'e1',
        kind: BargainingEventKind.openingAsk,
        actorLabel: 'Kashmir Dry Fruits',
        body: 'Opening ask.',
        at: '2026-04-18 08:00',
        amountHighlight: 'Rs 1,900 / kg',
      ),
      BargainingEvent(
        id: 'e2',
        kind: BargainingEventKind.counterBuyer,
        actorLabel: 'You',
        body: 'Counter for full truck load.',
        at: '2026-04-18 09:20',
        amountHighlight: 'Rs 1,780 / kg',
      ),
      BargainingEvent(
        id: 'e3',
        kind: BargainingEventKind.accepted,
        actorLabel: 'System',
        body: 'Both parties accepted. Deal can move to contract.',
        at: '2026-04-18 10:05',
        amountHighlight: 'Rs 1,820 / kg',
      ),
    ],
  ),
  BargainingThread(
    id: 'BR-8980',
    productTitle: 'Aseel dates · bulk',
    counterparty: 'Sindh Traders',
    yourRole: BargainingPartyRole.youSell,
    status: BargainingThreadStatus.declined,
    askingLine: 'Last ask: Rs 640 / kg',
    biddingLine: 'Their last: Rs 580 / kg',
    events: [
      BargainingEvent(
        id: 'e1',
        kind: BargainingEventKind.openingAsk,
        actorLabel: 'You',
        body: 'Floor price for 120 kg.',
        at: '2026-04-10 11:00',
        amountHighlight: 'Rs 640 / kg',
      ),
      BargainingEvent(
        id: 'e2',
        kind: BargainingEventKind.counterBuyer,
        actorLabel: 'Sindh Traders',
        body: 'Cannot bridge gap this season.',
        at: '2026-04-10 16:45',
        amountHighlight: 'Rs 580 / kg',
      ),
      BargainingEvent(
        id: 'e3',
        kind: BargainingEventKind.declined,
        actorLabel: 'You',
        body: 'Negotiation closed — no deal.',
        at: '2026-04-10 17:00',
      ),
    ],
  ),
];
