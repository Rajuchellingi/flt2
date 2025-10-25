List<MultiBookingProductVM> multiBookingProductsVMFromJson(dynamic str) =>
    List<MultiBookingProductVM>.from(
        str.map((x) => MultiBookingProductVM.fromJson(x)));

class MultiBookingProductVM {
  String? id;
  String? productName;
  bool? isCustomizable;
  bool? isAssorted;
  int? moq;
  num? discount;
  num? productDiscount;
  String? priceDisplayType;
  String? currencySymbol;
  String? type;
  String? setCode;
  String? packCode;
  MultiBookingPriceVM? price;
  MultiBookingImageVM? image;
  PreferenceVariantVM? preferenceVariant;
  MultiBookingSetQuantityVM? setQuantity;
  MultiBookingPackQuantityVM? packQuantity;
  List<MultiBookingPackVariantVM>? packVariant;
  List<MultiBookingSetVariantVM>? variants;

  MultiBookingProductVM({
    this.id,
    this.productName,
    this.isCustomizable,
    this.isAssorted,
    this.moq,
    this.discount,
    this.productDiscount,
    this.priceDisplayType,
    this.currencySymbol,
    this.type,
    this.setCode,
    this.packCode,
    this.price,
    this.image,
    this.preferenceVariant,
    this.setQuantity,
    this.packQuantity,
    this.packVariant,
    this.variants,
  });

