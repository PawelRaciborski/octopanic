import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:octopanic/api/api_models.dart';
import 'package:octopanic/control/print_control_store.dart';
import 'package:octopanic/main.dart';
import 'package:octopanic/setup/initial_setup_route.dart';
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
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final PrintControlStore printControlStore = snapshot.data!;
        printControlStore.loadData();

        return Observer(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InitialSetupRoute(
                            isRunForInitialConfiguration: true,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.settings))
              ],
            ),
            body: printControlStore.showLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Column(
                      children: [
                        _getVideoOutput(printControlStore.streamUrl),
                        _buildStatusDetails(
                          printControlStore.jobState,
                          printControlStore.fileName,
                          printControlStore.completion,
                        ),
                        _buildPanicButton(
                          sendStopInstruction: () => printControlStore.sendStopInstruction(),
                        ),
                        ElevatedButton(
                          onLongPress: () => printControlStore.sendCancelInstruction(),
                          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Long press to cancel print!'),
                            ),
                          ),
                          child: const Text("KALM"),
                        ),
                      ],
                    ),
                  ),
          );
        });
      });

  Widget _buildStatusDetails(
    JobState jobState,
    String? fileDisplayName,
    double completion,
  ) {
    final List<Widget> list = [
      Text("Printer state: ${jobState.name}"),
    ];
    if (fileDisplayName != null) {
      list.add(Text("File: $fileDisplayName"));
    }

    list.addAll([
      Text("Printing progress: ${completion.toStringAsFixed(2)}%"),
      LinearProgressIndicator(
        value: completion / 100.0,
        semanticsLabel: "Print progress visualisation",
      ),
    ]);

    return Column(children: list);
  }

  Widget _buildPanicButton({required Function sendStopInstruction}) => ClipOval(
        child: Material(
          color: Colors.red, // Button color
          child: InkWell(
            splashColor: Colors.orange, // Splash color
            onLongPress: () => sendStopInstruction(),
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
      );

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
