import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../app_exceptions.dart';
import 'base_api_services.dart';

/// Concrete HTTP client: JSON headers, timeouts, unified [returnResponse].
class NetworkApiService implements BaseApiServices {
  NetworkApiService({http.Client? client}) : _client = client ?? http.Client();

  static const Duration _timeout = Duration(seconds: 30);

  final http.Client _client;

  Map<String, String> get _jsonHeaders => {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      };

  Map<String, String> _authHeaders(String token) => {
        ..._jsonHeaders,
        'Authorization': 'Bearer $token',
      };

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        final body = response.body;
        if (body.isEmpty) return <String, dynamic>{};
        final decoded = jsonDecode(body);
        return decoded;
      case 400:
        throw BadRequestException(response.body);
      case 401:
      case 403:
        throw UnauthorizedException(response.body);
      case 404:
        throw NotFoundException(response.body);
      default:
        throw FetchDataException(
          'Status ${response.statusCode}: ${response.body}',
        );
    }
  }

  @override
  Future<dynamic> getGetApiResponse(String url) async {
    try {
      final res = await _client
          .get(Uri.parse(url), headers: _jsonHeaders)
          .timeout(_timeout);
      return returnResponse(res);
    } on SocketException {
      throw NoInternetException();
    } on http.ClientException {
      throw NoInternetException();
    }
  }

  @override
  Future<dynamic> getGetApiResponseWithAuth(String url, String token) async {
    try {
      final res = await _client
          .get(Uri.parse(url), headers: _authHeaders(token))
          .timeout(_timeout);
      return returnResponse(res);
    } on SocketException {
      throw NoInternetException();
    } on http.ClientException {
      throw NoInternetException();
    }
  }

  @override
  Future<dynamic> getPostApiResponse(String url, dynamic body) async {
    try {
      final res = await _client
          .post(
            Uri.parse(url),
            headers: _jsonHeaders,
            body: jsonEncode(body),
          )
          .timeout(_timeout);
      return returnResponse(res);
    } on SocketException {
      throw NoInternetException();
    } on http.ClientException {
      throw NoInternetException();
    }
  }

  @override
  Future<dynamic> getPostApiResponseWithAuth(
    String url,
    dynamic body,
    String token,
  ) async {
    try {
      final res = await _client
          .post(
            Uri.parse(url),
            headers: _authHeaders(token),
            body: jsonEncode(body),
          )
          .timeout(_timeout);
      return returnResponse(res);
    } on SocketException {
      throw NoInternetException();
    } on http.ClientException {
      throw NoInternetException();
    }
  }

  @override
  Future<dynamic> putApiResponseWithAuth(
    String url,
    dynamic body,
    String token,
  ) async {
    try {
      final res = await _client
          .put(
            Uri.parse(url),
            headers: _authHeaders(token),
            body: jsonEncode(body),
          )
          .timeout(_timeout);
      return returnResponse(res);
    } on SocketException {
      throw NoInternetException();
    } on http.ClientException {
      throw NoInternetException();
    }
  }

  @override
  Future<dynamic> deleteApiResponseWithAuth(String url, String token) async {
    try {
      final res = await _client
          .delete(Uri.parse(url), headers: _authHeaders(token))
          .timeout(_timeout);
      return returnResponse(res);
    } on SocketException {
      throw NoInternetException();
    } on http.ClientException {
      throw NoInternetException();
    }
  }
}
