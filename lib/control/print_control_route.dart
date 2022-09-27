import 'package:flutter/material.dart';
import 'package:octopanic/api/api_config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrintControlRoute extends StatefulWidget {
  const PrintControlRoute({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PrintControlRoute();
}

class _PrintControlRoute extends State<PrintControlRoute> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            const AspectRatio(
              aspectRatio: 4 / 3,
              child: WebView(
                  initialUrl: 'http://${ApiConfig.streamUrl}/?action=stream'),
            ),
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
}
