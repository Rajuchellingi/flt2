import 'package:black_locust/controller/return_controller.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReturnProductDesign1 extends StatelessWidget {
  const ReturnProductDesign1({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final ReturnController _controller;
  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _controller.webViewController,
    );
  }
}
