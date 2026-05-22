/// Typed failures from the network layer. ViewModels map these to user-visible messages.
class AppException implements Exception {
  AppException([this.message, this.prefix]);

  final String? message;
  final String? prefix;

  @override
  String toString() => '$prefix${message ?? ''}';
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, 'Fetch error: ');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid request: ');
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message]) : super(message, 'Unauthorized: ');
}

class NotFoundException extends AppException {
  NotFoundException([String? message]) : super(message, 'Not found: ');
}

class NoInternetException extends AppException {
  NoInternetException([String? message])
      : super(message ?? 'Please check your connection.', 'Network: ');
}
