import 'package:black_locust/const/constant.dart';
import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  CustomDropdownField(
      {Key? key,
      required this.dropdownList,
      required this.lableText,
      required this.selectedType,
      required this.controller})
      : super(key: key);
  final dropdownList;
  final lableText;
  final selectedType;
  final controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: 20),
      child: InputDecorator(
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.only(
                top: 35,
                left: 25,
                right: 25,
                bottom:
                    0), //EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,

            // labelStyle: textStyle,
            errorStyle:
                const TextStyle(color: Colors.redAccent, fontSize: 16.0),
            labelText: lableText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            )),
        isEmpty: false,
        child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
          isExpanded: true,
          value: selectedType != null ? selectedType : null,
          isDense: true,
          onChanged: (String? newValue) {
            controller.dropValueChange(newValue);
          },
          items: dropdownList.map<DropdownMenuItem<String>>((dynamic value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )),
      ),
    );
  }

  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    // borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 8,
  );
}
