// ignore_for_file: deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionSortDesign1 extends StatelessWidget {
  CollectionSortDesign1({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final design;
  @override
  Widget build(BuildContext context) {
    // final brightness = Theme.of(context).brightness;
    return Obx(() => Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var element in _controller.sortSetting.value) ...[
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: GestureDetector(
                              onTap: () {
                                _controller.assignSelectedSort(element);
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: _controller.selectedSort.value.sId ==
                                            element.sId
                                        ? kPrimaryColor.withOpacity(0.5)
                                        : Color(0xFFF3F4F6),
                                  ),
                                  child: Row(children: [
                                    Icon(iconByType(element.sId),
                                        color: _controller
                                                    .selectedSort.value.sId ==
                                                element.sId
                                            ? Colors.white
                                            : Colors.black),
                                    SizedBox(width: 5),
                                    Text(element.name,
                                        style: TextStyle(
                                            color: _controller.selectedSort
                                                        .value.sId ==
                                                    element.sId
                                                ? Colors.white
                                                : Colors.black))
                                  ]))))
                    ]
                  ])),
        ));
  }

  iconByType(id) {
    switch (id) {
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
