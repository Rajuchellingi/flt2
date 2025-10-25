// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionMenuDesign2 extends StatelessWidget {
  CollectionMenuDesign2({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final design;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Obx(() {
      final menuList = _controller.collectionMenu.value;

      if (menuList.isEmpty) {
        return const SizedBox();
      }

      final brand = menuList.first;
      final collections = brand.collections as List<dynamic>;

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var collection in collections) ...[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      _controller.getCollectionMenuProducts(collection);
                      _controller.selectedCollectionMenu.value =
                          collection.collectionId;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 18),
                      child: IntrinsicWidth(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              collection.collectionName ?? "",
                              style: TextStyle(
                                color:
                                    _controller.selectedCollectionMenu.value ==
                                            collection.collectionId
                                        ? Colors.orange
                                        : Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (_controller.selectedCollectionMenu.value ==
                                collection.collectionId) ...[
                              const SizedBox(height: 10),
                              Container(
                                height: 2,
                                width: double.infinity, // match text width
                                color: Colors.orange,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      );
    });
  }
}
