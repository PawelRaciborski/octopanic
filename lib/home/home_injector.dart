import 'package:get_it/get_it.dart';
import 'package:octopanic/home/home_store.dart';

extension SetupInjector on GetIt {
  GetIt registerHome() => this
    ..registerFactoryAsync<HomeStore>(
      () async => HomeStore(await getAsync()),
    );
}
