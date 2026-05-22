/// Negotiation thread lifecycle (demo).
enum BargainingThreadStatus {
  active,
  agreed,
  declined,
}

/// Current user’s side in the negotiation (for counters & copy).
enum BargainingPartyRole {
  youBuy,
  youSell,
}

/// Single timeline row in a bargaining thread.
enum BargainingEventKind {
  /// Seller’s opening ask.
  openingAsk,
  /// Buyer counter.
  counterBuyer,
  /// Seller counter.
  counterSeller,
  accepted,
  declined,
  /// System / info line.
  system,
}

class BargainingEvent {
  const BargainingEvent({
    required this.id,
    required this.kind,
    required this.actorLabel,
    required this.body,
    required this.at,
    this.amountHighlight,
  });

  final String id;
  final BargainingEventKind kind;
  final String actorLabel;
  final String body;
  final String at;

  /// Optional short price line shown as emphasis (e.g. "Rs 720 / kg").
  final String? amountHighlight;

  BargainingEvent copyWith({
    String? id,
    BargainingEventKind? kind,
    String? actorLabel,
    String? body,
    String? at,
    String? amountHighlight,
  }) {
    return BargainingEvent(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      actorLabel: actorLabel ?? this.actorLabel,
      body: body ?? this.body,
      at: at ?? this.at,
      amountHighlight: amountHighlight ?? this.amountHighlight,
    );
  }
}

class BargainingThread {
  const BargainingThread({
    required this.id,
    required this.productTitle,
    required this.counterparty,
    required this.yourRole,
    required this.status,
    required this.askingLine,
    required this.biddingLine,
    required this.events,
  });

  final String id;
  final String productTitle;
  final String counterparty;
  final BargainingPartyRole yourRole;
  final BargainingThreadStatus status;
  final String askingLine;
  final String biddingLine;
  final List<BargainingEvent> events;

  BargainingThread copyWith({
    String? id,
    String? productTitle,
    String? counterparty,
    BargainingPartyRole? yourRole,
    BargainingThreadStatus? status,
    String? askingLine,
    String? biddingLine,
    List<BargainingEvent>? events,
  }) {
    return BargainingThread(
      id: id ?? this.id,
      productTitle: productTitle ?? this.productTitle,
      counterparty: counterparty ?? this.counterparty,
      yourRole: yourRole ?? this.yourRole,
      status: status ?? this.status,
      askingLine: askingLine ?? this.askingLine,
      biddingLine: biddingLine ?? this.biddingLine,
      events: events ?? List<BargainingEvent>.from(this.events),
    );
  }
}

/// List filter chips on the bargaining home screen.
enum BargainingListFilter {
  all,
  active,
  agreed,
  declined,
}
