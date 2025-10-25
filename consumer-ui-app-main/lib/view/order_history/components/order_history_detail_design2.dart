import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/constant.dart';

import 'package:black_locust/helper/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderHistoryDetailDesign2 extends StatelessWidget {
  const OrderHistoryDetailDesign2(
      {Key? key, required this.orderItem, required controller})
      : _controller = controller,
        super(key: key);
  final orderItem;
  final _controller;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Card(
      color: brightness == Brightness.dark ? Colors.black : Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      surfaceTintColor:
          brightness == Brightness.dark ? Colors.black : Colors.white,
      borderOnForeground: true,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order No ${orderItem.orderNo}',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryTextColor,
                          fontSize: 15)),
                  Text(formatDate(orderItem.creationDate),
                      style: TextStyle(
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : kPrimaryTextColor,
                      ))
                ]),
            kDefaultHeight(kDefaultPadding / 2),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text('Quantity: ',
                        style: TextStyle(
                            color: brightness == Brightness.dark
                                ? Colors.white
                                : kPrimaryTextColor)),
                    const SizedBox(width: 5),
                    Text(orderQuantity(orderItem.products),
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: brightness == Brightness.dark
                                ? Colors.white
                                : kPrimaryTextColor)),
                  ]),
                  Row(children: [
                    Text('Total Amount: ',
                        style: TextStyle(
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : kPrimaryTextColor,
                        )),
                    const SizedBox(width: 5),
                    if (platform == 'shopify') ...[
                      Text(
                          CommonHelper.currencySymbol() +
                              orderItem.price.totalPrice
                                  .toStringAsFixed(1)
                                  .toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: brightness == Brightness.dark
                                ? Colors.white
                                : kPrimaryTextColor,
                          ))
                    ] else ...[
                      Text(
                          orderItem.price.currencySymbol +
                              orderItem.price.totalPrice.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: brightness == Brightness.dark
                                ? Colors.white
                                : kPrimaryTextColor,
                          ))
                    ],
                  ]),
                ]),
            kDefaultHeight(kDefaultPadding / 2),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          foregroundColor: kPrimaryColor),
                      onPressed: () {
                        _controller.navigateToOrderDetails(orderItem);
                      },
                      child: Text("Details",
                          style: TextStyle(
                            color: brightness == Brightness.dark
                                ? Colors.white
                                : kPrimaryTextColor,
                          ))),
                  Text(orderItem.status,
                      style: TextStyle(
                          color: orderItem.status == 'CANCELED'
                              ? Colors.red
                              : Color(0XFF2AA952))),
                ]),
          ],
        ),
      ),
    );
  }

  String orderQuantity(products) {
    num quantity = 0;
    for (var product in products) {
      quantity += product.quantity;
    }
    return quantity.toString();
  }

  String formatDate(String utcDate) {
    DateTime dateTime = DateTime.parse(utcDate);
    return DateFormat("dd-MM-yyyy").format(dateTime);
  }
}
