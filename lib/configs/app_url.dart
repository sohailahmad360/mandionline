/// Base URL and path segments. Set [baseUrl] once at startup from `.env` / flavors.
class AppUrl {
  AppUrl._();

  static String baseUrl = 'https://api.example.com';

  static String get login => '$baseUrl/api/auth/login';
  static String tradesPage(int page) => '$baseUrl/api/trades?page=$page';
}
