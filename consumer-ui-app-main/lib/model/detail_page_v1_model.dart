// ignore_for_file: unnecessary_question_mark, unnecessary_null_comparison

import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/model/collection_model.dart';

ProductDetailPage productDetailFromVson(dynamic str) =>
    (ProductDetailPage.fromJson(str.toJson()));

// ProductCollectionVM productCollectionVMFromJson(dynamic str) =>
// (ProductCollectionVM.fromJson(str.toJson()));

class ProductDetailPage {
  late final String? sId;
  late final bool? isMultiple;
  late final String? imageId;
  late final String? productId;
  late final String? name;
  late final String? description;
  // late final dynamic? details;
  late final String? skuIds;
  late final List<PackVariant>? packVariant;
  late final int? moq;
  late final String? type;
  late final Price? price;
  late final List<Images>? images;
  late final String? sTypename;
  late final String? currencySymbol;
  late final bool? isCustomizable;
  late int? quantity;
  late final PreferenceVariant? preferenceVariant;
  late final num? offer;
  late final bool? isAssorted;
  late final bool? showPrice;
  late final bool? showPriceRange;
  late final bool? isWishlist;
  late final bool? showWishlist;
  late final List? wishlistCollection;
  late final PackQuantity? packQuantity;
  late final SetQuantity? setQuantity;
  late final List<Variants>? variants;
  late final List<ProductVariantsVM>? productVariant;
  late final List<RelatedProducts> relatedProducts;
  late final bool? showDownloadCatalog;
  late final String? downloadCatalogForm;
  late final String? downloadCatalogButtonName;
  late final String? catalogUrl;
  // late final CatalogFileVM? productCatalog;
  late final List<CatalogFileVM> productCatalog;

  // newwwwwwwww

  late final String? brandName;
  late final String? units;
  late final bool? showUnits;
  late final bool? showVariantPrice;
  late final bool? showVariantQuantity;
  late final bool? showVariantInList;
  late final bool? showAddToCart;
  late final bool? showPriceAfterLogin;
  late final String? priceDisplayType;
  late final String? discountDisplayType;
  late final List<MetaField>? metafields;

  ProductDetailPage({
    required this.sId,
    required this.isMultiple,
    // required this.categoryIds,
    required this.imageId,
    required this.productId,
    required this.name,
    required this.description,
    required this.packVariant,
    required this.moq,
    required this.type,
    required this.price,
    required this.productVariant,
    required this.images,
    required this.currencySymbol,
    required this.sTypename,
    required this.isCustomizable,
    required this.preferenceVariant,
    required this.quantity,
    required this.offer,
    required this.isAssorted,
    required this.showPrice,
    required this.showPriceRange,
    required this.isWishlist,
    required this.wishlistCollection,
    required this.showDownloadCatalog,
    required this.downloadCatalogForm,
    required this.downloadCatalogButtonName,
    required this.catalogUrl,
    required this.productCatalog,
    required this.showWishlist,
    required this.packQuantity,
    required this.setQuantity,
    required this.variants,
    required this.relatedProducts,

    // newwwwwwwwwwwwwwwwwwwwwwwwwwwwwww

    required this.brandName,
    required this.units,
    required this.showUnits,
    required this.showVariantPrice,
    required this.showVariantQuantity,
    required this.showVariantInList,
    required this.showAddToCart,
    required this.showPriceAfterLogin,
    required this.priceDisplayType,
    required this.discountDisplayType,
    required this.metafields,
  });

