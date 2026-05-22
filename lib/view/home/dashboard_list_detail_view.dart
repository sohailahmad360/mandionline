import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';

import '../../configs/color/app_colors.dart';
import '../../configs/components/safe_network_image.dart';
import '../../configs/routes/route_arguments.dart';
import '../../data/home_catalog_demo.dart';
import '../../model/trade/trade_row.dart';
import '../trades/trade_detail_view.dart';
import '../widgets/trade_row_tile.dart';

/// Full-screen list opened from home “View all”.
class DashboardListDetailView extends StatelessWidget {
  const DashboardListDetailView({
    super.key,
    required this.kind,
    this.tradeRowsSnapshot,
  });

  final DashboardListKind kind;
  final List<TradeRow>? tradeRowsSnapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final title = switch (kind) {
      DashboardListKind.categories => l10n.sectionTopCategories,
      DashboardListKind.offers => l10n.sectionLiveOffers,
      DashboardListKind.trades => l10n.sectionRecentTrades,
    };
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: switch (kind) {
        DashboardListKind.categories => _CategoriesListBody(l10n: l10n),
        DashboardListKind.offers => _OffersListBody(l10n: l10n),
        DashboardListKind.trades => _TradesListBody(
            l10n: l10n,
            rows: tradeRowsSnapshot ?? const <TradeRow>[],
          ),
      },
    );
  }
}

class _CategoriesListBody extends StatelessWidget {
  const _CategoriesListBody({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final rows = demoCategoryRows();
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      itemCount: rows.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final r = rows[i];
        final title = demoCategoryTitle(l10n, r.id);
        final count = l10n.itemsCount(r.itemCount);
        final w = MediaQuery.sizeOf(context).width - 32;
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 120,
            child: Stack(
              fit: StackFit.expand,
              children: [
                SafeNetworkImage(
                  url: r.imageUrl,
                  width: w,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.black.withValues(alpha: 0.55),
                          Colors.black.withValues(alpha: 0.25),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        count,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OffersListBody extends StatelessWidget {
  const _OffersListBody({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final offers = demoOfferRows(l10n);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        Text(
          l10n.listDetailOffersSubtitle,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        for (final o in offers) ...[
          _OfferListCard(
            rating: o.rating,
            category: demoOfferRegionLabel(l10n, o.region),
            title: o.productTitle,
            price: o.price,
            unit: l10n.unitPerKg,
            image: o.imageUrl,
            priceLabel: l10n.priceLabel,
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _OfferListCard extends StatelessWidget {
  const _OfferListCard({
    required this.rating,
    required this.category,
    required this.title,
    required this.price,
    required this.unit,
    required this.image,
    required this.priceLabel,
  });

  final String rating;
  final String category;
  final String title;
  final String price;
  final String unit;
  final String image;
  final String priceLabel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 112,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  SafeNetworkImage(
                    url: image,
                    width: 112,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.ratingBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, size: 12, color: Colors.black87),
                          const SizedBox(width: 2),
                          Text(
                            rating,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      priceLabel,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: price,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                          TextSpan(
                            text: ' $unit',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TradesListBody extends StatelessWidget {
  const _TradesListBody({
    required this.l10n,
    required this.rows,
  });

  final AppLocalizations l10n;
  final List<TradeRow> rows;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            l10n.noTradesYet,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      itemCount: rows.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final row = rows[i];
        return TradeRowTile(
          row: row,
          onTap: () {
            Navigator.of(context).push<void>(
              MaterialPageRoute<void>(
                builder: (_) => TradeDetailView(row: row),
              ),
            );
          },
        );
      },
    );
  }
}
