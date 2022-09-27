import 'package:octopanic/api/api.dart';
import 'package:octopanic/config/config_repo.dart';

import '../api/api_models.dart';

class GetStreamUrlUseCase {
  final ConfigurationRepository _configurationRepository;
  final RestClientInteractor _restClientInteractor;

  GetStreamUrlUseCase(
    this._configurationRepository,
    this._restClientInteractor,
  );

  Future<String?> execute() async {
    final String? configurationUrl = await _configurationRepository.streamUrl;
    if (configurationUrl != null) {
      return configurationUrl;
    }

    try {
      final Settings settings = await _restClientInteractor.getSettings();
      return settings.webcam?.streamUrl;
    } catch (e) {
      return null;
    }
  }
}
