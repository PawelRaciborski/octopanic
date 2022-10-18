import 'dart:io';

import 'package:dio/dio.dart';
import 'package:octopanic/api/api_instruciton.dart';
import 'package:octopanic/api/api_models.dart';
import 'package:retrofit/http.dart';

part 'api.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/settings")
  Future<Settings> getSettings(
    @Header(HttpHeaders.authorizationHeader) String bearerToken,
  );

  @POST("/printer/command")
  Future postPrinterCommand(
      @Header(HttpHeaders.authorizationHeader) bearerToken,
      @Body() Command command);

  @POST("/job")
  Future postJobCommand(
      @Header(HttpHeaders.authorizationHeader) bearerToken,
      @Body() Command command);
}

class RestClientInteractor {
  final RestClient _restClient;
  final String _apiKey;

  String get _bearer => "Bearer $_apiKey";

  RestClientInteractor(this._restClient, this._apiKey);

  Future<Settings> getSettings() => _restClient.getSettings(_bearer);

  Future postPrinterCommand(
      OctoprintInstruction octoprintInstruction) {
    switch (octoprintInstruction.handler) {
      case OctoprintCommandHandler.printer:
        return _restClient.postPrinterCommand(
          _bearer,
          octoprintInstruction.command.value,
        );
      case OctoprintCommandHandler.job:
        return _restClient.postJobCommand(
          _bearer,
          octoprintInstruction.command.value,
        );
    }
  }

  updateBaseUrl(String baseUrl) {
    (_restClient as _RestClient).baseUrl = baseUrl;
  }
}

class GetSettingsUseCase {
  final RestClient _restClient;
  final String _apiKey;

  GetSettingsUseCase(this._restClient, this._apiKey);

  Future<Settings> execute() => _restClient.getSettings(_apiKey);
}
