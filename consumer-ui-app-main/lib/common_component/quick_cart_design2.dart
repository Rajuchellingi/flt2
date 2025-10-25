// ignore_for_file: unused_field, invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/quick_cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuickCartDesign2 extends StatelessWidget {
  final image;
  final title;
  final price;
  final dynamic product;

  QuickCartDesign2(
      {Key? key,
      required this.product,
      required this.image,
      required this.price,
      required this.title})
      : super(key: key);
  final _controller = Get.find<QuickCartController>();

  @override
  Widget build(BuildContext context) {
    var brightness = Get.isDarkMode ? Brightness.dark : Brightness.light;
    Future.delayed(Duration(milliseconds: 500), () {
      _controller.getProductVaraiants(product.options);
    });
    return Obx(() {
      return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            color: brightness == Brightness.dark ? Colors.black : kBackground,
          ),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Center(
                child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.grey))),
            const SizedBox(height: 10),
            if (product.options != null && product.options.length > 0)
              for (var element in product.options)
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          child: Text(
                        'Select ${element.name.toString()}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: brightness == Brightness.dark
                                ? Colors.white
                                : kPrimaryTextColor),
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: SizeConfig.screenWidth,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            runSpacing: 5,
                            spacing: 5,
                            children: [
                              if (element.values != null &&
                                  element.values.length > 0)
                                // if (product.options.length == 1)
                                for (var variant
                                    in _controller.getAvailableVariantOptions(
                                        product, element.name))
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (variant.isAvailable!)
                                                _controller.getProductByVariant(
                                                    element.name,
                                                    variant.name,
                                                    product);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 7,
                                                horizontal: 12,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                color: _controller
                                                        .selectedProductVariants
                                                        .value
                                                        .any((da) =>
                                                            da['type'] ==
                                                                element.name &&
                                                            da['value'] ==
                                                                variant.name)
                                                    ? kPrimaryColor
                                                    : variant.isAvailable ==
                                                            false
                                                        ? const Color.fromARGB(
                                                            255, 219, 219, 219)
                                                        : null,
                                                border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 198, 198, 198),
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Text(
                                                variant.name.toString(),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: _controller
                                                          .selectedProductVariants
                                                          .value
                                                          .any((da) =>
                                                              da['type'] ==
                                                                  element
                                                                      .name &&
                                                              da['value'] ==
                                                                  variant.name)
                                                      ? kSecondaryColor
                                                      : brightness ==
                                                              Brightness.dark
                                                          ? Colors.white
                                                          : kPrimaryTextColor,
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
                              // else
                              //   for (var variant in element.values!)
                              //     Padding(
                              //       padding: const EdgeInsets.all(3.0),
                              //       child: Stack(
                              //           alignment: Alignment.center,
                              //           children: [
                              //             GestureDetector(
                              //               onTap: () {
                              //                 _controller.getProductByVariant(
                              //                     element.name,
                              //                     variant.name,
                              //                     product);
                              //               },
                              //               child: Container(
                              //                 padding:
                              //                     const EdgeInsets.symmetric(
                              //                   vertical: 7,
                              //                   horizontal: 12,
                              //                 ),
                              //                 decoration: BoxDecoration(
                              //                   borderRadius:
                              //                       BorderRadius.circular(7),
                              //                   color: _controller
                              //                           .selectedProductVariants
                              //                           .value
                              //                           .any((da) =>
                              //                               da['type'] ==
                              //                                   element
                              //                                       .name &&
                              //                               da['value'] ==
                              //                                   variant.name)
                              //                       ? kPrimaryColor
                              //                       : null,
                              //                   border: Border.all(
                              //                     color: const Color.fromARGB(
                              //                         255, 198, 198, 198),
                              //                     width: 1.0,
                              //                   ),
                              //                 ),
                              //                 child: Text(
                              //                   variant.name.toString(),
                              //                   style: TextStyle(
                              //                       fontSize: 14,
                              //                       color: _controller
                              //                               .selectedProductVariants
                              //                               .value
                              //                               .any((da) =>
                              //                                   da['type'] ==
                              //                                       element
                              //                                           .name &&
                              //                                   da['value'] ==
                              //                                       variant
                              //                                           .name)
                              //                           ? kSecondaryColor
                              //                           : brightness ==
                              //                                   Brightness
                              //                                       .dark
                              //                               ? Colors.white
                              //                               : kPrimaryTextColor),
                              //                 ),
                              //               ),
                              //             ),
                              //             if (!variant.isAvailable!)
                              //               Positioned.fill(
                              //                 child: const Divider(
                              //                   color: Colors.grey,
                              //                   thickness: 1.0,
                              //                 ),
                              //               ),
                              //           ]),
                              //     ),
                            ],
                          )),
                    ],
                  ),
                ),
            const SizedBox(height: 20),
            Container(
                width: SizeConfig.screenWidth,
                child: ElevatedButton(
                    onPressed: () {
                      _controller.productAddToCart(product);
                    },
                    child: const Text("Add To Cart",
                        style: const TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        foregroundColor: kSecondaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 15)))),
            const SizedBox(height: 10)
          ]));
    });
  }
}
