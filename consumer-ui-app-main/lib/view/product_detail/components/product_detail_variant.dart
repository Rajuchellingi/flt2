// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/product_detail/components/detail_page_size_chart_design1.dart';
import 'package:black_locust/view/product_detail/components/detail_page_size_chart_design2.dart';
import 'package:black_locust/view/product_detail/components/product_detail_variant_design1.dart';
import 'package:black_locust/view/product_detail/components/product_detail_variant_design10.dart';
import 'package:black_locust/view/product_detail/components/product_detail_variant_design2.dart';
import 'package:black_locust/view/product_detail/components/product_detail_variant_design3.dart';
import 'package:black_locust/view/product_detail/components/product_detail_variant_design4.dart';
import 'package:black_locust/view/product_detail/components/product_detail_variant_design5.dart';
import 'package:black_locust/view/product_detail/components/product_detail_variant_design6.dart';
import 'package:black_locust/view/product_detail/components/product_detail_variant_design7.dart';
import 'package:black_locust/view/product_detail/components/product_detail_variant_design8.dart';
import 'package:black_locust/view/product_detail/components/product_detail_variant_design9.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailVariant extends StatelessWidget {
  ProductDetailVariant({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (design['instanceId'] == 'design1')
        ProductDetailVariantDesign1(controller: _controller, design: design)
      else if (design['instanceId'] == 'design2')
        ProductDetailVariantDesign2(controller: _controller, design: design)
      else if (design['instanceId'] == 'design3')
        ProductDetailVariantDesign3(controller: _controller, design: design)
      else if (design['instanceId'] == 'design4')
        ProductDetailVariantDesign4(controller: _controller, design: design)
      else if (design['instanceId'] == 'design5')
        ProductDetailVariantDesign5(controller: _controller, design: design)
      else if (design['instanceId'] == 'design6')
        ProductDetailVariantDesign6(controller: _controller, design: design)
      else if (design['instanceId'] == 'design7')
        ProductDetailVariantDesign7(controller: _controller, design: design)
      else if (design['instanceId'] == 'design8')
        ProductDetailVariantDesign8(controller: _controller, design: design)
      else if (design['instanceId'] == 'design9')
        ProductDetailVariantDesign9(controller: _controller, design: design)
      else if (design['instanceId'] == 'design10')
        ProductDetailVariantDesign10(controller: _controller, design: design),
      Obx(() {
        if (_controller.isSizeChart.value == true &&
            _controller.displayMode.value == "Embedded Mode") {
          return DetailPageSizeChartDesign1(
              product: _controller.product.value,
              shop: _controller.shop.value,
              code: _controller.code.value);
        } else if (_controller.isSizeChart.value == true &&
            _controller.displayMode.value == "Inline Mode")
          return DetailPageSizeChartDesign2(
              product: _controller.product.value,
              shop: _controller.shop.value,
              code: _controller.code.value);
        return const SizedBox.shrink();
      }),
      // else if (_controller.isSizeChart.value == true &&
      //     _controller.displayMode.value == "Inline Mode")
      //   DetailPageSizeChartDesign2(
      //     product: _controller.product.value,
      //   )
    ]);
  }
}
