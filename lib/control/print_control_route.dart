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
            body: printControlStore.showLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Column(
                      children: [
                        _getVideoOutput(printControlStore.streamUrl),
                        ClipOval(
                          child: Material(
                            color: Colors.red, // Button color
                            child: InkWell(
                              splashColor: Colors.orange, // Splash color
                              onLongPress: (){
                                //TODO: pass action to store
                              },
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Long press to panik!'),
                                  ),
                                );
                              },
                              // onLongPress: (){},
                              child: const SizedBox(
                                width: 200,
                                height: 200,
                                child: Padding(
                                  padding: EdgeInsets.all(40.0),
                                  child: Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Icon(
                                        Icons.warning_amber,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("KALM"),
                        ),
                      ],
                    ),
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
