class AppException implements Exception {
  final String message;
  final int? code;
  final dynamic originalError;

  AppException({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException({required String message, int? code})
      : super(message: message, code: code);
}

class ServerException extends AppException {
  ServerException({required String message, int? code})
      : super(message: message, code: code);
}

class UnauthorizedException extends AppException {
  UnauthorizedException({required String message})
      : super(message: message, code: 401);
}

class TimeoutException extends AppException {
  TimeoutException({required String message})
      : super(message: message, code: 0);
}
