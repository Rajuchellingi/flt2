// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/product_detail_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCustomVariantDesign2 extends StatelessWidget {
  ProductCustomVariantDesign2(
      {Key? key, required this.design, required controller})
      : _controller = controller,
        super(key: key);

  final design;
  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    var value = metaFieldData(design['value']);
    var variant = metaFieldData(design['variant']);
    if (variant.value == null) return Container();
    return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: brightness == Brightness.dark ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(design['title'],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : kPrimaryTextColor)),
            if (value.value != null &&
                value.type == 'single_line_text_field') ...[
              const SizedBox(width: 5),
              const Text(":"),
              const SizedBox(width: 5),
              Expanded(
                  child: Text(value.value,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryTextColor))),
            ]
          ]),
          const SizedBox(height: 5),
          if (variant.type == 'list.product_reference' &&
              variant.references != null &&
              variant.references.edges != null &&
              variant.references.edges.length > 0) ...[
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  for (var item in variant.references.edges) ...[
                    InkWell(
                        onTap: () {
                          _controller.navigateToProductDetails(item);
                        },
                        child: Container(
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: _controller.product.value.sId == item.sId
                                  ? Border.all(
                                      color: (brightness == Brightness.dark &&
                                              kPrimaryColor == Colors.black)
                                          ? const Color(0xFFB40A0A)
                                          : kPrimaryColor,
                                      width: 2)
                                  : null,
                              shape: BoxShape.rectangle,
                            ),
                            margin: const EdgeInsets.all(4),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                    imageUrl: item.image.url + "&width=120"))))
                  ]
                ]))
          ]
        ]));
  }

  metaFieldData(fieldData) {
    var key = fieldData['key'];
    var namespace = fieldData['namespace'];
    dynamic value = _controller.product.value.metafields!.firstWhere(
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
