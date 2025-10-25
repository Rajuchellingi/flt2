import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';

import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/view/order_history/components/order_history_item_row.dart';
import 'package:flutter/material.dart';

class OrderHistoryDetail extends StatelessWidget {
  const OrderHistoryDetail(
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
              OrderHistoryItemRow(
                  itemLable: 'Order Id :', itemValue: orderItem.orderNo),
              // kDefaultHeight(kDefaultPadding / 2),
              // OrderHistoryItemRow(
              //     itemLable: 'Order Date :',
              //     itemValue: CommonHelper.formateDate(
              //         DateTime.parse(orderItem.orderDate))),
              kDefaultHeight(kDefaultPadding / 2),
              OrderHistoryItemRow(
                  itemLable: 'Status :',
                  itemValue: _controller.getOrderStatus(orderItem.status)),
              kDefaultHeight(kDefaultPadding / 2),
              OrderHistoryItemRow(
                itemLable: 'Total :',
                itemValue: (platform == 'shopify'
                    ? CommonHelper.currencySymbol() +
                        orderItem.price.totalPrice.toString()
                    : orderItem.currencySymbol +
                        orderItem.totalPrice.toStringAsFixed(2).toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
