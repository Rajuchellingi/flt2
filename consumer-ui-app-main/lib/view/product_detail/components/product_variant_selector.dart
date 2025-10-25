// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/product_detail_v1_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductVariantSelector extends StatelessWidget {
  const ProductVariantSelector({Key? key, required controller})
      : _controller = controller,
        super(key: key);

  final ProductDetailV1Controller _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final productVariant = _controller.product.value.productVariant ?? [];
      if (productVariant.isNotEmpty)
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (var element in productVariant) ...[
            Text(element.attributeLabelName.toString(),
                style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 5),
            if (element.variantOptions != null &&
                element.variantOptions!.isNotEmpty)
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    for (var data in element.variantOptions!) ...[
                      if (_controller.hasVariant(element, data)) ...[
                        GestureDetector(
                            onTap: () {
                              _controller.onSelectVariant({
                                'variant': element.toJson(),
                                'variantOption': data.toJson()
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: _controller.isVariantSelected(
                                            element, data)
                                        ? kPrimaryColor.withOpacity(0.3)
                                        : Colors.transparent,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(data.attributeFieldValue!))),
                        const SizedBox(width: 10)
                      ]
                    ]
                  ])),
            SizedBox(height: 10)
          ]
        ]);
      else
        return Container();
    });
  }
}