  MultiBookingProductVM.fromJson(dynamic json) {
    id = json.id;
    productName = json.productName;
    isCustomizable = json.isCustomizable;
    isAssorted = json.isAssorted;
    moq = json.moq;
    discount = json.discount;
    productDiscount = json.productDiscount;
    priceDisplayType = json.priceDisplayType;
    currencySymbol = json.currencySymbol;
    type = json.type;
    setCode = json.setCode;
    packCode = json.packCode;
    price =
        json.price != null ? MultiBookingPriceVM.fromJson(json.price) : null;
    image =
        json.image != null ? MultiBookingImageVM.fromJson(json.image) : null;
    preferenceVariant = json.preferenceVariant != null
        ? PreferenceVariantVM.fromJson(json.preferenceVariant)
        : null;
    setQuantity = json.setQuantity != null
        ? MultiBookingSetQuantityVM.fromJson(json.setQuantity)
        : null;
    packQuantity = json.packQuantity != null
        ? MultiBookingPackQuantityVM.fromJson(json.packQuantity)
        : null;
    packVariant = [];
    if (json.packVariant != null) {
      json.packVariant.forEach((v) {
        packVariant!.add(MultiBookingPackVariantVM.fromJson(v));
      });
    }
    variants = [];
    if (json.variants != null) {
      json.variants.forEach((v) {
        variants!.add(MultiBookingSetVariantVM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['productName'] = productName;
    data['isCustomizable'] = isCustomizable;
    data['isAssorted'] = isAssorted;
    data['moq'] = moq;
    data['discount'] = discount;
    data['productDiscount'] = productDiscount;
    data['priceDisplayType'] = priceDisplayType;
    data['currencySymbol'] = currencySymbol;
    data['type'] = type;
    data['setCode'] = setCode;
    data['packCode'] = packCode;
    if (price != null) data['price'] = price!.toJson();
    if (image != null) data['image'] = image!.toJson();
    if (preferenceVariant != null)
      data['preferenceVariant'] = preferenceVariant!.toJson();
    if (setQuantity != null) data['setQuantity'] = setQuantity!.toJson();
    if (packQuantity != null) data['packQuantity'] = packQuantity!.toJson();
    if (packVariant != null)
      data['packVariant'] = packVariant!.map((v) => v.toJson()).toList();
    if (variants != null)
      data['variants'] = variants!.map((v) => v.toJson()).toList();
    return data;
  }
}

class MultiBookingPriceVM {
  String? mrp;
  String? sellingPrice;
  MultiBookingPriceVM({this.mrp, this.sellingPrice});
  MultiBookingPriceVM.fromJson(dynamic json) {
    mrp = json.mrp;
    sellingPrice = json.sellingPrice;
  }
  Map<String, dynamic> toJson() => {'mrp': mrp, 'sellingPrice': sellingPrice};
}

class MultiBookingImageVM {
  String? imageId;
  String? imageName;
  MultiBookingImageVM({this.imageId, this.imageName});
  MultiBookingImageVM.fromJson(dynamic json) {
    imageId = json.imageId;
    imageName = json.imageName;
  }
  Map<String, dynamic> toJson() => {'imageId': imageId, 'imageName': imageName};
}

class PreferenceVariantVM {
  String? attributeFieldName;
  String? attributeFieldId;
  String? attributeLabelName;
  String? attributeFieldSetting;
  PreferenceVariantVM({
    this.attributeFieldName,
    this.attributeFieldId,
    this.attributeLabelName,
    this.attributeFieldSetting,
  });
  PreferenceVariantVM.fromJson(dynamic json) {
    attributeFieldName = json.attributeFieldName;
    attributeFieldId = json.attributeFieldId;
    attributeLabelName = json.attributeLabelName;
    attributeFieldSetting = json.attributeFieldSetting;
  }
  Map<String, dynamic> toJson() => {
        'attributeFieldName': attributeFieldName,
        'attributeFieldId': attributeFieldId,
        'attributeLabelName': attributeLabelName,
        'attributeFieldSetting': attributeFieldSetting,
      };
}

class VariantPreferenceVariantVM {
  late final String? attributeFieldValueId;
  late final String? attributeFieldId;
  late final String? attributeFieldValue;
  VariantPreferenceVariantVM({
    required this.attributeFieldValueId,
    required this.attributeFieldId,
    required this.attributeFieldValue,
  });
  VariantPreferenceVariantVM.fromJson(dynamic json) {
    attributeFieldValueId = json.attributeFieldValueId;
    attributeFieldId = json.attributeFieldId;
    attributeFieldValue = json.attributeFieldValue;
  }
  Map<String, dynamic> toJson() => {
        'attributeFieldValueId': attributeFieldValueId,
        'attributeFieldId': attributeFieldId,
        'attributeFieldValue': attributeFieldValue,
      };
}

class MultiBookingSetQuantityVM {
  int? totalQuantity;
  String? variantType;
  List<SetVariantQuantityVM>? variantQuantites;
  MultiBookingSetQuantityVM({
    this.totalQuantity,
    this.variantType,
    this.variantQuantites,
  });
  MultiBookingSetQuantityVM.fromJson(dynamic json) {
    totalQuantity = json.totalQuantity;
    variantType = json.variantType;
    variantQuantites = [];
    if (json.variantQuantites != null) {
      json.variantQuantites.forEach((v) {
        variantQuantites!.add(SetVariantQuantityVM.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() => {
        'totalQuantity': totalQuantity,
        'variantType': variantType,
        'variantQuantites': variantQuantites?.map((v) => v.toJson()).toList(),
      };
}

class SetVariantQuantityVM {
  String? attributeFieldValue;
  int? moq;
  SetVariantQuantityVM({this.attributeFieldValue, this.moq});
  SetVariantQuantityVM.fromJson(dynamic json) {
    attributeFieldValue = json.attributeFieldValue;
    moq = json.moq;
  }
  Map<String, dynamic> toJson() => {
        'attributeFieldValue': attributeFieldValue,
        'moq': moq,
      };
}

class MultiBookingPackQuantityVM {
  int? totalQuantity;
  String? variantType;
  List<PackSetQuantityVM>? setQuantities;
  MultiBookingPackQuantityVM({
    this.totalQuantity,
    this.variantType,
    this.setQuantities,
  });
  MultiBookingPackQuantityVM.fromJson(dynamic json) {
    totalQuantity = json.totalQuantity;
    variantType = json.variantType;
    setQuantities = [];
    if (json.setQuantities != null) {
      json.setQuantities.forEach((v) {
        setQuantities!.add(PackSetQuantityVM.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() => {
        'totalQuantity': totalQuantity,
        'variantType': variantType,
        'setQuantities': setQuantities?.map((v) => v.toJson()).toList(),
      };
}

class PackSetQuantityVM {
  String? attributeFieldValueId;
  String? attributeFieldValue;
  List<SetVariantQuantityVM>? variantQuantites;
  PackSetQuantityVM({
    this.attributeFieldValueId,
    this.attributeFieldValue,
    this.variantQuantites,
  });
  PackSetQuantityVM.fromJson(dynamic json) {
    attributeFieldValueId = json.attributeFieldValueId;
    attributeFieldValue = json.attributeFieldValue;
    variantQuantites = [];
    if (json.variantQuantites != null) {
      json.variantQuantites.forEach((v) {
        variantQuantites!.add(SetVariantQuantityVM.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() => {
        'attributeFieldValueId': attributeFieldValueId,
        'attributeFieldValue': attributeFieldValue,
        'variantQuantites': variantQuantites?.map((v) => v.toJson()).toList(),
      };
}

class MultiBookingPackVariantVM {
  String? attributeLabelName;
  String? attributeFieldValueId;
  String? attributeFieldValue;
  String? colorCode;
  String? attributeFieldSetting;
  MultiBookingImageVM? variantImage;
  List<MultiBookingImageVM>? images;
  String? setId;
  List<PackVariantOption>? variantOptions;

  MultiBookingPackVariantVM({
    this.attributeLabelName,
    this.attributeFieldValueId,
    this.attributeFieldValue,
    this.colorCode,
    this.attributeFieldSetting,
    this.variantImage,
    this.images,
    this.setId,
    this.variantOptions,
  });

  MultiBookingPackVariantVM.fromJson(dynamic json) {
    attributeLabelName = json.attributeLabelName;
    attributeFieldValueId = json.attributeFieldValueId;
    attributeFieldValue = json.attributeFieldValue;
    colorCode = json.colorCode;
    attributeFieldSetting = json.attributeFieldSetting;
    variantImage = json.variantImage != null
        ? MultiBookingImageVM.fromJson(json.variantImage)
        : null;
    images = [];
    if (json.images != null) {
      json.images.forEach((v) {
        images!.add(MultiBookingImageVM.fromJson(v));
      });
    }
    setId = json.setId;
    variantOptions = [];
    if (json.variantOptions != null) {
      json.variantOptions.forEach((v) {
        variantOptions!.add(PackVariantOption.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        'attributeLabelName': attributeLabelName,
        'attributeFieldValueId': attributeFieldValueId,
        'attributeFieldValue': attributeFieldValue,
        'colorCode': colorCode,
        'attributeFieldSetting': attributeFieldSetting,
        'variantImage': variantImage?.toJson(),
        'images': images?.map((v) => v.toJson()).toList(),
        'setId': setId,
        'variantOptions': variantOptions?.map((v) => v.toJson()).toList(),
      };
}

class PackVariantOption {
  String? attributeLabelName;
  String? variantId;
  String? attributeFieldValueId;
  String? attributeFieldValue;
  String? colorCode;
  String? attributeFieldSetting;
  int? totalQuantity;
  bool? continueSellingWhenOutOfStock;
  bool? trackQuantity;
  List<PackVariantMetafield>? metafields;
  String? sellingPrice;
  String? mrp;

  PackVariantOption({
    this.attributeLabelName,
    this.variantId,
    this.attributeFieldValueId,
    this.attributeFieldValue,
    this.colorCode,
    this.attributeFieldSetting,
    this.totalQuantity,
    this.continueSellingWhenOutOfStock,
    this.trackQuantity,
    this.metafields,
    this.sellingPrice,
    this.mrp,
  });

  PackVariantOption.fromJson(dynamic json) {
    attributeLabelName = json.attributeLabelName;
    variantId = json.variantId;
    attributeFieldValueId = json.attributeFieldValueId;
    attributeFieldValue = json.attributeFieldValue;
    colorCode = json.colorCode;
    attributeFieldSetting = json.attributeFieldSetting;
    totalQuantity = json.totalQuantity;
    continueSellingWhenOutOfStock = json.continueSellingWhenOutOfStock;
    trackQuantity = json.trackQuantity;
    metafields = [];
    if (json.metafields != null) {
      json.metafields.forEach((v) {
        metafields!.add(PackVariantMetafield.fromJson(v));
      });
    }
    sellingPrice = json.sellingPrice;
    mrp = json.mrp;
  }

  Map<String, dynamic> toJson() => {
        'attributeLabelName': attributeLabelName,
        'variantId': variantId,
        'attributeFieldValueId': attributeFieldValueId,
        'attributeFieldValue': attributeFieldValue,
        'colorCode': colorCode,
        'attributeFieldSetting': attributeFieldSetting,
        'totalQuantity': totalQuantity,
        'continueSellingWhenOutOfStock': continueSellingWhenOutOfStock,
        'trackQuantity': trackQuantity,
        'metafields': metafields?.map((v) => v.toJson()).toList(),
        'sellingPrice': sellingPrice,
        'mrp': mrp,
      };
}

class PackVariantMetafield {
  String? customDataId;
  String? definition;
  String? namespace;
  String? key;
  String? customDatatype;
  String? customDataValueType;
  PackVariantReference? reference;
  String? id;

  PackVariantMetafield({
    this.customDataId,
    this.definition,
    this.namespace,
    this.key,
    this.customDatatype,
    this.customDataValueType,
    this.reference,
    this.id,
  });

  PackVariantMetafield.fromJson(dynamic json) {
    customDataId = json.customDataId;
    definition = json.definition;
    namespace = json.namespace;
    key = json.key;
    customDatatype = json.customDatatype;
    customDataValueType = json.customDataValueType;
    reference = json.reference != null
        ? PackVariantReference.fromJson(json.reference)
        : null;
    id = json.id;
  }

  Map<String, dynamic> toJson() => {
        'customDataId': customDataId,
        'definition': definition,
        'namespace': namespace,
        'key': key,
        'customDatatype': customDatatype,
        'customDataValueType': customDataValueType,
        'reference': reference?.toJson(),
        '_id': id,
      };
}

class PackVariantReference {
  String? value;
  String? id;
  PackVariantReference({this.value, this.id});
  PackVariantReference.fromJson(dynamic json) {
    value = json.value;
    id = json.id;
  }
  Map<String, dynamic> toJson() => {'value': value, '_id': id};
}

class MultiBookingSetVariantVM {
  String? variantId;
  int? moq;
  int? totalQuantity;
  bool? trackQuantity;
  bool? continueSellingWhenOutOfStock;
  VariantPreferenceVariantVM? preferenceVariant;
  MultiBookingImageVM? variantImage;
  SetVariantPrice? price;

  MultiBookingSetVariantVM({
    this.variantId,
    this.moq,
    this.totalQuantity,
    this.trackQuantity,
    this.continueSellingWhenOutOfStock,
    this.preferenceVariant,
    this.variantImage,
    this.price,
  });

  MultiBookingSetVariantVM.fromJson(dynamic json) {
    variantId = json.variantId;
    moq = json.moq;
    totalQuantity = json.totalQuantity;
    trackQuantity = json.trackQuantity;
    continueSellingWhenOutOfStock = json.continueSellingWhenOutOfStock;
    preferenceVariant = json.preferenceVariant != null
        ? VariantPreferenceVariantVM.fromJson(json.preferenceVariant)
        : null;
    variantImage = json.variantImage != null
        ? MultiBookingImageVM.fromJson(json.variantImage)
        : null;
    price = json.price != null ? SetVariantPrice.fromJson(json.price) : null;
  }

  Map<String, dynamic> toJson() => {
        'variantId': variantId,
        'moq': moq,
        'totalQuantity': totalQuantity,
        'trackQuantity': trackQuantity,
        'continueSellingWhenOutOfStock': continueSellingWhenOutOfStock,
        'preferenceVariant': preferenceVariant?.toJson(),
        'variantImage': variantImage?.toJson(),
        'price': price?.toJson(),
      };
}

class SetVariantPrice {
  String? sellingPrice;
  String? mrp;
  SetVariantPrice({this.sellingPrice, this.mrp});
  SetVariantPrice.fromJson(dynamic json) {
    sellingPrice = json.sellingPrice;
    mrp = json.mrp;
  }
  Map<String, dynamic> toJson() => {
        'sellingPrice': sellingPrice,
        'mrp': mrp,
      };
}
