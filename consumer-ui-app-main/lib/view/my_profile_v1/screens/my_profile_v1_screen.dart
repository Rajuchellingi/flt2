// ignore_for_file: unused_element, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/profile_v1_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:black_locust/view/my_profile_v1/components/my_profile_blocks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfileV1Screen extends StatelessWidget {
  final _controller = Get.find<ProfileV1Controller>();
  final themeController = Get.find<ThemeController>();
  //  final blocks = _controller.template['layout']?['blocks'] ?? [];

  //   /// ✅ Find the image block (same as LoginBodyV1 logic)
  //   final imgBlock = blocks.firstWhere(
  //     (b) =>
  //         b['componentId'] == 'image-component' &&
  //         b['source']?['image'] != null &&
  //         b['source']['image'].toString().isNotEmpty,
  //     orElse: () => null,
  //   );

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Obx(
      () {
        var header = _controller.template.value['layout'] != null
            ? _controller.template.value['layout']['header']
            : null;

        return SafeArea(
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
                // body: ProfileShopifyBody(),
                body: _controller.isLoading.value
                    ? LinearProgressIndicator(
                        backgroundColor: (brightness == Brightness.dark &&
                                kPrimaryColor == Colors.black)
                            ? Colors.white
                            : Color.fromRGBO(kPrimaryColor.red,
                                kPrimaryColor.green, kPrimaryColor.blue, 0.2),
                        color: kPrimaryColor,
                      )
                    : MyProfileBlocks()
                // MyProfileV1Body(controller: _controller)
                ));
      },
    );
  }
}
