import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:octopanic/main.dart';

import 'initial_setup_store.dart';

class InitialSetupRoute extends StatefulWidget {
  const InitialSetupRoute({Key? key}) : super(key: key);

  @override
  _InitialSetupRouteState createState() => _InitialSetupRouteState();
}

class _InitialSetupRouteState extends State<InitialSetupRoute> {
  final _formKey = GlobalKey<FormState>();

  // final InitialSetupStore _initialSetupStore = await injector.getAsync<InitialSetupStore>();
  final Future<InitialSetupStore> _initialSetupStoreFuture =
      injector.getAsync<InitialSetupStore>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<InitialSetupStore>(
      future: _initialSetupStoreFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text("ERROR!");
        }

        final InitialSetupStore initialSetupStore = snapshot.data!;
        initialSetupStore.loadData();

        return Form(
          key: _formKey,
          child: Scaffold(
            body: SafeArea(
              child: Observer(
                builder: (_) => Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        initialSetupStore.instanceUrl = value;
                      },
                      controller: _createTextEditingController(
                        initialSetupStore.initialInstanceUrl,
                      ),
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                          labelText: 'Octoprint instance address'),
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
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                          labelText: 'Video stream address (optional)'),
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
                            if (!(await initialSetupStore.submitInput())) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Could not connect to the server at ${initialSetupStore.instanceUrl}'),
                                ),
                              );
                            }
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
