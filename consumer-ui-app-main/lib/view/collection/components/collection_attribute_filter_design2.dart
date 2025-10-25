import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/collection_filter.controller.dart';
import 'package:black_locust/view/collection/components/collection_filter_header_row_design2.dart';
import 'package:black_locust/view/collection/components/filter_price_range.dart';
import 'package:flutter/material.dart';

class CollectionAttributeFilterDesign2 extends StatefulWidget {
  const CollectionAttributeFilterDesign2(
      {Key? key, required this.filterAttribute, required controller})
      : _controller = controller,
        super(key: key);

  final filterAttribute;
  final CollectionFilterController _controller;
  @override
  _AttributeFilterState createState() => _AttributeFilterState();
}

class _AttributeFilterState extends State<CollectionAttributeFilterDesign2> {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CollectionFilterHeaderRowDesign2(
          attribute: widget.filterAttribute,
          type: 'attribute',
        ),
        // kDefaultHeight(kDefaultPadding / 2),
        Container(
            width: SizeConfig.screenWidth,
            color: brightness == Brightness.dark ? Colors.black : kBackground,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Wrap(spacing: 10, runSpacing: 10, children: [
              for (var element in widget.filterAttribute.fieldValue)
                if (element.attributeFieldValue == "Price") ...[
                  FilterPriceRange(
                      fieldValue: element, controller: widget._controller)
                ] else ...[
                  GestureDetector(
                      onTap: () {
                        widget._controller.updateFilter(
                            element.attributeFieldValue,
                            widget.filterAttribute.fieldName);
                        setState(() {
                          element.checked = !element.checked;
                        });
                      },
                      child: Container(
                          width: (SizeConfig.screenWidth / 2) - 20,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                              color: element.checked ? kPrimaryColor : null,
                              border: Border.all(
                                  color: element.checked
                                      ? kPrimaryColor
                                      : Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            element.attributeFieldValue,
                            style: TextStyle(
                                color: brightness == Brightness.dark
                                    ? Colors.white
                                    : element.checked
                                        ? Colors.white
                                        : kPrimaryTextColor),
                          )))
                ]
            ])),
      ],
    );
  }
}
