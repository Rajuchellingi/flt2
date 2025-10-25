// ignore_for_file: unused_element, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/controller/category_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
// import 'package:black_locust/controller/navMenuType_controller.dart';
import 'package:black_locust/view/category/components/category_body_design.dart';
// import 'package:black_locust/view/category/components/category_body_v1.dart';
// import 'package:black_locust/view/category/components/category_body_v2.dart';
// import 'package:black_locust/view/category/components/category_body_v3.dart';
import 'package:black_locust/view/footer/footer_design1.dart';
import 'package:black_locust/view/footer/footer_design2.dart';
import 'package:black_locust/view/footer/footer_design3.dart';
import 'package:black_locust/view/footer/footer_design4.dart';
import 'package:black_locust/view/footer/footer_design5.dart';
import 'package:black_locust/view/header/common_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<CategoryController>();
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final template = _controller.template.value;
      final header = template['layout']?['header'];
      final footer = template['layout']?['footer'];
      final footerDesign = themeController.bottomBarType.value;
      final isBottomHeader = template['layout']?['bottom-header'] != null &&
          template['layout']?['bottom-header'].isNotEmpty;
      final bottomHeader = template['layout']?['bottom-header'];
      final brightness = Theme.of(context).brightness;

      // Memoize footer design checks
      final isDesign3 = _isFooterDesignVisible(footer, footerDesign, 'design3');
      final isDesign2 = _isFooterDesignVisible(footer, footerDesign, 'design2');
      final isDesign4 = _isFooterDesignVisible(footer, footerDesign, 'design4');
      final isDesign5 = _isFooterDesignVisible(footer, footerDesign, 'design5');
      final isDesign1 = _isFooterDesignVisible(footer, footerDesign, 'design1');

      final actionButton = themeController.floatingActionButton(footer);

      return SafeArea(
        top: false,
        child: Scaffold(
          appBar: _buildAppBar(header, isBottomHeader, bottomHeader,
              _controller, themeController),
          body: _buildBody(_controller, brightness, themeController),
          floatingActionButtonLocation:
              isDesign3 ? FloatingActionButtonLocation.centerDocked : null,
          floatingActionButton: (isDesign3 && actionButton != null)
              ? CustomFAB(template: template, actionButton: actionButton)
              : null,
          extendBody: isDesign1,
          bottomNavigationBar: _buildBottomNavigationBar(
            _controller.isLoading.value,
            isDesign2,
            isDesign4,
            isDesign5,
            isDesign1,
            template,
          ),
          drawerEnableOpenDragGesture: false,
        ),
      );
    });
  }

  bool _isFooterDesignVisible(Map? footer, String footerDesign, String design) {
    return footer != null &&
        footer.isNotEmpty &&
        footerDesign == design &&
        footer['visibility']['hide'] == false;
  }

  PreferredSizeWidget? _buildAppBar(
    Map? header,
    bool isBottomHeader,
    Map? bottomHeader,
    CategoryController controller,
    ThemeController themeController,
  ) {
    if (header == null || header.isEmpty) return null;

    return AppBar(
      backgroundColor: themeController.headerStyle(
        'backgroundColor',
        header['style']['root']['backgroundColor'],
      ),
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      elevation: 0.0,
      forceMaterialTransparency: isBottomHeader,
      title: controller.isLoading.value
          ? const SizedBox.shrink()
          : CommonHeader(header: header),
      bottom: (controller.isLoading.value == false && isBottomHeader)
          ? PreferredSize(
              child: Container(
                color: themeController.headerStyle(
                  'backgroundColor',
                  bottomHeader?['style']['root']['backgroundColor'],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CommonHeader(header: bottomHeader),
              ),
              preferredSize: Size.fromHeight(
                  bottomHeader!['style']['root']['height'] != null
                      ? bottomHeader['style']['root']['height'].toDouble()
                      : 50),
            )
          : const PreferredSize(
              preferredSize: Size.fromHeight(0.0),
              child: SizedBox.shrink(),
            ),
    );
  }

  Widget _buildBody(CategoryController controller, Brightness brightness,
      ThemeController themeController) {
    return Stack(
      children: [
        Container(
          child: controller.isLoading.value
              ? LoadingIcon(
                  logoPath: themeController.logo.value,
                )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: CategoryBodyDesign(controller: controller),
                ),
        ),
      ],
    );
  }

  Widget? _buildBottomNavigationBar(
    bool isLoading,
    bool isDesign2,
    bool isDesign4,
    bool isDesign5,
    bool isDesign1,
    Map template,
  ) {
    if (isLoading) return null;

    if (isDesign2) {
      return FooterDesign2(template: template);
    } else if (isDesign4) {
      return FooterDesign4(template: template);
    } else if (isDesign5) {
      return FooterDesign5(template: template);
    } else if (isDesign1) {
      return FooterDesign1(template: template);
    }
    return null;
  }

  // Widget _getCategoryBody() {
  //   switch (navMenuController.menuType.value) {
  //     case 'design1':
  //       return CategoryBodyV1();
  //     case 'design2':
  //       return CategoryPageV2();
  //     case 'design3':
  //       return CategoryPageV3();
  //   }
  //   return SizedBox.shrink();
  // }
}
