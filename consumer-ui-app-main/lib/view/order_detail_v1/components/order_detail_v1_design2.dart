// ignore_for_file: unnecessary_null_comparison

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/order_detail_v1_controller.dart';
import 'package:black_locust/view/order_detail_v1/components/order_information_design2.dart';
import 'package:black_locust/view/order_detail_v1/components/order_product_details_design2.dart';
import 'package:black_locust/view/order_detail_v1/components/order_summary_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailV1Design2 extends StatelessWidget {
  final OrderDetailV1Controller _controller;

  const OrderDetailV1Design2({
    Key? key,
    required OrderDetailV1Controller controller,
  })  : _controller = controller,
        super(key: key);

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
                        OrderInformationDesign2(controller: _controller),
                        const SizedBox(height: 10),
                        OrderProductDetailsDesign2(
                          controller: _controller,
                          products: _controller.orderDetail.value.products,
                        ),
                        const SizedBox(height: 10),
                        OrderSummaryDesign2(
                          price: _controller.orderDetail.value.price!,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(
                child: const Text("No booking details available."),
              ));
  }
}
