// ignore_for_file: unused_local_variable, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/controller/booking_summary_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/booking_summary/components/booking_summary_body.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingSummaryScreen extends StatelessWidget {
  final _controller = Get.find<BookingSummaryController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final dynamic argument = Get.arguments;
    return Obx(() {
      var header = _controller.template.value['layout'] != null
          ? _controller.template.value['layout']['header']
          : null;

      final brightness = Theme.of(context).brightness;

      return SafeArea(
          child: Scaffold(
        appBar: (header != null && header.isNotEmpty)
            ? AppBar(
                backgroundColor: themeController.headerStyle('backgroundColor',
                    header['style']['root']['backgroundColor']),
                automaticallyImplyLeading: false,
                titleSpacing: 0.0,
                elevation: 0.0,
                forceMaterialTransparency: true,
                title: CommonHeader(header: header),
              )
            : null,
        body: Obx(() => _controller.isLoading.value
            ? LoadingIcon(
                logoPath: themeController.logo.value,
              )
            : BookingSummaryBody(controller: _controller)),
      ));
    });
  }
}
