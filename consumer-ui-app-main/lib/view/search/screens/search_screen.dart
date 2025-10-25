// ignore_for_file: unused_local_variable, invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/controller/search_page_controller.dart';
import 'package:black_locust/controller/search_page_v2_controller.dart';
import 'package:black_locust/view/footer/footer_design3.dart';
import 'package:black_locust/view/search/components/search_blocks.dart';
import 'package:black_locust/view/search/components/search_bottom_header.dart';
import 'package:black_locust/view/search/components/search_footer.dart';
import 'package:black_locust/view/search/components/search_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/theme_controller.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  // Memoize controller initialization
  late final dynamic _controller = platform == 'shopify'
      ? Get.find<SearchPageController>()
      : Get.find<SearchPageV2Controller>();
  // : Get.find<SearchPageV1Controller>();
  late final themeController = Get.find<ThemeController>();

  PreferredSize _buildBottomHeader(
      dynamic controller, Map<String, dynamic> bottomHeader) {
    return PreferredSize(
      child: Container(
        color: themeController.headerStyle(
          'backgroundColor',
          bottomHeader['style']['root']['backgroundColor'],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SearchBottomHeader(controller: controller),
      ),
      preferredSize: const Size.fromHeight(40.0),
    );
  }

  PreferredSize _buildEmptyPreferredSize() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(0.0),
      child: SizedBox.shrink(),
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return LoadingIcon(
      logoPath: themeController.logo.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dynamic argument = Get.arguments;

    return Obx(() {
      final template = _controller.template.value;
      final layout = template['layout'];
      final isLoading = _controller.isLoading.value;

      final isBottomHeader =
          layout['bottom-header'] != null && layout['bottom-header'].isNotEmpty;
      final header = layout['header'];
      final bottomHeader = layout['bottom-header'];
      final footer = layout['footer'];

      final actionButton = themeController.floatingActionButton(footer);
      final isDesign3 = themeController.bottomBarType.value == 'design3';
      final extendBody = themeController.bottomBarType.value == 'design1' &&
          footer['componentId'] == 'footer-navigation';

      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: themeController.headerStyle(
              'backgroundColor',
              header['style']['root']['backgroundColor'],
            ),
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
            elevation: 0.0,
            forceMaterialTransparency: isBottomHeader,
            title: isLoading
                ? const SizedBox.shrink()
                : SearchHeader(controller: _controller),
            bottom: (!isLoading && isBottomHeader)
                ? _buildBottomHeader(_controller, bottomHeader)
                : _buildEmptyPreferredSize(),
          ),
          body: isLoading
              ? _buildLoadingIndicator(context)
              : SearchBlocks(controller: _controller),
          floatingActionButtonLocation:
              isDesign3 ? FloatingActionButtonLocation.centerDocked : null,
          floatingActionButton: (isDesign3 && actionButton != null)
              ? CustomFAB(
                  template: template,
                  actionButton: actionButton,
                )
              : null,
          extendBody: extendBody,
          bottomNavigationBar: SearchFooter(controller: _controller),
        ),
      );
    });
  }
}
