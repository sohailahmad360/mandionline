import 'package:mandionline/l10n/app_localizations.dart';

import '../configs/demo_media_urls.dart';

/// Home “Top categories” rows (counts + images). Titles come from l10n via [id].
enum DemoCategoryId {
  spices,
  dryFruits,
  nuts,
  herbs,
}

class DemoCategoryRow {
  const DemoCategoryRow({
    required this.id,
    required this.itemCount,
    required this.imageUrl,
  });

  final DemoCategoryId id;
  final int itemCount;
  final String imageUrl;
}

String demoCategoryTitle(AppLocalizations l10n, DemoCategoryId id) {
  switch (id) {
    case DemoCategoryId.spices:
      return l10n.categorySpices;
    case DemoCategoryId.dryFruits:
      return l10n.categoryDryFruits;
    case DemoCategoryId.nuts:
      return l10n.categoryNuts;
    case DemoCategoryId.herbs:
      return l10n.categoryHerbs;
  }
}

List<DemoCategoryRow> demoCategoryRows() => const [
      DemoCategoryRow(
        id: DemoCategoryId.spices,
        itemCount: 142,
        imageUrl: DemoMediaUrls.spice,
      ),
      DemoCategoryRow(
        id: DemoCategoryId.dryFruits,
        itemCount: 89,
        imageUrl: DemoMediaUrls.dryFruit,
      ),
      DemoCategoryRow(
        id: DemoCategoryId.nuts,
        itemCount: 56,
        imageUrl: DemoMediaUrls.nut,
      ),
      DemoCategoryRow(
        id: DemoCategoryId.herbs,
        itemCount: 33,
        imageUrl: DemoMediaUrls.herb,
      ),
    ];

/// Offer “category” line under product title (localized).
enum DemoOfferRegion {
  pakistan,
  guatemala,
  india,
}

class DemoOfferRow {
  const DemoOfferRow({
    required this.rating,
    required this.region,
    required this.productTitle,
    required this.price,
    required this.imageUrl,
  });

  final String rating;
  final DemoOfferRegion region;
  final String productTitle;
  final String price;
  final String imageUrl;
}

String demoOfferRegionLabel(AppLocalizations l10n, DemoOfferRegion r) {
  switch (r) {
    case DemoOfferRegion.pakistan:
      return l10n.offerCategoryPakistan;
    case DemoOfferRegion.guatemala:
      return l10n.offerCategoryGuatemala;
    case DemoOfferRegion.india:
      return l10n.offerCategoryIndia;
  }
}

List<DemoOfferRow> demoOfferRows(AppLocalizations l10n) => [
      DemoOfferRow(
        rating: '4.8',
        region: DemoOfferRegion.pakistan,
        productTitle: l10n.productDriedRedChilies,
        price: 'Rs 780',
        imageUrl: DemoMediaUrls.spice,
      ),
      DemoOfferRow(
        rating: '4.9',
        region: DemoOfferRegion.guatemala,
        productTitle: l10n.productGreenCardamom,
        price: 'Rs 4,200',
        imageUrl: DemoMediaUrls.offerSecondary,
      ),
      DemoOfferRow(
        rating: '4.7',
        region: DemoOfferRegion.india,
        productTitle: l10n.productTurmericPowder,
        price: 'Rs 420',
        imageUrl: DemoMediaUrls.spice,
      ),
      DemoOfferRow(
        rating: '4.6',
        region: DemoOfferRegion.pakistan,
        productTitle: l10n.productBlackPepper,
        price: 'Rs 1,850',
        imageUrl: DemoMediaUrls.nut,
      ),
      DemoOfferRow(
        rating: '4.85',
        region: DemoOfferRegion.india,
        productTitle: l10n.productCinnamonSticks,
        price: 'Rs 2,100',
        imageUrl: DemoMediaUrls.dryFruit,
      ),
      DemoOfferRow(
        rating: '4.75',
        region: DemoOfferRegion.guatemala,
        productTitle: l10n.productClovesWhole,
        price: 'Rs 3,400',
        imageUrl: DemoMediaUrls.herb,
      ),
    ];

/// Demo rows for order history (product titles stay English for mock SKUs).
class OrderHistoryEntry {
  const OrderHistoryEntry({
    required this.id,
    required this.placedAt,
    required this.productTitle,
    required this.total,
    required this.statusRaw,
  });

  final String id;
  final String placedAt;
  final String productTitle;
  final String total;

  /// API-style: `delivered` | `processing` | `cancelled`
  final String statusRaw;
}

List<OrderHistoryEntry> demoOrderHistory() => const [
      OrderHistoryEntry(
        id: 'ORD-24089',
        placedAt: '2026-04-20',
        productTitle: 'Dried red chilies · 500 kg',
        total: 'Rs 390,000',
        statusRaw: 'delivered',
      ),
      OrderHistoryEntry(
        id: 'ORD-24012',
        placedAt: '2026-04-08',
        productTitle: 'Green cardamom · 40 kg',
        total: 'Rs 168,000',
        statusRaw: 'processing',
      ),
      OrderHistoryEntry(
        id: 'ORD-23901',
        placedAt: '2026-03-28',
        productTitle: 'Premium walnuts · 200 kg',
        total: 'Rs 370,000',
        statusRaw: 'delivered',
      ),
      OrderHistoryEntry(
        id: 'ORD-23844',
        placedAt: '2026-03-15',
        productTitle: 'Aseel dates · 120 kg',
        total: 'Rs 74,400',
        statusRaw: 'cancelled',
      ),
    ];
