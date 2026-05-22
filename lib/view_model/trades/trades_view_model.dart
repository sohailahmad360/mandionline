import 'package:flutter/foundation.dart';

import '../../data/app_exceptions.dart';
import '../../data/response/api_response.dart';
import '../../data/response/status.dart';
import '../../configs/demo_media_urls.dart';
import '../../model/trade/trade_row.dart';
import '../../repository/auth_api/static_auth_config.dart';
import '../../repository/trades_api/trades_repository.dart';

class TradesViewModel with ChangeNotifier {
  TradesViewModel({required TradesRepository tradesRepository})
      : _tradesRepository = tradesRepository;

  final TradesRepository _tradesRepository;

  final ApiResponse<Map<String, dynamic>> tradesResponse =
      ApiResponse<Map<String, dynamic>>();

  int _page = 1;
  int get page => _page;

  bool _hasNextPage = true;
  bool get hasNextPage => _hasNextPage;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  /// Trades created in-session from the FAB form; prepended in [tradeRows].
  final List<Map<String, dynamic>> _userCreatedTradeMaps = [];

  /// Demo catalog for guest / offline UI.
  static final List<Map<String, dynamic>> guestTradeMaps = [
    {
      'id': '4587',
      'side': 'SELLING',
      'product': 'Dried Red Chilies',
      'trader': 'Karachi Wholesale',
      'qty': '500 kg',
      'price': 'Rs 390,000',
      'status': 'Active',
      'date': '2026-04-22',
      'img': DemoMediaUrls.tradeThumbA,
    },
    {
      'id': '4563',
      'side': 'BUYING',
      'product': 'Premium Walnuts',
      'trader': 'Kashmir Dry Fruits',
      'qty': '200 kg',
      'price': 'Rs 370,000',
      'status': 'Pending',
      'date': '2026-04-20',
      'img': DemoMediaUrls.tradeThumbB,
    },
    {
      'id': '4521',
      'side': 'SELLING',
      'product': 'Aseel Dates',
      'trader': 'Sindh Traders',
      'qty': '120 kg',
      'price': 'Rs 74,400',
      'status': 'Completed',
      'date': '2026-04-18',
      'img': DemoMediaUrls.tradeThumbC,
    },
    {
      'id': '4500',
      'side': 'BUYING',
      'product': 'Green Cardamom',
      'trader': 'Lahore Imports',
      'qty': '40 kg',
      'price': 'Rs 168,000',
      'status': 'Active',
      'date': '2026-04-15',
      'img': DemoMediaUrls.tradeThumbD,
    },
    {
      'id': '4488',
      'side': 'SELLING',
      'product': 'Turmeric powder',
      'trader': 'Multan Spices',
      'qty': '2 tons',
      'price': 'Rs 840,000',
      'status': 'Pending',
      'date': '2026-04-12',
      'img': DemoMediaUrls.spice,
    },
    {
      'id': '4471',
      'side': 'BUYING',
      'product': 'Black pepper whole',
      'trader': 'Gujranwala Traders',
      'qty': '150 kg',
      'price': 'Rs 277,500',
      'status': 'Active',
      'date': '2026-04-10',
      'img': DemoMediaUrls.nut,
    },
    {
      'id': '4455',
      'side': 'SELLING',
      'product': 'Cinnamon sticks',
      'trader': 'Quetta Dry Goods',
      'qty': '80 kg',
      'price': 'Rs 168,000',
      'status': 'Completed',
      'date': '2026-04-05',
      'img': DemoMediaUrls.dryFruit,
    },
    {
      'id': '4440',
      'side': 'BUYING',
      'product': 'Cloves (whole)',
      'trader': 'Islamabad Imports',
      'qty': '25 kg',
      'price': 'Rs 85,000',
      'status': 'Pending',
      'date': '2026-04-02',
      'img': DemoMediaUrls.herb,
    },
  ];

  List<TradeRow> get tradeRows {
    final remote = _tradeRowsFromResponseOnly();
    final local = _userCreatedTradeMaps
        .map((e) => TradeRow.fromMap(Map<String, dynamic>.from(e)))
        .toList();
    return [...local, ...remote];
  }

  List<TradeRow> _tradeRowsFromResponseOnly() {
    final data = tradesResponse.data;
    if (data == null) return [];
    final raw = data['items'] ?? data['data'] ?? data['trades'];
    if (raw is List) {
      return raw
          .whereType<Map>()
          .map((e) => TradeRow.fromMap(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }

  /// Adds a trade created from the UI (prepended to lists until the next API refresh clears locals).
  void addUserTrade(TradeRow row) {
    _userCreatedTradeMaps.insert(0, row.toMap());
    notifyListeners();
  }

  Future<void> loadTrades({
    required String token,
    bool refresh = false,
  }) async {
    if (token == 'guest' || token == StaticAuthConfig.demoSessionToken) {
      if (refresh) {
        _page = 1;
        _hasNextPage = false;
      }
      tradesResponse.setLoading();
      notifyListeners();
      await Future<void>.delayed(const Duration(milliseconds: 150));
      tradesResponse.setCompleted({'items': guestTradeMaps});
      notifyListeners();
      return;
    }

    if (refresh) {
      _page = 1;
      _hasNextPage = true;
    }
    tradesResponse.setLoading();
    notifyListeners();
    try {
      if (refresh) {
        _userCreatedTradeMaps.clear();
      }
      final data = await _tradesRepository.fetchTrades(
        token: token,
        page: _page,
      );
      tradesResponse.setCompleted(data);
    } on AppException catch (e) {
      tradesResponse.setError(e.toString());
    } catch (e) {
      tradesResponse.setError(e.toString());
    }
    notifyListeners();
  }

  Future<void> loadMore(String token) async {
    if (token == 'guest' || token == StaticAuthConfig.demoSessionToken) {
      return;
    }
    if (!_hasNextPage || _loadingMore) return;
    if (tradesResponse.status != Status.completed) return;
    _loadingMore = true;
    notifyListeners();
    try {
      _page += 1;
      final data = await _tradesRepository.fetchTrades(
        token: token,
        page: _page,
      );
      tradesResponse.setCompleted(data);
      final list = data['data'] ?? data['items'];
      if (list is List && list.isEmpty) {
        _hasNextPage = false;
        _page -= 1;
      }
    } on AppException catch (e) {
      _page -= 1;
      tradesResponse.setError(e.toString());
    } catch (e) {
      _page -= 1;
      tradesResponse.setError(e.toString());
    }
    _loadingMore = false;
    notifyListeners();
  }
}
