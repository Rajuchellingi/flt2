// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use, unused_local_variable

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/controller/add_review_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/add_review/components/add_review_body.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddReviewScreen extends StatelessWidget {
  final AddReviewController _controller = Get.find<AddReviewController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
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
        body: _controller.isLoading.value == true
            ? LoadingIcon(
                logoPath: themeController.logo.value,
              )
            : AddReviewBody(controller: _controller),
      ));
    });
  }
}
