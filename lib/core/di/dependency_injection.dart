import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:intellichat/core/firebase/custom_firebase.dart';
import 'package:intellichat/core/gemini/custom_gemini.dart';
import 'package:intellichat/core/media/media_seervice.dart';
import 'package:intellichat/features/auth/repos/auth_repo_implementation.dart';
import 'package:intellichat/features/chat/repos/chat_repo_implementation.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerLazySingleton<AuthRepoImplementation>(
      () => AuthRepoImplementation(getIt(), getIt()));
  getIt.registerLazySingleton<CustomFirebase>(() => CustomFirebase());
  getIt.registerLazySingleton<MediaService>(() => MediaService());
  getIt.registerLazySingleton<ChatRepoImplementation>(
      () => ChatRepoImplementation(getIt(), getIt()));
  getIt.registerLazySingleton<CustomGemini>(() => CustomGemini());
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
