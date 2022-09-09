import 'package:flutter/material.dart';

class InitialSetupRoute extends StatefulWidget {
  const InitialSetupRoute({Key? key}) : super(key: key);

  @override
  _InitialSetupRouteState createState() => _InitialSetupRouteState();
}

class _InitialSetupRouteState extends State<InitialSetupRoute> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const Text("data"),
                TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    labelText: 'Octoprint instance address'
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Ups!";
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Hura!"),
                          ),
                        );
                      }
                    },
                    child: const Text("Confirm"))
              ],
            ),
          ),
        ),
      );
}
