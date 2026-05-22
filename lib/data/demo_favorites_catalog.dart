import '../configs/demo_media_urls.dart';
import '../model/favorites/favorite_models.dart';

List<FavoriteItem> cloneDemoFavorites() {
  return _seeds.map(_clone).toList();
}

FavoriteItem _clone(FavoriteItem f) {
  return FavoriteItem(
    id: f.id,
    kind: f.kind,
    title: f.title,
    subtitle: f.subtitle,
    priceLine: f.priceLine,
    savedAtLabel: f.savedAtLabel,
    imageUrl: f.imageUrl,
  );
}

final List<FavoriteItem> _seeds = [
  FavoriteItem(
    id: 'fv-501',
    kind: FavoriteKind.liveOffer,
    title: 'Dried red chilies · Grade A',
    subtitle: 'Karachi Wholesale · Pakistan',
    priceLine: 'Rs 800 / kg · 500 kg lot',
    savedAtLabel: '2026-04-22',
    imageUrl: DemoMediaUrls.spice,
  ),
  FavoriteItem(
    id: 'fv-502',
    kind: FavoriteKind.liveOffer,
    title: 'Green cardamom · 8mm',
    subtitle: 'Multan Spices Co.',
    priceLine: 'Rs 4,400 / kg',
    savedAtLabel: '2026-04-21',
    imageUrl: DemoMediaUrls.herb,
  ),
  FavoriteItem(
    id: 'fv-410',
    kind: FavoriteKind.traderProfile,
    title: 'Lahore Dry Fruit House',
    subtitle: 'Verified store · Lahore',
    priceLine: null,
    savedAtLabel: '2026-04-18',
    imageUrl: DemoMediaUrls.avatar,
  ),
  FavoriteItem(
    id: 'fv-411',
    kind: FavoriteKind.traderProfile,
    title: 'Kashmir Dry Fruits',
    subtitle: 'Seller · bulk walnuts',
    priceLine: null,
    savedAtLabel: '2026-04-10',
    imageUrl: DemoMediaUrls.dryFruit,
  ),
  FavoriteItem(
    id: 'fv-305',
    kind: FavoriteKind.tradeListing,
    title: 'SELLING · Black pepper (whole)',
    subtitle: 'You posted · Active',
    priceLine: 'Rs 1,120 / kg',
    savedAtLabel: '2026-04-15',
    imageUrl: DemoMediaUrls.nut,
  ),
  FavoriteItem(
    id: 'fv-306',
    kind: FavoriteKind.tradeListing,
    title: 'BUYING · Cinnamon sticks',
    subtitle: 'Watching price · Guatemala origin',
    priceLine: 'Target ≤ Rs 980 / kg',
    savedAtLabel: '2026-04-08',
    imageUrl: DemoMediaUrls.herb,
  ),
];
