import 'package:flutter/foundation.dart';

import '../../data/app_exceptions.dart';
import '../../data/response/api_response.dart';
import '../../repository/auth_api/auth_repository.dart';
import '../services/storage/local_storage.dart';

class LoginViewModel extends ChangeNotifier {
  /// Sentinel stored in [loginState.message] when email/password do not match the demo account.
  static const invalidCredentialsFormMessage = 'LOGIN_INVALID_CREDENTIALS';

  LoginViewModel({
    required AuthRepository authRepository,
    required LocalStorage localStorage,
  })  : _authRepository = authRepository,
        _localStorage = localStorage;

  final AuthRepository _authRepository;
  final LocalStorage _localStorage;

  final ApiResponse<void> loginState = ApiResponse<void>();

  Future<void> submit({
    required String email,
    required String password,
  }) async {
    loginState.setLoading();
    notifyListeners();
    try {
      final user = await _authRepository.login(
        email: email,
        password: password,
      );
      final token = user.token;
      if (token != null) {
        await _localStorage.clearGuestFlag();
        await _localStorage.writeToken(token);
        final name = user.name;
        if (name != null && name.isNotEmpty) {
          await _localStorage.writeProfileName(name);
        }
      }
      loginState.setCompleted(null);
    } on UnauthorizedException {
      // [LoginView] maps this to a localized message.
      loginState.setError(LoginViewModel.invalidCredentialsFormMessage);
    } on AppException catch (e) {
      loginState.setError(e.toString());
    } catch (e) {
      loginState.setError(e.toString());
    }
    notifyListeners();
  }

  Future<void> loginAsGuest() async {
    loginState.setLoading();
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 200));
    try {
      await _localStorage.setGuestSession();
      loginState.setCompleted(null);
    } catch (e) {
      loginState.setError(e.toString());
    }
    notifyListeners();
  }
}
