// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/controller/order_detail_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/footer/footer_design1.dart';
import 'package:black_locust/view/footer/footer_design2.dart';
import 'package:black_locust/view/footer/footer_design3.dart';
import 'package:black_locust/view/footer/footer_design4.dart';
import 'package:black_locust/view/footer/footer_design5.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:black_locust/view/order_detail/components/order_detail_block.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<OrderDetailController>();
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final template = _controller.template.value as Map<String, dynamic>;
      final layout = template['layout'] as Map<String, dynamic>?;
      final header = layout?['header'] as Map<String, dynamic>?;
      final footer = layout?['footer'] as Map<String, dynamic>?;
      final footerDesign = themeController.bottomBarType.value;
      final brightness = Theme.of(context).brightness;

      // Memoize footer design checks
      final isDesign1 = _isFooterDesign(footer, footerDesign, 'design1');
      final isDesign2 = _isFooterDesign(footer, footerDesign, 'design2');
      final isDesign3 = _isFooterDesign(footer, footerDesign, 'design3');
      final isDesign4 = _isFooterDesign(footer, footerDesign, 'design4');
      final isDesign5 = _isFooterDesign(footer, footerDesign, 'design5');

      final actionButton = _getFloatingActionButton(footer);

      return SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(header, themeController),
          body: _buildBody(_controller, themeController, brightness),
          floatingActionButtonLocation:
              isDesign3 ? FloatingActionButtonLocation.centerDocked : null,
          floatingActionButton: (isDesign3 && actionButton != null)
              ? CustomFAB(template: template, actionButton: actionButton)
              : null,
          bottomNavigationBar: _buildBottomNavigationBar(_controller, template,
              isDesign1, isDesign2, isDesign3, isDesign4, isDesign5),
          drawerEnableOpenDragGesture: false,
        ),
      );
    });
  }

  bool _isFooterDesign(
      Map<String, dynamic>? footer, String design, String designType) {
    return footer != null &&
        footer.isNotEmpty &&
        design == designType &&
        footer['visibility']['hide'] == false;
  }

  Map<String, dynamic>? _getFloatingActionButton(Map<String, dynamic>? footer) {
    if (footer == null) return null;

    final layout = footer['layout'] as Map<String, dynamic>?;
    if (layout == null ||
        layout['children'] == null ||
        (layout['children'] as List).isEmpty) return null;

    return (layout['children'] as List).firstWhere(
      (element) {
        final key = (element as Map<String, dynamic>)['key'];
        return footer['options'][key]['isCenterButton'] == true;
      },
      orElse: () => null,
    ) as Map<String, dynamic>?;
  }

  PreferredSizeWidget? _buildAppBar(
      Map<String, dynamic>? header, ThemeController themeController) {
    if (header == null || header.isEmpty) return null;

    return AppBar(
      backgroundColor: themeController.headerStyle(
          'backgroundColor', header['style']['root']['backgroundColor']),
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      elevation: 0.0,
      forceMaterialTransparency: true,
      title: CommonHeader(header: header),
    );
  }

  Widget _buildBody(OrderDetailController controller,
      ThemeController themeController, Brightness brightness) {
    if (controller.isLoading.value) {
      return LoadingIcon(
        logoPath: themeController.logo.value,
      );
    }

    return Stack(
      children: [
        OrderDetailBlock(controller: controller),
      ],
    );
  }

  Widget? _buildBottomNavigationBar(
    OrderDetailController controller,
    Map<String, dynamic> template,
    bool isDesign1,
    bool isDesign2,
    bool isDesign3,
    bool isDesign4,
    bool isDesign5,
  ) {
    if (controller.isTemplateLoading.value == false && isDesign2) {
      return FooterDesign2(template: template);
    }
    if (isDesign4) return FooterDesign4(template: template);
    if (isDesign3) return FooterDesign3(template: template);
    if (isDesign5) return FooterDesign5(template: template);
    if (isDesign1) return FooterDesign1(template: template);
    return null;
  }
}
