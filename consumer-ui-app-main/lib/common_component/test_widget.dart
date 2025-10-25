import 'package:black_locust/controller/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IntegrationTest extends StatelessWidget {
  final _controller = Get.put(TestController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
            child: Scaffold(
                body: Container(
                    child: Column(children: [
          ElevatedButton(
              onPressed: () {
                _controller.openWebView();
              },
              child: const Text("Open WebView")),
          !_controller.isLoaded.value
              ? CircularProgressIndicator()
              : Expanded(
                  // height: 100,
                  // width: SizeConfig.screenHeight,
                  child: WebViewWidget(
                  controller: _controller.webViewController,
                ))
        ])))));
  }
}
