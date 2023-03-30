import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:octopanic/config/config_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension ConfigInjector on GetIt {
  GetIt registerConfig() => this
    ..registerFactory(
      () => const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
      ),
    )
    ..registerFactoryAsync(
      () => SharedPreferences.getInstance(),
    )
    ..registerLazySingletonAsync<ConfigurationRepository>(
      () async => ConfigurationRepository(
        get(),
        await getAsync(),
      ),
    );
}
