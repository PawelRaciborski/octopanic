import 'package:octopanic/api/api.dart';
import 'package:octopanic/api/api_models.dart';

class GetJobInfoUseCase {
  final RestClientInteractor _restClientInteractor;


  GetJobInfoUseCase(this._restClientInteractor);

  Stream<JobInfo> execute() async* {
    while (true) {
      yield await _restClientInteractor.getJobInfo();
      await Future.delayed(const Duration(seconds: 5));
    }
  }
}
