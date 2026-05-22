import 'package:flutter/material.dart';

/// Toggles app [Locale] (English / Urdu) from the shell app bar pill.
class LocaleController extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void toggleUrdu() {
    _locale = _locale.languageCode == 'ur'
        ? const Locale('en')
        : const Locale('ur');
    notifyListeners();
  }
}
