/// What kind of entity the user saved.
enum FavoriteKind {
  /// A live offer / listing on the board.
  liveOffer,

  /// A counterparty or store profile.
  traderProfile,

  /// A trade row the user is watching.
  tradeListing,
}

/// One saved favorite (demo / in-memory until APIs exist).
class FavoriteItem {
  const FavoriteItem({
    required this.id,
    required this.kind,
    required this.title,
    required this.subtitle,
    this.priceLine,
    required this.savedAtLabel,
    required this.imageUrl,
  });

  final String id;
  final FavoriteKind kind;
  final String title;
  final String subtitle;

  /// Optional e.g. "Rs 720 / kg".
  final String? priceLine;
  final String savedAtLabel;
  final String imageUrl;

  FavoriteItem copyWith({
    String? id,
    FavoriteKind? kind,
    String? title,
    String? subtitle,
    String? priceLine,
    String? savedAtLabel,
    String? imageUrl,
  }) {
    return FavoriteItem(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      priceLine: priceLine ?? this.priceLine,
      savedAtLabel: savedAtLabel ?? this.savedAtLabel,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

/// Chips on the favorites home screen.
enum FavoriteListFilter {
  all,
  liveOffers,
  traders,
  trades,
}
