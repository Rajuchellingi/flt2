import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/collection_filter.controller.dart';
import 'package:black_locust/view/collection/components/collection_filter_header_row.dart';
import 'package:flutter/material.dart';

class CollectionAttributeFilter extends StatefulWidget {
  const CollectionAttributeFilter(
      {Key? key, required this.filterAttribute, required controller})
      : _controller = controller,
        super(key: key);

  final filterAttribute;
  final CollectionFilterController _controller;
  @override
  _AttributeFilterState createState() => _AttributeFilterState();
}

class _AttributeFilterState extends State<CollectionAttributeFilter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CollectionFilterHeaderRow(
          attribute: widget.filterAttribute,
          type: 'attribute',
        ),
        kDefaultHeight(kDefaultPadding / 2),
        Column(
          children: List.generate(
            widget.filterAttribute.fieldValue.length,
            (indexField) => Padding(
              padding: EdgeInsets.only(left: kDefaultPadding / 3),
              child: CheckboxListTile(
                dense: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  widget._controller.updateFilter(
                      widget.filterAttribute.fieldValue[indexField]
                          .attributeFieldValue,
                      widget.filterAttribute.fieldName);
                  setState(() {
                    widget.filterAttribute.fieldValue[indexField].checked =
                        value;
                  });
                },
                title: Text(
                  '${widget.filterAttribute.fieldValue[indexField].attributeFieldValue} (${widget.filterAttribute.fieldValue[indexField].count})',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                value: (widget.filterAttribute.fieldValue[indexField].checked ==
                        false)
                    ? false
                    : true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
