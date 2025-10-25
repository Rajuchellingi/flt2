// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/controller/order_enquiry_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/enquiry_history/components/enquiry_history_block.dart';
import 'package:black_locust/view/footer/footer_design1.dart';
import 'package:black_locust/view/footer/footer_design2.dart';
import 'package:black_locust/view/footer/footer_design3.dart';
import 'package:black_locust/view/footer/footer_design4.dart';
import 'package:black_locust/view/footer/footer_design5.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnquiryHistoryScreen extends StatelessWidget {
  final dynamic _controller = Get.find<OrderEnquiryController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var header = _controller.template.value['layout'] != null
          ? _controller.template.value['layout']['header']
          : null;
      var footer = _controller.template.value['layout'] != null
          ? _controller.template.value['layout']['footer']
          : null;
      var footerDesign = themeController.bottomBarType.value;
      final isDesign1 = footer != null &&
          footer.isNotEmpty &&
          footerDesign == 'design1' &&
          footer['visibility']['hide'] == false;
      final isDesign2 = footer != null &&
          footer.isNotEmpty &&
          footerDesign == 'design2' &&
          footer['visibility']['hide'] == false;
      final isDesign4 = footer != null &&
          footer.isNotEmpty &&
          footerDesign == 'design4' &&
          footer['visibility']['hide'] == false;
      final isDesign5 = footer != null &&
          footer.isNotEmpty &&
          footerDesign == 'design5' &&
          footer['visibility']['hide'] == false;
      final isDesign3 = footer != null &&
          footer.isNotEmpty &&
          footerDesign == 'design3' &&
          footer['visibility']['hide'] == false;
      final actionButton = floatingActionButton(footer);
      final brightness = Theme.of(context).brightness;

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
          body: Stack(children: [
            Container(
                child: _controller.isLoading.value
                    ? LoadingIcon(
                        logoPath: themeController.logo.value,
                      )
                    : EnquiryHistoryBlock(controller: _controller)),
            if (footer['instanceId'] == 'design1' &&
                footer['visibility']['hide'] == false)
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: FooterDesign1(template: _controller.template.value),
              ),
          ]),
          floatingActionButtonLocation:
              isDesign3 ? FloatingActionButtonLocation.centerDocked : null,
          floatingActionButton: (isDesign3 && actionButton != null)
              ? CustomFAB(
                  template: _controller.template.value,
                  actionButton: actionButton)
              : null,
          extendBody: isDesign1,
          bottomNavigationBar: (_controller.isTemplateLoading.value == false &&
                  isDesign2)
              ? FooterDesign2(template: _controller.template.value)
              : isDesign4
                  ? FooterDesign4(template: _controller.template.value)
                  : isDesign3
                      ? FooterDesign3(template: _controller.template.value)
                      : isDesign5
                          ? FooterDesign5(template: _controller.template.value)
                          : isDesign1
                              ? FooterDesign1(
                                  template: _controller.template.value)
                              : null,
          drawerEnableOpenDragGesture: false,
        ),
      );
    });
  }

  floatingActionButton(footer) {
    if (footer != null) {
      if (footer['layout'] != null &&
          footer['layout']['children'] != null &&
          footer['layout']['children'].length > 0) {
        var data = footer['layout']['children'].firstWhere(
          (element) {
            var key = element['key'];
            return footer['options'][key]['isCenterButton'] == true;
          },
          orElse: () => null,
        );

        return data;
      }
    }
  }
}
