import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/cart_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/view/cart/components/discount_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartDiscountProgressBarDesign1 extends StatelessWidget {
  CartDiscountProgressBarDesign1(
      {Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final design;
  final CartController _controller;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(children: [
          _controller.selectedDiscountIndex >=
                  _controller.cartSetting.value.discountProgressBar!.length
              ? Text(
                  "You've unlocked ${_controller.cartSetting.value.discountProgressBar!.last.discountType! == 'amount' ? '${CommonHelper.currencySymbol() + _controller.cartSetting.value.discountProgressBar!.last.discountValue.toString()} Off' : '${_controller.cartSetting.value.discountProgressBar!.last.discountValue.toString()}%'} Off",
                  style: const TextStyle(fontWeight: FontWeight.w600))
              : _controller
                          .cartSetting
                          .value
                          .discountProgressBar![
                              _controller.selectedDiscountIndex.value]
                          .requirementType ==
                      'amount'
                  ? Text(
                      "Add ${CommonHelper.currencySymbol() + differenceAmount()} to unlock ${_controller.cartSetting.value.discountProgressBar![_controller.selectedDiscountIndex.value].discountType! == 'amount' ? '${CommonHelper.currencySymbol() + _controller.cartSetting.value.discountProgressBar![_controller.selectedDiscountIndex.value].discountValue.toString()}' : '${_controller.cartSetting.value.discountProgressBar!.last.discountValue.toString()}%'} Off",
                      style: const TextStyle(fontWeight: FontWeight.w600))
                  : _controller
                              .cartSetting
                              .value
                              .discountProgressBar![
                                  _controller.selectedDiscountIndex.value]
                              .requirementType ==
                          'quantity'
                      ? Text(
                          "Add ${(_controller.cartSetting.value.discountProgressBar![_controller.selectedDiscountIndex.value].requirementValue - _controller.totalCartPrice.value.totalQuantity).toString()} more products to unlock ${_controller.cartSetting.value.discountProgressBar![_controller.selectedDiscountIndex.value].discountType! == 'amount' ? '${CommonHelper.currencySymbol() + _controller.cartSetting.value.discountProgressBar![_controller.selectedDiscountIndex.value].discountValue.toString()}' : '${_controller.cartSetting.value.discountProgressBar!.last.discountValue.toString()}%'} Off",
                          style: const TextStyle(fontWeight: FontWeight.w600))
                      : Container(),
          const SizedBox(height: 10),
          StepProgressView(
            controller: _controller,
            color: kPrimaryColor,
          ),
          const SizedBox(height: 10)
        ]));
  }

  differenceAmount() {
    var amount = _controller
            .cartSetting
            .value
            .discountProgressBar![_controller.selectedDiscountIndex.value]
            .requirementValue -
        _controller.totalCartPrice.value.summary!.totalSellingPrice;
    var result = amount.toStringAsFixed(2);
    return result.toString();
  }
}
