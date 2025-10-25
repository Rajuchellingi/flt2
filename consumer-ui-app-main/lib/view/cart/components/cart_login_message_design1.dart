// ignore_for_file: invalid_use_of_protected_member, unused_field

import 'package:black_locust/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartLoginMessageDesign1 extends StatelessWidget {
  CartLoginMessageDesign1({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);
  final design;
  final CartController _controller;

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: brightness == Brightness.dark ? Colors.black : Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
        child: Row(spacing: 10, children: [
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                if (design['source']['title'] != null &&
                    design['source']['title'].isNotEmpty) ...[
                  Text(design['source']['title'],
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5)
                ],
                if (design['source']['description'] != null &&
                    design['source']['description'].isNotEmpty) ...[
                  Text(design['source']['description'])
                ],
              ])),
          if (design['source']['buttonName'] != null &&
              design['source']['buttonName'].isNotEmpty)
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                onPressed: () {
                  Get.toNamed('/login');
                },
                child: Text(design['source']['buttonName'],
                    style: TextStyle(
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold)))
        ]));
  }
}
