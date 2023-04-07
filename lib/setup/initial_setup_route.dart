import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:octopanic/control/print_control_route.dart';
import 'package:octopanic/main.dart';

import 'initial_setup_store.dart';

class InitialSetupRoute extends StatefulWidget {
  final bool isRunForInitialConfiguration;

  const InitialSetupRoute({Key? key, required this.isRunForInitialConfiguration}) : super(key: key);

  @override
  State<InitialSetupRoute> createState() => _InitialSetupRouteState();
}

class _InitialSetupRouteState extends State<InitialSetupRoute> {
  final _formKey = GlobalKey<FormState>();

  final Future<InitialSetupStore> _initialSetupStoreFuture = injector.getAsync<InitialSetupStore>();

  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
    _initialSetupStoreFuture.then((store) {
      _disposers.add(
        reaction(
          (_) => store.isReadyForNavigation,
          (value) {
            if (!(value == true)) {
              return;
            }
            if (widget.isRunForInitialConfiguration) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrintControlRoute(),
                ),
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
      );
      store.initialize();
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
  Widget build(BuildContext context) => FutureBuilder<InitialSetupStore>(
      future: _initialSetupStoreFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final InitialSetupStore initialSetupStore = snapshot.data!;

        return Form(
          key: _formKey,
          child: Scaffold(
            body: Observer(
              builder: (_) => initialSetupStore.showProgress
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SafeArea(
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              initialSetupStore.instanceUrl = value;
                            },
                            controller: _createTextEditingController(
                              initialSetupStore.initialInstanceUrl,
                            ),
                            keyboardType: TextInputType.url,
                            decoration:
                                const InputDecoration(labelText: 'Octoprint instance address'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Octoprint instance address cannot be empty!";
                              }

                              if (!Uri.parse(value).isAbsolute) {
                                return "Invalid Uri!";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            onChanged: (value) {
                              initialSetupStore.streamUrl = value;
                            },
                            controller: _createTextEditingController(
                              initialSetupStore.initialStreamUrl,
                            ),
                            keyboardType: TextInputType.url,
                            decoration:
                                const InputDecoration(labelText: 'Video stream address (optional)'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return null;
                              }

                              if (!Uri.parse(value).isAbsolute) {
                                return "Invalid Uri!";
                              }

                              return null;
                            },
                          ),
                          TextFormField(
                            onChanged: (value) {
                              initialSetupStore.apiKey = value;
                            },
                            controller: _createTextEditingController(
                              initialSetupStore.initialApiKey,
                            ),
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(labelText: 'API key'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "API key cannot be empty!";
                              }
                              if (!RegExp(r'[A-Z0-9]{32}').hasMatch(value)) {
                                return "Wrong format!";
                              }
                              return null;
                            },
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ?? false) {
                                  initialSetupStore.submitInput();
                                }
                              },
                              child: const Text("Confirm"))
                        ],
                      ),
                    ),
            ),
          ),
        );
      });

  TextEditingController? _createTextEditingController(String? value) =>
      value != null ? (TextEditingController()..text = value) : null;
}
