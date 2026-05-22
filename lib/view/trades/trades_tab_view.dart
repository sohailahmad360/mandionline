import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';
import 'package:mandionline/l10n/ui_strings.dart';
import 'package:provider/provider.dart';

import '../../configs/color/app_colors.dart';
import '../../configs/components/safe_network_image.dart';
import '../../configs/demo_media_urls.dart';
import '../../data/response/status.dart';
import '../../injection/di.dart';
import '../../model/trade/trade_row.dart';
import '../../view_model/services/storage/local_storage.dart';
import '../../view_model/trades/trades_view_model.dart';
import '../widgets/trade_row_tile.dart';
import 'trade_detail_view.dart';

class TradesTabView extends StatefulWidget {
  const TradesTabView({super.key});

  @override
  State<TradesTabView> createState() => _TradesTabViewState();
}

class _TradesTabViewState extends State<TradesTabView> {
  String _filter = 'all'; // all | buying | selling

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      final vm = context.read<TradesViewModel>();
      final token = await getIt<LocalStorage>().readToken();
      if (!mounted || token == null) return;
      await vm.loadTrades(token: token, refresh: true);
    });
  }

  List<TradeRow> _filtered(List<TradeRow> rows) {
    if (_filter == 'buying') {
      return rows.where((e) => e.side == 'BUYING').toList();
    }
    if (_filter == 'selling') {
      return rows.where((e) => e.side == 'SELLING').toList();
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer<TradesViewModel>(
      builder: (context, vm, _) {
        final status = vm.tradesResponse.status;
        final rows = _filtered(vm.tradeRows);
        final browseItems = _browseCatalogEntries(l10n);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Text(
                l10n.tradesTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Text(
                l10n.tradesScreenSubtitle,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: Row(
                children: [
                  _Chip(
                    label: l10n.filterAll,
                    selected: _filter == 'all',
                    onTap: () => setState(() => _filter = 'all'),
                  ),
                  _Chip(
                    label: l10n.filterBuying,
                    selected: _filter == 'buying',
                    onTap: () => setState(() => _filter = 'buying'),
                  ),
                  _Chip(
                    label: l10n.filterSelling,
                    selected: _filter == 'selling',
                    onTap: () => setState(() => _filter = 'selling'),
                  ),
                  const Spacer(),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list, size: 18),
                    label: Text(l10n.filterButton),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: status == Status.loading && vm.tradesResponse.data == null
                  ? const Center(child: CircularProgressIndicator())
                  : status == Status.error
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              vm.tradesResponse.message ?? l10n.genericError,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : CustomScrollView(
                          slivers: [
                            SliverPadding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    if (index.isOdd) {
                                      return const SizedBox(height: 10);
                                    }
                                    final i = index ~/ 2;
                                    return _TradeCard(row: rows[i]);
                                  },
                                  childCount: rows.isEmpty
                                      ? 0
                                      : rows.length * 2 - 1,
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  20,
                                  20,
                                  20,
                                  12,
                                ),
                                child: Text(
                                  l10n.browseProducts,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                            SliverPadding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                              sliver: SliverGrid(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 0.68,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return _BrowseProductCard(
                                      item: browseItems[index],
                                    );
                                  },
                                  childCount: browseItems.length,
                                ),
                              ),
                            ),
                          ],
                        ),
            ),
          ],
        );
      },
    );
  }
}

/// Demo wholesale catalog rows for the Trades “Browse products” grid.
class _BrowseCatalogItem {
  const _BrowseCatalogItem({
    required this.origin,
    required this.name,
    required this.priceLabel,
    required this.imageUrl,
  });

  final String origin;
  final String name;
  final String priceLabel;
  final String imageUrl;
}

List<_BrowseCatalogItem> _browseCatalogEntries(AppLocalizations l10n) {
  return [
    _BrowseCatalogItem(
      origin: l10n.browseRegionPakistan,
      name: 'Dried Red Chilies',
      priceLabel: 'Rs 780',
      imageUrl: DemoMediaUrls.spice,
    ),
    _BrowseCatalogItem(
      origin: l10n.browseRegionGuatemala,
      name: 'Green Cardamom',
      priceLabel: 'Rs 4,200',
      imageUrl: DemoMediaUrls.herb,
    ),
    _BrowseCatalogItem(
      origin: l10n.browseRegionPakistan,
      name: 'Turmeric Powder',
      priceLabel: 'Rs 540',
      imageUrl: 'https://picsum.photos/seed/mandi-turmeric/800/800',
    ),
    _BrowseCatalogItem(
      origin: 'India',
      name: 'Black Pepper',
      priceLabel: 'Rs 1,850',
      imageUrl: DemoMediaUrls.nut,
    ),
    _BrowseCatalogItem(
      origin: l10n.browseRegionPakistan,
      name: 'Cumin Seeds',
      priceLabel: 'Rs 920',
      imageUrl: DemoMediaUrls.dryFruit,
    ),
    _BrowseCatalogItem(
      origin: l10n.browseRegionGuatemala,
      name: 'Dried Oregano',
      priceLabel: 'Rs 640',
      imageUrl: 'https://picsum.photos/seed/mandi-oregano/800/800',
    ),
  ];
}

class _BrowseProductCard extends StatelessWidget {
  const _BrowseProductCard({required this.item});

  final _BrowseCatalogItem item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final side = constraints.maxWidth;
                return SafeNetworkImage(
                  url: item.imageUrl,
                  width: side,
                  height: side,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.origin,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  item.priceLabel,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(
          color: selected ? Colors.white : AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: AppColors.chipInactive,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }
}

class _TradeCard extends StatelessWidget {
  const _TradeCard({required this.row});

  final TradeRow row;

  void _openDetail(BuildContext context) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => TradeDetailView(row: row),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final badge = row.side == 'SELLING'
        ? AppColors.sellingBadge
        : AppColors.buyingBadge;
    return Material(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _openDetail(context),
        child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SafeNetworkImage(
              url: row.imageUrl,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#${row.id}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: badge,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    localizedTradeSide(context, row.side),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  row.product,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                Text(
                  row.trader,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  row.date,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                row.qty,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                row.price,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              TradeStatusChip(
                rawStatus: row.status,
                displayLabel: localizedRowStatus(context, row.status),
                dense: true,
              ),
            ],
          ),
        ],
      ),
        ),
      ),
    );
  }
}
