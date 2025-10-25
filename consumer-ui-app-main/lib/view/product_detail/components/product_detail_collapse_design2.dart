import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class ProductDetailCollapseDesign2 extends StatefulWidget {
  const ProductDetailCollapseDesign2(
      {required this.designBlock,
      required this.title,
      required this.description});
  final designBlock;
  final title;
  final description;

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDetailCollapseDesign2>
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
        onLinkTap: (url, attributes, element) {
          if (url != null) {
            Get.toNamed('/webView',
                arguments: {"url": url, "pageTitle": widget.title});
          }
        },
        data: widget.description,
        style: {
          "body": Style(
            margin: Margins.symmetric(horizontal: 5),
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
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: const BoxDecoration(
          border: const Border(
            bottom: const BorderSide(
              width: 1,
              color: const Color(0xFF979797),
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (widget.designBlock['options'] != null &&
                    widget.designBlock['options']['collapsible'] == true)
                  Icon(
                    isExpanded ? Icons.remove : Icons.add,
                    size: 20.0,
                  ),
              ],
            ),
            // Animated expansion
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isExpanded
                  ? Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      child: content,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
