import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../controller/cart_controller.dart';

class CartFooterDesign1 extends StatelessWidget {
  CartFooterDesign1({
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
    return Container(
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: Color(0xFF373636), width: 2))),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (var element in footerChildren) ...[
            if (element['key'] == 'price-summary') ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    footer['options'][element['key']]['title'],
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  Text(
                    "Rs. " +
                        _controller
                            .totalCartPrice.value.summary!.totalSellingPrice!
                            .toStringAsFixed(2),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
              kDefaultHeight(kDefaultPadding / 2),
              const Text(
                'Taxes, discounts and shipping calculated at checkout.',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
              const SizedBox(height: 30)
            ] else if (element['key'] == 'checkout-button') ...[
              GestureDetector(
                  onTap: () {
                    if (!_controller.outOfStock.value)
                      _controller.navigateToCheckout();
                  },
                  child: Container(
                      width: SizeConfig.screenWidth,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          border: Border.all(
                              color: brightness == Brightness.dark
                                  ? kPrimaryColor == Colors.black
                                      ? Colors.white
                                      : kPrimaryColor
                                  : kPrimaryColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(footer['options'][element['key']]['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: kSecondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14))))
            ]
          ]
        ]));
  }
}
