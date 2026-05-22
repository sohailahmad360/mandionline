import 'package:flutter/foundation.dart';

import '../services/storage/local_storage.dart';

class SplashViewModel extends ChangeNotifier {
  SplashViewModel({
    required LocalStorage localStorage,
  }) : _localStorage = localStorage;

  final LocalStorage _localStorage;

  bool _ready = false;
  bool get ready => _ready;

  String? _token;
  String? get cachedToken => _token;

  Future<void> bootstrap() async {
    _token = await _localStorage.readToken();
    _ready = true;
    notifyListeners();
  }

  bool get hasSession => (_token ?? '').isNotEmpty;
}
