// ignore_for_file: unused_element, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/cart_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/cart/components/cart_blocks.dart';
import 'package:black_locust/view/cart/components/cart_footer.dart';
import 'package:black_locust/view/footer/footer_design3.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  final _controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final brightness = Theme.of(context).brightness;

    return SafeArea(
      top: false,
      child: Obx(() {
        // Memoize expensive computations
        final template = _controller.template.value;
        final layout = template['layout'];
        final header = layout?['header'];
        final footer = layout?['footer'];
        final actionButton = themeController.floatingActionButton(footer);
        final isDesign3 = themeController.bottomBarType.value == 'design3';
        final isLoading = _controller.isLoading.value;

        return Scaffold(
          appBar: _buildAppBar(header, themeController),
          body: _buildBody(isLoading, brightness, _controller, themeController),
          floatingActionButtonLocation:
              isDesign3 ? FloatingActionButtonLocation.centerDocked : null,
          floatingActionButton:
              _buildFloatingActionButton(isDesign3, actionButton, template),
          extendBody: _shouldExtendBody(themeController, footer),
          bottomNavigationBar: CartFooter(controller: _controller),
        );
      }),
    );
  }

  PreferredSizeWidget? _buildAppBar(
      Map? header, ThemeController themeController) {
    if (header == null || header.isEmpty) return null;

    return AppBar(
      backgroundColor: themeController.headerStyle(
        'backgroundColor',
        header['style']['root']['backgroundColor'],
      ),
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      elevation: 0.0,
      forceMaterialTransparency: true,
      title: CommonHeader(header: header),
    );
  }

  Widget _buildBody(bool isLoading, Brightness brightness,
      CartController controller, ThemeController themeController) {
    return isLoading
        ? LoadingIcon(
            logoPath: themeController.logo.value,
          )
        : CartBlocks(controller: controller);
  }

  Color _getProgressBackgroundColor(Brightness brightness) {
    if (brightness == Brightness.dark && kPrimaryColor == Colors.black) {
      return Colors.white;
    }
    return Color.fromRGBO(
      kPrimaryColor.red,
      kPrimaryColor.green,
      kPrimaryColor.blue,
      0.2,
    );
  }

  Widget? _buildFloatingActionButton(
      bool isDesign3, dynamic actionButton, Map template) {
    if (!isDesign3 || actionButton == null) return null;

    return CustomFAB(
      template: template,
      actionButton: actionButton,
    );
  }

  bool _shouldExtendBody(ThemeController themeController, Map? footer) {
    return themeController.bottomBarType.value == 'design1' &&
        footer?['componentId'] == 'footer-navigation';
  }
}
