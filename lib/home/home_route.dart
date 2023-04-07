import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:octopanic/control/print_control_route.dart';
import 'package:octopanic/home/home_store.dart';
import 'package:octopanic/main.dart';
import 'package:octopanic/setup/initial_setup_route.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  final Future<HomeStore> _homeStoreFuture = injector.getAsync<HomeStore>();

  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
    _homeStoreFuture.then((value) {
      value.onDataLoaded = (bool configAlreadyAvailable) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => configAlreadyAvailable
                ? const PrintControlRoute()
                : const InitialSetupRoute(isRunForInitialConfiguration: true),
          ),
        );
      };
      value.loadData();
    });
  }

  @override
  void dispose() {
    for (var dispose in _disposers) {
      dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
