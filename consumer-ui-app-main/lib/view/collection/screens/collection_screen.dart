// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/controller/collection_controller.dart';
import 'package:black_locust/controller/collection_v2_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/collection/components/collection_blocks.dart';
import 'package:black_locust/view/collection/components/collection_footer.dart';
import 'package:black_locust/view/collection/components/collection_header.dart';
import 'package:black_locust/view/footer/footer_design3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionScreen extends StatelessWidget {
  final dynamic _controller = platform == 'shopify'
      ? Get.find<CollectionController>()
      : Get.find<CollectionV1ControllerV2>();

  // : Get.find<CollectionV1Controller>();
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final template = _controller.template.value;
      final layout = template['layout'];
      final header = layout['header'];
      final bottomHeader = layout['bottom-header'];
      final footer = layout['footer'];
      final isBottomHeader = bottomHeader != null && bottomHeader.isNotEmpty;
      final actionButton = themeController.floatingActionButton(footer);
      final isDesign3 = themeController.bottomBarType.value == 'design3';
      final brightness = Theme.of(context).brightness;

      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: themeController.headerStyle(
                'backgroundColor', header['style']['root']['backgroundColor']),
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
            elevation: 0.0,
            forceMaterialTransparency: isBottomHeader,
            title: _controller.isLoading.value
                ? const SizedBox.shrink()
                : CollectionHeader(controller: _controller),
            // bottom: (_controller.isLoading.value == false && isBottomHeader)
            //     ? PreferredSize(
            //         preferredSize: const Size.fromHeight(40.0),
            //         child: Container(
            //           color: themeController.headerStyle('backgroundColor',
            //               bottomHeader['style']['root']['backgroundColor']),
            //           padding: const EdgeInsets.symmetric(horizontal: 15),
            //           child: CollectionBottomHeader(controller: _controller),
            //         ),
            //       )
            //     : const PreferredSize(
            //         preferredSize: Size.fromHeight(0.0),
            //         child: SizedBox.shrink(),
            //       ),
          ),
          body: Obx(
            () => _controller.isLoading.value
                ? LoadingIcon(
                    logoPath: themeController.logo.value,
                  )
                : CollectionBlocks(controller: _controller),
          ),
          floatingActionButtonLocation:
              isDesign3 ? FloatingActionButtonLocation.centerDocked : null,
          floatingActionButton: (isDesign3 && actionButton != null)
              ? CustomFAB(
                  template: template,
                  actionButton: actionButton,
                )
              : null,
          extendBody: themeController.bottomBarType.value == 'design1' &&
              footer['componentId'] == 'footer-navigation',
          bottomNavigationBar: CollectionFooter(controller: _controller),
        ),
      );
    });
  }
}
