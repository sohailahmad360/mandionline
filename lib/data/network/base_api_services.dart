/// HTTP contract for the shared network layer. Feature repositories depend on this abstraction.
abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);

  Future<dynamic> getGetApiResponseWithAuth(String url, String token);

  Future<dynamic> getPostApiResponse(String url, dynamic body);

  Future<dynamic> getPostApiResponseWithAuth(
    String url,
    dynamic body,
    String token,
  );

  Future<dynamic> putApiResponseWithAuth(
    String url,
    dynamic body,
    String token,
  );

  Future<dynamic> deleteApiResponseWithAuth(String url, String token);
}
