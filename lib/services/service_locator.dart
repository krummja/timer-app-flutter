import 'package:get_it/get_it.dart';

import 'package:test_app/services/storage_service/shared_preferences_storage.dart';
import 'package:test_app/services/storage_service/storage_service.dart';
import 'package:test_app/pages/timer/timer_page_logic.dart';


final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<TimerPageManager>(() => TimerPageManager());
  getIt.registerLazySingleton<StorageService>(() => SharedPreferencesStorage());
}
