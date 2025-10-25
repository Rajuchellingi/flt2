// ignore_for_file: unused_local_variable

import 'package:black_locust/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductDetailDescriptionDesign2 extends StatelessWidget {
  const ProductDetailDescriptionDesign2({Key? key, required controller})
      : _controller = controller,
        super(key: key);
  final _controller;
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kDefaultHeight(20),
            const Text(
              'Description', // Add your text here
              style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight:
                      FontWeight.w800), // Set your desired font size here
            ),
            kDefaultHeight(10),
            _controller.product.value.description != null
                ? Html(
                    data: _controller.product.value.description,
                    style: {
                      "body": Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                      ),
                      "p": Style(
                        margin: Margins.symmetric(vertical: 5),
                        padding: HtmlPaddings.zero,
                      ),
                      "hr": Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                      ),
                    },
                  )
                : const Text(
                    '',
                    style: const TextStyle(
                        fontSize: 16.0), // Set your desired font size here
                  ),
            // _controller.product.value.description != null
            //     ? Obx(() => Text(
            //           parse(_controller.product.value.description)
            //               .documentElement!
            //               .text,
            //           style: const TextStyle(
            //               fontSize: 11.0), // Set your desired font size here
            //         ))
            //     : const Text(
            //         '',
            //         style: const TextStyle(
            //             fontSize: 16.0), // Set your desired font size here
            //       ),
            kDefaultHeight(10 / 2),
          ],
        ));
  }

  Text buildContentHeader(String name) {
    return Text(
      name,
      style: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w700),
    );
  }

  Padding buildParagraphText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Text(capitalize(text)),
    );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
