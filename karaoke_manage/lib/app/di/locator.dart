import 'package:get_it/get_it.dart';

import '../../features/auth/data/auth_repo.dart';

final locator = GetIt.instance;


void setupLocator() {
  locator.registerLazySingleton(() => AuthRepository());

}