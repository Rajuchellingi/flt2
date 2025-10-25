// ignore_for_file: unnecessary_question_mark

import 'package:black_locust/config/configConstant.dart';

ProductDetailVM productDetailVMFromJson(dynamic str) =>
    (ProductDetailVM.fromJson(str.toJson()));

class ProductDetailVM {
  late final String? sId;
  late final String? handle;
  late final bool? isMultiple;
  late final List<CategoryIds>? categoryIds;
  late final String? imageId;
  late final String? productId;
  late final String? name;
  late final String? productType;
  late final String? vendor;
  late final String? description;
  late final String? bulletPoints;
  late final List<MetafieldVM>? metafields;
  late final dynamic? details;
  late final dynamic? packVariant;
  late final int? moq;
  late bool? isOutofstock;
  late final String? type;
  late final List<SkuData>? skuIds;
  late final List<ProductChildren>? children;
  late final Price? price;
  late final List<VariantTypes>? variantTypes;
  late final List<VariantTypesNew>? variantTypesNew;
  List<ImageVariant>? imageVariant;
  late final List<Images>? images;
  late final List<String>? tags;
  late final List<ProductCollectionsVM>? collections;
  late final List<MergeAttribute>? mergeAttribute;
  late final dynamic? filterAttribute;
  late final String? sTypename;
  late final String? priceType;
  late final bool? isCustomizable;
  late final String? skuId;
  late int? quantity;
  late final PreferenceVariant? preferenceVariant;

  ProductDetailVM(
      {required this.sId,
      required this.isMultiple,
      required this.categoryIds,
      required this.imageId,
      required this.productType,
      required this.productId,
      required this.name,
      required this.bulletPoints,
      required this.vendor,
      required this.description,
      required this.details,
      required this.packVariant,
      required this.moq,
      required this.isOutofstock,
      required this.type,
      required this.handle,
      required this.skuIds,
      required this.collections,
      required this.children,
      required this.price,
      required this.variantTypes,
      required this.variantTypesNew,
      required this.images,
      required this.metafields,
      required this.tags,
      required this.mergeAttribute,
      required this.filterAttribute,
      required this.sTypename,
      required this.priceType,
      required this.isCustomizable,
      required this.preferenceVariant,
      required this.imageVariant,
      required this.quantity,
      required this.skuId});

