import '../../configs/app_url.dart';
import '../../data/app_exceptions.dart';
import '../../data/network/base_api_services.dart';
import '../../model/user/user_model.dart';
import 'auth_repository.dart';

class AuthHttpApiRepository implements AuthRepository {
  AuthHttpApiRepository({required BaseApiServices api}) : _api = api;

  final BaseApiServices _api;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final dynamic raw = await _api.getPostApiResponse(
      AppUrl.login,
      <String, dynamic>{
        'email': email,
        'password': password,
      },
    );
    if (raw is! Map<String, dynamic>) {
      throw FetchDataException('Unexpected login response');
    }
    final user = UserModel.fromJson(raw);
    if (user.token == null || user.token!.isEmpty) {
      throw FetchDataException('Missing token in response');
    }
    return user;
  }

  @override
  Future<void> logout() async {
    // Optional: call revoke endpoint with token when session layer supplies it.
  }
}
