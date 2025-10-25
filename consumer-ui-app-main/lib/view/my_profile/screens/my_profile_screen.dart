// ignore_for_file: unused_element, invalid_use_of_protected_member, deprecated_member_use, unused_local_variable

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/controller/profile_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:black_locust/view/my_profile/components/my_profile_block.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<ProfileController>();
    final themeController = Get.find<ThemeController>();
    final brightness = Theme.of(context).brightness;

    return Obx(() {
      final header = _controller.template.value['layout']?['header'];
      final isLoading = _controller.isLoading.value;

      return SafeArea(
        child: Scaffold(
          appBar: (header != null && header.isNotEmpty)
              ? AppBar(
                  backgroundColor: themeController.headerStyle(
                    'backgroundColor',
                    header['style']['root']['backgroundColor'],
                  ),
                  automaticallyImplyLeading: false,
                  titleSpacing: 0.0,
                  elevation: 0.0,
                  forceMaterialTransparency: true,
                  title: CommonHeader(header: header),
                )
              : null,
          extendBody: false,
          resizeToAvoidBottomInset: false,
          body: isLoading
              ? LoadingIcon(
                  logoPath: themeController.logo.value,
                )
              : MyProfileBlock(controller: _controller),
        ),
      );
    });
  }
}
