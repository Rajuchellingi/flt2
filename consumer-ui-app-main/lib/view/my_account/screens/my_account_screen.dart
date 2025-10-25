// ignore_for_file: unused_element, invalid_use_of_protected_member, unused_local_variable, deprecated_member_use

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/controller/account_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/footer/footer_design1.dart';
import 'package:black_locust/view/footer/footer_design2.dart';
import 'package:black_locust/view/footer/footer_design3.dart';
import 'package:black_locust/view/footer/footer_design4.dart';
import 'package:black_locust/view/footer/footer_design5.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:black_locust/view/my_account/components/my_account_block.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../components/profile_shopify_body.dart';

class MyAccountScreen extends StatelessWidget {
  final _controller = Get.find<AccountController>();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final template = _controller.template.value;
      final layout = template['layout'];
      final header = layout?['header'];
      final footer = layout?['footer'];
      final footerDesign = themeController.bottomBarType.value;
      final isLoading = _controller.isLoading.value;
      final brightness = Theme.of(context).brightness;

      // Memoize footer design checks
      final footerVisibility = footer?['visibility']?['hide'] == false;
      final isDesign1 =
          _isFooterDesign(footer, footerDesign, 'design1', footerVisibility);
      final isDesign2 =
          _isFooterDesign(footer, footerDesign, 'design2', footerVisibility);
      final isDesign3 =
          _isFooterDesign(footer, footerDesign, 'design3', footerVisibility);
      final isDesign4 =
          _isFooterDesign(footer, footerDesign, 'design4', footerVisibility);
      final isDesign5 =
          _isFooterDesign(footer, footerDesign, 'design5', footerVisibility);

      final actionButton = _getFloatingActionButton(footer);

      return SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(header),
          body: _buildBody(isLoading, brightness),
          floatingActionButtonLocation:
              isDesign3 ? FloatingActionButtonLocation.centerDocked : null,
          floatingActionButton: isDesign3 && actionButton != null
              ? CustomFAB(template: template, actionButton: actionButton)
              : null,
          extendBody: isDesign1,
          bottomNavigationBar: _buildBottomNavigationBar(
            isLoading,
            isDesign1,
            isDesign2,
            isDesign3,
            isDesign4,
            isDesign5,
            template,
          ),
          drawerEnableOpenDragGesture: false,
        ),
      );
    });
  }

  bool _isFooterDesign(
      Map? footer, String design, String designType, bool? visibility) {
    return footer != null &&
        footer.isNotEmpty &&
        design == designType &&
        visibility == true;
  }

  PreferredSizeWidget? _buildAppBar(Map? header) {
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

  Widget _buildBody(bool isLoading, Brightness brightness) {
    return Stack(
      children: [
        Container(
          child: isLoading
              ? LoadingIcon(
                  logoPath: themeController.logo.value,
                )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: MyAccountBlock(controller: _controller),
                ),
        ),
      ],
    );
  }

  Widget? _buildBottomNavigationBar(
    bool isLoading,
    bool isDesign1,
    bool isDesign2,
    bool isDesign3,
    bool isDesign4,
    bool isDesign5,
    Map template,
  ) {
    if (isLoading) return null;

    if (isDesign2) return FooterDesign2(template: template);
    if (isDesign4) return FooterDesign4(template: template);
    if (isDesign5) return FooterDesign5(template: template);
    if (isDesign3) return FooterDesign3(template: template);
    if (isDesign1) return FooterDesign1(template: template);

    return null;
  }

  Map? _getFloatingActionButton(Map? footer) {
    if (footer == null) return null;

    final layout = footer['layout'];
    if (layout == null ||
        layout['children'] == null ||
        layout['children'].isEmpty) {
      return null;
    }

    return layout['children'].firstWhere(
      (element) {
        final key = element['key'];
        return footer['options'][key]['isCenterButton'] == true;
      },
      orElse: () => null,
    );
  }
}
