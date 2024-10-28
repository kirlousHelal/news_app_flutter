import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatelessWidget {
  final String url;

  const WebviewScreen({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    final WebViewController controller = WebViewController()
      ..loadRequest(Uri.parse(url));

    return Scaffold(
        appBar: AppBar(), body: WebViewWidget(controller: controller)
        // WebView(initialUrl: url),
        );
  }
}
