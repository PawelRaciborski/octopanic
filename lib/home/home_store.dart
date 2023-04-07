import 'package:octopanic/config/config_repo.dart';

class HomeStore {
  final ConfigurationRepository _configurationRepository;

  HomeStore(this._configurationRepository);

  Function(bool)? onDataLoaded;

  loadData() {
    final hasConfiguration = _configurationRepository.initialConfigurationSucceeded;
    if (onDataLoaded != null) {
      onDataLoaded!(hasConfiguration);
    }
  }
}
