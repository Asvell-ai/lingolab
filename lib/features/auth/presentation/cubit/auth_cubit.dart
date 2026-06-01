import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingolab_app/features/auth/data/repositories/auth_repository.dart';
import 'package:lingolab_app/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit({required this.repository}) : super(const AuthInitial());

  Future<void> login(String email, String password) async {
    emit(const AuthLoading());
    try {
      final response = await repository.login(email, password);
      emit(AuthSuccess(authResponse: response));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> register(String email, String password, String name) async {
    emit(const AuthLoading());
    try {
      final response = await repository.register(email, password, name);
      emit(AuthSuccess(authResponse: response));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await repository.logout();
      emit(const AuthLoggedOut());
      emit(const AuthInitial());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}
