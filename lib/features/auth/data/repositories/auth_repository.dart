import 'package:lingolab_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:lingolab_app/features/auth/data/models/auth_models.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> register(String email, String password, String name);
  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<AuthResponse> login(String email, String password) async {
    try {
      final request = LoginRequest(email: email, password: password);
      return await remoteDatasource.login(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthResponse> register(
    String email,
    String password,
    String name,
  ) async {
    try {
      final request = RegisterRequest(
        email: email,
        password: password,
        name: name,
      );
      return await remoteDatasource.register(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDatasource.logout();
    } catch (e) {
      rethrow;
    }
  }
}
