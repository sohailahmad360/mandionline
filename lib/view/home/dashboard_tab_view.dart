import 'package:flutter/material.dart';
import 'package:mandionline/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../configs/color/app_colors.dart';
import '../../configs/routes/route_arguments.dart';
import '../../configs/routes/routes_name.dart';
import '../../configs/components/safe_network_image.dart';
import '../../configs/demo_media_urls.dart';
import '../../data/response/status.dart';
import '../../injection/di.dart';
import '../../model/trade/trade_row.dart';
import '../../view_model/home/home_view_model.dart';
import '../../view_model/services/storage/local_storage.dart';
import '../../view_model/trades/trades_view_model.dart';
import '../trades/trade_detail_view.dart';
import '../widgets/trade_row_tile.dart';

class DashboardTabView extends StatefulWidget {
  const DashboardTabView({super.key});

  @override
  State<DashboardTabView> createState() => _DashboardTabViewState();
}

class _DashboardTabViewState extends State<DashboardTabView> {
  final _search = TextEditingController();
  String? _storedProfileName;
  bool _guest = false;

  @override
  void initState() {
    super.initState();
    _hydrateProfile();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      final vm = context.read<TradesViewModel>();
      final token = await getIt<LocalStorage>().readToken();
      if (!mounted || token == null || token.isEmpty) return;
      await vm.loadTrades(token: token);
    });
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _hydrateProfile() async {
    final s = getIt<LocalStorage>();
    final g = await s.isGuestUser();
    final n = await s.readProfileName();
    if (!mounted) return;
    setState(() {
      _guest = g;
      _storedProfileName = g ? null : n;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final profileName =
        _guest ? l10n.drawerGuest : (_storedProfileName ?? l10n.demoProfileName);
    return RefreshIndicator(
      onRefresh: () async {
        final vm = context.read<TradesViewModel>();
        final token = await getIt<LocalStorage>().readToken();
        if (!mounted || token == null) return;
        await vm.loadTrades(token: token, refresh: true);
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                    child: ClipOval(
                      child: SafeNetworkImage(
                        url: DemoMediaUrls.avatar,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.greetingMorning,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          profileName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _guest
                              ? l10n.guestHomeSubtitle
                              : l10n.demoStoreSubtitle,
                          style: const TextStyle(
                            fontSize: 13,
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                  hintText: l10n.searchHintHome,
                  prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.surface,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                ),
                onChanged: (v) =>
                    context.read<HomeViewModel>().setSearchQuery(v),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.02,
              ),
              delegate: SliverChildListDelegate([
                _StatCard(
                  icon: Icons.shopping_bag_outlined,
                  iconBg: Color(0xFFE8F5E9),
                  label: l10n.dashboardStatTrades,
                  value: '24',
                ),
                _StatCard(
                  icon: Icons.handshake_outlined,
                  iconBg: Color(0xFFFFF3E0),
                  label: l10n.dashboardStatDeals,
                  value: '12',
                ),
                _StatCard(
                  icon: Icons.account_balance_wallet_outlined,
                  iconBg: Color(0xFFE8F5E9),
                  label: l10n.dashboardStatLedgers,
                  value: 'Rs 1,240,000',
                  onTap: () =>
                      Navigator.of(context).pushNamed(RoutesName.ledgers),
                ),
                _StatCard(
                  icon: Icons.trending_up,
                  iconBg: Color(0xFFFFF3E0),
                  label: l10n.dashboardStatActiveOffers,
                  value: '8',
                ),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: _sectionHeader(
              context,
              l10n.sectionTopCategories,
              onViewAll: () => Navigator.of(context).pushNamed(
                RoutesName.dashboardListDetail,
                arguments: const DashboardListDetailArgs(
                  kind: DashboardListKind.categories,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _CategoryCard(
                    title: l10n.categorySpices,
                    count: l10n.itemsCount(142),
                    image: DemoMediaUrls.spice,
                  ),
                  const SizedBox(width: 12),
                  _CategoryCard(
                    title: l10n.categoryDryFruits,
                    count: l10n.itemsCount(89),
                    image: DemoMediaUrls.dryFruit,
                  ),
                  const SizedBox(width: 12),
                  _CategoryCard(
                    title: l10n.categoryNuts,
                    count: l10n.itemsCount(56),
                    image: DemoMediaUrls.nut,
                  ),
                  const SizedBox(width: 12),
                  _CategoryCard(
                    title: l10n.categoryHerbs,
                    count: l10n.itemsCount(33),
                    image: DemoMediaUrls.herb,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _sectionHeader(
              context,
              l10n.sectionLiveOffers,
              onViewAll: () => Navigator.of(context).pushNamed(
                RoutesName.dashboardListDetail,
                arguments: const DashboardListDetailArgs(
                  kind: DashboardListKind.offers,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 320,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                children: [
                  _OfferCard(
                    rating: '4.8',
                    category: l10n.offerCategoryPakistan,
                    title: l10n.productDriedRedChilies,
                    price: 'Rs 780',
                    unit: l10n.unitPerKg,
                    image: DemoMediaUrls.spice,
                  ),
                  const SizedBox(width: 12),
                  _OfferCard(
                    rating: '4.9',
                    category: l10n.offerCategoryGuatemala,
                    title: l10n.productGreenCardamom,
                    price: 'Rs 4,200',
                    unit: l10n.unitPerKg,
                    image: DemoMediaUrls.offerSecondary,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _sectionHeader(
              context,
              l10n.sectionRecentTrades,
              onViewAll: () {
                final rows = List<TradeRow>.from(
                  context.read<TradesViewModel>().tradeRows,
                );
                Navigator.of(context).pushNamed(
                  RoutesName.dashboardListDetail,
                  arguments: DashboardListDetailArgs(
                    kind: DashboardListKind.trades,
                    tradeRowsSnapshot: rows,
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Consumer<TradesViewModel>(
              builder: (context, tradesVm, _) {
                final status = tradesVm.tradesResponse.status;
                if (status == Status.loading &&
                    tradesVm.tradesResponse.data == null) {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (status == Status.error) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      tradesVm.tradesResponse.message ??
                          l10n.tradeLoadError,
                      style: const TextStyle(color: AppColors.error),
                    ),
                  );
                }
                final rows = tradesVm.tradeRows;
                if (rows.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(l10n.noTradesYet),
                  );
                }
                final slice = rows.length > 4 ? rows.sublist(0, 4) : rows;
                return Column(
                  children: [
                    for (final t in slice)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: TradeRowTile(
                          row: t,
                          onTap: () {
                            Navigator.of(context).push<void>(
                              MaterialPageRoute<void>(
                                builder: (_) => TradeDetailView(row: t),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _sectionHeader(
    BuildContext context,
    String title, {
    required VoidCallback onViewAll,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: onViewAll,
            child: Text(
              l10n.viewAll,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconBg,
    required this.label,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final Color iconBg;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: iconBg,
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );

    final decorated = Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );

    if (onTap == null) return decorated;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: decorated,
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.title,
    required this.count,
    required this.image,
  });

  final String title;
  final String count;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          SafeNetworkImage(
            url: image,
            width: 160,
            height: 140,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.65),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  count,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12,
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

class _OfferCard extends StatelessWidget {
  const _OfferCard({
    required this.rating,
    required this.category,
    required this.title,
    required this.price,
    required this.unit,
    required this.image,
  });

  final String rating;
  final String category;
  final String title;
  final String price;
  final String unit;
  final String image;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      width: 260,
      child: Card(
        elevation: 2,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SafeNetworkImage(
                  url: image,
                  height: 138,
                  width: 260,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.ratingBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.black87),
                        const SizedBox(width: 4),
                        Text(
                          rating,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.priceLabel,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: price,
                                    style: const TextStyle(
                                      fontSize: 17,
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
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.surfaceMuted,
                        child: Icon(
                          Icons.north_east,
                          color: AppColors.primary.withValues(alpha: 0.9),
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

