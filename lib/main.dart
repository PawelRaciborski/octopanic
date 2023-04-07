import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:octopanic/api/api_injector.dart';
import 'package:octopanic/config/config_injector.dart';
import 'package:octopanic/control/print_control_injector.dart';
import 'package:octopanic/home/home_injector.dart';
import 'package:octopanic/home/home_route.dart';
import 'package:octopanic/setup/setup_injector.dart';

GetIt injector = GetIt.instance;

void main() {
  injector
    ..registerConfig()
    ..registerApi()
    ..registerSetup()
    ..registerPrintControl()
    ..registerHome();

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
      home: const HomeRoute(),
    );
  }
}
