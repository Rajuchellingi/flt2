// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/controller/review_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:black_locust/view/review/components/review_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatelessWidget {
  final ReviewController _controller = Get.find<ReviewController>();
  final themeController = Get.find<ThemeController>();

  ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Obx(() {
      final header = _controller.template.value['layout']?['header'];
      final isLoading = _controller.isLoading.value;

      return SafeArea(
        child: Scaffold(
          key: const Key('review_screen'),
          appBar: _buildAppBar(header),
          body: isLoading
              ? _buildLoadingIndicator(brightness)
              : ReviewBody(
                  key: const Key('review_body'),
                  controller: _controller,
                ),
        ),
      );
    });
  }

  PreferredSizeWidget? _buildAppBar(Map<String, dynamic>? header) {
    if (header == null || header.isEmpty) return null;

    return AppBar(
      key: const Key('review_app_bar'),
      backgroundColor: themeController.headerStyle(
        'backgroundColor',
        header['style']['root']['backgroundColor'],
      ),
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      elevation: 0.0,
      forceMaterialTransparency: true,
      title: CommonHeader(
        key: const Key('review_header'),
        header: header,
      ),
    );
  }

  Widget _buildLoadingIndicator(Brightness brightness) {
    return LoadingIcon(
      logoPath: themeController.logo.value,
    );
  }
}
