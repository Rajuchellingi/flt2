// ignore_for_file: unused_field, unnecessary_null_comparison

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/cart_login_message_controller.dart';
import 'package:flutter/material.dart';

class CartLoginMessageDesign1 extends StatelessWidget {
  CartLoginMessageDesign1({
    Key? key,
    required this.design,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final design;
  final CartLoginMessageController _controller;

  @override
  Widget build(BuildContext context) {
    var source = design['source'];
    final brightness = Theme.of(context).brightness;

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(children: [
          if (source['title'] != null && source['title'] != '') ...[
            Text(source['title'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryTextColor,
                )),
          ],
          if (source['description'] != null && source['description'] != '') ...[
            const SizedBox(height: 10),
            Text(source['description'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : kPrimaryTextColor,
                )),
          ],
          if (source['buttonName'] != null && source['buttonName'] != '') ...[
            const SizedBox(height: 10),
            GestureDetector(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(source['buttonName'],
                        style: const TextStyle(color: Colors.white))),
                onTap: () {
                  _controller.openLoginPage();
                })
          ],
        ]));
  }
}
