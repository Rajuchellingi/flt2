import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../controller/cart_controller.dart';

class CartFooterDesign2 extends StatelessWidget {
  CartFooterDesign2({
    Key? key,
    required this.template,
    required controller,
  })  : _controller = controller,
        super(key: key);
  final template;
  final _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var footer = _controller.template.value['layout']['footer'];
    var footerChildren = footer['layout']['children'];
    var brightness = Theme.of(context).brightness;
    return Obx(() {
      return Container(
          color: brightness == Brightness.dark ? Colors.black : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Row(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var element in footerChildren) ...[
                  if (element['key'] == 'price-summary') ...[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            CommonHelper.currencySymbol() +
                                " " +
                                _controller
                                    .totalCartPrice.value.summary!.totalMrpPrice
                                    .toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          const Text(
                            'Price inclusive of all taxes',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          )
                        ]),
                  ] else if (element['key'] == 'checkout-button') ...[
                    Expanded(
                        child: GestureDetector(
                            onTap: () {
                              if (!_controller.outOfStock.value)
                                _controller.navigateToCheckout();
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    border: Border.all(
                                        color: brightness == Brightness.dark
                                            ? kPrimaryColor == Colors.black
                                                ? Colors.white
                                                : kPrimaryColor
                                            : kPrimaryColor),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                    footer['options'][element['key']]['title'],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: kSecondaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)))))
                  ]
                ]
              ]));
    });
  }
}
