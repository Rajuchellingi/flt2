// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CollectionSortDesign1a extends StatelessWidget {
  final dynamic controller;
  final dynamic design;

  const CollectionSortDesign1a({
    Key? key,
    required this.controller,
    required this.design,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSortBottomSheet(context),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(
              controller.selectedSortValue.value != null
                  ? iconByType(controller.selectedSortValue.value.type)
                  : Icons.sort,
              color: Colors.black,
              size: 18,
            ),
            const SizedBox(width: 6),
            const Text(
              'Sort By',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  void _showSortBottomSheet(BuildContext context) {
    final sortList = controller.sortSetting.value;
    final selectedSort = controller.selectedSortValue.value;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 12),
          children: sortList.map<Widget>((element) {
            final isSelected = selectedSort.sId == element.sId;
            final isDefault = element.isDefault == true;

            return InkWell(
              onTap: () {
                controller.assignSelectedSort(element);
                Navigator.of(context).pop(); // Close bottom sheet
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? kPrimaryColor.withOpacity(0.1)
                      : isDefault
                          ? Colors.red.shade50
                          : Colors.white,
                ),
                child: Row(
                  children: [
                    Icon(
                      iconByType(element.type),
                      color: isSelected
                          ? kPrimaryColor
                          : isDefault
                              ? Colors.red
                              : Colors.black,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        element.name,
                        style: TextStyle(
                          color: isSelected
                              ? kPrimaryColor
                              : isDefault
                                  ? Colors.red
                                  : Colors.black,
                          fontWeight: isSelected || isDefault
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check, color: kPrimaryColor, size: 18),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  IconData iconByType(dynamic type) {
    switch (type) {
      case 1:
        return Icons.trending_up;
      case 2:
        return Icons.access_time;
      case 3:
        return CupertinoIcons.sort_down;
      case 4:
        return CupertinoIcons.sort_up;
      case 5:
        return CupertinoIcons.sort_down_circle;
      case 6:
        return CupertinoIcons.sort_up_circle;
      default:
        return CupertinoIcons.sort_down;
    }
  }
}
