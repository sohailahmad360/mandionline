import '../../../configs/app_globals.dart';
import '../../../configs/routes/routes_name.dart';
import '../storage/local_storage.dart';

/// Clears secure session and resets navigation to login (logout flow).
class SessionManager {
  SessionManager({required LocalStorage localStorage})
      : _localStorage = localStorage;

  final LocalStorage _localStorage;

  Future<void> logout() async {
    await _localStorage.clearSession();
    final nav = appNavigatorKey.currentState;
    nav?.pushNamedAndRemoveUntil(RoutesName.login, (route) => false);
  }
}
