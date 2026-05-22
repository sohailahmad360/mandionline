import '../../data/app_exceptions.dart';
import '../../model/user/user_model.dart';
import 'auth_repository.dart';
import 'static_auth_config.dart';

/// Local-only login (no HTTP). Swap for [AuthHttpApiRepository] when APIs are live.
class AuthStaticRepository implements AuthRepository {
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    // Simulate brief network latency; remove or reduce when switching to real API.
    await Future<void>.delayed(const Duration(milliseconds: 450));
    final okEmail =
        email.trim().toLowerCase() == StaticAuthConfig.demoEmail.toLowerCase();
    final okPassword = password == StaticAuthConfig.demoPassword;
    if (!okEmail || !okPassword) {
      throw UnauthorizedException('Invalid email or password');
    }
    return UserModel(
      id: 'demo-user-1',
      email: StaticAuthConfig.demoEmail,
      name: 'Azhar Iqbal Awan',
      token: StaticAuthConfig.demoSessionToken,
    );
  }

  @override
  Future<void> logout() async {}
}
