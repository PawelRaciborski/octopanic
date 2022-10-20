import 'package:get_it/get_it.dart';
import 'package:octopanic/setup/initial_setup_store.dart';

extension SetupInjector on GetIt {
  GetIt registerSetup() => this
    ..registerFactoryAsync<InitialSetupStore>(
      () async => InitialSetupStore(
        get(),
        await getAsync(),
      ),
    );
}
