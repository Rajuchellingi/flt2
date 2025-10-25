// ignore_for_file: unused_element

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:flutter/material.dart';

class CollectionFilterHeaderRowDesign2 extends StatelessWidget {
  const CollectionFilterHeaderRowDesign2(
      {Key? key, required this.attribute, required this.type})
      : super(key: key);

  final attribute;
  final type;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: kDefaultPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // if (attribute.labelName != "Price")
          Text(
            type == 'attribute' ? attribute.labelName : 'Price Range',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: brightness == Brightness.dark
                    ? Colors.white
                    : kPrimaryTextColor,
                fontSize: getProportionateScreenHeight(16)),
          ),
        ],
      ),
    );
  }
}
