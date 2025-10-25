// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductColorPickDesign3 extends StatelessWidget {
  const ProductColorPickDesign3({Key? key, required controller})
      : _controller = controller,
        super(key: key);

  final _controller;

  @override
  Widget build(BuildContext context) {
    final productSettingController = Get.find<ProductSettingController>();
    final productSetting = productSettingController.productSetting.value;
    final brightness = Theme.of(context).brightness;

    return Obx(() {
      int totalQuantity = _controller.calculateTotalQuantity();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------- Available Colors ----------
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: const Text(
              "Available Colors",
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(
              _controller.product.value.packVariant?.length ?? 0,
              (fieldIndex) {
                final fieldValue =
                    _controller.product.value.packVariant![fieldIndex];

                bool isSelected = _controller.attributeFieldValues.any((attr) =>
                    attr['attributeFieldValueId'] ==
                        fieldValue.attributeFieldValueId &&
                    attr['color'] == fieldValue.fieldValue);

                return GestureDetector(
                  onTap: () {
                    if (_controller.attributeFieldValues.isNotEmpty) {
                      _controller.updateDefaultColor(fieldValue);
                    } else {
                      _controller.selectedColorVariants(fieldValue);
                    }
                  },
                  child: fieldValue.colorCode != null
                      ? Container(
                          width: 28.0,
                          height: 28.0,
                          decoration: BoxDecoration(
                            color: Color(
                              int.parse(fieldValue.colorCode!
                                  .replaceFirst('#', '0xFF')),
                            ),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blue
                                  : const Color.fromARGB(255, 154, 148, 148),
                              width: isSelected ? 2.0 : 1.0,
                            ),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? kPrimaryColor
                                  : const Color.fromARGB(255, 154, 148, 148),
                              width: isSelected ? 2.0 : 1.0,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                            color: isSelected
                                ? kPrimaryColor.withOpacity(0.2)
                                : Colors.transparent,
                          ),
                          child: Text(
                            fieldValue.fieldValue,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? kPrimaryColor
                                  : brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                "Download CatLog",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.orange),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                "Download Image",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
