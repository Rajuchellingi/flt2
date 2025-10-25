// ignore_for_file: unnecessary_null_comparison

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/booking_history_detail_controller.dart';
import 'package:black_locust/view/booking_detail/components/booking_address.dart';
import 'package:black_locust/view/booking_detail/components/booking_information.dart';
import 'package:black_locust/view/booking_detail/components/booking_product_details.dart';
import 'package:black_locust/view/booking_detail/components/booking_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingDetailDesign1 extends StatelessWidget {
  final BookingDetailController _controller;

  const BookingDetailDesign1({
    Key? key,
    required BookingDetailController controller,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : _controller.bookingDetail != null
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
                        BookingInformation(controller: _controller),
                        const SizedBox(height: 10),
                        BookingProductDetails(
                          products: _controller.bookingDetail.value.products,
                        ),
                        const SizedBox(height: 10),
                        if (_controller.bookingDetail.value.shippingAddress !=
                            null) ...[
                          BookingAddress(
                            title: "Shipping Address",
                            address: _controller
                                .bookingDetail.value.shippingAddress!,
                          ),
                          const SizedBox(height: 10)
                        ],
                        if (_controller.bookingDetail.value.billingAddress !=
                            null) ...[
                          BookingAddress(
                            title: "Billing Address",
                            address:
                                _controller.bookingDetail.value.billingAddress!,
                          ),
                          const SizedBox(height: 10)
                        ],
                        BookingSummary(
                          price: _controller.bookingDetail.value.price!,
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
