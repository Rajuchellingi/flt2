import 'package:flutter/material.dart';
import '../../../common_component/color_text_button.dart';

class EnquiryHistoryItemRow extends StatelessWidget {
  const EnquiryHistoryItemRow(
      {Key? key,
      required this.itemLable,
      required this.itemValue,
      String? this.specialLabel})
      : super(key: key);

  final itemLable;
  final itemValue;
  final specialLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          itemLable,
          style: const TextStyle(
              color: const Color.fromARGB(255, 83, 83, 83),
              fontWeight: FontWeight.w500),
        ),
        if (specialLabel != null)
          ColorTextOrButton(
            colorCode: const Color(0XFF00AF5D),
            itemValue: specialLabel,
            onPress: () {},
          ),
        itemLable == 'Status :'
            ? ColorTextOrButton(
                colorCode: const Color(0XFF00AF5D),
                itemValue: itemValue,
                onPress: () {},
              )
            : Text(itemValue ?? ''),
      ],
    );
  }
}
