import '../../configs/app_url.dart';
import '../../data/app_exceptions.dart';
import '../../data/network/base_api_services.dart';
import 'trades_repository.dart';

class TradesHttpApiRepository implements TradesRepository {
  TradesHttpApiRepository({required BaseApiServices api}) : _api = api;

  final BaseApiServices _api;

  @override
  Future<Map<String, dynamic>> fetchTrades({
    required String token,
    int? page,
  }) async {
    final url = AppUrl.tradesPage(page ?? 1);
    final dynamic raw =
        await _api.getGetApiResponseWithAuth(url, token);
    if (raw is Map<String, dynamic>) return raw;
    throw FetchDataException('Unexpected trades response');
  }
}
