import 'package:octopanic/api/api.dart';
import 'package:octopanic/api/api_models.dart';

class GetJobInfoUseCase {
  final RestClientInteractor _restClientInteractor;

  GetJobInfoUseCase(this._restClientInteractor);

  Future<JobInfo> execute() => _restClientInteractor.getJobInfo();
}
