abstract class TradesRepository {
  Future<Map<String, dynamic>> fetchTrades({
    required String token,
    int? page,
  });
}
