// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/notification_history_controller.dart';
import '../components/notification_body.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<NotificationHistoryController>();
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final header = _controller.template.value['layout']?['header'];
      final isLoading = _controller.isLoading.value;

      return SafeArea(
        child: Scaffold(
          key: const Key('notification_screen'),
          appBar: _buildAppBar(header, themeController),
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    key: Key('notification_loading_indicator'),
                  ),
                )
              : NotificationBody(
                  key: const Key('notification_body'),
                  controller: _controller,
                ),
        ),
      );
    });
  }

  PreferredSizeWidget? _buildAppBar(
      Map<String, dynamic>? header, ThemeController themeController) {
    if (header == null || header.isEmpty) return null;

    return AppBar(
      key: const Key('notification_app_bar'),
      backgroundColor: themeController.headerStyle(
        'backgroundColor',
        header['style']['root']['backgroundColor'],
      ),
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      elevation: 0.0,
      forceMaterialTransparency: true,
      title: CommonHeader(header: header),
    );
  }
}