  ProductDetailVM.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isMultiple = json['isMultiple'];
    vendor = json['vendor'];
    handle = json['handle'];
    if (json['categoryIds'] != null) {
      categoryIds = <CategoryIds>[];
      json['categoryIds'].forEach((v) {
        categoryIds!.add(new CategoryIds.fromJson(v));
      });
    } else {
      categoryIds = [];
    }
    imageId = json['imageId'];
    productId = json['productId'];
    name = json['name'];
    productType = json['productType'];
    description = json['description'];
    bulletPoints = json['bulletPoints'];
    details = json['details'];
    packVariant = json['packVariant'];
    moq = json['moq'];
    skuId = json['skuId'];
    isCustomizable = json["isCustomizable"];
    isOutofstock = json['isOutofstock'];
    // isOutofstock = false;
    type = json['type'];
    quantity = 1;
    preferenceVariant = json['preferenceVariant'] != null
        ? new PreferenceVariant.fromJson(json['preferenceVariant'])
        : null;
    if (json['skuIds'] != null) {
      skuIds = <SkuData>[];
      json['skuIds'].forEach((v) {
        skuIds!.add(new SkuData.fromJson(v));
      });
    } else {
      skuIds = [];
    }
    if (json['metafields'] != null) {
      metafields = <MetafieldVM>[];
      json['metafields'].forEach((v) {
        metafields!.add(new MetafieldVM.fromJson(v));
      });
    } else {
      metafields = [];
    }
    if (json['children'] != null) {
      children = <ProductChildren>[];
      json['children'].forEach((v) {
        children!.add(new ProductChildren.fromJson(v));
      });
    } else {
      children = [];
    }
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    if (json['variantTypes'] != null) {
      variantTypes = <VariantTypes>[];
      json['variantTypes'].forEach((v) {
        variantTypes!.add(VariantTypes.fromJson(v));
      });
    } else {
      variantTypes = [];
    }
    if (json['variantTypes'] != null) {
      variantTypesNew = <VariantTypesNew>[];
      json['variantTypes'].forEach((v) {
        variantTypesNew!.add(VariantTypesNew.fromJson(v));
      });
    } else {
      variantTypesNew = [];
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    } else {
      images = [];
    }
    tags = List<String>.from(json['tags']);
    if (json['collections'] != null) {
      collections = <ProductCollectionsVM>[];
      json['collections'].forEach((v) {
        collections!.add(new ProductCollectionsVM.fromJson(v));
      });
    } else {
      collections = [];
    }
    if (json['imageVariant'] != null) {
      imageVariant = <ImageVariant>[];
      json['imageVariant'].forEach((v) {
        imageVariant!.add(new ImageVariant.fromJson(v));
      });
    } else {
      imageVariant = [];
    }
    if (json['mergeAttribute'] != null) {
      mergeAttribute = <MergeAttribute>[];
      json['mergeAttribute'].forEach((v) {
        mergeAttribute!.add(new MergeAttribute.fromJson(v));
      });
    } else {
      mergeAttribute = [];
    }
    filterAttribute = json['filterAttribute'];
    priceType = json['priceType'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['isMultiple'] = this.isMultiple;
    data['vendor'] = this.vendor;
    if (this.categoryIds != null) {
      data['categoryIds'] = this.categoryIds!.map((v) => v.toJson()).toList();
    }
    data['imageId'] = this.imageId;
    data['handle'] = this.handle;
    data['productId'] = this.productId;
    data['productType'] = this.productType;
    data['name'] = this.name;
    data['description'] = this.description;
    data['bulletPoints'] = this.bulletPoints;
    data['skuId'] = this.skuId;
    data['details'] = this.details;
    data['packVariant'] = this.packVariant;
    data['moq'] = this.moq;
    data['isOutofstock'] = this.isOutofstock;
    data["isCustomizable"] = this.isCustomizable;
    data['type'] = this.type;
    data['quantity'] = this.quantity;
    data['tags'] = List<dynamic>.from(this.tags!.map((x) => x));

    if (this.skuIds != null) {
      data['skuIds'] = this.skuIds!.map((v) => v.toJson()).toList();
    }
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.preferenceVariant != null) {
      data['preferenceVariant'] = this.preferenceVariant!.toJson();
    }
    if (this.variantTypes != null) {
      data['variantTypes'] = this.variantTypes!.map((v) => v.toJson()).toList();
    }
    if (this.variantTypesNew != null) {
      data['variantTypes'] =
          this.variantTypesNew!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.collections != null) {
      data['collections'] = this.collections!.map((v) => v.toJson()).toList();
    }
    if (this.imageVariant != null) {
      data['imageVariant'] = this.imageVariant!.map((v) => v.toJson()).toList();
    }
    if (this.metafields != null) {
      data['metafields'] = this.metafields!.map((v) => v.toJson()).toList();
    }
    if (this.mergeAttribute != null) {
      data['mergeAttribute'] =
          this.mergeAttribute!.map((v) => v.toJson()).toList();
    }
    data['filterAttribute'] = this.filterAttribute;
    data['__typename'] = this.sTypename;
    data['priceType'] = this.priceType;
    return data;
  }
}

class ProductCollectionsVM {
  late final String? id;
  late final String? handle;
  late final String? title;

  ProductCollectionsVM({
    required this.id,
    required this.handle,
    required this.title,
  });

  ProductCollectionsVM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    handle = json['handle'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['handle'] = this.handle;
    data['title'] = this.title;
    return data;
  }
}

class Price {
  late final num? sellingPrice;
  late final num? mrp;
  late final num? discount;
  late final num? minPrice;
  late final num? maxPrice;
  late final String? type;
  late final bool? isSamePrice;
  late final String? sTypename;

  Price(
      {required this.sellingPrice,
      required this.mrp,
      required this.discount,
      required this.minPrice,
      required this.maxPrice,
      required this.type,
      required this.isSamePrice,
      required this.sTypename});

