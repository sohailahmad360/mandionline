import 'package:flutter/foundation.dart';

import '../../data/demo_favorites_catalog.dart';
import '../../model/favorites/favorite_models.dart';

class FavoritesViewModel extends ChangeNotifier {
  FavoritesViewModel() {
    _items = cloneDemoFavorites();
  }

  late List<FavoriteItem> _items;
  FavoriteListFilter _filter = FavoriteListFilter.all;
  String _searchQuery = '';
  FavoriteItem? _selected;

  List<FavoriteItem> get allItems => List.unmodifiable(_items);

  FavoriteListFilter get filter => _filter;

  String get searchQuery => _searchQuery;

  FavoriteItem? get selectedItem => _selected;

  List<FavoriteItem> get filteredItems {
    Iterable<FavoriteItem> rows = _items;

    switch (_filter) {
      case FavoriteListFilter.all:
        break;
      case FavoriteListFilter.liveOffers:
        rows = rows.where((f) => f.kind == FavoriteKind.liveOffer);
        break;
      case FavoriteListFilter.traders:
        rows = rows.where((f) => f.kind == FavoriteKind.traderProfile);
        break;
      case FavoriteListFilter.trades:
        rows = rows.where((f) => f.kind == FavoriteKind.tradeListing);
        break;
    }

    final q = _searchQuery.trim().toLowerCase();
    if (q.isNotEmpty) {
      rows = rows.where((f) {
        if (f.title.toLowerCase().contains(q)) return true;
        if (f.subtitle.toLowerCase().contains(q)) return true;
        final p = f.priceLine;
        return p != null && p.toLowerCase().contains(q);
      });
    }

    return rows.toList();
  }

  void setFilter(FavoriteListFilter f) {
    if (_filter == f) return;
    _filter = f;
    notifyListeners();
  }

  void setSearchQuery(String q) {
    if (_searchQuery == q) return;
    _searchQuery = q;
    notifyListeners();
  }

  void openItem(FavoriteItem item) {
    _selected = _items.firstWhere((e) => e.id == item.id);
    notifyListeners();
  }

  void closeDetail() {
    _selected = null;
    notifyListeners();
  }

  /// Permanently removes from this session’s list (demo; not persisted).
  void removeFavorite(String id) {
    _items.removeWhere((e) => e.id == id);
    if (_selected?.id == id) {
      _selected = null;
    }
    notifyListeners();
  }
}
