// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductSetCustomizableDesign2 extends StatelessWidget {
  const ProductSetCustomizableDesign2({Key? key, required controller})
      : _controller = controller,
        super(key: key);

  final _controller;

  @override
  Widget build(BuildContext context) {
    final productSettingController = Get.find<ProductSettingController>();
    final productSetting = productSettingController.productSetting.value;
    // final brightness = Theme.of(context).brightness;

    return Container(
      child: Obx(
        () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (var variant in _controller.product.value.variants) ...[
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Enter Quantity",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Container(
                    width: SizeConfig.screenWidth,
                    child: TextField(
                      controller:
                          _controller.getVariantController(variant.variantId),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 5,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    var price =
                                        productSetting.priceDisplayType == 'mrp'
                                            ? variant.price?.mrp
                                            : variant.price?.sellingPrice;
                                    _controller.minusVariantQuantity(
                                        variant.variantId, price);
                                  },
                                  child:
                                      Icon(Icons.remove, color: Colors.grey)),
                              Text('|', style: TextStyle(color: Colors.grey)),
                              GestureDetector(
                                  onTap: () {
                                    var price =
                                        productSetting.priceDisplayType == 'mrp'
                                            ? variant.price?.mrp
                                            : variant.price?.sellingPrice;
                                    _controller.addVariantQuantity(
                                        variant.variantId, price);
                                  },
                                  child: Icon(Icons.add, color: Colors.grey)),
                              SizedBox(width: 5)
                            ]),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 3, horizontal: 10), // Adjust height
                      ),
                      keyboardType: TextInputType.number,
                      enabled: true,
                      onChanged: (value) {
                        var price = productSetting.priceDisplayType == 'mrp'
                            ? variant.price?.mrp
                            : variant.price?.sellingPrice;
                        _controller.changeTotalPrice(price, value);
                        _controller.selectedValue(variant.variantId, value);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Total:"),
                    Text(
                        "${_controller.product.value.currencySymbol}${_controller.totalPrice.value}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))
                  ]))
        ]),
      ),
    );
  }
}
