import '../../model/trade/trade_row.dart';

/// Which home “View all” list to show on [DashboardListDetailView].
enum DashboardListKind {
  categories,
  offers,
  trades,
}

/// Arguments for [RoutesName.dashboardListDetail].
class DashboardListDetailArgs {
  const DashboardListDetailArgs({
    required this.kind,
    this.tradeRowsSnapshot,
  });

  final DashboardListKind kind;

  /// Required when [kind] is [DashboardListKind.trades]; captured at navigation time.
  final List<TradeRow>? tradeRowsSnapshot;
}

/// Title for [ModulePlaceholderView] (drawer modules without a tab yet).
class ModulePlaceholderArgs {
  const ModulePlaceholderArgs({required this.title});

  final String title;
}
