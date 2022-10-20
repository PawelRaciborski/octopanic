import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:octopanic/config/config_repo.dart';

extension ConfigInjector on GetIt {
  GetIt registerConfig() => this
    ..registerFactory(
          () => const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
      ),
    )
    ..registerLazySingleton<ConfigurationRepository>(
          () => ConfigurationRepository(get()),
    );
}
