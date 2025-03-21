import 'package:get_it/get_it.dart';
import 'package:plordle/services/player_file_service.dart';
import 'package:plordle/services/storage_service.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<StorageService>(() => StorageService());
  serviceLocator
      .registerLazySingleton<PlayerFileService>(() => PlayerFileService());
}
