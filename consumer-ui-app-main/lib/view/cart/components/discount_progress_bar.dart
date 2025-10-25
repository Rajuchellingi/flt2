import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/cart_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepProgressView extends StatelessWidget {
  final Color _activeColor;
  final Color _inactiveColor = Colors.grey;
  final double lineWidth = 3.0;
  final CartController _controller;

  const StepProgressView({Key? key, required controller, required Color color})
      : _controller = controller,
        _activeColor = color,
        super(key: key);

  Widget build(BuildContext context) {
    return Obx(() => Container(
        width: SizeConfig.screenWidth,
        child: Column(
          children: <Widget>[
            Row(
              children: _iconViews(),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _titleViews(),
            ),
          ],
        )));
  }

  List<Widget> _iconViews() {
    var list = <Widget>[];
    _controller.cartSetting.value.discountProgressBar!
        .asMap()
        .forEach((i, value) {
      var circleColor = (_controller.selectedDiscountIndex >= i + 1)
          ? _activeColor
          : _inactiveColor;
      var lineColor = _controller.selectedDiscountIndex > i + 1
          ? _activeColor
          : _inactiveColor;

      list.add(
        Container(
          width: 50.0,
          height: 50.0,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: circleColor,
              shape: BoxShape.circle,
              border: Border.all(color: circleColor)),
          child: Center(
              child: Text(
            value.discountType == 'amount'
                ? '${CommonHelper.currencySymbol() + value.discountValue.toString()} Off'
                : '${value.discountValue.toString()}% Off',
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          )),
        ),
      );

      //line between icons
      if (i != _controller.cartSetting.value.discountProgressBar!.length - 1) {
        list.add(Expanded(
            child: Container(
          height: lineWidth,
          color: lineColor,
        )));
      }
    });

    return list;
  }

  List<Widget> _titleViews() {
    var list = <Widget>[];
    _controller.cartSetting.value.discountProgressBar!
        .asMap()
        .forEach((i, value) {
      list.add(Text(value.title.toString(), style: TextStyle(fontSize: 12)));
    });
    return list;
  }
}
