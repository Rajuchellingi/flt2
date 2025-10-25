// ignore_for_file: unnecessary_null_comparison

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/order_detail_v1_controller.dart';
import 'package:black_locust/view/order_detail_v1/components/order_address.dart';
import 'package:black_locust/view/order_detail_v1/components/order_information.dart';
import 'package:black_locust/view/order_detail_v1/components/order_product_details.dart';
import 'package:black_locust/view/order_detail_v1/components/order_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package

class OrderDetailV1Design1 extends StatelessWidget {
  const OrderDetailV1Design1({
    Key? key,
    required OrderDetailV1Controller controller,
  })  : _controller = controller,
        super(key: key);

  final OrderDetailV1Controller _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : _controller.orderDetail != null
            ? RefreshIndicator(
                color: kPrimaryColor,
                onRefresh: _controller.refreshPage,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OrderInformation(
                            controller: _controller,
                            orderDetail: _controller.orderDetail.value),
                        const SizedBox(height: 10),
                        OrderProductDetails(
                            products: _controller.orderDetail.value.products),
                        const SizedBox(height: 10),
                        if (_controller.orderDetail.value.shippingAddress !=
                            null) ...[
                          OrderAddress(
                            title: "Shipping Address",
                            address:
                                _controller.orderDetail.value.shippingAddress!,
                          ),
                          const SizedBox(height: 10),
                        ],
                        if (_controller.orderDetail.value.billingAddress !=
                            null) ...[
                          OrderAddress(
                            title: "Billing Address",
                            address:
                                _controller.orderDetail.value.billingAddress!,
                          ),
                          const SizedBox(height: 10)
                        ],
                        if (_controller.orderDetail.value.price != null) ...[
                          OrderSummary(
                              price: _controller.orderDetail.value.price!)
                        ]
                      ],
                    ),
                  ),
                ),
              )
            : const Center(
                child: const Text('No Orders Found'),
              ));
  }
}
