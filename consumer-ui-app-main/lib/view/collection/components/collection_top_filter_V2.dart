// ignore_for_file: unused_local_variable, non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionTopFilterV2 extends StatelessWidget {
  final controller;
  final Color backgroundColor;
  final dynamic f_controller;

  const CollectionTopFilterV2({
    Key? key,
    required this.controller,
    required this.backgroundColor,
    required this.f_controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(

              // child: CircularProgressIndicator(),
              )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  // decoration: BoxDecoration(
                  //   border: Border(
                  //     bottom: BorderSide(
                  //       color: Colors.grey,
                  //       width: 1,
                  //     ),
                  //     left: BorderSide(
                  //       color: Colors.grey,
                  //       width: 1,
                  //     ),
                  //   ),
                  //   color: backgroundColor,
                  // ),
                  child: Row(
                    children: <Widget>[
                      // Expanded(
                      //   child: SingleChildScrollView(
                      //     scrollDirection: Axis.horizontal,
                      //     child: Row(
                      //       children: f_controller.selectedFilterAttr
                      //           .asMap()
                      //           .entries
                      //           .map<Widget>((entry) {
                      //         final index = entry.key;
                      //         final filter = entry.value;
                      //         return Padding(
                      //           padding: const EdgeInsets.only(left: 10.0),
                      //           child: Chip(
                      //             backgroundColor:
                      //                 kPrimaryColor.withOpacity(0.5),
                      //             label: Text('${filter.fieldValue}',
                      //                 style: TextStyle(color: kSecondaryColor)),
                      //             onDeleted: () {
                      //               f_controller.updateTopFilter(
                      //                 filter.fieldName,
                      //                 filter.fieldValue,
                      //                 controller,
                      //               );
                      //             },
                      //           ),
                      //         );
                      //       }).toList(),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 40,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: TextButton.icon(
                          onPressed: () {
                            controller.openTopFilter(context, controller);
                          },
                          label: const Text(
                            'Filter',
                            style: const TextStyle(color: Colors.black),
                          ),
                          icon: const Icon(
                            Icons.filter_list,
                            color: Colors.black,
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
