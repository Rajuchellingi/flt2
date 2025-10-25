// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/controller/wishlist_collection_controller.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:black_locust/view/wishlist_collection/components/wishlist_collection_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistCollectionScreen extends StatelessWidget {
  final _controller = Get.find<WishlistCollectionController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Obx(() {
      var header = _controller.template.value['layout'] != null
          ? _controller.template.value['layout']['header']
          : null;
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
        body: SafeArea(
            child: _controller.isLoading.value
                ? LinearProgressIndicator(
                    backgroundColor: (brightness == Brightness.dark &&
                            kPrimaryColor == Colors.black)
                        ? Colors.white
                        : Color.fromRGBO(kPrimaryColor.red, kPrimaryColor.green,
                            kPrimaryColor.blue, 0.2),
                    color: kPrimaryColor,
                  )
                : WishlistCollectionBody(controller: _controller)),
      ));
    });
  }
}
