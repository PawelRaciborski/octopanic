import 'package:get_it/get_it.dart';
import 'package:octopanic/api/api.dart';
import 'package:octopanic/config/config_repo.dart';
import 'package:octopanic/control/get_stream_url_usecase.dart';

extension PrintControlInjector on GetIt {
  GetIt registerApi() => this
    ..registerFactoryAsync<GetStreamUrlUseCase>(
      () async => GetStreamUrlUseCase(
        get(),
        get(),
      ),
    )
    ..registerFactoryAsync(() async => RestClientInteractor(
          await getAsync<RestClient>(),
          await (get<ConfigurationRepository>().apiKey) ?? "",
        ));
}
