import 'package:flutter/foundation.dart';

/// Bottom navigation index for [MainShellView].
class ShellViewModel extends ChangeNotifier {
  int _index = 0;
  int get currentIndex => _index;

  /// Selects a bottom-nav tab (0–3). Use [allowReselect] to notify even when
  /// [i] is already selected (e.g. after publishing a trade while on Trades).
  void setIndex(int i, {bool allowReselect = false}) {
    if (i < 0 || i > 3) return;
    if (i == _index && !allowReselect) return;
    _index = i;
    notifyListeners();
  }
}
