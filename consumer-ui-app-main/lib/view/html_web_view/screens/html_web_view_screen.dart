// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/controller/html_web_view_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../const/constant.dart';

class HtmlWebViewScreen extends StatelessWidget {
  final HtmlWebviewController _controller = Get.find<HtmlWebviewController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var header = _controller.template.value['layout'] != null
          ? _controller.template.value['layout']['header']
          : null;
      return WillPopScope(
          onWillPop: () => _controller.handleBack(context),
          child: SafeArea(
            child: Scaffold(
              appBar: (header != null && header.isNotEmpty)
                  ? AppBar(
                      backgroundColor: themeController.headerStyle(
                          'backgroundColor',
                          header['style']['root']['backgroundColor']),
                      automaticallyImplyLeading: false,
                      titleSpacing: 0.0,
                      elevation: 0.0,
                      forceMaterialTransparency: true,
                      title: CommonHeader(header: header),
                    )
                  : null,
              body: _controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(color: kPrimaryColor),
                    )
                  : WebViewWidget(
                      controller: _controller.webViewController,
                    ),
            ),
          ));
    });
  }
}
