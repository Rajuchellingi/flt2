// ignore_for_file: unused_field, invalid_use_of_protected_member

import 'package:black_locust/common_component/cached_network_image.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/quick_cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/common_helper.dart';

class QuickCartDesign3 extends StatelessWidget {
  final image;
  final title;
  final price;
  final dynamic product;

  QuickCartDesign3(
      {Key? key,
      required this.product,
      required this.image,
      required this.price,
      required this.title})
      : super(key: key);
  final _controller = Get.find<QuickCartController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    var mrp = product.price!.mrp;
    Future.delayed(Duration(milliseconds: 500), () {
      _controller.getProductVaraiants(product.options);
    });
    return Obx(() {
      return Container(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
          child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                // Header
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select colour & size',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Divider(),
                const SizedBox(height: 20),
                // Product Card
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: brightness == Brightness.dark
                        ? Color(0xFF2A2A2A)
                        : Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImageWidget(
                              fill: BoxFit.cover, image: image),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              spacing: 7,
                              children: [
                                Text(
                                  CommonHelper.currencySymbol() +
                                      ' ' +
                                      price.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                if (mrp != 0 && mrp != null && mrp != price)
                                  Text(
                                    CommonHelper.currencySymbol() +
                                        ' ' +
                                        mrp.toString(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                discountValue()
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (product.options != null && product.options.length > 0)
                  for (var element in product.options)
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            element.name.toString() + ':',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              spacing: 5,
                              children: [
                                if (element.values != null &&
                                    element.values.length > 0)
                                  if (product.options.length == 1)
                                    for (var variant in _controller
                                        .getAvailableVariantOptions(
                                            product, element.name))
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  if (variant.isAvailable!)
                                                    _controller
                                                        .getProductByVariant(
                                                            element.name,
                                                            variant.name,
                                                            product);
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 7,
                                                    horizontal: 9,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: _controller
                                                            .selectedProductVariants
                                                            .value
                                                            .any((da) =>
                                                                da['type'] ==
                                                                    element
                                                                        .name &&
                                                                da['value'] ==
                                                                    variant
                                                                        .name)
                                                        ? brightness ==
                                                                Brightness.dark
                                                            ? Colors.white
                                                            : Colors.black
                                                        : variant.isAvailable ==
                                                                false
                                                            ? const Color
                                                                .fromARGB(255,
                                                                240, 240, 240)
                                                            : brightness ==
                                                                    Brightness
                                                                        .dark
                                                                ? Color(
                                                                    0xFF2A2A2A)
                                                                : Colors.white,
                                                    border: Border.all(
                                                      color: _controller
                                                              .selectedProductVariants
                                                              .value
                                                              .any((da) =>
                                                                  da['type'] ==
                                                                      element
                                                                          .name &&
                                                                  da['value'] ==
                                                                      variant
                                                                          .name)
                                                          ? brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? Colors.white
                                                              : Colors.black
                                                          : Color.fromARGB(255,
                                                              220, 220, 220),
                                                      width: 1.5,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    variant.name.toString(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: _controller
                                                              .selectedProductVariants
                                                              .value
                                                              .any((da) =>
                                                                  da['type'] ==
                                                                      element
                                                                          .name &&
                                                                  da['value'] ==
                                                                      variant
                                                                          .name)
                                                          ? brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? Colors.black
                                                              : Colors.white
                                                          : brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? Colors.white
                                                              : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if (!variant.isAvailable!)
                                                Positioned.fill(
                                                  child: const Divider(
                                                    color: Colors.grey,
                                                    thickness: 1.0,
                                                  ),
                                                ),
                                            ]),
                                      )
                                  else
                                    for (var variant in element.values!)
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            _controller.getProductByVariant(
                                                element.name,
                                                variant.name,
                                                product);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                              horizontal: 20,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: _controller
                                                      .selectedProductVariants
                                                      .value
                                                      .any((da) =>
                                                          da['type'] ==
                                                              element.name &&
                                                          da['value'] ==
                                                              variant.name)
                                                  ? brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : Colors.black
                                                  : brightness ==
                                                          Brightness.dark
                                                      ? Color(0xFF2A2A2A)
                                                      : Colors.white,
                                              border: Border.all(
                                                color: _controller
                                                        .selectedProductVariants
                                                        .value
                                                        .any((da) =>
                                                            da['type'] ==
                                                                element.name &&
                                                            da['value'] ==
                                                                variant.name)
                                                    ? brightness ==
                                                            Brightness.dark
                                                        ? Colors.white
                                                        : Colors.black
                                                    : Color.fromARGB(
                                                        255, 220, 220, 220),
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Text(
                                              variant.name.toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: _controller
                                                          .selectedProductVariants
                                                          .value
                                                          .any((da) =>
                                                              da['type'] ==
                                                                  element
                                                                      .name &&
                                                              da['value'] ==
                                                                  variant.name)
                                                      ? brightness ==
                                                              Brightness.dark
                                                          ? Colors.black
                                                          : Colors.white
                                                      : brightness ==
                                                              Brightness.dark
                                                          ? Colors.white
                                                          : Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                // Validation message
                if (_controller.selectedProductVariants.value.length <
                    (product.options?.length ?? 0))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Please select ${product.options?.map((e) => e.name).join(' and ')} to proceed',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                // Quantity section
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Quantity selector
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 220, 220, 220),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          // Decrease quantity logic
                          if (_controller.quantity.value > 1) {
                            _controller.quantity.value--;
                          }
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                          alignment: Alignment.center,
                          child: Icon(Icons.remove, size: 24),
                        ),
                      ),
                      Container(
                        width: 1.5,
                        color: Color.fromARGB(255, 220, 220, 220),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                        alignment: Alignment.center,
                        child: Obx(() => Text(
                              _controller.quantity.value.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ),
                      Container(
                        width: 1.5,
                        color: Color.fromARGB(255, 220, 220, 220),
                      ),
                      InkWell(
                        onTap: () {
                          // Increase quantity logic
                          _controller.quantity.value++;
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                          alignment: Alignment.center,
                          child: Icon(Icons.add, size: 24),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Add to Cart button
                Container(
                    width: SizeConfig.screenWidth,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          _controller.productAddToCart(product);
                        },
                        child: const Text(
                          "Add to Cart",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brightness == Brightness.dark
                              ? kPrimaryColor == Colors.black
                                  ? Colors.white
                                  : kPrimaryColor
                              : Colors.black,
                          foregroundColor: brightness == Brightness.dark
                              ? kSecondaryColor == Colors.white
                                  ? Colors.black
                                  : kSecondaryColor
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )))
              ])));
    });
  }

  Widget discountValue() {
    if (product.price?.mrp != 0 &&
        product.price?.mrp != null &&
        product.price?.mrp != product.price?.sellingPrice) {
      var discountAmount =
          ((product.price!.mrp! - product.price!.sellingPrice!) /
                  product.price!.mrp!) *
              100;
      var discount = double.parse(discountAmount.toStringAsFixed(2)).round();
      if (discount > 0) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(5)),
            child: Text("${discount}% off",
                style: const TextStyle(color: kSecondaryColor)));
      }
    }
    return SizedBox.shrink();
  }
}
