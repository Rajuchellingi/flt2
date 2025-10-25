// ignore_for_file: deprecated_member_use

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/controller/registration_controller.dart';
import 'package:black_locust/controller/registration_v1_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/footer/footer_design3.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:black_locust/view/register/components/registration_block.dart';
import 'package:black_locust/view/register/components/registration_body_v1.dart';
import 'package:black_locust/view/register/components/registration_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  late final dynamic _controller = platform == 'shopify'
      ? Get.find<RegistrationController>()
      : Get.find<RegistrationV1Controller>();
  late final themeController = Get.find<ThemeController>();

  PreferredSizeWidget? _buildHeader(Map<String, dynamic>? header) {
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

  Widget _buildBody(BuildContext context) {
    if (_controller.isLoading.value) {
      return LoadingIcon(
        logoPath: themeController.logo.value,
      );
    }

    return platform == 'shopify'
        ? RegistrationBlock(controller: _controller)
        : RegistrationFormBodyV1();
  }

  Widget? _buildFloatingActionButton(Map<String, dynamic>? footer) {
    if (footer == null || footer.isEmpty) return null;

    final footerDesign = themeController.bottomBarType.value;
    final isDesign3 =
        footerDesign == 'design3' && footer['visibility']['hide'] == false;

    if (!isDesign3) return null;

    final actionButton = themeController.floatingActionButton(footer);
    if (actionButton == null) return null;

    return CustomFAB(
      template: _controller.template.value,
      actionButton: actionButton,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final template = _controller.template.value;
      final layout = template['layout'];
      final header = layout?['header'];
      final footer = layout?['footer'];

      final footerDesign = themeController.bottomBarType.value;
      final isDesign1 = footer != null &&
          footer.isNotEmpty &&
          footerDesign == 'design1' &&
          footer['visibility']['hide'] == false;
      final isDesign3 = footer != null &&
          footer.isNotEmpty &&
          footerDesign == 'design3' &&
          footer['visibility']['hide'] == false;

      return SafeArea(
        child: Scaffold(
          appBar: _buildHeader(header),
          body: _buildBody(context),
          floatingActionButtonLocation:
              isDesign3 ? FloatingActionButtonLocation.centerDocked : null,
          floatingActionButton: _buildFloatingActionButton(footer),
          extendBody: isDesign1,
          bottomNavigationBar: RegistrationFooter(controller: _controller),
        ),
      );
    });
  }
}
