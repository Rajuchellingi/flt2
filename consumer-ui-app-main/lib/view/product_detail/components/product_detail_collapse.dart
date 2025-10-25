import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class ProductDetailCollapse extends StatefulWidget {
  const ProductDetailCollapse(
      {required this.designBlock,
      required this.title,
      required this.description});
  final designBlock;
  final title;
  final description;

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDetailCollapse>
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
        margin: EdgeInsets.symmetric(horizontal: 10),
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
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: brightness == Brightness.dark ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (widget.designBlock['options'] != null &&
                    widget.designBlock['options']['collapsible'] == true)
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
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

  @override
  void dispose() {
    super.dispose();
  }
}
