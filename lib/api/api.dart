import 'dart:io';

import 'package:dio/dio.dart';
import 'package:octopanic/api/api_models.dart';
import 'package:retrofit/http.dart';

part 'api.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/settings")
  Future<Settings> getSettings(
    @Header(HttpHeaders.authorizationHeader) bearerToken,
  );
}

class RestClientInteractor {
  final RestClient _restClient;
  final String _apiKey;

  RestClientInteractor(this._restClient, this._apiKey);

  Future<Settings> getSettings() => _restClient.getSettings("Bearer $_apiKey");
}

class GetSettingsUseCase {
  final RestClient _restClient;
  final String _apiKey;

  GetSettingsUseCase(this._restClient, this._apiKey);

  Future<Settings> execute() => _restClient.getSettings(_apiKey);
}
