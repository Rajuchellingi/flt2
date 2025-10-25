// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/controller/payment_web_view_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatelessWidget {
  final PaymentWebViewController _controller =
      Get.find<PaymentWebViewController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          body: _controller.isLoading.value
              ? LoadingIcon(
                  logoPath: themeController.logo.value,
                )
              : WebViewWidget(
                  controller: _controller.webViewController,
                ),
        ),
      );
    });
  }
}
