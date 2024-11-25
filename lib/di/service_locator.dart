import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:newsapp/data/services/news_api_service.dart';
import 'package:newsapp/data/repositories/news_repository.dart';
import 'package:newsapp/presentation/stores/news_list_store.dart';
import '../data/repositories/secure_key_repository.dart';
import '../core/constants/secure_storage_service.dart';

final GetIt serviceLocator = GetIt.instance;

void setupLocator() {
  serviceLocator.registerLazySingleton(() => SecureStorageService());
  serviceLocator.registerLazySingleton(() => SecureKeyRepository(serviceLocator<SecureStorageService>()));
  serviceLocator.registerLazySingleton(() => Dio());
  serviceLocator.registerLazySingleton(() => NewsApiService(serviceLocator()));
  serviceLocator.registerLazySingleton(() => NewsRepository(serviceLocator()));
  serviceLocator.registerFactory(() => NewsListStore(serviceLocator()));
}
