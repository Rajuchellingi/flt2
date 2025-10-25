// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/controller/wishlist_controller.dart';
import 'package:black_locust/view/footer/footer_design1.dart';
import 'package:black_locust/view/footer/footer_design2.dart';
import 'package:black_locust/view/footer/footer_design3.dart';
import 'package:black_locust/view/footer/footer_design4.dart';
import 'package:black_locust/view/footer/footer_design5.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:black_locust/view/wishlist/components/wishlist_block.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistScreen extends StatelessWidget {
  final _controller = Get.find<WishlistController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final template = _controller.template.value;
      final layout = template['layout'];
      final footer = layout?['footer'];
      final header = layout?['header'];
      final footerDesign = themeController.bottomBarType.value;

      // Pre-compute footer visibility conditions
      final isFooterVisible = footer != null &&
          footer.isNotEmpty &&
          footer['visibility']['hide'] == false;

      final isDesign3 = isFooterVisible && footerDesign == 'design3';
      final isDesign2 = isFooterVisible && footerDesign == 'design2';
      final isDesign4 = isFooterVisible && footerDesign == 'design4';
      final isDesign5 = isFooterVisible && footerDesign == 'design5';
      final isDesign1 = isFooterVisible && footerDesign == 'design1';

      final actionButton = themeController.floatingActionButton(footer);

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
          body: Stack(
            children: [
              Container(
                child: _controller.isLoading.value
                    ? LoadingIcon(
                        logoPath: themeController.logo.value,
                      )
                    : WishlistBlock(controller: _controller),
              ),
            ],
          ),
          floatingActionButtonLocation:
              isDesign3 ? FloatingActionButtonLocation.centerDocked : null,
          floatingActionButton: (isDesign3 && actionButton != null)
              ? CustomFAB(
                  template: template,
                  actionButton: actionButton,
                )
              : null,
          extendBody: isDesign1,
          bottomNavigationBar: _buildBottomNavigationBar(
            isDesign2,
            isDesign4,
            isDesign3,
            isDesign5,
            isDesign1,
            template,
          ),
          drawerEnableOpenDragGesture: false,
        ),
      );
    });
  }

  Widget? _buildBottomNavigationBar(
    bool isDesign2,
    bool isDesign4,
    bool isDesign3,
    bool isDesign5,
    bool isDesign1,
    dynamic template,
  ) {
    if (_controller.isTemplateLoading.value == false && isDesign2) {
      return FooterDesign2(template: template);
    } else if (isDesign4) {
      return FooterDesign4(template: template);
    } else if (isDesign3) {
      return FooterDesign3(template: template);
    } else if (isDesign5) {
      return FooterDesign5(template: template);
    } else if (isDesign1) {
      return FooterDesign1(template: template);
    }
    return null;
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
