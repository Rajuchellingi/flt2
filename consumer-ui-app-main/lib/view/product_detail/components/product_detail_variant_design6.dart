// ignore_for_file: unnecessary_null_comparison

import 'package:black_locust/controller/product_detail_v2_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/product_detail/components/product_color_pick_design4.dart';
import 'package:black_locust/view/product_detail/components/product_quantity_update.dart';
import 'package:black_locust/view/product_detail/components/product_set_customizable_design2.dart';
import 'package:black_locust/view/product_detail/components/product_variant_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailVariantDesign6 extends StatelessWidget {
  ProductDetailVariantDesign6(
      {Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final ProductDetailV2Controller _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        // margin: EdgeInsets.only(top: 20),
        // decoration:
        //     BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_controller.product.value.type == 'pack' &&
                _controller.product.value.isCustomizable == true)
              ProductColorPickDesign4(controller: _controller, design: design),
            if (_controller.product.value.type == 'pack' &&
                    _controller.product.value.isCustomizable == false ||
                _controller.product.value.type == 'set' &&
                    _controller.product.value.isCustomizable == false ||
                _controller.product.value.type == 'set' &&
                    _controller.product.value.isAssorted == true)
              Row(
                children: [
                  Obx(() => ProductQuantityUpdate(
                        controller: _controller,
                        size: _controller.product.value.quantity,
                      )),
                ],
              ),
            if (_controller.product.value.type == 'set' &&
                _controller.product.value.isCustomizable == true)
              ProductSetCustomizableDesign2(controller: _controller),
            if (_controller.product.value.type == 'product')
              ProductVariantSelector(controller: _controller)
          ],
        ));
  }
}