  Price.fromJson(Map<String, dynamic> json) {
    sellingPrice = json['sellingPrice'] != null
        ? parseToDouble(json['sellingPrice'].toString())
        : 0;
    mrp = json['mrp'] != null ? parseToDouble(json['mrp'].toString()) : 0;
    discount = json['discount'] != null
        ? parseToDouble(json['discount'].toString())
        : 0;
    minPrice = json['minPrice'] != null
        ? parseToDouble(json['minPrice'].toString())
        : 0;
    maxPrice = json['maxPrice'] != null
        ? parseToDouble(json['maxPrice'].toString())
        : 0;
    type = json['type'];
    isSamePrice = json['isSamePrice'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellingPrice'] = this.sellingPrice;
    data['mrp'] = this.mrp;
    data['discount'] = this.discount;
    data['minPrice'] = this.minPrice;
    data['maxPrice'] = this.maxPrice;
    data['type'] = this.type;
    data['isSamePrice'] = this.isSamePrice;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class PreferenceVariant {
  late final String? attributeFieldId;
  late final String? type;
  late final String? sTypename;
  late final List<FieldValue>? fieldValue;

  PreferenceVariant(
      {required this.attributeFieldId,
      required this.type,
      required this.sTypename,
      required this.fieldValue});

  PreferenceVariant.fromJson(Map<String, dynamic> json) {
    // print("varient---1 $json");
    attributeFieldId = json['attributeFieldId'];
    type = json['type'];
    sTypename = json['__typename'];
    if (json['fieldValue'] != null) {
      fieldValue = <FieldValue>[];
      json['fieldValue'].forEach((v) {
        fieldValue!.add(new FieldValue.fromJson(v));
      });
    } else {
      fieldValue = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeFieldId'] = this.attributeFieldId;
    data['type'] = this.type;
    data['__typename'] = this.sTypename;
    if (this.fieldValue != null) {
      data['fieldValue'] = this.fieldValue!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageVariant {
  late final String? attributeFieldId;
  late final String? type;
  late final String? sTypename;
  late final List<ImageVariantFieldValue>? fieldValue;

  ImageVariant(
      {required this.attributeFieldId,
      required this.type,
      required this.sTypename,
      required this.fieldValue});

  ImageVariant.fromJson(Map<String, dynamic> json) {
    attributeFieldId = json['attributeFieldId'];
    type = json['type'];
    sTypename = json['__typename'];
    if (json['fieldValue'] != null) {
      fieldValue = <ImageVariantFieldValue>[];
      json['fieldValue'].forEach((v) {
        fieldValue!.add(new ImageVariantFieldValue.fromJson(v));
      });
    } else {
      fieldValue = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeFieldId'] = this.attributeFieldId;
    data['type'] = this.type;
    data['__typename'] = this.sTypename;
    if (this.fieldValue != null) {
      data['fieldValue'] = this.fieldValue!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageVariantFieldValue {
  late final String? id;
  late final String? attributeFieldValueId;
  late final String? attributeFieldId;
  late final String? labelName;
  late final String? colorCode;
  late final bool? enable;
  late final bool? disabled;
  late final String? imageName;
  late final String? sTypename;

  ImageVariantFieldValue(
      {required this.id,
      required this.attributeFieldValueId,
      required this.attributeFieldId,
      required this.labelName,
      required this.colorCode,
      required this.enable,
      required this.disabled,
      required this.imageName,
      required this.sTypename});

  ImageVariantFieldValue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributeFieldValueId = json['attributeFieldValueId'];
    attributeFieldId = json['attributeFieldId'];
    labelName = json['labelName'];
    colorCode = json['colorCode'];
    enable = json['enable'];
    disabled = json['disabled'];
    imageName = json['imageName'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attributeFieldValueId'] = this.attributeFieldValueId;
    data['attributeFieldId'] = this.attributeFieldId;
    data['labelName'] = this.labelName;
    data['colorCode'] = this.colorCode;
    data['enable'] = this.enable;
    data['disabled'] = this.disabled;
    data['imageName'] = this.imageName;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Images {
  late final String? imageName;
  late final int? position;
  late final String? sTypename;
  late final String? attributeFieldId;
  late final String? attributeFieldValueId;
  late final String? link;

  Images(
      {required this.imageName,
      required this.position,
      required this.attributeFieldId,
      required this.attributeFieldValueId,
      required this.sTypename,
      this.link});

  Images.fromJson(Map<String, dynamic> json) {
    imageName = json['imageName'];
    position = json['position'];
    attributeFieldId = json['attributeFieldId'];
    attributeFieldValueId = json['attributeFieldValueId'];
    sTypename = json['__typename'];
    link = json['link'] != null ? json['link'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageName'] = this.imageName;
    data['position'] = this.position;
    data['attributeFieldId'] = this.attributeFieldId;
    data['attributeFieldValueId'] = this.attributeFieldValueId;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ProductChildren {
  late final String? productId;
  late final int? quantity;
  late final List<SkuAttribute>? attribute;
  late final PreferenceVariant? preferenceVariant;
  late final ProductChildrenPrice? price;
  late final List<SkuData>? skuIds;
  late final ProductTag? tag;
  late final int? totalQty;
  late final String? sTypeName;

  ProductChildren(
      {required this.attribute,
      required this.preferenceVariant,
      required this.price,
      required this.productId,
      required this.quantity,
      required this.sTypeName,
      required this.skuIds,
      required this.totalQty,
      required this.tag});

  ProductChildren.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
    sTypeName = json['__typename'];
    totalQty = 0;
    price = json['price'] != null
        ? new ProductChildrenPrice.fromJson(json['price'])
        : null;
    tag = json['tag'] != null ? new ProductTag.fromJson(json['tag']) : null;
    if (json['attribute'] != null) {
      attribute = <SkuAttribute>[];
      json['attribute'].forEach((v) {
        attribute!.add(new SkuAttribute.fromJson(v));
      });
    }
    preferenceVariant = json['preferenceVariant'] != null
        ? new PreferenceVariant.fromJson(json['preferenceVariant'])
        : null;
    if (json['skuIds'] != null) {
      skuIds = <SkuData>[];
      json['skuIds'].forEach((v) {
        skuIds!.add(new SkuData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["productId"] = this.productId;
    data["quantity"] = this.quantity;
    data["__typename"] = this.sTypeName;
    data["totalQty"] = this.totalQty;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.tag != null) {
      data['tag'] = this.tag!.toJson();
    }
    if (this.attribute != null) {
      data['attribute'] = this.attribute!.map((v) => v.toJson()).toList();
    }
    if (this.skuIds != null) {
      data['skuIds'] = this.skuIds!.map((v) => v.toJson()).toList();
    }
    if (this.preferenceVariant != null) {
      data['preferenceVariant'] = this.preferenceVariant!.toJson();
    }
    return data;
  }
}

class ProductChildrenPrice {
  late final num? sellingPrice;
  late final num? mrp;
  late final String? sTypename;

  ProductChildrenPrice(
      {required this.sellingPrice, required this.mrp, required this.sTypename});

  ProductChildrenPrice.fromJson(Map<String, dynamic> json) {
    sellingPrice = json['sellingPrice'] != null
        ? parseToDouble(json['sellingPrice'].toString())
        : 0;
    mrp = json['mrp'] != null ? parseToDouble(json['mrp'].toString()) : 0;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellingPrice'] = this.sellingPrice;
    data['mrp'] = this.mrp;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ProductTag {
  late final String? name;
  late final String? sTypename;

  ProductTag({
    required this.name,
    required this.sTypename,
  });

  ProductTag.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SkuData {
  late final String? skuId;
  late final int? originalQty;
  late final int? quantity;
  late final int? skuMoq;
  late final bool? availableForSale;
  late int? totalQty;
  late final SkuPrice? price;
  late final List<SkuAttribute>? attribute;
  late final String? sTypename;
  late final String? title;

  SkuData({
    required this.skuId,
    required this.originalQty,
    required this.quantity,
    required this.skuMoq,
    required this.totalQty,
    required this.availableForSale,
    required this.price,
    required this.attribute,
    required this.sTypename,
    required this.title,
  });

  SkuData.fromJson(Map<String, dynamic> json) {
    // print("SkuData json ${json}");
    skuId = json['skuId'];
    title = json['title'] ?? null;
    originalQty = json['originalQty'];
    quantity = json['quantity'];
    skuMoq = json['skuMoq'];
    availableForSale = json['availableForSale'];
    totalQty = 0;
    sTypename = json['__typename'];
    price = json['price'] != null ? new SkuPrice.fromJson(json['price']) : null;
    if (json['attribute'] != null) {
      attribute = <SkuAttribute>[];
      json['attribute'].forEach((v) {
        attribute!.add(new SkuAttribute.fromJson(v));
      });
    } else {
      attribute = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['skuId'] = this.skuId;
    data['title'] = this.title;
    data['originalQty'] = this.originalQty;
    data['quantity'] = this.quantity;
    data['availableForSale'] = this.availableForSale;
    data['__typename'] = this.sTypename;
    data['skuMoq'] = this.skuMoq;
    data['totalQty'] = this.totalQty;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.attribute != null) {
      data['attribute'] = this.attribute!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SkuPrice {
  late final num? sellingPrice;
  late final num? skuSellingPrice;
  late final num? mrp;
  late final num? skuMrp;
  late final String? sTypename;

  SkuPrice(
      {required this.sellingPrice,
      required this.mrp,
      required this.skuSellingPrice,
      required this.skuMrp,
      required this.sTypename});

  SkuPrice.fromJson(Map<String, dynamic> json) {
    sellingPrice = json['sellingPrice'] != null
        ? parseToDouble(json['sellingPrice'].toString())
        : 0;
    mrp = json['mrp'] != null ? parseToDouble(json['mrp'].toString()) : 0;
    skuSellingPrice = json['skuSellingPrice'] != null
        ? parseToDouble(json['skuSellingPrice'].toString())
        : 0;
    skuMrp =
        json['skuMrp'] != null ? parseToDouble(json['skuMrp'].toString()) : 0;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellingPrice'] = this.sellingPrice;
    data['mrp'] = this.mrp;
    data['skuSellingPrice'] = this.skuSellingPrice;
    data['skuMrp'] = this.skuMrp;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SkuAttribute {
  late final String? labelName;
  late final String? attributeFieldId;
  late final String? attributeFieldValueId;
  late final String? fieldValue;
  late final String? colorCode;
  late final String? sTypename;

  SkuAttribute(
      {required this.labelName,
      required this.attributeFieldId,
      required this.attributeFieldValueId,
      required this.fieldValue,
      required this.colorCode,
      required this.sTypename});

  SkuAttribute.fromJson(Map<String, dynamic> json) {
    labelName = json['labelName'];
    attributeFieldId = json['attributeFieldId'];
    attributeFieldValueId = json['attributeFieldValueId'];
    fieldValue = json['fieldValue'];
    colorCode = json['colorCode'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['labelName'] = this.labelName;
    data['attributeFieldId'] = this.attributeFieldId;
    data['attributeFieldValueId'] = this.attributeFieldValueId;
    data['fieldValue'] = this.fieldValue;
    data['colorCode'] = this.colorCode;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CategoryIds {
  late final String? categoryName;
  late final String? link;
  late final int? level;
  late final String? sTypename;

  CategoryIds(
      {required this.categoryName,
      required this.link,
      required this.level,
      required this.sTypename});

  CategoryIds.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    link = json['link'];
    level = json['level'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    data['link'] = this.link;
    data['level'] = this.level;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class PriceDetails {
  late final num? sellingPrice;
  late final num? minPrice;
  late final num? maxPrice;
  late final num? mrp;
  late final String? type;
  late final num? discount;
  late final List<PriceRange>? priceRange;
  late final dynamic? priceRangeAll;
  late final String? sTypename;

  PriceDetails(
      {required this.sellingPrice,
      required this.minPrice,
      required this.maxPrice,
      required this.mrp,
      required this.type,
      required this.discount,
      required this.priceRange,
      required this.priceRangeAll,
      required this.sTypename});

  PriceDetails.fromJson(Map<String, dynamic> json) {
    sellingPrice = parseToDouble(json['sellingPrice'].toString());
    minPrice = parseToDouble(json['minPrice'].toString());
    maxPrice = parseToDouble(json['maxPrice'].toString());
    mrp = parseToDouble(json['mrp'].toString());
    type = json['type'];
    discount = parseToDouble(json['discount'].toString());
    if (json['priceRange'] != null) {
      priceRange = <PriceRange>[];
      json['priceRange'].forEach((v) {
        priceRange!.add(new PriceRange.fromJson(v));
      });
    }
    priceRangeAll = json['priceRangeAll'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellingPrice'] = this.sellingPrice;
    data['minPrice'] = this.minPrice;
    data['maxPrice'] = this.maxPrice;
    data['mrp'] = this.mrp;
    data['type'] = this.type;
    data['discount'] = this.discount;
    if (this.priceRange != null) {
      data['priceRange'] = this.priceRange!.map((v) => v.toJson()).toList();
    }
    data['priceRangeAll'] = this.priceRangeAll;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class PriceRange {
  late final String? id;
  late final int? minQty;
  late final int? maxQty;
  late final num? discount;
  late final num? sellingPrice;
  late final String? sTypename;

  PriceRange(
      {required this.id,
      required this.minQty,
      required this.maxQty,
      required this.discount,
      required this.sellingPrice,
      required this.sTypename});

  PriceRange.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    minQty = json['minQty'];
    maxQty = json['maxQty'];
    discount = parseToDouble(json['discount'].toString());
    sellingPrice = parseToDouble(json['sellingPrice'].toString());
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['minQty'] = this.minQty;
    data['maxQty'] = this.maxQty;
    data['discount'] = this.discount;
    data['sellingPrice'] = this.sellingPrice;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class VariantTypes {
  late final String? type;
  late final String? attributeFieldId;
  late List<FieldValue>? fieldValue;
  late final String? sTypename;

  VariantTypes(
      {required this.type,
      required this.attributeFieldId,
      required this.fieldValue,
      required this.sTypename});

  VariantTypes.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    attributeFieldId = json['attributeFieldId'];
    if (json['fieldValue'] != null) {
      fieldValue = <FieldValue>[];
      json['fieldValue'].forEach((v) {
        fieldValue!.add(new FieldValue.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['attributeFieldId'] = this.attributeFieldId;
    if (this.fieldValue != null) {
      data['fieldValue'] = this.fieldValue!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }

  // firstWhere(bool Function(dynamic da) param0,
  //     {required Null Function() orElse}) {}
}

class VariantTypesNew {
  late final String? type;
  late final String? attributeFieldId;
  late List<FieldValue>? fieldValue;
  late final String? sTypename;

  VariantTypesNew(
      {required this.type,
      required this.attributeFieldId,
      required this.fieldValue,
      required this.sTypename});

  VariantTypesNew.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    attributeFieldId = json['attributeFieldId'];
    if (json['fieldValue'] != null) {
      fieldValue = <FieldValue>[];
      json['fieldValue'].forEach((v) {
        fieldValue!.add(new FieldValue.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['attributeFieldId'] = this.attributeFieldId;
    if (this.fieldValue != null) {
      data['fieldValue'] = this.fieldValue!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }

  // firstWhere(bool Function(dynamic da) param0,
  //     {required Null Function() orElse}) {}
}

class FieldValue {
  late final String? id;
  late final String? attributeFieldValueId;
  late final String? attributeFieldId;
  late final String? labelName;
  late final String? colorCode;
  late final bool? enable;
  late final dynamic? disabled;
  late final String? sTypename;

  FieldValue(
      {required this.id,
      required this.attributeFieldValueId,
      required this.attributeFieldId,
      required this.labelName,
      required this.colorCode,
      required this.enable,
      required this.disabled,
      required this.sTypename});

  FieldValue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributeFieldValueId = json['attributeFieldValueId'];
    attributeFieldId = json['attributeFieldId'];
    labelName = json['labelName'];
    colorCode = json['colorCode'];
    enable = json['enable'];
    disabled = json['disabled'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attributeFieldValueId'] = this.attributeFieldValueId;
    data['attributeFieldId'] = this.attributeFieldId;
    data['labelName'] = this.labelName;
    data['colorCode'] = this.colorCode;
    data['enable'] = this.enable;
    data['disabled'] = this.disabled;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ImageDetails {
  late final String? imageName;
  late final int? position;
  late final String? sTypename;

  ImageDetails(
      {required this.imageName,
      required this.position,
      required this.sTypename});

  ImageDetails.fromJson(Map<String, dynamic> json) {
    imageName = json['imageName'];
    position = json['position'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageName'] = this.imageName;
    data['position'] = this.position;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class MergeAttribute {
  late final String? type;
  late final String? attributeFieldId;
  late final String? fieldValue;
  late final String? sTypename;

  MergeAttribute(
      {required this.type,
      required this.attributeFieldId,
      required this.fieldValue,
      required this.sTypename});

  MergeAttribute.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    attributeFieldId = json['attributeFieldId'];
    fieldValue = json['fieldValue'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['attributeFieldId'] = this.attributeFieldId;
    data['fieldValue'] = this.fieldValue;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class MetafieldVM {
  late final String? id;
  late final String? description;
  late final String? type;
  late final String? key;
  late final String? namespace;
  late final String? value;
  late final ReferencesVM? references;
  late final ReferenceVM? reference;

  MetafieldVM({
    required this.id,
    required this.description,
    required this.type,
    required this.key,
    required this.namespace,
    required this.value,
    required this.references,
    required this.reference,
  });

  MetafieldVM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    type = json['type'];
    key = json['key'];
    namespace = json['namespace'];
    value = json['value'];
    references = json['references'] != null
        ? ReferencesVM.fromJson(json['references'])
        : null;
    reference = json['reference'] != null
        ? ReferenceVM.fromJson(json['reference'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['type'] = type;
    data['key'] = key;
    data['namespace'] = namespace;
    data['value'] = value;
    if (references != null) {
      data['references'] = references!.toJson();
    }
    if (reference != null) {
      data['reference'] = reference!.toJson();
    }
    return data;
  }
}

class ReferencesVM {
  late final List<ReferenceNode> edges;

  ReferencesVM({required this.edges});

  ReferencesVM.fromJson(Map<String, dynamic> json) {
    edges = (json['edges'] as List)
        .map((edge) => ReferenceNode.fromJson(edge['node']))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'edges': edges.map((edge) => {'node': edge.toJson()}).toList(),
    };
  }
}

class ReferenceNode {
  late final String? sId;
  late final String? title;
  late final String? handle;
  late final String? mediaContentType;
  late final List<SourceVM>? sources;
  late final MetaImageDetailsVM? image;
  late final MetaImageDetailsVM? previewImage;
  late final String? sTypename;

  ReferenceNode({
    required this.sId,
    required this.title,
    required this.handle,
    required this.mediaContentType,
    this.sources,
    this.image,
    this.previewImage,
    this.sTypename,
  });

  ReferenceNode.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    mediaContentType = json['mediaContentType'];
    title = json['title'];
    handle = json['handle'];
    if (json['sources'] != null) {
      sources = (json['sources'] as List)
          .map((source) => SourceVM.fromJson(source))
          .toList();
    }
    image = json['image'] != null
        ? MetaImageDetailsVM.fromJson(json['image'])
        : null;
    previewImage = json['previewImage'] != null
        ? MetaImageDetailsVM.fromJson(json['previewImage'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = sId;
    data['mediaContentType'] = mediaContentType;
    data['title'] = title;
    data['handle'] = handle;
    if (sources != null) {
      data['sources'] = sources!.map((source) => source.toJson()).toList();
    }
    if (image != null) {
      data['image'] = image!.toJson();
    }
    if (previewImage != null) {
      data['previewImage'] = previewImage!.toJson();
    }
    data['__typename'] = sTypename;
    return data;
  }
}

class ReferenceVM {
  late final String id;
  late final String mediaContentType;
  late final MetaImageDetailsVM? image;
  late final MetaImageDetailsVM? previewImage;

  late final List<SourceVM>? sources;

  ReferenceVM({
    required this.id,
    required this.mediaContentType,
    this.sources,
    this.image,
    this.previewImage,
  });

  ReferenceVM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediaContentType = json['mediaContentType'];
    if (json['sources'] != null) {
      sources = (json['sources'] as List)
          .map((source) => SourceVM.fromJson(source))
          .toList();
    }
    image = json['image'] != null
        ? MetaImageDetailsVM.fromJson(json['image'])
        : null;
    previewImage = json['previewImage'] != null
        ? MetaImageDetailsVM.fromJson(json['previewImage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mediaContentType'] = mediaContentType;
    if (sources != null) {
      data['sources'] = sources!.map((source) => source.toJson()).toList();
    }
    if (image != null) {
      data['image'] = image!.toJson();
    }
    if (previewImage != null) {
      data['previewImage'] = previewImage!.toJson();
    }
    return data;
  }
}

class SourceVM {
  late final String format;
  late final String mimeType;
  late final String url;

  SourceVM({
    required this.format,
    required this.mimeType,
    required this.url,
  });

  SourceVM.fromJson(Map<String, dynamic> json) {
    format = json['format'];
    mimeType = json['mimeType'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'format': format,
      'mimeType': mimeType,
      'url': url,
    };
  }
}

class MetaImageDetailsVM {
  late final String id;
  late final String url;

  MetaImageDetailsVM({required this.id, required this.url});

  MetaImageDetailsVM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
    };
  }
}
