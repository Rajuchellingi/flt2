import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/controller/checkout_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutBody extends StatelessWidget {
  final _controller = Get.find<CheckoutController>();
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.isLoading.value
          ? LoadingIcon(
              logoPath: themeController.logo.value,
            )
          : WebViewWidget(
              controller: _controller.webViewController,
            ),
    );
  }
}
