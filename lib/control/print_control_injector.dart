import 'package:get_it/get_it.dart';
import 'package:octopanic/control/get_stream_url_usecase.dart';
import 'package:octopanic/control/print_control_store.dart';

extension PrintControlInjector on GetIt {
  GetIt registerPrintControl() => this
    ..registerFactoryAsync<GetStreamUrlUseCase>(
      () async => GetStreamUrlUseCase(
        get(),
        await getAsync(),
      ),
    )
    ..registerFactoryAsync(
      () async => PrintControlStore(
        await getAsync(),
      ),
    );
}
