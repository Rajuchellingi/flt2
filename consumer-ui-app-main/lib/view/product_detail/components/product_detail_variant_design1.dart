// ignore_for_file: unnecessary_null_comparison

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailVariantDesign1 extends StatelessWidget {
  ProductDetailVariantDesign1(
      {Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return (_controller.productVariants != null &&
            _controller.productVariants.isNotEmpty)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var element in _controller.productVariants)
                Container(
                  padding: const EdgeInsets.all(15),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        child: Text(
                          element.type.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var variant in element.fieldValue ?? [])
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      _controller.getProductByVariant(
                                        element.type,
                                        variant.labelName,
                                      );
                                    },
                                    child: Obx(
                                      () => Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: _controller
                                                  .selectedProductVariants
                                                  .any((da) =>
                                                      da['type'] ==
                                                          element.type &&
                                                      da['value'] ==
                                                          variant.labelName)
                                              ? kPrimaryColor
                                              : null,
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 198, 198, 198),
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Text(
                                          variant.labelName.toString(),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: _controller
                                                    .selectedProductVariants
                                                    .any((da) =>
                                                        da['type'] ==
                                                            element.type &&
                                                        da['value'] ==
                                                            variant.labelName)
                                                ? brightness == Brightness.dark
                                                    ? Colors.white
                                                    : kSecondaryColor
                                                : brightness == Brightness.dark
                                                    ? Colors.white
                                                    : const Color.fromRGBO(
                                                        0, 0, 0, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          )
        : Container();
  }
}
