import 'dart:convert';

import 'package:b2b_graphql_package/modules/collection/collection_repo.dart';
import 'package:black_locust/model/collection_model.dart';
import 'package:black_locust/model/filter_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CollectionFilterController extends GetxController {
  CollectionRepo? collectionRepo;
  var categoryAttribute = CollectionAttributeVM(attribute: [], sTypename: "");

  var filterAttribute = [].obs;
  var selectedFilterAttr = [].obs;
  var priceRange;
  var priceRangeMin = (0.0).obs;
  var priceRangeMax = (0.0).obs;
  var initialRangeMin = 0.0;
  var initialRangeMax = 0.0;
  var isLoading = false.obs;
  var filterDesign = 'design1'.obs;
  var priceRangeValue = RangeValues(0, 0).obs;
  @override
  void dispose() {
    GetStorage().remove('collectionfilter');
    super.dispose();
  }

  @override
  void onInit() {
    collectionRepo = CollectionRepo();
    var argument = Get.arguments;
    // GetStorage().remove('collectionfilter');
    var collectionFilterData = GetStorage().read('collectionfilter');
    if (argument != null) {
      filterDesign.value = argument['design'];
      if (collectionFilterData == null) {
        getCategoryAttributeWithSet(argument['collection'], []);
      } else {
        categoryAttribute = collectionAttributeVMFromJson(collectionFilterData);
        updateInitialData(categoryAttribute);
      }
    }
    super.onInit();
  }

  updateInitialData(categoryAttribute) {
    if (filterDesign.value == 'design2') {
      filterAttribute.value = categoryAttribute.attribute;
    } else {
      filterAttribute.value = categoryAttribute.attribute!
          .where((attribute) => attribute.labelName != 'Price')
          .toList();
    }
  }

  Future getCategoryAttributeWithSet(String categoryLink, List filter) async {
    // print("categoryLink collection $categoryLink");
    isLoading.value = true;
    var result = await collectionRepo!.getAttributeByCollection(categoryLink);
    isLoading.value = false;
    categoryAttribute = collectionAttributeVMFromJson(result);
    updateInitialData(categoryAttribute);
  }

  updatePriceRange(PriceRangeVMModel priceRangeModel) {
    // ignore: unnecessary_null_comparison
    if (priceRangeModel != null) {
      priceRange = priceRangeModel;
      priceRangeMin.value = priceRangeModel.selectedLow!.toDouble();
      priceRangeMax.value = priceRangeModel.selectedHigh!.toDouble();

      initialRangeMin = priceRangeModel.selectedLow!.toDouble();
      initialRangeMax = priceRangeModel.selectedHigh!.toDouble();
    }
  }

  setPriceRange(range) {
    priceRangeValue.value = range;
  }

  onChangePriceRange(range, fieldValue) {
    fieldValue.checked = true;
    priceRangeValue.value = range;
    if (priceRangeValue.value.end > 0) {
      var value = {
        "price": {
          "min": priceRangeValue.value.start,
          "max": priceRangeValue.value.end
        }
      };
      fieldValue.input = jsonEncode(value);
    }
  }

  resetAll() {
    for (var i = 0; i < categoryAttribute.attribute!.length; i++) {
      categoryAttribute.attribute![i].fieldValue!.forEach((element) {
        element.checked = false;
      });
    }
    priceRangeMax.value = initialRangeMax;
    priceRangeMin.value = initialRangeMin;

    if (GetStorage().read('collectionfilter') != null) {
      GetStorage().write(
          'collectionfilter', collectionAttributeVMFromJson(categoryAttribute));
    }
  }

  updateFilter(value, filterName) {}

  priceRangeChanged(value) {
    priceRangeMin.value = value.start.toDouble();
    priceRangeMax.value = value.end.toDouble();
  }

  applyClick() {
    if (priceRangeMin.value != initialRangeMin ||
        priceRangeMax.value != initialRangeMax) {
      var filterPl = new SelectedFilter(
          fieldName: 'pl', fieldValue: priceRangeMin.value.round().toString());
      selectedFilterAttr.add(filterPl);

      var filterPh = new SelectedFilter(
          fieldName: 'ph', fieldValue: priceRangeMax.value.round().toString());
      selectedFilterAttr.add(filterPh);

      priceRange.selectedHigh = priceRangeMax.value.round();
      priceRange.selectedLow = priceRangeMin.value.round();
    }

    GetStorage().write(
        'collectionfilter', collectionAttributeVMFromJson(categoryAttribute));

    for (var i = 0; i < categoryAttribute.attribute!.length; i++) {
      categoryAttribute.attribute![i].fieldValue!.forEach((element) {
        if (element.checked!) {
          var filter = {
            'fieldName': categoryAttribute.attribute![i].fieldName.toString(),
            'fieldValue': element.attributeFieldValue.toString(),
            'input': element.input,
          };
          selectedFilterAttr.add(filter);
        }
      });
    }
    Get.back(result: selectedFilterAttr);
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
    filterAttribute.close();
    selectedFilterAttr.close();
    priceRangeMin.close();
    priceRangeMax.close();
    isLoading.close();
    filterDesign.close();
    priceRangeValue.close();
    super.onClose();
  }
}
