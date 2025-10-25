// ignore_for_file: invalid_use_of_protected_member, null_check_always_fails

import 'package:black_locust/controller/product_detail_controller.dart';
import 'package:black_locust/model/product_detail_model.dart';
import 'package:black_locust/view/product_detail/components/product_meta_field_design1.dart';
import 'package:flutter/material.dart';

class ProductMetaFields extends StatelessWidget {
  const ProductMetaFields({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final ProductDetailController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (_controller.product.value.metafields != null &&
          _controller.product.value.metafields!.isNotEmpty) ...[
        if (design['instanceId'] == 'design1' && metaFieldData().key != null)
          Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ProductMetaFieldDesign1(
                  design: design,
                  controller: _controller,
                  metaField: metaFieldData()))
      ]
    ]);
  }

  metaFieldData() {
    var key = design['source']['key'];
    var namespace = design['source']['namespace'];
    final value = _controller.product.value.metafields!.firstWhere(
        (element) => element.key == key && element.namespace == namespace,
        orElse: () => MetafieldVM(
            id: null,
            description: null,
            key: null,
            namespace: null,
            reference: null,
            references: null,
            type: null,
            value: null));
    return value;
  }
}
