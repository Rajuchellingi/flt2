import 'package:black_locust/view/product_detail/components/product_detail_collapse_desing4.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/product_setting_controller.dart';

class ProductDetailDescriptionDesign5 extends StatelessWidget {
  ProductDetailDescriptionDesign5(
      {required this.product, required this.designBlock});
  final product;
  final designBlock;
  final _pController = Get.find<ProductSettingController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 5),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.grey.withAlpha(100),
        //       offset: Offset(0, 4),
        //       blurRadius: 6,
        //       spreadRadius: 6,
        //     ),
        //     BoxShadow(
        //       color: Colors.grey.withAlpha(100),
        //       offset: Offset(0, 4),
        //       blurRadius: 2,
        //       spreadRadius: 0,
        //     ),
        //   ],
        // ),
        child: Column(children: [
          ProductDetailCollapse4(
            designBlock: designBlock,
            title: "",
            description: product.description,
          ),
          if (_pController.productSetting.value.productPolicy != null &&
              _pController.productSetting.value.productPolicy!.length > 0)
            for (var i = 0;
                i < _pController.productSetting.value.productPolicy!.length;
                i++)
              ProductDetailCollapse4(
                  designBlock: designBlock,
                  title: _pController
                      .productSetting.value.productPolicy![i].title!,
                  description: _pController
                      .productSetting.value.productPolicy![i].description),
        ]));
  }
}
