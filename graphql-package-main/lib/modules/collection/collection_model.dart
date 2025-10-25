List<HomePagePromotion> homePagePromotionFromJson(dynamic str) =>
    List<HomePagePromotion>.from(str.map((x) => HomePagePromotion.fromJson(x)));

class HomePagePromotion {
  late final String? sId;
  late final String? productName;
  late final String? imageUrl;
  late final String? producturl;
  late final String? type;
  late final String? vendor;
  late final int? moq;
  late final bool? showUnits;
  late final String? units;
  late final bool? availableForSale;
  late final HomePagePromotionPrice? price;
  late final List<PromotionProductOptions>? options;
  late final List<PromotionProductVariants>? variants;
  late final List<String>? wishlistCollection;
  late final bool? isWishlist;
  late final bool? showPrice;
  late final bool? showPriceRange;
  late final List<ProductMetafields>? metafields;
  late final List<ProductImages>? images;
  late final CollectionProductRibbonVM? ribbon;
  late final String? sTypename;

  HomePagePromotion(
      {required this.sId,
      required this.productName,
      required this.imageUrl,
      required this.availableForSale,
      required this.moq,
      required this.showUnits,
      required this.units,
      required this.type,
      required this.price,
      required this.vendor,
      required this.ribbon,
      required this.options,
      required this.images,
      required this.metafields,
      required this.isWishlist,
      required this.producturl,
      required this.showPrice,
      required this.showPriceRange,
      required this.wishlistCollection,
      required this.variants,
      required this.sTypename});

