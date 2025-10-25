// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/multi_booking_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:black_locust/view/multi_booking/components/apply_different_quantity.dart';
import 'package:black_locust/view/multi_booking/components/apply_same_quantity.dart';
import 'package:black_locust/view/multi_booking/components/multi_booking_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiBookingScreen extends StatelessWidget {
  final _controller = Get.find<MultiBookingController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var header = _controller.template.value['layout'] != null
          ? _controller.template.value['layout']['header']
          : null;
      var template = _controller.template.value;
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
        body: MultiBookingBody(controller: _controller),
        bottomNavigationBar: (template['instanceId'] == 'design1' &&
                _controller.isLoading.value == false)
            ? Container(
                color: kPrimaryColor,
                child: Row(children: [
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              useSafeArea: true,
                              showDragHandle: true,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24)),
                              ),
                              builder: (context) => ApplySameQuantitySheet(
                                controller: _controller,
                                selectedProducts:
                                    _controller.products.value.length,
                                onCancel: () => Navigator.pop(context),
                              ),
                            );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      right:
                                          BorderSide(color: kSecondaryColor))),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 15),
                              child: Text("Apply Same Quantity",
                                  style: TextStyle(color: kSecondaryColor),
                                  textAlign: TextAlign.center)))),
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              useSafeArea: true,
                              showDragHandle: true,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24)),
                              ),
                              builder: (context) => ApplyDifferentQuantitySheet(
                                controller: _controller,
                                selectedProducts:
                                    _controller.products.value.length,
                                onCancel: () => Navigator.pop(context),
                              ),
                            );
                          },
                          child: Container(
                              child: Text("Apply Different Quantity",
                                  style: TextStyle(color: kSecondaryColor),
                                  textAlign: TextAlign.center)))),
                ]))
            : SizedBox.shrink(),
      ));
    });
  }
}
