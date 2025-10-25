// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/policy_page_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/policy_page/components/policy_page_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../const/constant.dart';

class PolicyPageScreen extends StatelessWidget {
  final PolicyPageController _controller = Get.find<PolicyPageController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final header = _controller.template.value['layout']?['header'];
      final isLoading = _controller.isLoading.value;

      return SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(header),
          body: _buildBody(isLoading),
        ),
      );
    });
  }

  PreferredSizeWidget? _buildAppBar(Map<String, dynamic>? header) {
    if (header == null || header.isEmpty) return null;

    return AppBar(
      backgroundColor: themeController.headerStyle(
        'backgroundColor',
        header['style']['root']['backgroundColor'],
      ),
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      elevation: 0.0,
      forceMaterialTransparency: true,
      title: PolicyPageHeader(controller: _controller),
    );
  }

  Widget _buildBody(bool isLoading) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: kPrimaryColor),
      );
    }

    return WebViewWidget(
      controller: _controller.webViewController,
    );
  }
}
