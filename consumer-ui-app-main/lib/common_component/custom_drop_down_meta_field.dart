import 'package:black_locust/const/constant.dart';
import 'package:flutter/material.dart';

class CustomDropdownMetaField extends StatelessWidget {
  CustomDropdownMetaField(
      {Key? key,
      required this.dropdownList,
      required this.lableText,
      required this.selectedType,
      required this.controller,
      required this.name,
      this.hintText,
      required enabled})
      : super(key: key);
  final dropdownList;
  final lableText;
  final selectedType;
  final controller;
  final String? hintText;
  final name;

  @override
  Widget build(BuildContext context) {
    // print("hintText---->>> ${hintText}");
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
            hintText: hintText,
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
            print("newValue --->>> ${newValue}");
            controller.dropMetaValueChange(newValue, name);
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
    borderSide: const BorderSide(color: kTextColor),
    gapPadding: 8,
  );
}
