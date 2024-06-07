import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:intellichat/features/auth/repos/auth_repo_implementation.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerLazySingleton<AuthRepoImplementation>(
          () => AuthRepoImplementation(getIt()));
}

Dio createAndSetupDio() {
  Dio dio = Dio();
  dio.interceptors.add(
    LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
      requestBody: true,
    ),
  );
  return dio;
}
