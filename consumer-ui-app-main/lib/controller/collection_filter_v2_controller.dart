// ignore_for_file: invalid_use_of_protected_member, non_constant_identifier_names, unused_local_variable

import 'package:black_locust/model/collection_v1_model.dart';
import 'package:black_locust/model/filter_model.dart';
import 'package:get/get.dart';

class CollectionFilterV1Controller extends GetxController {
  var categoryAttribute =
      CollectionAttributeVM(attribute: [], sTypename: "").obs;

  var filterAttribute = [].obs;
  var selectedFilterAttr = [].obs;
  var priceRange;
  var priceRangeMin = (0.0).obs;
  var priceRangeMax = (0.0).obs;
  var initialRangeMin = 0.0;
  var initialRangeMax = 0.0;
  var isLoading = false.obs;
  var selectedFilter = [].obs;

  @override
  void onInit() {
    var argument = Get.arguments;
    // GetStorage().erase();
    if (argument != null) {}

    super.onInit();
  }

  updateInitialData(filterAttributeValue) {
    filterAttribute.value = filterAttributeValue!;
  }

  Future getCategoryAttributeWithSet(
      collectionFilter, filterAttributeValue, List filter) async {
    isLoading.value = true;
    var collectionFilterApplyValues = {
      "attribute": collectionFilter['filters']
    };
    categoryAttribute.value =
        collectionAttributeVMMFromJson(collectionFilterApplyValues);
    //         print("categoryAttribute--->>> ${categoryAttribute.toJson()}");
    updateInitialData(filterAttributeValue);
    isLoading.value = false;
  }

  void resetAll(c_controller) {
    // print("click resetAll");
    selectedFilterAttr.value = [];
    selectedFilterAttr.refresh();
    c_controller.getProductByFilter(selectedFilterAttr.value);
  }

  void updateFilter(String fieldName, String fieldValue, c_controller) {
    // print("Filter change requested: {fieldName: $fieldName, fieldValue: $fieldValue}");
    var existingFilter = selectedFilterAttr.firstWhere(
      (element) =>
          element.fieldName == fieldName && element.fieldValue == fieldValue,
      orElse: () => null,
    );

    if (existingFilter != null) {
      selectedFilterAttr.remove(existingFilter);
      // print("Filter removed: {fieldName: $fieldName, fieldValue: $fieldValue}");
    } else {
      var filter = SelectedFilter(fieldName: fieldName, fieldValue: fieldValue);
      selectedFilterAttr.add(filter);
      // print("Filter added: {fieldName: $fieldName, fieldValue: $fieldValue}");
    }
    // print("selectedFilterAttr.value ${selectedFilterAttr.value}");
    // applyClick();
    c_controller.getProductByFilter(selectedFilterAttr.value);
    selectedFilterAttr.refresh();
    // Print current filters for debugging
  }

  void updateTopFilter(
      String fieldName, String fieldValue, collectionController) {
    // print("Filter change requested: {fieldName: $fieldName, fieldValue: $fieldValue}");

    var existingFilter = selectedFilterAttr.firstWhere(
      (element) =>
          element.fieldName == fieldName && element.fieldValue == fieldValue,
      orElse: () => null,
    );

    if (existingFilter != null) {
      selectedFilterAttr.remove(existingFilter);
      // print("Filter removed: {fieldName: $fieldName, fieldValue: $fieldValue}");
    } else {
      var filter = SelectedFilter(fieldName: fieldName, fieldValue: fieldValue);
      selectedFilterAttr.add(filter);
      // print("Filter added: {fieldName: $fieldName, fieldValue: $fieldValue}");
    }
    selectedFilterAttr.refresh(); // Ensure the UI is updated
    // print("Current filters: ${selectedFilterAttr.map((e) => e.toJson()).toList()}");
    collectionController.getProductByFilter(selectedFilterAttr.value);
  }

  applyClick() {
    var filter;
    for (var i = 0; i < categoryAttribute.value.attribute.length; i++) {
      categoryAttribute.value.attribute[i].fieldValue!.forEach((element) {
        if (element.checked!) {
          filter = new SelectedFilter(
              fieldName:
                  categoryAttribute.value.attribute[i].fieldName.toString(),
              fieldValue: element.attributeFieldValue.toString());
          // selectedFilterAttr.add(filter);
        }
      });
    }
    // print("selectedFilterAttr applyclick: ${selectedFilterAttr.map((e) => e.toJson()).toList()}");
    Get.back(result: selectedFilterAttr);
  }

  String toCamelCase(String str) {
    if (str.isEmpty) return str;
    List<String> words = str.split(' ');
    words = words.map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();
    return words.join(' ');
  }

  bool showAttRowClear(attribute) {
    bool show = false;
    attribute.fieldValue.forEach((element) {
      if (element.checked) {
        show = true;
      }
    });
    return show;
  }

  bool showRowClear() {
    return true;
  }

  resetAttrField(attribute) {
    attribute.fieldValue.forEach((element) {
      element.checked = false;
    });
  }

  @override
  void onClose() {
    categoryAttribute.close();
    filterAttribute.close();
    selectedFilterAttr.close();
    priceRangeMin.close();
    priceRangeMax.close();
    isLoading.close();
    selectedFilter.close();
    super.onClose();
  }
}
