// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison, deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/collection_filter_v1_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionAttributeFilterV2 extends StatefulWidget {
  const CollectionAttributeFilterV2({
    Key? key,
    required this.filterAttribute,
    required controller,
  })  : _cController = controller,
        super(key: key);
  final _cController;

  final dynamic filterAttribute;
  @override
  _AttributeFilterState createState() => _AttributeFilterState();
}

class _AttributeFilterState extends State<CollectionAttributeFilterV2> {
  bool showSubValues = false;
  late CollectionFilterV1Controller _controller;
  String? selectedCategory;
  List? fieldValue;
  int? selectedIndex;
  Map<int, bool> expandedState = {};

  @override
  void initState() {
    super.initState();
    _controller = Get.find<CollectionFilterV1Controller>();
    if (_controller.filterAttribute.isNotEmpty) {
      selectedCategory = _controller.filterAttribute[0].fieldName;
      fieldValue = _controller.filterAttribute[0].fieldValue;
      selectedIndex = 0;
    }
  }

  int getSelectedCount(fieldName) {
    if (_controller.selectedFilterAttr.value != null &&
        _controller.selectedFilterAttr.value.length > 0) {
      return _controller.selectedFilterAttr.value
          .where((item) => item.fieldName == fieldName)
          .length;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(
    //     "_controller.filterAttribute: ${_controller.filterAttribute.toJson()}");
    return Obx(() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey[200],
            width: MediaQuery.of(context).size.width * 0.29,
            child: ListView.builder(
              itemCount: _controller.filterAttribute.length,
              itemBuilder: (context, index) {
                bool isSelected = selectedCategory ==
                    _controller.filterAttribute[index].fieldName;
                int selectedCount = getSelectedCount(
                    _controller.filterAttribute[index].fieldName);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory =
                          _controller.filterAttribute[index].fieldName;
                      fieldValue =
                          _controller.filterAttribute[index].fieldValue;
                      selectedIndex = index;
                      expandedState.clear();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 17.0), // Apply 20px padding top and bottom
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white
                          : kPrimaryColor.withOpacity(0.5),
                    ),
                    child: Center(
                      // Center the content inside the container
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 0, left: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    _controller
                                        .filterAttribute[index].labelName,
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      color: isSelected
                                          ? kPrimaryColor
                                          : const Color(0xFF5A5A9B),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                if (selectedCount > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10.0, left: 20.0),
                                    child: Text(
                                      '$selectedCount',
                                      style: const TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(5.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Text(
                        _controller.toCamelCase(selectedCategory ?? ''),
                        // (selectedCategory ?? ''),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // SizedBox(height: 12.0),
                    if (fieldValue == null)
                      Center(
                        child: Text(
                          'No Filters selected.',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      )
                    else
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 5.0,
                          runSpacing: 5.0,
                          children: List.generate(fieldValue!.length, (index) {
                            return Container(
                              margin: EdgeInsets.only(right: 2.0),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    fieldValue![index].checked =
                                        !fieldValue![index].checked;
                                    // Ensure selectedIndex is within bounds
                                    if (selectedIndex != null &&
                                        selectedIndex! <
                                            _controller
                                                .filterAttribute.length) {
                                      _controller.updateFilterV1(
                                          _controller
                                              .filterAttribute[selectedIndex!]
                                              .fieldName,
                                          fieldValue![index]
                                              .attributeFieldValue,
                                          widget._cController);
                                    } else {
                                      print('Selected index is out of bounds');
                                    }
                                  });
                                },
                                style: TextButton.styleFrom(
                                  // backgroundColor: fieldValue![index].checked
                                  backgroundColor: checkIsSelected(
                                          _controller
                                              .filterAttribute[selectedIndex!]
                                              .fieldName,
                                          fieldValue![index]
                                              .attributeFieldValue)
                                      ? kPrimaryColor.withOpacity(0.5)
                                      : Colors.grey[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        fieldValue![index].attributeFieldValue,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: checkIsSelected(
                                                  _controller
                                                      .filterAttribute[
                                                          selectedIndex!]
                                                      .fieldName,
                                                  fieldValue![index]
                                                      .attributeFieldValue)
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (checkIsSelected(
                                        _controller
                                            .filterAttribute[selectedIndex!]
                                            .fieldName,
                                        fieldValue![index].attributeFieldValue))
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Icon(
                                          Icons.close,
                                          size: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  bool checkIsSelected(fieldName, fieldValue) {
    // print("fieldName: $fieldName, fieldValue: $fieldValue");
    // print(
    //     "_controller.selectedFilterAttr.value ${_controller.selectedFilterAttr.value.map((e) => e.toJson()).toList()}");
    if (_controller.selectedFilterAttr.value != null &&
        _controller.selectedFilterAttr.value.length > 0) {
      bool isFieldName = _controller.selectedFilterAttr.value.any((element) =>
          element.fieldName == fieldName && element.fieldValue == fieldValue);
      // _controller.updateFilterV1(fieldName,fieldValue);
      return isFieldName;
    } else {
      return false;
    }
  }
}
