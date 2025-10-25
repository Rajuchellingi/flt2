// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class ProductDetailCollapse4 extends StatefulWidget {
  const ProductDetailCollapse4(
      {required this.designBlock,
      required this.title,
      required this.description});
  final designBlock;
  final title;
  final description;

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDetailCollapse4>
    with SingleTickerProviderStateMixin {
  int _expandedIndex = -1;

  void initState() {
    super.initState();
    if (widget.designBlock['options'] != null &&
        widget.designBlock['options']['collapsible'] == true &&
        widget.designBlock['options']['defaultExpanded'] == true)
      _expandedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _buildExpandableItem(
      index: 0,
      title: widget.title,
      content: Html(
        data: widget.description,
        onLinkTap: (url, attributes, element) {
          if (url != null) {
            Get.toNamed('/webView',
                arguments: {"url": url, "pageTitle": widget.title});
          }
        },
        style: {
          "body": Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
          ),
          "p": Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
          ),
          "hr": Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
          ),
        },
      ),
    ));
  }

  // Method to build each expandable item
  Widget _buildExpandableItem({
    required int index,
    required String title,
    required Widget content,
  }) {
    bool isExpanded = widget.designBlock['options'] != null &&
            widget.designBlock['options']['collapsible'] == false
        ? true
        : _expandedIndex == index;
    var brightness = MediaQuery.of(context).platformBrightness;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.designBlock['options'] != null &&
              widget.designBlock['options']['collapsible'] == true) {
            _expandedIndex = isExpanded ? -1 : index;
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
          color: brightness == Brightness.dark ? Colors.black : Colors.white,
        ),
        child: Column(
          children: [
            if (title != null && title.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (widget.designBlock['options'] != null &&
                      widget.designBlock['options']['collapsible'] == true)
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                      size: 20.0,
                    ),
                ],
              )
            ],
            // Animated expansion
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isExpanded
                  ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: content,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
