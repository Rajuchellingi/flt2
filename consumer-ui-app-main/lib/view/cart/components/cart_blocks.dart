// ignore_for_file: invalid_use_of_protected_member

import 'package:black_locust/controller/cart_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/cart/components/cart_discount_progress_bar.dart';
import 'package:black_locust/view/cart/components/cart_login_message.dart';
import 'package:black_locust/view/cart/components/cart_price_details.dart';
import 'package:black_locust/view/cart/components/cart_products.dart';
import 'package:black_locust/view/cart/components/cart_related_products.dart';
import 'package:black_locust/view/cart/components/coupen_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'empty_cart.dart';

class CartBlocks extends StatelessWidget {
  CartBlocks({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final CartController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var blocks = _controller.template.value['layout']['blocks'];
      var footer = _controller.template.value['layout'] != null
          ? _controller.template.value['layout']['footer']
          : null;
      return Container(
          // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            if (_controller.productCart.length > 0) ...[
              for (var design in blocks) ...[
                if (design['componentId'] == 'discount-progress-bar' &&
                    design['visibility']['hide'] == false &&
                    _controller.cartSetting.value.discountProgressBar != null &&
                    _controller.cartSetting.value.discountProgressBar!.length >
                        0)
                  CartDiscountProgressBar(
                      controller: _controller, design: design),
                if (design['componentId'] == 'cart-products' &&
                    design['visibility']['hide'] == false)
                  CartProducts(controller: _controller, design: design),
                if (design['componentId'] == 'price-details' &&
                    design['visibility']['hide'] == false)
                  CartPriceDetails(controller: _controller, design: design),
                if (design['componentId'] == 'login-message' &&
                    design['visibility']['hide'] == false &&
                    _controller.userId == null)
                  CartLoginMessage(controller: _controller, design: design),
                if (design['componentId'] == 'related-products' &&
                    design['visibility']['hide'] == false)
                  CartRelatedProducts(controller: _controller, design: design),
                if (design['componentId'] == 'coupen-code-block' &&
                    design['visibility']['hide'] == false)
                  CoupenCode(controller: _controller, design: design),
              ]
            ] else ...[
              EmptyCart(),
              for (var design in blocks) ...[
                if (design['componentId'] == 'related-products' &&
                    design['visibility']['hide'] == false)
                  CartRelatedProducts(controller: _controller, design: design),
              ]
            ],
            if (footer != null &&
                footer.isNotEmpty &&
                themeController.bottomBarType.value == 'design1' &&
                footer['componentId'] == 'footer-navigation')
              const SizedBox(height: 80),
          ])));
    });
  }
}