  HomePagePromotion.fromJson(Map<String, dynamic> json) {
    sId = json['node'] != null ? json['node']['id'] : null;
    productName = json['node'] != null ? json['node']['title'] : null;
    imageUrl = (json['node'] != null && json['node']['featuredImage'] != null)
        ? json['node']['featuredImage']['url']
        : null;
    availableForSale =
        json['node'] != null ? json['node']['availableForSale'] : null;
    vendor = json['node'] != null ? json['node']['vendor'] : null;
    price = json['node'] != null
        ? new HomePagePromotionPrice.fromJson(json['node'])
        : null;
    type = "product";
    ribbon = null;
    moq = 0;
    producturl = null;
    isWishlist = false;
    showUnits = false;
    showPrice = true;
    units = "";
    showPriceRange = false;
    wishlistCollection = [];
    if (json['node'] != null && json['node']['options'] != null) {
      options = <PromotionProductOptions>[];
      json['node']['options'].forEach((v) {
        options!.add(PromotionProductOptions.fromJson(v));
      });
    } else {
      options = [];
    }
    images = <ProductImages>[];
    if (json['node'] != null &&
        json['node']['images'] != null &&
        json['node']['images']['nodes'] != null) {
      json['node']['images']['nodes'].forEach((v) {
        images!.add(ProductImages.fromJson(v));
      });
    }
    metafields = <ProductMetafields>[];
    if (json['node'] != null && json['node']['metafields'] != null) {
      var value =
          json['node']['metafields'].where((element) => element != null);
      value.forEach((v) {
        metafields!.add(ProductMetafields.fromJson(v));
      });
    }
    if (json['node'] != null &&
        json['node']['variants'] != null &&
        json['node']['variants']['edges'] != null) {
      variants = <PromotionProductVariants>[];
      json['node']['variants']['edges'].forEach((v) {
        var data = {
          "id": v['node'] != null ? v['node']['id'] : null,
          "title": v['node'] != null ? v['node']['title'] : null,
          "availableForSale":
              v['node'] != null ? v['node']['availableForSale'] : null,
        };
        variants!.add(PromotionProductVariants.fromJson(data));
      });
    } else {
      variants = [];
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productName'] = this.productName;
    data['type'] = this.type;
    data['ribbon'] = this.ribbon;
    data['producturl'] = this.producturl;
    data['vendor'] = this.vendor;
    data['moq'] = this.moq;
    data['showUnits'] = this.showUnits;
    data['units'] = this.units;
    data['imageUrl'] = this.imageUrl;
    data['availableForSale'] = this.availableForSale;
    data['wishlistCollection'] = this.wishlistCollection;
    data['isWishlist'] = this.isWishlist;
    data['showPrice'] = this.showPrice;
    data['showPriceRange'] = this.showPriceRange;
    if (this.metafields != null) {
      data['metafields'] = this.metafields!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
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

class HomePagePromotionPrice {
  late final num? mrp;
  late final num? sellingPrice;
  late final num? minPrice;
  late final String? currencySymbol;
  late final num? maxPrice;

  late final String? sTypename;

  HomePagePromotionPrice(
      {required this.mrp,
      required this.sellingPrice,
      required this.currencySymbol,
      required this.minPrice,
      required this.maxPrice,
      required this.sTypename});

  HomePagePromotionPrice.fromJson(Map<String, dynamic> json) {
    mrp = (json['compareAtPriceRange'] != null &&
            json['compareAtPriceRange']['maxVariantPrice'] != null)
        ? num.parse(json['compareAtPriceRange']['maxVariantPrice']['amount'])
        : 0;
    sellingPrice = (json['priceRange'] != null &&
            json['priceRange']['minVariantPrice'] != null)
        ? num.parse(json['priceRange']['minVariantPrice']['amount'])
        : 0;
    minPrice = 0;
    maxPrice = 0;
    currencySymbol = '₹';
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mrp'] = this.mrp;
    data['sellingPrice'] = this.sellingPrice;
    data['currencySymbol'] = this.currencySymbol;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class PromotionProductVariants {
  late final String? sId;
  late final String? title;
  late final bool? availableForSale;
  late final String? sTypename;

  PromotionProductVariants({
    required this.title,
    required this.sId,
    required this.availableForSale,
    required this.sTypename,
  });

  PromotionProductVariants.fromJson(Map<String, dynamic> json) {
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

class PromotionProductOptions {
  late final String? sId;
  late final String? name;
  late final List<PromotionProductOptionsValue> values;
  late final String? sTypename;

  PromotionProductOptions({
    required this.name,
    required this.sId,
    required this.values,
    required this.sTypename,
  });

  PromotionProductOptions.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    if (json['values'] != null) {
      values = <PromotionProductOptionsValue>[];
      json['values'].forEach((v) {
        var optionValue = {"name": v};
        values.add(PromotionProductOptionsValue.fromJson(optionValue));
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

class PromotionProductOptionsValue {
  late final String? name;

  PromotionProductOptionsValue({
    required this.name,
  });

  PromotionProductOptionsValue.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

ProductCollection productCollectionFromJson(dynamic str) =>
    (ProductCollection.fromJson(str));

class ProductCollection {
  late final int? currentPage;
  late final int? totalPages;
  late final int? count;
  // late final List<Collection>? collection;
  late final Collection? collection;
  late final PageInfo? pageInfo;
  late final bool? showDownloadCatalog;
  late final String? downloadCatalogForm;
  late final String? downloadCatalogButtonName;
  late final String? catalogUrl;
  late final CatalogFile? collectionCatalog;
  late final List<ProductCollectionList> product;
  late final List<CollectionMetafield>? metafields;
  late final String? sTypename;
  late final String? title;
  late final String? description;
  late final String? sId;

  ProductCollection({
    required this.currentPage,
    required this.totalPages,
    required this.pageInfo,
    required this.count,
    required this.collection,
    required this.product,
    required this.metafields,
    required this.sTypename,
    required this.title,
    required this.description,
    required this.sId,
    required this.showDownloadCatalog,
    required this.downloadCatalogForm,
    required this.downloadCatalogButtonName,
    required this.catalogUrl,
    required this.collectionCatalog,
  });

  ProductCollection.fromJson(Map<String, dynamic> json) {
    currentPage = json['values']['currentPage'] ?? null;
    sId = json['values']['id'];
    totalPages = json['values']['totalPages'] ?? null;
    count = json['values']['count'] ?? null;
    collection =
        json['values'] != null ? new Collection.fromJson(json['values']) : null;
    pageInfo = json['values']['products']['pageInfo'] != null
        ? new PageInfo.fromJson(json['values']['products']['pageInfo'])
        : null;
    if (json['values']['products']['edges'] != null) {
      product = <ProductCollectionList>[];
      json['values']['products']['edges'].forEach((v) {
        if (v != null && v['node'] != null) {
          product.add(ProductCollectionList.fromJson(v['node']));
        }
      });
    }
    metafields = <CollectionMetafield>[];
    if (json['values']['metafields'] != null &&
        json['values']['metafields'].length > 0) {
      var value =
          json['values']['metafields'].where((element) => element != null);
      value.forEach((v) {
        metafields!.add(new CollectionMetafield.fromJson(v));
      });
    }
    // if (json['node']['products']['edges'] != null) {
    //   collection = <Collection>[];
    //   json['node']['products']['edges'].forEach((v) {
    //     collection?.add(new Collection.fromJson(v['node']));
    //   });
    // }
    sTypename = json['values']['__typename'];
    title = json['values']['title'];
    showDownloadCatalog = null;
    downloadCatalogForm = null;
    downloadCatalogButtonName = null;
    catalogUrl = null;
    collectionCatalog = null;
    description = json['values']['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // print("datasssss $data");

    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    data['count'] = this.count;
    data['id'] = this.sId;
    if (this.collection != null) {
      data['collection'] = this.collection!.toJson();
    }
    if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo!.toJson();
    }
    data['product'] = this.product.map((v) => v.toJson()).toList();
    if (this.metafields != null) {
      data['metafields'] = this.metafields!.map((v) => v.toJson()).toList();
    }
    // data['collection'] = this.collection?.map((v) => v.toJson()).toList();
    data['__typename'] = this.sTypename;
    data['title'] = this.title;
    data['description'] = this.description;
    data['showDownloadCatalog'] = this.showDownloadCatalog;
    data['downloadCatalogForm'] = this.downloadCatalogForm;
    data['downloadCatalogButtonName'] = this.downloadCatalogButtonName;
    data['catalogUrl'] = this.catalogUrl;
    data['collectionCatalog'] = this.collectionCatalog;
    return data;
  }
}

class CatalogFile {
  late final String? fileName;
  late final String? fileUrl;
  late final String? fileType;

  CatalogFile(
      {required this.fileName, required this.fileUrl, required this.fileType});

  CatalogFile.fromJson(Map<String, dynamic> json) {
    // print("collection $json");
    fileName = json['fileName'] ?? null;
    fileUrl = json['fileUrl'] ?? null;
    fileType = json['fileType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['fileUrl'] = this.fileUrl;
    data['fileType'] = this.fileType;
    return data;
  }
}

class Collection {
  late final String? sId;
  late final String? name;
  late final String? sTypename;

  Collection({required this.sId, required this.name, required this.sTypename});

  Collection.fromJson(Map<String, dynamic> json) {
    // print("collection $json");
    sId = json['id'] ?? null;
    name = json['title'] ?? null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CollectionMetafield {
  late final String? id;
  late final String? description;
  late final String? type;
  late final String? key;
  late final String? namespace;
  late final String? value;
  late final CollectionMetaReferences? references;

  CollectionMetafield({
    required this.id,
    required this.description,
    required this.type,
    required this.key,
    required this.namespace,
    required this.value,
    required this.references,
  });

  CollectionMetafield.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    type = json['type'];
    key = json['key'];
    namespace = json['namespace'];
    value = json['value'];
    references = json['references'] != null
        ? CollectionMetaReferences.fromJson(json['references'])
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

    return data;
  }
}

class CollectionMetaReferences {
  late final List<ProductCollectionList> edges;

  CollectionMetaReferences({required this.edges});

  CollectionMetaReferences.fromJson(Map<String, dynamic> json) {
    edges = (json['edges'] as List)
        .map((edge) => ProductCollectionList.fromJson(edge['node']))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'edges': edges.map((edge) => {'node': edge.toJson()}).toList(),
    };
  }
}

class PageInfo {
  late final bool? hasNextPage;
  late final bool? hasPreviousPage;
  late final String? endCursor;
  late final String? sTypename;

  PageInfo(
      {required this.hasNextPage,
      required this.hasPreviousPage,
      required this.endCursor,
      required this.sTypename});

  PageInfo.fromJson(Map<String, dynamic> json) {
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

class ProductCollectionList {
  late final String? sId;
  late final String? productName;
  late final String? imageUrl;
  late final String? type;
  late final String? vendor;
  late final bool? availableForSale;
  late final List<String>? wishlistCollection;
  late final bool? isWishlist;
  late final bool? showPrice;
  late final bool? showPriceRange;
  late final CollectionProductRibbonVM? ribbon;
  late final HomePagePromotionPrice? price;
  late final List<PromotionProductOptions>? options;
  late final List<ProductImages>? images;
  late final List<ProductMetafields>? metafields;
  late final List<PromotionProductVariants>? variants;
  late final String? sTypename;

  ProductCollectionList(
      {required this.sId,
      required this.productName,
      required this.imageUrl,
      required this.type,
      required this.vendor,
      required this.availableForSale,
      required this.price,
      required this.ribbon,
      required this.options,
      required this.variants,
      required this.isWishlist,
      required this.metafields,
      required this.images,
      required this.showPrice,
      required this.showPriceRange,
      required this.wishlistCollection,
      required this.sTypename});

  ProductCollectionList.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    productName = json['title'];
    vendor = json['vendor'];
    imageUrl =
        json['featuredImage'] != null ? json['featuredImage']['url'] : null;
    availableForSale = json['availableForSale'];
    price = new HomePagePromotionPrice.fromJson(json);
    type = "product";
    ribbon = null;
    isWishlist = false;
    showPrice = true;
    showPriceRange = false;
    wishlistCollection = [];
    if (json['options'] != null) {
      options = <PromotionProductOptions>[];
      json['options'].forEach((v) {
        options!.add(PromotionProductOptions.fromJson(v));
      });
    } else {
      options = [];
    }
    metafields = <ProductMetafields>[];
    if (json['metafields'] != null) {
      var value = json['metafields'].where((element) => element != null);
      value.forEach((v) {
        metafields!.add(ProductMetafields.fromJson(v));
      });
    }
    images = <ProductImages>[];
    if (json['images'] != null && json['images']['nodes'] != null) {
      json['images']['nodes'].forEach((v) {
        images!.add(ProductImages.fromJson(v));
      });
    }
    if (json['variants'] != null && json['variants']['edges'] != null) {
      variants = <PromotionProductVariants>[];
      json['variants']['edges'].forEach((v) {
        var data = {
          "id": v['node'] != null ? v['node']['id'] : null,
          "title": v['node'] != null ? v['node']['title'] : null,
          "availableForSale":
              v['node'] != null ? v['node']['availableForSale'] : null,
        };
        variants!.add(PromotionProductVariants.fromJson(data));
      });
    } else {
      variants = [];
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productName'] = this.productName;
    data['type'] = this.type;
    data['wishlistCollection'] = this.wishlistCollection;
    data['vendor'] = this.vendor;
    data['isWishlist'] = this.isWishlist;
    data['showPrice'] = this.showPrice;
    data['showPriceRange'] = this.showPriceRange;
    data['imageUrl'] = this.imageUrl;
    data['availableForSale'] = this.availableForSale;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    if (this.metafields != null) {
      data['metafields'] = this.metafields!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    if (this.ribbon != null) {
      data['ribbon'] = this.ribbon!.toJson();
    }
    data['__typename'] = this.sTypename;
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
    // print("jsonnnnnnnnIMG $json");
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
    var priceRange = json['priceRange'];
    var compareAtPriceRange = json['compareAtPriceRange'];
    // print('prize json ${json['maxVariantPrice']['amount']}');
    // print('prizejson $json');
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

CollectionAttribute collectionAttributeFromJson(dynamic str) =>
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
    sTypename = json['__typename'] ?? null;
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
  late final String? type;
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
      required this.type,
      required this.sTypename});

  AttributeList.fromJson(Map<String, dynamic> json) {
    sId = json['id'] ?? null;
    if (json['values'] != null) {
      fieldValue = <AttributeFieldValue>[];
      json['values'].forEach((v) {
        fieldValue!.add(new AttributeFieldValue.fromJson(v));
      });
    }

    attributeFieldId = json['id'] ?? null;
    checked = json['checked'] ?? null;
    fieldEnable = json['fieldEnable'] ?? null;
    fieldName = json['label'];
    fieldSetting = json['fieldSetting'] ?? null;
    labelName = json['label'];
    sortOrder = json['sortOrder'] ?? null;
    sTypename = json['__typename'];
    type = json['type'];
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
  late final int? count;
  late final String? input;
  late final String? filterValue;

  AttributeFieldValue({
    required this.appletName,
    required this.attributeFieldValue,
    required this.attributeFieldValueId,
    required this.checked,
    required this.fieldValueEnable,
    required this.sortOrder,
    required this.sTypename,
    required this.count,
    required this.input,
    required this.filterValue,
  });

  AttributeFieldValue.fromJson(Map<String, dynamic> json) {
    // AttributeFieldValue.fromJson(Map<String, dynamic> json) {
    appletName = json['label'];
    attributeFieldValue = json['label'] ?? null;
    attributeFieldValueId = json['attributeFieldId'] ?? null;
    checked = json['checked'] ?? null;
    fieldValueEnable = json['fieldValueEnable'] ?? null;
    sortOrder = json['sortOrder'] ?? null;
    sTypename = json['__typename'] ?? null;
    count = json['count'] ?? null;
    input = json['input'] ?? null;
    filterValue = json['input'] ?? null;
    // var inputData = jsonDecode(json['input']);
    // print("value json ${inputData}");
    // input = (json['input'] != null ? new InputValue.fromJson(inputData) : null);
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
    data['input'] = this.input;
    data['filterValue'] = this.filterValue;
    // if (this.input != null) {
    //   data['input'] = this.input!.toJson();
    // }
    return data;
  }
}
