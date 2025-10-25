import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox(
      {Key? key,
      required this.controller,
      required this.name,
      required this.label,
      this.element,
      this.enabled,
      required this.value});

  final controller;
  final name;
  final label;
  final value;
  final enabled;
  final element;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Checkbox(
          value: (value != null && value == 'true') ? true : false,
          onChanged: enabled == false
              ? (value) {}
              : (value) {
                  controller.changeCheckBoxValue(value, element, name);
                },
        ),
        Text(label)
      ]),
    ]);
  }
}
