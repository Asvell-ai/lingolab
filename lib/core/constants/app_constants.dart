class AppConstants {
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = '/v1';

  // Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String logoutEndpoint = '/auth/logout';
  static const String refreshTokenEndpoint = '/auth/refresh';
  static const String userEndpoint = '/users';

  // LocalStorage Keys
  static const String tokenKey = 'token';
  static const String refreshTokenKey = 'refreshToken';
  static const String userKey = 'user';

  // Network
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  // Error Messages
  static const String networkError = 'Network error occurred';
  static const String serverError = 'Server error occurred';
  static const String unknownError = 'Unknown error occurred';
  static const String unauthorizedError = 'Unauthorized';
  static const String invalidCredentials = 'Invalid credentials';
}
