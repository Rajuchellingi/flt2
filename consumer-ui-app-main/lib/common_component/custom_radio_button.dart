// ignore_for_file: unnecessary_statements

import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton(
      {Key? key,
      required this.controller,
      required this.name,
      required this.label,
      required this.options,
      required this.enabled,
      required this.element,
      required this.value});

  final controller;
  final name;
  final label;
  final options;
  final value;
  final enabled;
  final element;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Container(
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      for (var opt in options)
        RadioListTile<dynamic>(
          title: Text(opt.name),
          value: opt.value == value,
          groupValue: true,
          onChanged: (value) {
            enabled == false
                ? null
                : controller.changeRadioButtonValue(
                    opt.value, element, opt, name);
          },
        ),
    ]);
  }
}
