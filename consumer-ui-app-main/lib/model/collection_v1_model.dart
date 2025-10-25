CollectionAttributeVM collectionAttributeVMFromJson(dynamic str) =>
    (CollectionAttributeVM.fromJson(str.toJson()));

CollectionAttributeVM collectionAttributeVMMFromJson(dynamic str) =>
    (CollectionAttributeVM.fromJson(str));

class CollectionAttributeVM {
  late final List<AttributeListVM> attribute;
  late final String? sTypename;

  CollectionAttributeVM({required this.attribute, required this.sTypename});

  CollectionAttributeVM.fromJson(Map<String, dynamic> json) {
    if (json['attribute'] != null) {
      attribute = <AttributeListVM>[];
      json['attribute'].forEach((v) {
        attribute.add(new AttributeListVM.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['attribute'] = this.attribute.map((v) => v.toJson()).toList();
    data['__typename'] = this.sTypename;

    return data;
  }
}

class AttributeListVM {
  late final String? sId;
  late final String? attributeFieldId;
  late final bool? checked;
  late final bool? fieldEnable;
  late final String? fieldName;
  late final String? fieldSetting;
  late final String? labelName;
  late final int? sortOrder;
  late final List<AttributeFieldValueVM>? fieldValue;
  late final String? sTypename;

  AttributeListVM(
      {required this.sId,
      required this.attributeFieldId,
      required this.checked,
      required this.fieldEnable,
      required this.fieldName,
      required this.fieldSetting,
      required this.labelName,
      required this.sortOrder,
      required this.fieldValue,
      required this.sTypename});

  AttributeListVM.fromJson(Map<String, dynamic> json) {
    // print("toJson data ${json}");
    sId = json['_id'];
    attributeFieldId = json['attributeFieldId'];
    checked = json['checked'] != null ? json['checked'] : false;
    fieldEnable = json['fieldEnable'];
    fieldName = json['fieldName'];
    fieldSetting = json['fieldSetting'];
    labelName = json['labelName'];
    sortOrder = json['sortOrder'];
    if (json['fieldValue'] != null) {
      fieldValue = <AttributeFieldValueVM>[];
      json['fieldValue'].forEach((v) {
        fieldValue!.add(new AttributeFieldValueVM.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['attributeFieldId'] = this.attributeFieldId;
    data['checked'] = this.checked;
    data['fieldEnable'] = this.fieldEnable;
    data['fieldName'] = this.fieldName;
    data['fieldSetting'] = this.fieldSetting;
    data['labelName'] = this.labelName;
    data['sortOrder'] = this.sortOrder;
    if (this.fieldValue != null) {
      data['fieldValue'] = this.fieldValue!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class AttributeFieldValueVM {
  late final String? appletName;
  late final String? attributeFieldValue;
  late final String? attributeFieldValueId;
  bool? checked;
  late final bool? fieldValueEnable;
  late final int? sortOrder;
  late final String? sTypename;

  AttributeFieldValueVM(
      {required this.appletName,
      required this.attributeFieldValue,
      required this.attributeFieldValueId,
      required this.checked,
      required this.fieldValueEnable,
      required this.sortOrder,
      required this.sTypename});

  AttributeFieldValueVM.fromJson(Map<String, dynamic> json) {
    // print("toJson data2--->>> ${json}");
    appletName = json['appletName'];
    attributeFieldValue = json['attributeFieldValue'];
    attributeFieldValueId = json['attributeFieldValueId'];
    checked = json['checked'] != null ? json['checked'] : false;
    fieldValueEnable = json['fieldValueEnable'];
    sortOrder = json['sortOrder'];
    sTypename = json['__typename'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appletName'] = this.appletName;
    data['attributeFieldValue'] = this.attributeFieldValue;
    data['attributeFieldValueId'] = this.attributeFieldValueId;
    data['checked'] = this.checked;
    data['fieldValueEnable'] = this.fieldValueEnable;
    data['sortOrder'] = this.sortOrder;
    data['__typename'] = this.sTypename;
    return data;
  }
}
