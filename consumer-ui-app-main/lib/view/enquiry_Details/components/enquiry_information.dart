// ignore_for_file: unused_field

import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/model/enquiry_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EnquiryOrderInformation extends StatelessWidget {
  EnquiryOrderInformation({
    Key? key,
    required controller,
    required this.orderDetail,
  })  : _controller = controller,
        super(key: key);

  final _controller;
  final MyEnquiryDetailVM orderDetail;
  final productSetting = Get.find<ProductSettingController>();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Column(children: [
          Container(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Text("Enquiry On",
                          style: const TextStyle(fontSize: 13)),
                      Expanded(
                          child: Text(
                              CommonHelper.converToDateByType(
                                  orderDetail.creationDate),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              )))
                    ]),
                    const SizedBox(height: 5),
                    if (orderDetail.orderNo != null) ...[
                      Row(children: [
                        const Text("Enquiry No",
                            style: const TextStyle(fontSize: 13)),
                        Expanded(
                            child: Text(orderDetail.orderNo.toString(),
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                )))
                      ]),
                      const SizedBox(height: 5),
                    ],
                    Row(children: [
                      const Text("Status",
                          style: const TextStyle(fontSize: 13)),
                      Expanded(
                          child: Text(
                              toBeginningOfSentenceCase(
                                      orderDetail.status.toString())
                                  .toString(),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              )))
                    ]),
                    const SizedBox(height: 5),
                    if (productSetting.productSetting.value.cartSummaryType ==
                        'quantity-summary') ...[
                      Row(children: [
                        const Text("Total",
                            style: const TextStyle(fontSize: 13)),
                        Expanded(
                            child: Text("${orderDetail.totalQuantity} Pieces",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ))),
                      ]),
                      const SizedBox(height: 5)
                    ] else if (orderDetail.price != null) ...[
                      Row(children: [
                        const Text("Total",
                            style: const TextStyle(fontSize: 13)),
                        Expanded(
                            child: Text(
                                orderDetail.price!.currencySymbol.toString() +
                                    orderDetail.price!.totalPrice!
                                        .toStringAsFixed(2),
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                )))
                      ]),
                      const SizedBox(height: 5)
                    ],
                    if (orderDetail.message != null)
                      Row(children: [
                        const Text("Message",
                            style: const TextStyle(fontSize: 13)),
                        Expanded(
                            child: Text(orderDetail.message.toString(),
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                )))
                      ]),
                  ])),
          // if (platform == 'to-automation') ...[
          //   Divider(),
          //   Container(
          //       padding: EdgeInsets.fromLTRB(15, 10, 15, 15),
          //       child: GestureDetector(
          //         child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Expanded(child: Text("Download Invoice")),
          //               Icon(
          //                 Icons.arrow_forward_ios,
          //                 color: Colors.grey,
          //                 size: 14,
          //               )
          //             ]),
          //         onTap: () {
          //           _controller.downloadInvoice();
          //         },
          //       ))
          // ] else ...[
          //   SizedBox(height: 10)
          // ]
        ]));
  }
}
