// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:black_locust/common_component/loading_icon.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/controller/product_detail_v2_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/footer/footer_design3.dart';
import 'package:black_locust/view/product_detail/components/product_detail_blocks.dart';
import 'package:black_locust/view/product_detail/components/product_detail_footer.dart';
import 'package:black_locust/view/product_detail/components/product_detail_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/product_detail_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({Key? key}) : super(key: key);

  // Memoize controllers using late initialization
  late final dynamic _controller = platform == 'shopify'
      ? Get.find<ProductDetailController>()
      : Get.find<ProductDetailV2Controller>();
  late final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    // print("template.value ------>>>> ${_controller.template.value.toString()}");
    return Obx(() {
      final template = _controller.template.value;
      final header = template['layout']['header'];
      final footerDesign = themeController.bottomBarType.value;
      final footer = template['layout']['footer'];
      final actionButton = themeController.floatingActionButton(footer);
      final isLoading = _controller.isLoading.value;
      final brightness = Theme.of(context).brightness;

      return SafeArea(
        child: Scaffold(
          key: const ValueKey('product_detail_scaffold'),
          appBar: AppBar(
            key: const ValueKey('product_detail_appbar'),
            backgroundColor: themeController.headerStyle(
                'backgroundColor', header['style']['root']['backgroundColor']),
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
            elevation: 0.0,
            forceMaterialTransparency: true,
            title: isLoading
                ? const SizedBox.shrink()
                : ProductDetailHeader(
                    key: const ValueKey('product_detail_header'),
                    controller: _controller,
                  ),
          ),
          body: Container(
            key: const ValueKey('product_detail_body'),
            child: isLoading
                ? LoadingIcon(
                    logoPath: themeController.logo.value,
                  )
                : ProductDetailBlocks(
                    key: const ValueKey('product_detail_blocks'),
                    controller: _controller,
                  ),
          ),
          extendBody: footer['componentId'] == 'footer-navigation' &&
              footerDesign == 'design1',
          floatingActionButtonLocation: footerDesign == 'design3'
              ? FloatingActionButtonLocation.centerDocked
              : null,
          floatingActionButton:
              (footerDesign == 'design3' && actionButton != null)
                  ? CustomFAB(
                      key: const ValueKey('product_detail_fab'),
                      template: template,
                      actionButton: actionButton,
                    )
                  : null,
          bottomNavigationBar: isLoading
              ? const SizedBox.shrink()
              : ProductDetailFooter(
                  key: const ValueKey('product_detail_footer'),
                  controller: _controller,
                ),
        ),
      );
    });
  }
}
