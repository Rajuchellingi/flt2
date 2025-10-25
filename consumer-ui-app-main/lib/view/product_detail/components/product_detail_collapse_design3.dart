import 'package:black_locust/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class ProductDetailCollapseDesign3 extends StatefulWidget {
  const ProductDetailCollapseDesign3(
      {required this.designBlock, this.title, required this.description});
  final designBlock;
  final title;
  final description;

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDetailCollapseDesign3>
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
    final brightness = Theme.of(context).brightness;
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
            color: brightness == Brightness.dark
                ? Colors.white
                : kPrimaryTextColor,
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
    required String? title,
    required Widget content,
  }) {
    final brightness = Theme.of(context).brightness;
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (title != null) ...[
                  Text(
                    title,
                    style: TextStyle(
                      // fontSize: 14,
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : kPrimaryTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.designBlock['options'] != null &&
                      widget.designBlock['options']['collapsible'] == true)
                    Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 20.0,
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : kPrimaryTextColor)
                ]
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
