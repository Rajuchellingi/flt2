// ignore_for_file: unnecessary_null_comparison
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/order_enquiry_details_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/view/enquiry_Details/components/enquiry_information.dart';
import 'package:black_locust/view/enquiry_Details/components/order_product_details.dart';
import 'package:black_locust/view/enquiry_Details/components/order_summary.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package

class EnquiryDetailV1Body extends StatelessWidget {
  const EnquiryDetailV1Body({
    Key? key,
    required EnquiryDetailController controller,
  })  : _controller = controller,
        super(key: key);

  final EnquiryDetailController _controller;

  @override
  Widget build(BuildContext context) {
    final productSettingController = Get.find<ProductSettingController>();
    return Obx(() => _controller.isLoading.value
        ? const Center(
            child: const CircularProgressIndicator(),
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
                        EnquiryOrderInformation(
                            controller: _controller,
                            orderDetail: _controller.orderDetail.value),
                        const SizedBox(height: 10),
                        EnquiryProductDetails(
                            products: _controller.orderDetail.value.products,
                            orderDetail: _controller.orderDetail.value),
                        const SizedBox(height: 10),
                        // if (_controller.orderDetail.value.shippingAddress !=
                        //     null) ...[
                        //   OrderAddress(
                        //     title: "Shipping Address",
                        //     address:
                        //         _controller.orderDetail.value.shippingAddress!,
                        //   ),
                        //   SizedBox(height: 10),
                        // ],
                        // if (_controller.orderDetail.value.billingAddress !=
                        //     null) ...[
                        //   OrderAddress(
                        //     title: "Billing Address",
                        //     address:
                        //         _controller.orderDetail.value.billingAddress!,
                        //   ),
                        //   SizedBox(height: 10)
                        // ],
                        if (productSettingController
                                    .productSetting.value.cartSummaryType ==
                                'price-summary' &&
                            _controller.orderDetail.value.price != null) ...[
                          EnquirySummary(
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
