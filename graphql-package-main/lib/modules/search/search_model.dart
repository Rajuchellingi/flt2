SearchProducts productCollectionFromJson(dynamic str) =>
    (SearchProducts.fromJson(str));
// List<SearchList> productCollectionFromJson(dynamic str) =>
//     (List<SearchList>.from(str.map((x) => SearchList.fromJson(x))));

class SearchProducts {
  late final SearchPageInfo? pageInfo;
  late final List<SearchList> products;

  SearchProducts({
    required this.pageInfo,
    required this.products,
  });

  SearchProducts.fromJson(Map<String, dynamic> json) {
    pageInfo = json['pageInfo'] != null
        ? new SearchPageInfo.fromJson(json['pageInfo'])
        : null;
    if (json['products'] != null) {
      products = <SearchList>[];
      json['products'].forEach((v) {
        if (v != null) {
          products.add(SearchList.fromJson(v));
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

class SearchList {
  late final String? sId;
  late final String? productId;
  late final String? name;
  late final String? description;
  late final String? type;
  late final int? moq;
  late final bool? isOutofstock;
  late final bool? isMultiple;
  late final String? imageId;
  late final String? vendor;
  late final List<String>? wishlistCollection;
  late final String? priceType;
  // late final CollectionProductRibbon? ribbon;
  late final CollectionProductPrice? price;
  late final List<ProductOptions>? options;
  late final List<ProductVariants>? variants;
  late final List<ProductMetafields>? metafields;
  late final List<CollectionProductImage>? images;
  late final List<ProductImages>? productImages;
  late final String? sTypename;

  SearchList(
      {required this.sId,
      required this.productId,
      required this.name,
      required this.description,
      required this.type,
      required this.moq,
      required this.wishlistCollection,
      required this.isOutofstock,
      required this.vendor,
      required this.isMultiple,
      required this.imageId,
      required this.productImages,
      required this.metafields,
      required this.priceType,
      // required this.ribbon,
      required this.options,
      required this.variants,
      required this.price,
      required this.images,
      required this.sTypename});

  SearchList.fromJson(Map<String, dynamic> json) {
    // print("jsonnnnnnnn ${json["featuredImage"]}");
    sId = json['id'];
    productId = json['productId'] ?? null;
    name = json['title'];
    vendor = json['vendor'];
    description = json['description'];
    type = json['type'] ?? "product";
    moq = 1;
    isOutofstock = json['availableForSale'] == true ? false : true;
    isMultiple = json['isMultiple'];
    imageId =
        json['featuredImage'] != null ? json['featuredImage']['id'] : null;
    // imageId = json['featuredImage'] ?? null json['featuredImage']['id'] ?? null;
    priceType = json['priceType'] ?? null;
    price = json['priceRange'] != null
        ? new CollectionProductPrice.fromJson(json)
        : null;
    // ribbon = json['ribbon'] != null
    //     ? new CollectionProductRibbon.fromJson(json['ribbon'])
    //     : null;
    // images = json['featuredImage'] != null
    //     ? new CollectionProductImage.fromJson(json['featuredImage'])
    //     : null;
    // print('imgaes......... ${json['featuredImage']}');
    wishlistCollection = [];
    if (json['options'] != null) {
      options = <ProductOptions>[];
      json['options'].forEach((v) {
        options!.add(ProductOptions.fromJson(v));
      });
    }
    metafields = <ProductMetafields>[];
    if (json['metafields'] != null) {
      json['metafields'].forEach((v) {
        var value = json['metafields'].where((element) => element != null);
        value.forEach((v) {
          metafields!.add(ProductMetafields.fromJson(v));
        });
      });
    }
    if (json['variants'] != null && json['variants']['edges'] != null) {
      variants = <ProductVariants>[];
      json['variants']['edges'].forEach((v) {
        variants!.add(ProductVariants.fromJson(v['node']));
      });
    }
    if (json['featuredImage'] != null) {
      images = <CollectionProductImage>[];
      images!.add(new CollectionProductImage.fromJson(json['featuredImage']));
    } else {
      images = <CollectionProductImage>[];
    }
    sTypename = json['__typename'];
    productImages = <ProductImages>[];
    if (json['images'] != null && json['images']['nodes'] != null) {
      json['images']['nodes'].forEach((v) {
        productImages!.add(ProductImages.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productId'] = this.productId;
    data['name'] = this.name;
    data['vendor'] = this.vendor;
    data['description'] = this.description;
    data['type'] = this.type;
    data['moq'] = this.moq;
    data['wishlistCollection'] = this.wishlistCollection;
    data['isOutofstock'] = this.isOutofstock;
    data['isMultiple'] = this.isMultiple;
    data['imageId'] = this.imageId;
    data['priceType'] = this.priceType;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    // if (this.ribbon != null) {
    //   data['ribbon'] = this.ribbon!.toJson();
    // }
    // if (this.images != null) {
    //   data['images'] = this.images!.toJson();
    // }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.productImages != null) {
      data['productImages'] =
          this.productImages!.map((v) => v.toJson()).toList();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    if (this.metafields != null) {
      data['metafields'] = this.metafields!.map((v) => v.toJson()).toList();
    }
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ProductImages {
  late final String? url;
  late final int? height;
  late final int? width;

  ProductImages({required this.url, required this.height, required this.width});
  ProductImages.fromJson(Map<String, dynamic> json) {
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

class ProductMetafields {
  late final String? type;
  late final String? key;
  late final String? namespace;
  late final String? value;

  ProductMetafields({
    required this.value,
    required this.type,
    required this.key,
    required this.namespace,
  });

  ProductMetafields.fromJson(Map<String, dynamic> json) {
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

class ProductVariants {
  late final String? sId;
  late final String? title;
  late final bool? availableForSale;
  late final String? sTypename;

  ProductVariants({
    required this.title,
    required this.sId,
    required this.availableForSale,
    required this.sTypename,
  });

  ProductVariants.fromJson(Map<String, dynamic> json) {
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

class ProductOptions {
  late final String? sId;
  late final String? name;
  late final List<ProductOptionsValue> values;
  late final String? sTypename;

  ProductOptions({
    required this.name,
    required this.sId,
    required this.values,
    required this.sTypename,
  });

  ProductOptions.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    if (json['values'] != null) {
      values = <ProductOptionsValue>[];
      json['values'].forEach((v) {
        var optionValue = {"name": v};
        values.add(ProductOptionsValue.fromJson(optionValue));
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

class ProductOptionsValue {
  late final String? name;

  ProductOptionsValue({
    required this.name,
  });

  ProductOptionsValue.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
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

  // CollectionProductImage.fromJson(Map<String, dynamic> json) {
  CollectionProductImage.fromJson(Map<String, dynamic> json) {
    position = json['position'] ?? null;
    imageName = json['url'] ?? null;
    sTypename = json['__typename'] ?? false;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['position'] = this.position;
    data['imageName'] = this.imageName;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CollectionProductPrice {
  late final num? sellingPrice;
  late final num? mrp;
  late final num? discount;
  late final num? minPrice;
  late final num? maxPrice;
  late final String? type;
  late final bool? isSamePrice;
  late final String? sTypename;

  CollectionProductPrice(
      {required this.sellingPrice,
      required this.mrp,
      required this.discount,
      required this.minPrice,
      required this.maxPrice,
      required this.type,
      required this.isSamePrice,
      required this.sTypename});

  CollectionProductPrice.fromJson(Map<String, dynamic> json) {
    // print('prize json ${json['maxVariantPrice']['amount']}');
    var priceRange = json['priceRange'];
    var compareAtPriceRange = json['compareAtPriceRange'];
    sellingPrice = priceRange['maxVariantPrice']['amount'] != null
        ? num.parse(priceRange['maxVariantPrice']['amount'])
        : 0;
    mrp = compareAtPriceRange['maxVariantPrice']['amount'] != null
        ? num.parse(compareAtPriceRange['maxVariantPrice']['amount'])
        : 0;
    discount = json['discount'] != null ? json['discount'].toDouble() : 0;
    minPrice = priceRange['maxVariantPrice']['amount'] != null
        ? num.parse(priceRange['maxVariantPrice']['amount'])
        : 0;
    maxPrice = compareAtPriceRange['maxVariantPrice']['amount'] != null
        ? num.parse(compareAtPriceRange['maxVariantPrice']['amount'])
        : 0;
    type = json['type'];
    isSamePrice = json['isSamePrice'] ?? null;
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

class CollectionProductRibbon {
  late final String? name;
  late final String? colorCode;

  CollectionProductRibbon({required this.name, required this.colorCode});
  CollectionProductRibbon.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? null;
    colorCode = json['colorCode'] ?? null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['colorCode'] = this.colorCode;
    return data;
  }
}

// CollectionAttribute SearchProductCollectionFromJson(dynamic str) =>
//     (CollectionAttribute.fromJson(str));

CollectionAttribute searchProductCollectionFromJson(dynamic str) =>
    (CollectionAttribute.fromJson(str));

class CollectionAttribute {
  late final List<AttributeList> attribute;
  late final String? sTypename;

  CollectionAttribute({required this.attribute, required this.sTypename});

  CollectionAttribute.fromJson(Map<String, dynamic> json) {
    if (json['attribute'] != null) {
      attribute = <AttributeList>[];
      json['attribute'].forEach((v) {
        attribute.add(new AttributeList.fromJson(v));
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

class AttributeList {
  late final String? sId;
  late final String? attributeFieldId;
  late final bool? checked;
  late final bool? fieldEnable;
  late final String? fieldName;
  late final String? fieldSetting;
  late final String? labelName;
  late final int? sortOrder;
  late final List<AttributeFieldValue>? fieldValue;
  late final String? sTypename;

  AttributeList(
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

  AttributeList.fromJson(Map<String, dynamic> json) {
    sId = json['id'] ?? null;
    // if (json['values'] != null) {
    //   fieldValue = <AttributeFieldValue>[];
    //   json['values'].forEach((v) {
    //     fieldValue!.add(new AttributeFieldValue.fromJson(v));
    //   });
    // }
    if (json['values'] != null) {
      fieldValue = <AttributeFieldValue>[];
      json['values'].forEach((v) {
        var field = {
          "id": "8854080",
          "labelName": v,
          "attributeFieldId": json['id']
        };
        fieldValue!.add(new AttributeFieldValue.fromJson(field));
      });

      // fieldValue!
      //     .add(FieldValue(id: 'gid://shopify/ProductImage/42100131135788'));
    }

    attributeFieldId = json['id'] ?? null;
    checked = json['checked'] ?? null;
    fieldEnable = json['fieldEnable'] ?? null;
    fieldName = json['name'];
    fieldSetting = json['fieldSetting'] ?? null;
    labelName = json['name'];
    sortOrder = json['sortOrder'] ?? null;
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

class AttributeFieldValue {
  late final String? appletName;
  late final String? attributeFieldValue;
  late final String? attributeFieldValueId;
  late final bool? checked;
  late final bool? fieldValueEnable;
  late final int? sortOrder;
  late final String? sTypename;

  AttributeFieldValue(
      {required this.appletName,
      required this.attributeFieldValue,
      required this.attributeFieldValueId,
      required this.checked,
      required this.fieldValueEnable,
      required this.sortOrder,
      required this.sTypename});

  AttributeFieldValue.fromJson(Map<String, dynamic> json) {
    // AttributeFieldValue.fromJson(Map<String, dynamic> json) {
    appletName = json['labelName'];
    attributeFieldValue = json['labelName'];
    attributeFieldValueId = json['id'];
    checked = json['checked'] ?? null;
    fieldValueEnable = json['fieldValueEnable'] ?? null;
    sortOrder = json['sortOrder'] ?? null;
    sTypename = json['__typename'] ?? null;
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

class SearchPageInfo {
  late final bool? hasNextPage;
  late final bool? hasPreviousPage;
  late final String? endCursor;
  late final String? sTypename;

  SearchPageInfo(
      {required this.hasNextPage,
      required this.hasPreviousPage,
      required this.endCursor,
      required this.sTypename});

  SearchPageInfo.fromJson(Map<String, dynamic> json) {
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

PredictiveSearch predictiveSearchFromJson(dynamic str) =>
    (PredictiveSearch.fromJson(str));

class PredictiveSearch {
  late final List<SearchQuery>? queries;
  late final List<PredictiveProducts>? products;
  late final String? sTypename;

  PredictiveSearch(
      {required this.queries, required this.products, required this.sTypename});

  PredictiveSearch.fromJson(Map<String, dynamic> json) {
    if (json['queries'] != null) {
      queries = <SearchQuery>[];
      json['queries'].forEach((v) {
        if (v != null) {
          queries!.add(SearchQuery.fromJson(v));
        }
      });
    }
    if (json['products'] != null) {
      products = <PredictiveProducts>[];
      json['products'].forEach((v) {
        if (v != null) {
          products!.add(PredictiveProducts.fromJson(v));
        }
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['queries'] = this.queries!.map((v) => v.toJson()).toList();
    data['products'] = this.products!.map((v) => v.toJson()).toList();
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SearchQuery {
  late final String? text;
  late final String? sTypename;

  SearchQuery({required this.text, required this.sTypename});

  SearchQuery.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    sTypename = json['__typename'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class PredictiveProducts {
  late final String? title;
  late final String? id;
  late final String? imageUrl;

  PredictiveProducts(
      {required this.title, required this.id, required this.imageUrl});

  PredictiveProducts.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    imageUrl =
        json['featuredImage'] != null ? json['featuredImage']['url'] : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

SearchSetting searchSettingFromJson(dynamic str) =>
    (SearchSetting.fromJson(str));

class SearchSetting {
  late final String? sId;
  late final SearchRecommendedProducts? recommendedProducts;
  late final List<PopularSearches>? popularSearches;

  SearchSetting({
    required this.sId,
    required this.popularSearches,
    required this.recommendedProducts,
  });

  SearchSetting.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['popularSearches'] != null) {
      popularSearches = <PopularSearches>[];
      json['popularSearches'].forEach((v) {
        popularSearches!.add(new PopularSearches.fromJson(v));
      });
    } else {
      popularSearches = <PopularSearches>[];
    }
    recommendedProducts = json['recommendedProducts'] != null
        ? new SearchRecommendedProducts.fromJson(json['recommendedProducts'])
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

class PopularSearches {
  late final String? sId;
  late final String? title;

  PopularSearches({
    required this.sId,
    required this.title,
  });

  PopularSearches.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    return data;
  }
}

class SearchRecommendedProducts {
  late final String? sId;
  late final String? title;
  late final int? count;
  late final String? collectionUrl;

  SearchRecommendedProducts({
    required this.sId,
    required this.title,
    required this.count,
    required this.collectionUrl,
  });

  SearchRecommendedProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    count = json['count'];
    collectionUrl = json['collectionUrl'];
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
