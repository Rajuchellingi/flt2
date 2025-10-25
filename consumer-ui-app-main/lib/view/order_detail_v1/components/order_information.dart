import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/model/order_model.dart';
import 'package:black_locust/view/order_detail_v1/components/order_cancel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderInformation extends StatelessWidget {
  const OrderInformation({
    Key? key,
    required controller,
    required this.orderDetail,
  })  : _controller = controller,
        super(key: key);

  final _controller;
  final MyOrderDetailVM orderDetail;
  @override
  Widget build(BuildContext context) {
    var validStatus = ['created', 'packed'];

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
                      const Text("Order Date",
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
                        const Text("Order No",
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
                    if (orderDetail.price != null)
                      Row(children: [
                        const Text("Total",
                            style: const TextStyle(fontSize: 13)),
                        Expanded(
                            child: Text(
                                platform == 'shopify'
                                    ? CommonHelper.currencySymbol() +
                                        orderDetail.price!.totalPrice!
                                            .toStringAsFixed(2)
                                    : orderDetail.price!.currencySymbol
                                            .toString() +
                                        orderDetail.price!.totalPrice!
                                            .toString(),
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                )))
                      ]),
                  ])),
          if (platform == 'to-automation') ...[
            const Divider(),
            Container(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                child: GestureDetector(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: const Text("Download Invoice")),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 14,
                        )
                      ]),
                  onTap: () {
                    _controller.downloadInvoice();
                  },
                )),
            if (validStatus.contains(orderDetail.status)) ...[
              const Divider(),
              Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                  child: GestureDetector(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: const Text("Cancel Order")),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 14,
                          )
                        ]),
                    onTap: () {
                      Get.dialog(OrderCancel(controller: _controller));
                    },
                  ))
            ],
          ] else ...[
            const SizedBox(height: 10)
          ]
        ]));
  }
}
