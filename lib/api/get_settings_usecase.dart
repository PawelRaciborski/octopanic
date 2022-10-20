import 'package:octopanic/api/api.dart';
import 'package:octopanic/api/api_models.dart';

class GetSettingsUseCase {
  final RestClient _restClient;
  final String _apiKey;

  GetSettingsUseCase(this._restClient, this._apiKey);

  Future<Settings> execute() => _restClient.getSettings(_apiKey);
}
