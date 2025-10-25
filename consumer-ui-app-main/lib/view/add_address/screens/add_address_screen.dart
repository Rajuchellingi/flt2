// import 'package:black_locust/view/profile/components/add_address_body.dart';
// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/add_address_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/add_address/components/add_address_body.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressScreen extends StatelessWidget {
  final _controller = Get.find<AddAddressController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
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
        body: AddAddressBody(),
      ));
    });
  }
}
