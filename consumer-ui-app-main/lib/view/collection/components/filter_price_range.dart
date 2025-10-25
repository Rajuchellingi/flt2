// ignore_for_file: unused_element

import 'dart:convert';

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterPriceRange extends StatelessWidget {
  const FilterPriceRange(
      {Key? key, required this.fieldValue, required this.controller})
      : super(key: key);

  final fieldValue;
  final controller;

  @override
  Widget build(BuildContext context) {
    var input = fieldValue.input != null ? jsonDecode(fieldValue.input) : null;
    if (input != null) {
      var filterValue = jsonDecode(fieldValue.filterValue);
      controller.setPriceRange(RangeValues(
          input['price']['min'].toDouble(), input['price']['max'].toDouble()));
      return Obx(() => Stack(children: [
            Container(
                padding: const EdgeInsets.only(top: 5),
                width: SizeConfig.screenWidth,
                child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 3.0,
                    ),
                    child: RangeSlider(
                      activeColor: kPrimaryColor,
                      inactiveColor: Colors.grey,
                      values: controller.priceRangeValue.value,
                      min: filterValue['price']['min'].toDouble(),
                      max: filterValue['price']['max'].toDouble(),
                      onChanged: (RangeValues values) {
                        controller.onChangePriceRange(values, fieldValue);
                      },
                    ))),
            Positioned(
                top: -5,
                left: 15,
                child: Text(
                    "₹" +
                        controller.priceRangeValue.value.start
                            .round()
                            .toString(),
                    textAlign: TextAlign.left)),
            Positioned(
                top: -5,
                right: 15,
                child: Text(
                  "₹" + controller.priceRangeValue.value.end.round().toString(),
                  textAlign: TextAlign.right,
                ))
          ]));
    } else {
      return Container();
    }
  }
}
