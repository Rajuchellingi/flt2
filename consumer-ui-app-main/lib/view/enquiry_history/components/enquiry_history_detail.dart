import 'package:black_locust/const/constant.dart';

import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/view/enquiry_history/components/enquiry_history_item_row.dart';
import 'package:flutter/material.dart';

class EnquiryHistoryDetail extends StatelessWidget {
  const EnquiryHistoryDetail(
      {Key? key, required this.orderItem, required controller})
      : _controller = controller,
        super(key: key);
  final orderItem;
  final _controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // _controller.navigateToOrderDetails(orderItem);
        _controller.navigateToOrderDetails(orderItem);
      },
      child: Card(
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          child: Column(
            children: [
              EnquiryHistoryItemRow(
                  itemLable: 'Enquiry Id :', itemValue: orderItem.orderId),
              // kDefaultHeight(kDefaultPadding / 2),
              // OrderHistoryItemRow(
              //     itemLable: 'Order Date :',
              //     itemValue: CommonHelper.formateDate(
              //         DateTime.parse(orderItem.orderDate))),
              kDefaultHeight(kDefaultPadding / 2),
              EnquiryHistoryItemRow(
                  itemLable: 'Enquiry On :',
                  itemValue:
                      CommonHelper.converToDateByType(orderItem.creationDate)),
              kDefaultHeight(kDefaultPadding / 2),
              EnquiryHistoryItemRow(
                  itemLable: 'Status :',
                  itemValue: _controller.getOrderStatus(orderItem.orderStatus)),
            ],
          ),
        ),
      ),
    );
  }
}
