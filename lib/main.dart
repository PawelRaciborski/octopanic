import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:octopanic/api/api_config.dart';
import 'package:octopanic/api/api_injector.dart';
import 'package:octopanic/config/config_repo.dart';
import 'package:octopanic/setup/initial_setup_route.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'setup/initial_setup_store.dart';

GetIt injector = GetIt.instance;

void main() {
  injector
    ..registerFactory(
      () => const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
      ),
    )
    ..registerLazySingleton<ConfigurationRepository>(
      () => ConfigurationRepository(injector.get()),
    )
    ..registerApi()
    ..registerFactoryAsync<InitialSetupStore>(
      () async => InitialSetupStore(
        injector.get(),
        await injector.getAsync(),
      ),
    );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oktopanic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InitialSetupRoute(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const AspectRatio(
            aspectRatio: 4 / 3,
            child: WebView(
                initialUrl: 'http://${ApiConfig.streamUrl}/?action=stream'),
          ),
          ElevatedButton(
            onPressed: () {
              callBackend();
            },
            child: const Text("PANIK!"),
          ),
          ElevatedButton(
            onPressed: () {
              sendStopCommand();
            },
            child: const Text("KALM"),
          )
        ],
      ),
    );
  }

  Future<bool> callBackend() async {
    try {
      var response = await http.get(
        Uri.http(ApiConfig.baseUrl, 'api/settings'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${ApiConfig.apiKey}'
        },
      );
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return true;
    } catch (e) {
      return false;
    }
  }
}

Future<bool> sendStopCommand() async {
  try {
    var response = await http.post(
      Uri.http(ApiConfig.baseUrl, '/api/printer/command'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ${ApiConfig.apiKey}'
      },
      body: json.encode(
        {
          "command": "M112",
        },
      ),
    );
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    return true;
  } catch (e) {
    return false;
  }
}
