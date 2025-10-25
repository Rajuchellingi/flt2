// List<ProductCollectionListVM> searchProductVMFromJson(dynamic str) =>
//     (List<ProductCollectionListVM>.from(
//         str.map((x) => ProductCollectionListVM.fromJson(x.toJson()))));

// List<ProductCollectionListVM> searchProductVMFromJson(dynamic str) =>
//     (List<ProductCollectionListVM>.from(
//         str.map((x) => ProductCollectionListVM.fromJson(x.toJson()))));
import 'package:black_locust/config/configConstant.dart';

SearchProductsVM searchProductVMFromJson(dynamic str) =>
    (SearchProductsVM.fromJson(str.toJson()));

class SearchProductsVM {
  late final SearchPageInfoVM? pageInfo;
  late final List<ProductCollectionListVM> products;

  SearchProductsVM({
    required this.pageInfo,
    required this.products,
  });

  SearchProductsVM.fromJson(Map<String, dynamic> json) {
    pageInfo = json['pageInfo'] != null
        ? new SearchPageInfoVM.fromJson(json['pageInfo'])
        : null;
    if (json['products'] != null) {
      products = <ProductCollectionListVM>[];
      json['products'].forEach((v) {
        if (v != null) {
          products.add(ProductCollectionListVM.fromJson(v));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo!.toJson();
    }
    data['products'] = this.products.map((v) => v.toJson()).toList();
    return data;
  }
}

class ProductCollectionListVM {
  late final String? sId;
  late final String? productId;
  late final String? producturl;
  late final String? name;
  late final String? description;
  late final String? type;
  late final String? vendor;
  late final String? url;
  late final int? moq;
  late final bool? isOutofstock;
  late final bool? isMultiple;
  late final List<String>? wishlistCollection;
  late final String? imageId;
  late final String? priceType;
  late final CollectionProductRibbonVM? ribbon;
  late final CollectionProductPriceVM? price;
  late final List<ProductOptionsVM>? options;
  late final List<ProductVariantsVM>? variants;
  late final List<ProductMetafieldsVM>? metafields;
  late final List<CollectionProductImageVM>? images;
  late final List<ProductImagesVM>? productImages;
  late final String? sTypename;

  ProductCollectionListVM(
      {required this.sId,
      required this.productId,
      required this.producturl,
      required this.name,
      required this.description,
      required this.type,
      required this.url,
      required this.vendor,
      required this.moq,
      required this.isOutofstock,
      required this.isMultiple,
      required this.imageId,
      required this.metafields,
      required this.priceType,
      required this.variants,
      required this.options,
      required this.ribbon,
      required this.price,
      required this.wishlistCollection,
      required this.images,
      required this.sTypename});

  // ProductCollectionListVM.fromJson(Map<String, dynamic> json) {
  ProductCollectionListVM.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['productId'];
    producturl = json["url"];
    name = json['name'];
    description = json['description'];
    vendor = json['vendor'];
    type = json['type'];
    wishlistCollection = json['wishlistCollection'] != null
        ? List<String>.from(json['wishlistCollection'])
        : [];
    url = json['url'];
    moq = json['moq'];
    isOutofstock = json['isOutofstock'];
    isMultiple = json['isMultiple'];
    imageId = json['imageId'];
    priceType = json['priceType'];
    price = json['price'] != null
        ? new CollectionProductPriceVM.fromJson(json['price'])
        : null;
    ribbon = json['ribbon'] != null
        ? new CollectionProductRibbonVM.fromJson(json['ribbon'])
        : null;
    if (json['images'] != null) {
      images = <CollectionProductImageVM>[];
      json['images'].forEach((v) {
        images!.add(new CollectionProductImageVM.fromJson(v));
      });
    }
    if (json['options'] != null) {
      options = <ProductOptionsVM>[];
      json['options'].forEach((v) {
        options!.add(new ProductOptionsVM.fromJson(v));
      });
    }
    productImages = <ProductImagesVM>[];
    if (json['productImages'] != null) {
      json['productImages'].forEach((v) {
        productImages!.add(new ProductImagesVM.fromJson(v));
      });
    }
    metafields = <ProductMetafieldsVM>[];
    if (json['metafields'] != null) {
      json['metafields'].forEach((v) {
        metafields!.add(new ProductMetafieldsVM.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      variants = <ProductVariantsVM>[];
      json['variants'].forEach((v) {
        variants!.add(new ProductVariantsVM.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productId'] = this.productId;
    data['url'] = this.producturl;
    data['name'] = this.name;
    data['description'] = this.description;
    data['vendor'] = this.vendor;
    data['type'] = this.type;
    data['url'] = this.url;
    data['moq'] = this.moq;
    data['isOutofstock'] = this.isOutofstock;
    data['isMultiple'] = this.isMultiple;
    data['imageId'] = this.imageId;
    data['priceType'] = this.priceType;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.ribbon != null) {
      data['ribbon'] = this.ribbon!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.productImages != null) {
      data['productImages'] =
          this.productImages!.map((v) => v.toJson()).toList();
    }
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    if (this.metafields != null) {
      data['metafields'] = this.metafields!.map((v) => v.toJson()).toList();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ProductImagesVM {
  late final String? url;
  late final int? height;
  late final int? width;

  ProductImagesVM(
      {required this.url, required this.height, required this.width});
  ProductImagesVM.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    height = json['height'];
    width = json['width'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['height'] = this.height;
    data['width'] = this.width;
    return data;
  }
}

class ProductMetafieldsVM {
  late final String? type;
  late final String? value;
  late final String? key;
  late final String? namespace;

  ProductMetafieldsVM({
    required this.value,
    required this.type,
    required this.key,
    required this.namespace,
  });

  ProductMetafieldsVM.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
    key = json['key'];
    namespace = json['namespace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    data['key'] = this.key;
    data['namespace'] = this.namespace;
    return data;
  }
}

class ProductVariantsVM {
  late final String? sId;
  late final String? title;
  late final bool? availableForSale;
  late final String? sTypename;

  ProductVariantsVM({
    required this.title,
    required this.sId,
    required this.availableForSale,
    required this.sTypename,
  });

  ProductVariantsVM.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    title = json['title'];
    availableForSale = json['availableForSale'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['title'] = this.title;
    data['availableForSale'] = this.availableForSale;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ProductOptionsVM {
  late final String? sId;
  late final String? name;
  late final List<ProductOptionsValueVM> values;
  late final String? sTypename;

  ProductOptionsVM({
    required this.name,
    required this.sId,
    required this.values,
    required this.sTypename,
  });

  ProductOptionsVM.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    if (json['values'] != null) {
      values = <ProductOptionsValueVM>[];
      json['values'].forEach((v) {
        values.add(ProductOptionsValueVM.fromJson(v));
      });
    }
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['values'] = this.values.map((v) => v.toJson()).toList();
    data['__typename'] = this.sTypename;
    data['name'] = this.name;
    return data;
  }
}

class ProductOptionsValueVM {
  late final String? name;

  ProductOptionsValueVM({
    required this.name,
  });

  ProductOptionsValueVM.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class CollectionProductImageVM {
  late final String? imageName;
  late final int? position;
  late final String? sTypename;

  CollectionProductImageVM(
      {required this.position,
      required this.imageName,
      required this.sTypename});

  CollectionProductImageVM.fromJson(Map<String, dynamic> json) {
    position = json['position'] ?? null;
    imageName = json['imageName'] ?? null;
    sTypename = json['__typename'] ?? null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['position'] = this.position;
    data['imageName'] = this.imageName;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CollectionProductPriceVM {
  late final num? sellingPrice;
  late final String? currencySymbol;
  late final num? mrp;
  late final num? discount;
  late final num? minPrice;
  late final num? maxPrice;
  late final String? type;
  late final bool? isSamePrice;
  late final String? sTypename;

  CollectionProductPriceVM(
      {required this.sellingPrice,
      required this.mrp,
      required this.currencySymbol,
      required this.discount,
      required this.minPrice,
      required this.maxPrice,
      required this.type,
      required this.isSamePrice,
      required this.sTypename});

  CollectionProductPriceVM.fromJson(Map<String, dynamic> json) {
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
    currencySymbol = json['currencySymbol'];
    isSamePrice = json['isSamePrice'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellingPrice'] = this.sellingPrice;
    data['mrp'] = this.mrp;
    data['discount'] = this.discount;
    data['minPrice'] = this.minPrice;
    data['currencySymbol'] = this.currencySymbol;
    data['maxPrice'] = this.maxPrice;
    data['type'] = this.type;
    data['isSamePrice'] = this.isSamePrice;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CollectionProductRibbonVM {
  late final String? name;
  late final String? colorCode;

  CollectionProductRibbonVM({required this.name, required this.colorCode});
  CollectionProductRibbonVM.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    colorCode = json['colorCode'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['colorCode'] = this.colorCode;
    return data;
  }
}

// SearchCollectionAttributeVM searchAttributeVMMFromJson(dynamic str) =>
//     (SearchCollectionAttributeVM.fromJson(str));

SearchCollectionAttributeVM searchAttributeVMFromJson(dynamic str) =>
    (SearchCollectionAttributeVM.fromJson(str.toJson()));

// SearchCollectionAttributeVM searchAttributeVMFromJson(dynamic str) =>
//     (SearchCollectionAttributeVM.fromJson(str));

class SearchCollectionAttributeVM {
  late final List<AttributeListVM> attribute;
  late final String? sTypename;

  SearchCollectionAttributeVM(
      {required this.attribute, required this.sTypename});

  SearchCollectionAttributeVM.fromJson(Map<String, dynamic> json) {
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
  late final int? count;
  late final InputValue? input;

  AttributeFieldValueVM({
    required this.appletName,
    required this.attributeFieldValue,
    required this.attributeFieldValueId,
    required this.checked,
    required this.fieldValueEnable,
    required this.sortOrder,
    required this.sTypename,
    required this.count,
    required this.input,
  });

  AttributeFieldValueVM.fromJson(Map<String, dynamic> json) {
    appletName = json['appletName'];
    attributeFieldValue = json['attributeFieldValue'];
    attributeFieldValueId = json['attributeFieldValueId'];
    checked = json['checked'] != null ? json['checked'] : false;
    fieldValueEnable = json['fieldValueEnable'];
    sortOrder = json['sortOrder'];
    sTypename = json['__typename'];
    count = json['count'] ?? null;
    // var inputData = jsonDecode(json['input']);
    // // print("value json ${inputData}");
    // input = (json['input'] != null ? new InputValue.fromJson(inputData) : null);
    input =
        json['input'] != null ? new InputValue.fromJson(json['input']) : null;
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
    data['count'] = this.count;
    if (this.input != null) {
      data['input'] = this.input!.toJson();
    }
    return data;
  }
}

class SearchPageInfoVM {
  late final bool? hasNextPage;
  late final bool? hasPreviousPage;
  late String? endCursor;
  late final String? sTypename;

  SearchPageInfoVM(
      {required this.hasNextPage,
      required this.hasPreviousPage,
      required this.endCursor,
      required this.sTypename});

  SearchPageInfoVM.fromJson(Map<String, dynamic> json) {
    hasNextPage = json['hasNextPage'] ?? null;
    hasPreviousPage = json['hasPreviousPage'] ?? null;
    endCursor = json['endCursor'] ?? null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasNextPage'] = this.hasNextPage;
    data['hasPreviousPage'] = this.hasPreviousPage;
    data['endCursor'] = this.endCursor;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class InputValue {
  late final num? minPrice;
  late final num? maxPrice;
  late final bool? available;
  late final String? sTypename;

  InputValue({
    required this.minPrice,
    required this.maxPrice,
    required this.available,
    required this.sTypename,
  });
  InputValue.fromJson(Map<String, dynamic> json) {
    available = json['available'] ?? null;
    minPrice = json['price'] != null && json['price']['min'] != null
        ? num.tryParse(json['price']['min'].toString())
        : 0;

    maxPrice = json['price'] != null && json['price']['max'] != null
        ? num.tryParse(json['price']['max'].toString())
        : 0;

    sTypename = json['__typename'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minPrice'] = this.minPrice;
    data['maxPrice'] = this.maxPrice;
    data['available'] = this.available;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SearchProductSizeOptions {
  late final String? name;
  bool? isAvailable;

  SearchProductSizeOptions({required this.name, required this.isAvailable});

  SearchProductSizeOptions.fromJson(dynamic json) {
    name = json.name;
    isAvailable = json.isAvailable;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isAvailable'] = this.isAvailable;
    return data;
  }
}

PredictiveSearchVM predictiveSearchVMFromJson(dynamic str) =>
    (PredictiveSearchVM.fromJson(str));

class PredictiveSearchVM {
  late final List<SearchQueryVM>? queries;
  late final List<PredictiveProductsVM>? products;
  late final String? sTypename;

  PredictiveSearchVM(
      {required this.queries, required this.products, required this.sTypename});

  PredictiveSearchVM.fromJson(dynamic json) {
    if (json.queries != null) {
      queries = <SearchQueryVM>[];
      json.queries.forEach((v) {
        if (v != null) {
          queries!.add(SearchQueryVM.fromJson(v));
        }
      });
    }
    if (json.products != null) {
      products = <PredictiveProductsVM>[];
      json.products.forEach((v) {
        if (v != null) {
          products!.add(PredictiveProductsVM.fromJson(v));
        }
      });
    }
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['queries'] = this.queries!.map((v) => v.toJson()).toList();
    data['products'] = this.products!.map((v) => v.toJson()).toList();
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SearchQueryVM {
  late final String? text;
  late final String? sTypename;

  SearchQueryVM({required this.text, required this.sTypename});

  SearchQueryVM.fromJson(dynamic json) {
    text = json.text;
    sTypename = json.sTypename;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class PredictiveProductsVM {
  late final String? title;
  late final String? sId;
  late final String? imageUrl;

  PredictiveProductsVM(
      {required this.title, required this.sId, required this.imageUrl});

  PredictiveProductsVM.fromJson(dynamic json) {
    title = json.title;
    sId = json.id;
    imageUrl = json.imageUrl;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.sId;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

SearchSettingVM searchSettingVMFromJson(dynamic str) =>
    (SearchSettingVM.fromJson(str));

class SearchSettingVM {
  late final String? sId;
  late final SearchRecommendedProductsVM? recommendedProducts;
  late final List<PopularSearchesVM>? popularSearches;

  SearchSettingVM({
    required this.sId,
    required this.popularSearches,
    required this.recommendedProducts,
  });

  SearchSettingVM.fromJson(dynamic json) {
    sId = json.sId;
    if (json.popularSearches != null) {
      popularSearches = <PopularSearchesVM>[];
      json.popularSearches.forEach((v) {
        popularSearches!.add(new PopularSearchesVM.fromJson(v));
      });
    } else {
      popularSearches = <PopularSearchesVM>[];
    }
    recommendedProducts = json.recommendedProducts != null
        ? new SearchRecommendedProductsVM.fromJson(json.recommendedProducts)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.popularSearches != null) {
      data['popularSearches'] =
          this.popularSearches!.map((v) => v.toJson()).toList();
    }
    if (this.recommendedProducts != null) {
      data['recommendedProducts'] = this.recommendedProducts!.toJson();
    }
    return data;
  }
}

class PopularSearchesVM {
  late final String? sId;
  late final String? title;

  PopularSearchesVM({
    required this.sId,
    required this.title,
  });

  PopularSearchesVM.fromJson(dynamic json) {
    sId = json.sId;
    title = json.title;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    return data;
  }
}

class SearchRecommendedProductsVM {
  late final String? sId;
  late final String? title;
  late final int? count;
  late final String? collectionUrl;

  SearchRecommendedProductsVM({
    required this.sId,
    required this.title,
    required this.count,
    required this.collectionUrl,
  });

  SearchRecommendedProductsVM.fromJson(dynamic json) {
    sId = json.sId;
    title = json.title;
    count = json.count;
    collectionUrl = json.collectionUrl;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['count'] = this.count;
    data['collectionUrl'] = this.collectionUrl;

    return data;
  }
}