  ProductDetailPage.fromJson(Map<String, dynamic> json) {
    sId = json['sId'];
    isMultiple = json['isMultiple'];
    imageId = json['_id'];
    productId = json['_id'];
    name = json['name'];
    description = json['description'];
    showWishlist = json['showWishlist'];
    moq = json['moq'];
    isCustomizable = json["isCustomizable"];
    type = json['type'];
    currencySymbol = json['currencySymbol'];
    isAssorted = json['isAssorted'];
    showPrice = json['showPrice'];
    showPriceRange = json["showPriceRange"];
    isWishlist = json['isWishlist'];
    wishlistCollection = json['wishlistCollection'];
    quantity = json['moq'] != null ? json['moq'] : 1;
    preferenceVariant = json['preferenceVariant'] != null
        ? new PreferenceVariant.fromJson(json['preferenceVariant'])
        : null;
    packQuantity = json['packQuantity'] != null
        ? new PackQuantity.fromJson(json['packQuantity'])
        : null;
    if (json['packVariant'] != null) {
      packVariant = <PackVariant>[];
      json['packVariant'].forEach((v) {
        packVariant!.add(new PackVariant.fromJson(v));
      });
    } else {
      packVariant = [];
    }
    productVariant = <ProductVariantsVM>[];
    if (json['productVariant'] != null) {
      json['productVariant'].forEach((v) {
        productVariant!.add(new ProductVariantsVM.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    } else {
      variants = [];
    }
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    setQuantity = json['setQuantity'] != null
        ? new SetQuantity.fromJson(json['setQuantity'])
        : null;
    sTypename = json['__typename'];
    offer = json['offer'];
    // productCatalog = json['productCatalog'] != null
    //     ? new CatalogFileVM.fromJson(json['productCatalog'])
    //     : null;
    if (json['productCatalog'] != null) {
      productCatalog = <CatalogFileVM>[];
      json['productCatalog'].forEach((v) {
        productCatalog.add(new CatalogFileVM.fromJson(v));
      });
    } else {
      productCatalog = [];
    }
    showDownloadCatalog = json['showDownloadCatalog'];
    downloadCatalogForm = json['downloadCatalogForm'];
    downloadCatalogButtonName = json['downloadCatalogButtonName'];
    catalogUrl = json['catalogUrl'];
    if (json['relatedProducts'] != null) {
      relatedProducts = <RelatedProducts>[];
      json['relatedProducts'].forEach((v) {
        relatedProducts.add(new RelatedProducts.fromJson(v));
      });
    } else {
      relatedProducts = [];
    }

    // newwwwwwwwwwwwwwwwwwwwwwwwwwwwwww

    brandName = json['brandName'];
    units = json['units'];
    showUnits = json['showUnits'];
    showVariantPrice = json['showVariantPrice'];
    showVariantQuantity = json['showVariantQuantity'];
    showVariantInList = json['showVariantInList'];
    showAddToCart = json['showAddToCart'];
    showPriceAfterLogin = json['showPriceAfterLogin'];
    priceDisplayType = json['priceDisplayType'];
    discountDisplayType = json['discountDisplayType'];

    metafields = json['metafields'] != null
        ? (json['metafields'] as List)
            .map((e) => MetaField.fromJson(e))
            .toList()
        : [];
  }

  get variantImage => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sId'] = this.sId;
    data['isMultiple'] = this.isMultiple;
    data['imageId'] = this.imageId;
    data['productId'] = this.productId;
    data['isAssorted'] = this.isAssorted;
    data['showPrice'] = this.showPrice;
    data['currencySymbol'] = this.currencySymbol;
    data['showWishlist'] = this.showWishlist;
    data['showPriceRange'] = this.showPriceRange;
    data['isWishlist'] = this.isWishlist;
    data['wishlistCollection'] = this.wishlistCollection;
    data['name'] = this.name;
    data['description'] = this.description;
    data['moq'] = this.moq;
    data["isCustomizable"] = this.isCustomizable;
    data['type'] = this.type;
    data['quantity'] = this.quantity;
    // if (this.productCatalog != null) {
    //   data['productCatalog'] = this.productCatalog!.toJson();
    // }
    data['productCatalog'] =
        this.productCatalog.map((v) => v.toJson()).toList();
    data['showDownloadCatalog'] = this.showDownloadCatalog;
    data['downloadCatalogForm'] = this.downloadCatalogForm;
    data['downloadCatalogButtonName'] = this.downloadCatalogButtonName;
    data['catalogUrl'] = this.catalogUrl;
    if (this.packVariant != null) {
      data['packVariant'] = this.packVariant!.map((v) => v.toJson()).toList();
    }
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.packQuantity != null) {
      data['packQuantity'] = this.packQuantity!.toJson();
    }
    if (this.preferenceVariant != null) {
      data['preferenceVariant'] = this.preferenceVariant!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.setQuantity != null) {
      data['setQuantity'] = this.setQuantity!.toJson();
    }
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    if (this.productVariant != null) {
      data['productVariant'] =
          this.productVariant!.map((v) => v.toJson()).toList();
    }
    if (this.relatedProducts != null) {
      data['relatedProducts'] =
          this.relatedProducts.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    data['offer'] = this.offer;

    // newwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
    data['brandName'] = this.brandName;
    data['units'] = this.units;
    data['showUnits'] = this.showUnits;
    data['showVariantPrice'] = this.showVariantPrice;
    data['showVariantQuantity'] = this.showVariantQuantity;
    data['showVariantInList'] = this.showVariantInList;
    data['showAddToCart'] = this.showAddToCart;
    data['showPriceAfterLogin'] = this.showPriceAfterLogin;
    data['priceDisplayType'] = this.priceDisplayType;
    data['discountDisplayType'] = this.discountDisplayType;
    data['metafields'] = this.metafields?.map((e) => e.toJson()).toList();

    return data;
  }
}

class MetaField {
  final String? customDataId;
  final String? definition;
  final String? namespace;
  final String? key;
  final String? customDatatype;
  final String? customDataValueType;
  final dynamic reference; // could be Map
  final dynamic references; // could be Map
  final String? id;

  MetaField({
    this.customDataId,
    this.definition,
    this.namespace,
    this.key,
    this.customDatatype,
    this.customDataValueType,
    this.reference,
    this.references,
    this.id,
  });

  factory MetaField.fromJson(Map<String, dynamic> json) => MetaField(
        customDataId: json['customDataId'],
        definition: json['definition'],
        namespace: json['namespace'],
        key: json['key'],
        customDatatype: json['customDatatype'],
        customDataValueType: json['customDataValueType'],
        reference: json['reference'],
        references: json['references'],
        id: json['_id'],
      );

  Map<String, dynamic> toJson() => {
        'customDataId': customDataId,
        'definition': definition,
        'namespace': namespace,
        'key': key,
        'customDatatype': customDatatype,
        'customDataValueType': customDataValueType,
        'reference': reference,
        'references': references,
        '_id': id,
      };
}

class Price {
  late final String? currencySymbol;
  late final num? sellingPrice;
  late final num? mrp;
  late final num? discount;

  Price({
    required this.sellingPrice,
    required this.currencySymbol,
    required this.mrp,
    required this.discount,
  });

  Price.fromJson(Map<String, dynamic> json) {
    // print("data Price---->>12345 $json");
    sellingPrice = json['sellingPrice'] != null
        ? parseToDouble(json['sellingPrice'].toString())
        : 0;
    mrp = json['mrp'] != null ? parseToDouble(json['mrp'].toString()) : 0;
    discount = json['discount'] != null
        ? parseToDouble(json['discount'].toString())
        : 0;
    currencySymbol = json['currencySymbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellingPrice'] = this.sellingPrice;
    data['mrp'] = this.mrp;
    data['currencySymbol'] = this.currencySymbol;
    data['discount'] = this.discount;
    return data;
  }
}

class Variants {
  late final VariantImage? variantImage;
  late final List<VariantAttributesVM>? attribute;
  late final String? variantId;
  late final int? moq;
  late final int? totalQuantity;
  late final String? attributeFieldValueId;
  late final bool? continueSellingWhenOutOfStock;
  late final bool? trackQuantity;
  late final PreferenceVariantChild? preferenceVariant;
  late final Price? price;

  Variants(
      {required this.variantId,
      required this.moq,
      required this.attribute,
      required this.totalQuantity,
      required this.attributeFieldValueId,
      required this.variantImage,
      required this.preferenceVariant,
      required this.price,
      required this.continueSellingWhenOutOfStock,
      required this.trackQuantity});

  Variants.fromJson(Map<String, dynamic> json) {
    // print("json PackVariant--->>> $json");
    variantId = json['variantId'];
    moq = json['moq'];
    totalQuantity = json['totalQuantity'];
    attributeFieldValueId = json['attributeFieldValueId'];
    continueSellingWhenOutOfStock = json['continueSellingWhenOutOfStock'];
    trackQuantity = json['trackQuantity'];
    variantImage = json['variantImage'] != null
        ? new VariantImage.fromJson(json['variantImage'])
        : null;
    attribute = <VariantAttributesVM>[];
    if (json['attribute'] != null) {
      json['attribute'].forEach((v) {
        attribute!.add(new VariantAttributesVM.fromJson(v));
      });
    }
    preferenceVariant = json['preferenceVariant'] != null
        ? new PreferenceVariantChild.fromJson(json['preferenceVariant'])
        : null;
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variantId'] = this.variantId;
    data['moq'] = this.moq;
    data['attributeFieldValueId'] = this.attributeFieldValueId;
    data['totalQuantity'] = this.totalQuantity;
    data['continueSellingWhenOutOfStock'] = this.continueSellingWhenOutOfStock;
    data['trackQuantity'] = this.trackQuantity;
    if (this.variantImage != null) {
      data['variantImage'] = this.variantImage!.toJson();
    }
    if (this.preferenceVariant != null) {
      data['preferenceVariant'] = this.preferenceVariant!.toJson();
    }
    if (this.attribute != null) {
      data['attribute'] = this.attribute!.map((v) => v.toJson()).toList();
    }
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    return data;
  }
}

class PreferenceVariantChild {
  late final String? attributeFieldId;
  late final String? attributeFieldValueId;
  late final String? attributeFieldValue;

  PreferenceVariantChild({
    required this.attributeFieldId,
    required this.attributeFieldValueId,
    required this.attributeFieldValue,
  });

  PreferenceVariantChild.fromJson(Map<String, dynamic> json) {
    // print("json1a preferenceVariant--->> $json");
    attributeFieldId = json['attributeFieldId'];
    attributeFieldValueId = json['attributeFieldValueId'];
    attributeFieldValue = json['attributeFieldValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeFieldId'] = this.attributeFieldId;
    data['attributeFieldValueId'] = this.attributeFieldValueId;
    data['attributeFieldValue'] = this.attributeFieldValue;
    return data;
  }

  firstWhere(bool Function(dynamic da) param0) {}
}

class PackQuantity {
  late final int? totalQuantity;
  late final String? variantType;
  late final List<SetQuantities>? setQuantities;

  PackQuantity({
    required this.totalQuantity,
    required this.variantType,
    required this.setQuantities,
  });

  PackQuantity.fromJson(Map<String, dynamic> json) {
    // print("data PackQuantity---->>12345 $json");
    totalQuantity = json['totalQuantity'];
    variantType = json['variantType'];
    // setQuantities = json['setQuantities'];
    if (json['setQuantities'] != null) {
      setQuantities = <SetQuantities>[];
      json['setQuantities'].forEach((v) {
        setQuantities!.add(new SetQuantities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalQuantity'] = this.totalQuantity;
    data['variantType'] = this.variantType;
    if (this.setQuantities != null) {
      data['setQuantities'] =
          this.setQuantities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SetQuantity {
  late final int? totalQuantity;
  late final String? variantType;
  late final List<VariantQuantites>? variantQuantites;

  SetQuantity({
    required this.totalQuantity,
    required this.variantType,
    required this.variantQuantites,
  });

  SetQuantity.fromJson(Map<String, dynamic> json) {
    // print("data SetQuantity---->>12345 $json");
    totalQuantity = json['totalQuantity'];
    variantType = json['variantType'];
    if (json['variantQuantites'] != null) {
      variantQuantites = <VariantQuantites>[];
      json['variantQuantites'].forEach((v) {
        variantQuantites!.add(new VariantQuantites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalQuantity'] = this.totalQuantity;
    data['variantType'] = this.variantType;
    if (this.variantQuantites != null) {
      data['variantQuantites'] =
          this.variantQuantites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SetQuantities {
  late final String? attributeFieldValueId;
  late final String? fieldValue;
  late final List<VariantQuantites>? variantQuantites;

  SetQuantities({
    required this.attributeFieldValueId,
    required this.fieldValue,
    required this.variantQuantites,
  });

  SetQuantities.fromJson(Map<String, dynamic> json) {
    // print("json PackVariant--->>> $json");
    attributeFieldValueId = json['attributeFieldValueId'];
    fieldValue = json['fieldValue'];
    if (json['variantQuantites'] != null) {
      variantQuantites = <VariantQuantites>[];
      json['variantQuantites'].forEach((v) {
        variantQuantites!.add(new VariantQuantites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeFieldValueId'] = this.attributeFieldValueId;
    data['fieldValue'] = this.fieldValue;
    if (this.variantQuantites != null) {
      data['variantQuantites'] =
          this.variantQuantites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VariantQuantites {
  late final String? attributeFieldValue;
  late final int? moq;

  VariantQuantites({
    required this.attributeFieldValue,
    required this.moq,
  });

  VariantQuantites.fromJson(Map<String, dynamic> json) {
    // print("json VariantQuantites--->>> $json");
    attributeFieldValue = json['attributeFieldValue'];
    moq = json['moq'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeFieldValue'] = this.attributeFieldValue;
    data['moq'] = this.moq;

    return data;
  }
}

class PreferenceVariant {
  late final String? attributeFieldName;
  late final String? attributeFieldId;
  late final String? attributeLabelName;
  late final String? attributeFieldSetting;
  late final String? type;
  late final String? sTypename;
  // late final List<FieldValue>? fieldValue;

  PreferenceVariant({
    required this.attributeFieldId,
    required this.attributeFieldName,
    required this.attributeLabelName,
    required this.attributeFieldSetting,
    required this.type,
    required this.sTypename,
    // required this.fieldValue
  });

  PreferenceVariant.fromJson(Map<String, dynamic> json) {
    // print("json1a preferenceVariant--->> $json");
    attributeFieldId = json['attributeFieldId'];
    attributeFieldName = json['attributeFieldName'];
    attributeLabelName = json['attributeLabelName'];
    attributeFieldSetting = json['attributeFieldSetting'];
    type = json['type'];
    sTypename = json['__typename'];
    // if (json['fieldValue'] != null) {
    //   fieldValue = <FieldValue>[];
    //   json['fieldValue'].forEach((v) {
    //     fieldValue!.add(new FieldValue.fromJson(v));
    //   });
    // } else {
    //   fieldValue = [];
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeFieldId'] = this.attributeFieldId;
    data['attributeFieldName'] = this.attributeFieldName;
    data['attributeLabelName'] = this.attributeLabelName;
    data['attributeFieldSetting'] = this.attributeFieldSetting;
    data['type'] = this.type;
    data['__typename'] = this.sTypename;
    // if (this.fieldValue != null) {
    //   data['fieldValue'] = this.fieldValue!.map((v) => v.toJson()).toList();
    // }
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
  late final String? imageId;
  late final int? sortOrder;
  late final String? sId;

  Images(
      {required this.imageName,
      required this.position,
      required this.attributeFieldId,
      required this.attributeFieldValueId,
      required this.sTypename,
      required this.imageId,
      required this.sortOrder,
      required this.sId,
      this.link});

  Images.fromJson(Map<String, dynamic> json) {
    // print("json PackVariant Images--->>> $json");
    imageId = json['imageId'];
    imageName = json['imageName'];
    position = json['position'];
    attributeFieldId = json['attributeFieldId'];
    attributeFieldValueId = json['attributeFieldValueId'];
    sTypename = json['__typename'];
    sortOrder = json['sortOrder'];
    link = json['link'] != null ? json['link'] : "";
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageId'] = this.imageId;
    data['imageName'] = this.imageName;
    data['position'] = this.position;
    data['attributeFieldId'] = this.attributeFieldId;
    data['attributeFieldValueId'] = this.attributeFieldValueId;
    data['sortOrder'] = this.sortOrder;
    data['__typename'] = this.sTypename;
    data['_id'] = this.sId;
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

class PackVariant {
  late final List<VariantOptions>? variantOptions;
  late final VariantImage? variantImage;
  late final String? sTypename;
  late final String? labelName;
  late final String? attributeFieldId;
  late final String? attributeFieldValueId;
  late final bool? isCustomizable;
  late final bool? isAssorted;
  late final int? setQuantity;
  late final String? fieldValue;
  late final String? colorCode;
  late final List<Images>? images;
  late final String? setId;
  late final List<MetaField>? metafields;

  PackVariant({
    required this.variantOptions,
    required this.sTypename,
    required this.isCustomizable,
    required this.isAssorted,
    required this.labelName,
    required this.setQuantity,
    required this.attributeFieldId,
    required this.attributeFieldValueId,
    required this.fieldValue,
    required this.colorCode,
    required this.variantImage,
    required this.images,
    required this.setId,
    required this.metafields,
  });

  PackVariant.fromJson(Map<String, dynamic> json) {
    // print("json PackVariant--->>>toJson ${json['setId']}");
    sTypename = json['__typename'];
    labelName = json['labelName'];
    attributeFieldId = json['attributeFieldValueId'];
    isCustomizable = json['isCustomizable'];
    setQuantity = json['setQuantity'];
    isAssorted = json['isAssorted'];
    attributeFieldValueId = json['attributeFieldValueId'];
    fieldValue = json['fieldValue'];
    colorCode = json['colorCode'];
    setId = json['setId'];
    variantImage = json['variantImage'] != null
        ? new VariantImage.fromJson(json['variantImage'])
        : null;
    if (json['variantOptions'] != null) {
      variantOptions = <VariantOptions>[];
      json['variantOptions'].forEach((v) {
        variantOptions!.add(new VariantOptions.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    metafields = json['metafields'] != null
        ? (json['metafields'] as List)
            .map((e) => MetaField.fromJson(e))
            .toList()
        : [];
  }

  get availableSize => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['labelName'] = this.labelName;
    data['attributeFieldValueId'] = this.attributeFieldValueId;
    data['attributeFieldId'] = this.attributeFieldId;
    data['fieldValue'] = this.fieldValue;
    data['setId'] = this.setId;
    data['setQuantity'] = this.setQuantity;
    data['isAssorted'] = this.isAssorted;
    data['isCustomizable'] = this.isCustomizable;
    data['colorCode'] = this.colorCode;
    if (this.variantOptions != null) {
      data['variantOptions'] =
          this.variantOptions!.map((v) => v.toJson()).toList();
    }
    if (this.variantImage != null) {
      data['variantImage'] = this.variantImage!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['metafields'] = this.metafields?.map((e) => e.toJson()).toList();
    return data;
  }
}

class VariantImage {
  late final String? imageId;
  late final String? imageName;

  VariantImage({
    required this.imageId,
    required this.imageName,
  });

  VariantImage.fromJson(Map<String, dynamic> json) {
    // print("json VariantImage--->>> $json");
    imageId = json['imageId'];
    imageName = json['imageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageId'] = this.imageId;
    data['imageName'] = this.imageName;
    return data;
  }
}

class VariantOptions {
  late final num? sellingPrice;
  late final String? variantId;
  late final String? attributeFieldValueId;
  late final String? attributeFieldValue;
  late final String? colorCode;
  late final String? attributeFieldSetting;
  late final int? totalQuantity;
  late final int? moq;
  late final bool? trackQuantity;
  late final bool? continueSellingWhenOutOfStock;

  VariantOptions(
      {required this.sellingPrice,
      required this.variantId,
      required this.moq,
      required this.attributeFieldValueId,
      required this.attributeFieldValue,
      required this.colorCode,
      required this.trackQuantity,
      required this.continueSellingWhenOutOfStock,
      required this.attributeFieldSetting,
      required this.totalQuantity});

  VariantOptions.fromJson(Map<String, dynamic> json) {
    // print("json VariantOptions--->>> $json");

    sellingPrice = json['sellingPrice'] != null
        ? parseToDouble(json['sellingPrice'].toString())
        : 0;
    variantId = json['variantId'];
    moq = json['moq'];
    attributeFieldValueId = json['attributeFieldValueId'];
    attributeFieldValue = json['attributeFieldValue'];
    colorCode = json['colorCode'];
    attributeFieldSetting = json['attributeFieldSetting'];
    totalQuantity = json['totalQuantity'];
    trackQuantity = json['trackQuantity'];
    continueSellingWhenOutOfStock = json['continueSellingWhenOutOfStock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellingPrice'] = this.sellingPrice;
    data['variantId'] = this.variantId;
    data['attributeFieldValueId'] = this.attributeFieldValueId;
    data['attributeFieldValue'] = this.attributeFieldValue;
    data['colorCode'] = this.colorCode;
    data['attributeFieldSetting'] = this.attributeFieldSetting;
    data['moq'] = this.moq;
    data['totalQuantity'] = this.totalQuantity;
    data['trackQuantity'] = this.trackQuantity;
    data['continueSellingWhenOutOfStock'] = this.continueSellingWhenOutOfStock;
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

class FieldValue {
  late final String? id;
  late final String? attributeFieldValueId;
  late final String? attributeFieldId;
  late final List? availableSize;
  late final List? price;
  late final List? qty;
  late final String? labelName;
  late final String? colorCode;
  late final bool? enable;
  late final dynamic? disabled;
  late final String? sTypename;

  FieldValue(
      {required this.id,
      required this.attributeFieldValueId,
      required this.attributeFieldId,
      required this.availableSize,
      required this.price,
      required this.qty,
      required this.labelName,
      required this.colorCode,
      required this.enable,
      required this.disabled,
      required this.sTypename});

  FieldValue.fromJson(Map<String, dynamic> json) {
    // print("json1a FieldValue--->>> $json");
    id = json['id'] ?? null;
    attributeFieldValueId = json['attributeFieldValueId'] ?? null;
    attributeFieldId = json['attributeFieldId'] ?? null;
    availableSize = json['availableSize'] ?? null;
    price = json["price"] ?? null;
    qty = json['qty'] ?? null;
    labelName = json['labelName'] ?? null;
    colorCode = json['colorCode'] ?? null;
    enable = json['enable'] ?? null;
    disabled = json['disabled'] ?? null;
    sTypename = json['__typename'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attributeFieldValueId'] = this.attributeFieldValueId;
    data['attributeFieldId'] = this.attributeFieldId;
    data['availableSize'] = this.availableSize;
    data["price"] = this.price;
    data['qty'] = this.qty;
    data['labelName'] = this.labelName;
    data['colorCode'] = this.colorCode;
    data['enable'] = this.enable;
    data['disabled'] = this.disabled;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class RelatedProducts {
  late final String? sId;
  late final String? productId;
  late final String? name;
  late final String? description;
  late final String? type;
  late final String? url;
  late final int? moq;
  late final bool? isOutofstock;
  late final bool? isMultiple;
  late final bool? showPrice;
  late final bool? showPriceRange;
  late final String? imageId;
  late final String? priceType;
  late final Price? price;
  late final bool? showWishlist;
  late final bool? isWishlist;
  late final List? wishlistCollection;
  late final CollectionProductImage? images;
  late final CollectionProductRibbonVM? ribbon;

//   late final List<CollectionProductImage>? images;
  late final String? sTypename;

  RelatedProducts({
    required this.sId,
    required this.productId,
    required this.name,
    required this.description,
    required this.type,
    required this.url,
    required this.moq,
    required this.isOutofstock,
    required this.isMultiple,
    required this.showPrice,
    required this.showPriceRange,
    required this.imageId,
    required this.priceType,
    required this.ribbon,
    required this.price,
    required this.images,
    required this.sTypename,
    required this.isWishlist,
    required this.showWishlist,
    required this.wishlistCollection,
  });

  RelatedProducts.fromJson(Map<String, dynamic> json) {
    // print("json data--->>123 $json");
    sId = json['_id'];
    productId = json['_id'];
    name = json['name'];
    description = json['description'];
    isWishlist = json['isWishlist'];
    wishlistCollection = json['wishlistCollection'];
    type = json['type'];
    url = json['url'];
    moq = json['moq'];
    isOutofstock = json['isOutofstock'] == true ? true : false;
    isMultiple = json['isMultiple'];
    showPrice = json["showPrice"];
    showPriceRange = json["showPriceRange"];
    imageId = json['imageId'];
    priceType = json['priceType'];
    showWishlist = json['showWishlist'];
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    images = json['images'] != null
        ? new CollectionProductImage.fromJson(json['images'])
        : null;
    ribbon = json['ribbon'] != null
        ? new CollectionProductRibbonVM.fromJson(json['ribbon'])
        : null;
    // if (json['images'] != null) {
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productId'] = this.productId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['url'] = this.url;
    data['moq'] = this.moq;
    data['isOutofstock'] = this.isOutofstock;
    data['isMultiple'] = this.isMultiple;
    data['showPrice'] = this.showPrice;
    data['showPriceRange'] = this.showPriceRange;
    data['imageId'] = this.imageId;
    data['priceType'] = this.priceType;
    data['isWishlist'] = this.isWishlist;
    data['showWishlist'] = this.showWishlist;
    data['wishlistCollection'] = this.wishlistCollection;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.ribbon != null) {
      data['ribbon'] = this.ribbon!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }

    data['__typename'] = this.sTypename;
    return data;
  }
}

class CollectionProductImage {
  late final String? imageName;
  late final int? position;
  late final String? sTypename;

  CollectionProductImage(
      {required this.position,
      required this.imageName,
      required this.sTypename});

  CollectionProductImage.fromJson(Map<String, dynamic> json) {
    // print("json data--->>1234 $json");
    position = json['position'];
    imageName = json['imageName'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['position'] = this.position;
    data['imageName'] = this.imageName;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ProductVariantsVM {
  late final List<ProductVariantOptionsVM>? variantOptions;
  late final String? attributeFieldId;
  late final String? attributeLabelName;
  late final String? attributeFieldSetting;

  ProductVariantsVM({
    required this.variantOptions,
    required this.attributeFieldId,
    required this.attributeLabelName,
    required this.attributeFieldSetting,
  });

  ProductVariantsVM.fromJson(Map<String, dynamic> json) {
    attributeFieldSetting = json['attributeFieldSetting'];
    attributeFieldId = json['attributeFieldId'];
    attributeLabelName = json['attributeLabelName'];
    variantOptions = <ProductVariantOptionsVM>[];
    if (json['variantOptions'] != null) {
      json['variantOptions'].forEach((v) {
        variantOptions!.add(new ProductVariantOptionsVM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeLabelName'] = this.attributeLabelName;
    data['attributeFieldSetting'] = this.attributeFieldSetting;
    data['attributeFieldId'] = this.attributeFieldId;
    if (this.variantOptions != null) {
      data['variantOptions'] =
          this.variantOptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductVariantOptionsVM {
  late final String? attributeFieldValueId;
  late final String? attributeFieldValue;
  late final String? image;

  ProductVariantOptionsVM({
    required this.attributeFieldValueId,
    required this.attributeFieldValue,
    required this.image,
  });

  ProductVariantOptionsVM.fromJson(Map<String, dynamic> json) {
    attributeFieldValueId = json['attributeFieldValueId'];
    attributeFieldValue = json['attributeFieldValue'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeFieldValueId'] = this.attributeFieldValueId;
    data['attributeFieldValue'] = this.attributeFieldValue;
    data['image'] = this.image;
    return data;
  }
}

class VariantAttributesVM {
  late final String? attributeFieldValueId;
  late final String? attributeFieldId;

  VariantAttributesVM({
    required this.attributeFieldValueId,
    required this.attributeFieldId,
  });

  VariantAttributesVM.fromJson(Map<String, dynamic> json) {
    attributeFieldValueId = json['attributeFieldValueId'];
    attributeFieldId = json['attributeFieldId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeFieldValueId'] = this.attributeFieldValueId;
    data['attributeFieldId'] = this.attributeFieldId;
    return data;
  }
}
