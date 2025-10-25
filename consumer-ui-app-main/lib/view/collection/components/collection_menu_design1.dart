import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionMenuDesign1 extends StatelessWidget {
  CollectionMenuDesign1({Key? key, required controller, required this.design})
      : _controller = controller,
        super(key: key);

  final dynamic _controller;
  final design;
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Obx(() => Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var menu in _controller.collectionMenu.value) ...[
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: GestureDetector(
                              onTap: () {
                                _controller.getCollectionMenuProducts(menu);
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: _controller.selectedCollectionMenu.value ==
                                              menu['attribute_input']
                                          ? Colors.white
                                          : Colors.black,
                                      border: Border.all(
                                          color: brightness == Brightness.dark
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Text(menu['attribute_value_label'],
                                      style: TextStyle(
                                          color: _controller.selectedCollectionMenu.value ==
                                                  menu['attribute_input']
                                              ? Colors.black
                                              : Colors.white)))))
                    ]
                  ])),
        ));
  }
}
