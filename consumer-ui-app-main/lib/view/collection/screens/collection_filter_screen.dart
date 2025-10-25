import 'package:black_locust/controller/collection_filter.controller.dart';
import 'package:black_locust/view/collection/components/collection_filter.dart';
import 'package:black_locust/view/collection/components/collection_filter_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionFilterScreen extends StatelessWidget {
  final _controller = Get.find<CollectionFilterController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.filterDesign.value == 'design2')
        return CollectionFilterDesign2();
      else
        return CollectionFilter();
    });
  }
}
