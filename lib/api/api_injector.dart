import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:octopanic/api/api.dart';
import 'package:octopanic/config/config_repo.dart';

extension ApiInjector on GetIt {
  GetIt registerApi() => this
    ..registerFactoryAsync<RestClient>(() async => RestClient(
          Dio(),
          baseUrl: await (get<ConfigurationRepository>().instanceUrl) ?? "",
        ))
    ..registerSingletonAsync(() async => RestClientInteractor(
          await getAsync<RestClient>(),
          await (get<ConfigurationRepository>().apiKey) ?? "",
        ));
}
