import 'package:get_it/get_it.dart';
import 'package:octopanic/control/get_jobinfo_usecase.dart';
import 'package:octopanic/control/get_stream_url_usecase.dart';
import 'package:octopanic/control/print_control_store.dart';
import 'package:octopanic/control/send_command_usecase.dart';

extension PrintControlInjector on GetIt {
  GetIt registerPrintControl() => this
    ..registerFactoryAsync<GetStreamUrlUseCase>(
      () async => GetStreamUrlUseCase(
        get(),
        await getAsync(),
      ),
    )
    ..registerFactoryAsync(
      () async => SendCommandUseCase(
        await getAsync(),
      ),
    )
    ..registerFactoryAsync(
      () async => GetJobInfoUseCase(
        await getAsync(),
      ),
    )
    ..registerFactoryAsync(
      () async => PrintControlStore(
        await getAsync(),
        await getAsync(),
        await getAsync(),
      ),
    );
}
