import 'package:flutter/foundation.dart';

/// Home / dashboard search and lightweight shell state.
class HomeViewModel extends ChangeNotifier {
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  void setSearchQuery(String value) {
    if (_searchQuery == value) return;
    _searchQuery = value;
    notifyListeners();
  }
}
