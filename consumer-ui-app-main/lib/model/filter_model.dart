// ignore_for_file: unnecessary_null_comparison

List<AttributeVMModel> attributeListFromJson(dynamic str) =>
    List<AttributeVMModel>.from(
        str.map((x) => AttributeVMModel.fromPkModel(x)));

FilterVMModel filterFromJson(dynamic str) => (FilterVMModel.fromPkModel(str));

class FilterVMModel {
  late final List<CategoryVMModel> category;
  List<AttributeVMModel>? attribute;
  PriceRangeVMModel? priceRange;
  late final String sTypename;

  FilterVMModel(
      {required this.category,
      this.attribute,
      this.priceRange,
      required this.sTypename});

  FilterVMModel.fromPkModel(dynamic json) {
    if (json.category != null) {
      category = [];
      json.category.forEach((v) {
        category.add(new CategoryVMModel.fromPkModel(v));
      });
    }
    if (json.attribute != null) {
      attribute = [];
      json.attribute.forEach((v) {
        attribute!.add(new AttributeVMModel.fromPkModel(v));
      });
    }
    priceRange = json.priceRange != null
        ? new PriceRangeVMModel.fromPkModel(json.priceRange)
        : null;
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    if (this.attribute != null) {
      data['attribute'] = this.attribute!.map((v) => v.toJson()).toList();
    }
    if (this.priceRange != null) {
      data['priceRange'] = this.priceRange!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CategoryVMModel {
  late final String sId;
  late final String categoryName;
  late final String categoryDescription;
  late final String sTypename;

  CategoryVMModel(
      {required this.sId,
      required this.categoryName,
      required this.categoryDescription,
      required this.sTypename});

  CategoryVMModel.fromPkModel(dynamic json) {
    sId = json.sId;
    categoryName = json.categoryName;
    categoryDescription = json.categoryDescription;
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['categoryName'] = this.categoryName;
    data['categoryDescription'] = this.categoryDescription;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class AttributeVMModel {
  late final String attributeFieldId;
  late final bool fieldEnable;
  late final String fieldSetting;
  late final String labelName;
  late final String fieldName;
  late final bool? checked;
  late final List<FieldValueVMModel> fieldValue;
  late final String sTypename;

  AttributeVMModel(
      {required this.attributeFieldId,
      required this.fieldEnable,
      required this.fieldSetting,
      required this.labelName,
      required this.fieldName,
      required this.checked,
      required this.fieldValue,
      required this.sTypename});

  AttributeVMModel.fromPkModel(dynamic json) {
    attributeFieldId = json.attributeFieldId;
    fieldEnable = json.fieldEnable;
    fieldSetting = json.fieldSetting;
    labelName = json.labelName;
    fieldName = json.fieldName;
    checked = json.checked != null ? json.checked : false;
    if (json.fieldValue != null) {
      fieldValue = [];
      json.fieldValue.forEach((v) {
        fieldValue.add(new FieldValueVMModel.fromPkModel(v));
      });
    }
    sTypename = json.sTypename;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeFieldId'] = this.attributeFieldId;
    data['fieldEnable'] = this.fieldEnable;
    data['fieldSetting'] = this.fieldSetting;
    data['labelName'] = this.labelName;
    data['fieldName'] = this.fieldName;
    data['checked'] = this.checked;
    if (this.fieldValue != null) {
      data['fieldValue'] = this.fieldValue.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class FieldValueVMModel {
  late final String attributeFieldValueId;
  late final String attributeFieldValue;
  bool checked;
  late final String sTypename;

  FieldValueVMModel(
      {required this.attributeFieldValueId,
      required this.attributeFieldValue,
      required this.checked,
      required this.sTypename});

  FieldValueVMModel.fromPkModel(dynamic json)
      : attributeFieldValueId = json.attributeFieldValueId,
        attributeFieldValue = json.attributeFieldValue,
        checked = json.checked != null ? json.checked : false,
        sTypename = json.sTypename;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeFieldValueId'] = this.attributeFieldValueId;
    data['attributeFieldValue'] = this.attributeFieldValue;
    data['checked'] = this.checked;
    data['__typename'] = this.sTypename;
    return data;
  }
}

PriceRangeVMModel priceRangeFilterFromJson(dynamic str) =>
    (PriceRangeVMModel.fromPkModel(str));

class PriceRangeVMModel {
  late final int low;
  late final int high;
  int? selectedLow;
  int? selectedHigh;
  late final String sTypename;

  PriceRangeVMModel(
      {required this.low,
      required this.high,
      this.selectedLow,
      this.selectedHigh,
      required this.sTypename});

  PriceRangeVMModel.fromPkModel(dynamic json) {
    low = json.low;
    high = json.high;
    selectedLow = json.selectedLow;
    selectedHigh = json.selectedHigh;
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['low'] = this.low;
    data['high'] = this.high;
    data['selectedLow'] = this.selectedLow;
    data['selectedHigh'] = this.selectedHigh;
    data['__typename'] = this.sTypename;
    return data;
  }
}

SelectedFilterVMModel selectedFilterFromJson(dynamic str) =>
    (SelectedFilterVMModel.fromPkModel(str));

List<SelectedFilterVMModel> filterListFromJson(dynamic str) =>
    List<SelectedFilterVMModel>.from(
        str.map((x) => SelectedFilterVMModel.fromPkModel(x)));

class SelectedFilterVMModel {
  String fieldName;
  String fieldValue;

  SelectedFilterVMModel({
    required this.fieldName,
    required this.fieldValue,
  });

  SelectedFilterVMModel.fromPkModel(dynamic json)
      : fieldName = json.fieldName,
        fieldValue = json.fieldValue;
}

class SelectedFilter {
  String fieldName;
  String fieldValue;

  SelectedFilter({
    required this.fieldName,
    required this.fieldValue,
  });

  SelectedFilter.fromJson(dynamic json)
      : fieldName = json.fieldName,
        fieldValue = json.fieldValue;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldName'] = this.fieldName;
    data['fieldValue'] = this.fieldValue;

    return data;
  }
}
