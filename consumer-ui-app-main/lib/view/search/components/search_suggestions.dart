// ignore_for_file: unused_field, unnecessary_null_comparison

import 'package:black_locust/controller/predictive_search_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/view/search/components/search_suggestions_design1.dart';
import 'package:black_locust/view/search/components/search_suggestions_design2.dart';
import 'package:black_locust/view/search/components/search_suggestions_design3.dart';
import 'package:black_locust/view/search/components/search_suggestions_design4.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchSuggestions extends StatelessWidget {
  SearchSuggestions({
    Key? key,
    required this.title,
    required this.design,
    required controller,
    required this.products,
  })  : _controller = controller,
        super(key: key);

  final title;
  final design;
  final PredictiveSearchController _controller;
  final products;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var instanceId = themeController.instanceId('product');
    if (instanceId == 'design1') {
      return SearchSuggestionsDesign1(
          title: title,
          design: design,
          controller: _controller,
          products: products);
    } else if (instanceId == 'design2') {
      return SearchSuggestionsDesign2(
          title: title,
          design: design,
          controller: _controller,
          products: products);
    } else if (instanceId == 'design3') {
      return SearchSuggestionsDesign3(
          title: title,
          design: design,
          controller: _controller,
          products: products);
    } else if (instanceId == 'design4') {
      return SearchSuggestionsDesign4(
          title: title,
          design: design,
          controller: _controller,
          products: products);
    } else {
      return Container();
    }
  }
}
