// ignore_for_file: unused_element

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:flutter/material.dart';

class CollectionFilterHeaderRow extends StatelessWidget {
  const CollectionFilterHeaderRow(
      {Key? key, required this.attribute, required this.type})
      : super(key: key);

  final attribute;
  final type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // if (attribute.labelName != "Price")
          Text(
            type == 'attribute' ? attribute.labelName : 'Price Range',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: getProportionateScreenHeight(16)),
          ),
        ],
      ),
    );
  }
}
