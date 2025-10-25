// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/order_detail_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/order_detail_v1/components/order_address.dart';
import 'package:black_locust/view/order_detail_v1/components/order_information.dart';
import 'package:black_locust/view/order_detail_v1/components/order_product_details.dart';
import 'package:black_locust/view/order_detail_v1/components/order_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package

class OrderDetailDesign2 extends StatelessWidget {
  OrderDetailDesign2({
    Key? key,
    required OrderDetailController controller,
  })  : _controller = controller,
        super(key: key);

  final OrderDetailController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Obx(() {
      var footer = _controller.template.value['layout'] != null
          ? _controller.template.value['layout']['footer']
          : null;
      return SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Text("Order Details",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : kPrimaryTextColor,
                      ))),
              OrderInformation(
                  controller: _controller,
                  orderDetail: _controller.orderDetail.value),
              const SizedBox(height: 10),
              OrderProductDetails(
                  products: _controller.orderDetail.value.products),
              const SizedBox(height: 10),
              if (_controller.allowReturn.value) ...[
                InkWell(
                    onTap: () {
                      _controller.openReturnPage();
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade300, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(children: [
                          Expanded(
                              child: Text("Return / Exchange Products",
                                  style: TextStyle(
                                      color: brightness == Brightness.dark
                                          ? Colors.white
                                          : kPrimaryTextColor))),
                          Icon(Icons.keyboard_arrow_right_outlined,
                              color: brightness == Brightness.dark
                                  ? Colors.white
                                  : kPrimaryTextColor)
                        ]))),
                const SizedBox(height: 10)
              ],
              if (_controller.orderDetail.value.shippingAddress != null) ...[
                OrderAddress(
                  title: "Shipping Address",
                  address: _controller.orderDetail.value.shippingAddress!,
                ),
                const SizedBox(height: 10)
              ],
              if (_controller.orderDetail.value.billingAddress != null) ...[
                OrderAddress(
                  title: "Billing Address",
                  address: _controller.orderDetail.value.billingAddress!,
                ),
                const SizedBox(height: 10)
              ],
              OrderSummary(price: _controller.orderDetail.value.price!),
              if (footer != null &&
                  footer.isNotEmpty &&
                  themeController.bottomBarType.value == 'design1' &&
                  footer['componentId'] == 'footer-navigation')
                const SizedBox(height: 80),
            ],
          ),
        ),
      );
    });
  }
}
