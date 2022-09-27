import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:octopanic/control/print_control_store.dart';
import 'package:octopanic/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrintControlRoute extends StatefulWidget {
  const PrintControlRoute({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PrintControlRoute();
}

class _PrintControlRoute extends State<PrintControlRoute> {
  final Future<PrintControlStore> _printControlStore = injector.getAsync();

  @override
  Widget build(BuildContext context) => FutureBuilder<PrintControlStore>(
      future: _printControlStore,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text("ERROR!");
        }

        final PrintControlStore printControlStore = snapshot.data!;
        printControlStore.loadData();

        return Observer(builder: (context) {
          return Scaffold(
            body: Column(
              children: [
                _getVideoOutput(printControlStore.streamUrl),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("PANIK!"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("KALM"),
                ),
              ],
            ),
          );
        });
      });

  Widget _getVideoOutput(String? streamUrl) {
    if (streamUrl == null) {
      return const Text('No video stream available!');
    }

    return AspectRatio(
      aspectRatio: 4 / 3,
      child: WebView(initialUrl: streamUrl),
    );
  }
}
