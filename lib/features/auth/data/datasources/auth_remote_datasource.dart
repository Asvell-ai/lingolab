import 'package:dio/dio.dart';
import 'package:lingolab_app/core/constants/app_constants.dart';
import 'package:lingolab_app/core/network/app_dio.dart';
import 'package:lingolab_app/features/auth/data/models/auth_models.dart';

abstract class AuthRemoteDatasource {
  Future<AuthResponse> login(LoginRequest request);
  Future<AuthResponse> register(RegisterRequest request);
  Future<void> logout();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final AppDio appDio;

  AuthRemoteDatasourceImpl({required this.appDio});

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await appDio.post(
        AppConstants.loginEndpoint,
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return AuthResponse.fromJson(response.data);
      }
      throw Exception('Login failed');
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final response = await appDio.post(
        AppConstants.registerEndpoint,
        data: request.toJson(),
      );

      if (response.statusCode == 201) {
        return AuthResponse.fromJson(response.data);
      }
      throw Exception('Register failed');
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await appDio.post(AppConstants.logoutEndpoint);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  Exception _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return Exception('Connection timeout');
      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 401) {
          return Exception('Invalid credentials');
        }
        if (e.response?.statusCode == 400) {
          return Exception('Bad request');
        }
        return Exception('Server error: ${e.response?.statusCode}');
      case DioExceptionType.cancel:
        return Exception('Request cancelled');
      default:
        return Exception('Network error');
    }
  }
}
