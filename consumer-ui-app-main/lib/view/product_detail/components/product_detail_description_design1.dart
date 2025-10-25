import 'package:black_locust/view/product_detail/components/product_detail_collapse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/product_setting_controller.dart';

class ProductDetailDescriptionDesign1 extends StatelessWidget {
  ProductDetailDescriptionDesign1(
      {required this.product, required this.designBlock});
  final product;
  final designBlock;
  final _pController = Get.find<ProductSettingController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      ProductDetailCollapse(
        designBlock: designBlock,
        title: "Description",
        description: product.bulletPoints,
      ),
      if (_pController.productSetting.value.productPolicy != null &&
          _pController.productSetting.value.productPolicy!.length > 0)
        for (var i = 0;
            i < _pController.productSetting.value.productPolicy!.length;
            i++)
          ProductDetailCollapse(
              designBlock: designBlock,
              title: _pController.productSetting.value.productPolicy![i].title!,
              description: _pController
                  .productSetting.value.productPolicy![i].description),
    ]));
  }
}
