import 'package:mobx/mobx.dart';
import 'package:octopanic/api/api.dart';
import 'package:octopanic/config/config_repo.dart';

part 'initial_setup_store.g.dart';

class InitialSetupStore = _InitialSetupStore with _$InitialSetupStore;

abstract class _InitialSetupStore with Store {
  final ConfigurationRepository _configurationRepository;
  final RestClientInteractor _restClient;

  _InitialSetupStore(
    this._configurationRepository,
    this._restClient,
  );

  @observable
  String? _instanceUrl;

  @observable
  String? _initialInstanceUrl;

  String? get initialInstanceUrl => _initialInstanceUrl;

  String get instanceUrl => _instanceUrl ?? "";

  set instanceUrl(String value) {
    _instanceUrl = value;
    _initialInstanceUrl = null;
  }

  @observable
  String? _apiKey;

  @observable
  String? _initialApiKey;

  String? get initialApiKey => _initialApiKey;

  String get apiKey => _apiKey ?? "";

  set apiKey(String value) {
    _apiKey = value;
    _initialApiKey = null;
  }

  @observable
  String? _streamUrl;

  @observable
  String? _initialStreamUrl;

  String? get initialStreamUrl => _initialStreamUrl;

  String get streamUrl => _streamUrl ?? "";

  set streamUrl(String value) {
    _streamUrl = value;
    _initialStreamUrl = null;
  }

  @action
  Future loadData() async {
    final url = await _configurationRepository.instanceUrl;
    _instanceUrl = url;
    _initialInstanceUrl = url;

    final apiKey = await _configurationRepository.apiKey;
    _apiKey = _initialApiKey = apiKey;

    final streamUrl = await _configurationRepository.streamUrl;
    _streamUrl = _initialStreamUrl = streamUrl;
  }

  @action
  Future<bool> submitInput() async {
    await _configurationRepository.storeInstanceUrl(instanceUrl);
    await _configurationRepository.storeApiKey(apiKey);
    await _configurationRepository.storeStreamUrl(streamUrl);

    try {
      _restClient.updateBaseUrl(instanceUrl);
      final settings = await _restClient.getSettings();
      return true;
    } catch (exception) {
      return false;
    }
  }
}
