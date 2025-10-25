// ignore_for_file: unused_local_variable, invalid_use_of_protected_member, unnecessary_null_comparison
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewController extends GetxController with BaseController {
  var isLoading = false.obs;
  late WebViewController webViewController;
  var url;
  var type;
  var bookingId;
  final themeController = Get.find<ThemeController>();

  @override
  void onInit() {
    webViewController = new WebViewController();
    var args = Get.arguments;
    url = args['url'];
    type = args['type'];
    bookingId = args['bookingId'];
    if (url != null) {
      openWebView(args['url']);
    }
    super.onInit();
  }

  Future openWebView(url) async {
    isLoading.value = true;
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100)
              isLoading.value = false;
            else
              isLoading.value = true;
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.contains('transactionId')) {
              Uri transactionUrl = Uri.parse(request.url);
              String? id = transactionUrl.queryParameters['transactionId'];
              Get.offAndToNamed('/paymentVerification', arguments: {
                "transactionId": id,
                "type": type,
                "bookingId": bookingId
              });
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  Future<bool> handleBack(BuildContext context) async {
    if (await webViewController.canGoBack()) {
      webViewController.goBack();
      return false; // don't pop the page
    } else {
      return true; // pop the page
    }
  }
}
