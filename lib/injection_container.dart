import 'package:get_it/get_it.dart';
import 'package:lingolab_app/core/network/app_dio.dart';
import 'package:lingolab_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:lingolab_app/features/auth/data/repositories/auth_repository.dart';
import 'package:lingolab_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:lingolab_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:lingolab_app/features/home/data/repositories/home_repository.dart';
import 'package:lingolab_app/features/home/presentation/cubit/home_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Network
  getIt.registerSingleton<AppDio>(AppDio());

  // Auth
  getIt.registerSingleton<AuthRemoteDatasource>(
    AuthRemoteDatasourceImpl(appDio: getIt<AppDio>()),
  );

  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(remoteDatasource: getIt<AuthRemoteDatasource>()),
  );

  getIt.registerSingleton<AuthCubit>(
    AuthCubit(repository: getIt<AuthRepository>()),
  );

  // Home
  getIt.registerSingleton<HomeRemoteDatasource>(
    HomeRemoteDatasourceImpl(appDio: getIt<AppDio>()),
  );

  getIt.registerSingleton<HomeRepository>(
    HomeRepositoryImpl(remoteDatasource: getIt<HomeRemoteDatasource>()),
  );

  getIt.registerSingleton<HomeCubit>(
    HomeCubit(repository: getIt<HomeRepository>()),
  );
}
