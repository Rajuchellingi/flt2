// ignore_for_file: unused_local_variable, invalid_use_of_protected_member, unnecessary_null_comparison

import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReturnController extends GetxController with BaseController {
  var isLoading = false.obs;
  late WebViewController webViewController;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  var allowReturn = false.obs;
  final themeController = Get.find<ThemeController>();
  var returnPageUrl;

  @override
  void onInit() {
    webViewController = new WebViewController();
    var args = Get.arguments;
    returnPageUrl = args['url'];
    getTemplate();
    if (returnPageUrl != null) openWebView();
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates
        .firstWhere((value) => value['id'] == 'return-order', orElse: () => {});
    isTemplateLoading.value = false;
  }

  Future openWebView() async {
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
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(returnPageUrl));
  }

  @override
  void onClose() {
    super.onClose();
  }
}
