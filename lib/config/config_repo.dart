import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationRepository {
  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _sharedPreferences;

  ConfigurationRepository(this._secureStorage, this._sharedPreferences);

  static const _instanceUrlKey = 'INSTANCE_URL_KEY';

  Future<String?> get instanceUrl => _secureStorage.read(key: _instanceUrlKey);

  Future<void> storeInstanceUrl(String url) =>
      _secureStorage.write(key: _instanceUrlKey, value: url);

  static const _apiKey = 'API_KEY';

  Future<String?> get apiKey => _secureStorage.read(key: _apiKey);

  Future<void> storeApiKey(String apiKey) => _secureStorage.write(key: _apiKey, value: apiKey);

  static const _streamUrl = 'STREAM_URL';

  Future<String?> get streamUrl => _secureStorage.read(key: _streamUrl);

  Future<void> storeStreamUrl(String streamUrl) =>
      _secureStorage.write(key: _streamUrl, value: streamUrl);

  static const _initialConfigurationSucceeded = 'INITIAL_CONFIGURATION_SUCCEEDED';

  bool get initialConfigurationSucceeded =>
      _sharedPreferences.getBool(_initialConfigurationSucceeded) ?? false;

  Future<void> storeInitialConfigurationSucceeded(bool value) =>
      _sharedPreferences.setBool(_initialConfigurationSucceeded, value);
}
