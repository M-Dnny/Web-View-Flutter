import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late WebViewController controller;
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          if (await controller.canGoBack()) {
            controller.goBack();
            return false;
          }

          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Wish.com'),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  controller.clearCache();
                  CookieManager().clearCookies();
                },
                icon: const Icon(Icons.clear_all_rounded)),
            actions: [
              IconButton(
                  onPressed: () {
                    controller.reload();
                  },
                  icon: const Icon(Icons.refresh_rounded)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.exit_to_app_rounded)),
            ],
          ),
          bottomNavigationBar: Container(
            color: Theme.of(context).colorScheme.secondary,
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () async {
                      if (await controller.canGoBack()) {
                        controller.goBack();
                      }
                    },
                    color: Colors.white,
                    iconSize: 30,
                    icon: const Icon(
                      Icons.chevron_left_rounded,
                    )),
                IconButton(
                    onPressed: () async {
                      if (await controller.canGoForward()) {
                        controller.goForward();
                      }
                    },
                    color: Colors.white,
                    iconSize: 30,
                    icon: const Icon(
                      Icons.chevron_right_rounded,
                    )),
              ],
            ),
          ),
          body: Column(
            children: [
              LinearProgressIndicator(
                value: progress,
                color: Theme.of(context).colorScheme.secondary,
                backgroundColor: Colors.white,
              ),
              Expanded(
                child: WebView(
                  initialUrl: 'https://flutter.dev',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) {
                    this.controller = controller;
                  },
                  onProgress: (progress) => setState(() {
                    this.progress = progress / 100;
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
