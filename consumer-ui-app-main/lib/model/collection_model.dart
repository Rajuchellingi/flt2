import 'package:black_locust/config/configConstant.dart';

ProductCollectionVM productCollectionVMFromJson(dynamic str) =>
    (ProductCollectionVM.fromJson(str.toJson()));

class ProductCollectionVM {
  late final int? currentPage;
  late final int? totalPages;
  late final int? count;
  late final List<bannerList>? banners;
  late final String? collectionName;
  late final CollectionVM? collection;
  late final PageInfoVM? pageInfo;
  late final List<ProductCollectionListVM> product;
  late final List<CollectionMetafieldVM>? metafields;
  late final bool? showDownloadCatalog;
  late final String? downloadCatalogForm;
  late final String? downloadCatalogButtonName;
  late final String? catalogUrl;
  late final CatalogFileVM? collectionCatalog;
  late final String? sTypename;

  ProductCollectionVM(
      {required this.currentPage,
      required this.totalPages,
      required this.metafields,
      required this.count,
      required this.banners,
      required this.collectionName,
      required this.collection,
      required this.pageInfo,
      required this.showDownloadCatalog,
      required this.downloadCatalogForm,
      required this.downloadCatalogButtonName,
      required this.catalogUrl,
      required this.collectionCatalog,
      required this.product,
      required this.sTypename});

  ProductCollectionVM.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    count = json['count'];
    banners = <bannerList>[];
    collectionName = json['collectionName'];
    collection = json['collection'] != null
        ? new CollectionVM.fromJson(json['collection'])
        : null;
    pageInfo = json['pageInfo'] != null
        ? new PageInfoVM.fromJson(json['pageInfo'])
        : null;
    if (json['product'] != null) {
      product = <ProductCollectionListVM>[];
      json['product'].forEach((v) {
        product.add(new ProductCollectionListVM.fromJson(v));
      });
    }
    if (json['metafields'] != null) {
      metafields = <CollectionMetafieldVM>[];
      json['metafields'].forEach((v) {
        metafields!.add(new CollectionMetafieldVM.fromJson(v));
      });
    } else {
      metafields = [];
    }
    showDownloadCatalog = json['showDownloadCatalog'];
    downloadCatalogForm = json['downloadCatalogForm'];
    downloadCatalogButtonName = json['downloadCatalogButtonName'];
    catalogUrl = json['catalogUrl'];
    collectionCatalog = json['collectionCatalog'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    data['count'] = this.count;
    if (this.collection != null) {
      data['collection'] = this.collection!.toJson();
    }
    if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo!.toJson();
    }
    data['product'] = this.product.map((v) => v.toJson()).toList();
    data['__typename'] = this.sTypename;
    if (this.metafields != null) {
      data['metafields'] = this.metafields!.map((v) => v.toJson()).toList();
    }
    data['showDownloadCatalog'] = this.showDownloadCatalog;
    data['downloadCatalogForm'] = this.downloadCatalogForm;
    data['downloadCatalogButtonName'] = this.downloadCatalogButtonName;
    data['catalogUrl'] = this.catalogUrl;
    data['collectionCatalog'] = this.collectionCatalog;

    return data;
  }
}

class CollectionMetafieldVM {
  late final String? id;
  late final String? description;
  late final String? type;
  late final String? key;
  late final String? namespace;
  late final String? value;
  late final CollectionMetaReferencesVM? references;

  CollectionMetafieldVM({
    required this.id,
    required this.description,
    required this.type,
    required this.key,
    required this.namespace,
    required this.value,
    required this.references,
  });

  CollectionMetafieldVM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    type = json['type'];
    key = json['key'];
    namespace = json['namespace'];
    value = json['value'];
    references = json['references'] != null
        ? CollectionMetaReferencesVM.fromJson(json['references'])
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

class CollectionMetaReferencesVM {
  late final List<ProductCollectionListVM> edges;

  CollectionMetaReferencesVM({required this.edges});

  CollectionMetaReferencesVM.fromJson(Map<String, dynamic> json) {
    edges = (json['edges'] as List)
        .map((edge) => ProductCollectionListVM.fromJson(edge['node']))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'edges': edges.map((edge) => {'node': edge.toJson()}).toList(),
    };
  }
}

ProductCollectionV1VM productCollectionV1VMFromJson(dynamic str) =>
    (ProductCollectionV1VM.fromJson(str.toJson()));

class ProductCollectionV1VM {
  late final int? currentPage;
  late final int? totalPages;
  late final int? count;
  late final CollectionVM? collection;
  late final bool? showDownloadCatalog;
  late final String? downloadCatalogForm;
  late final String? downloadCatalogButtonName;
  late final String? catalogUrl;
  // late final CatalogFileVM? collectionCatalog;
  late final List<CatalogFileVM> collectionCatalog;
  late final List<AttributeListVM> filters;
  late final List<ProductCollectionListVM> product;
  late final String? sTypename;
  late final List<bannerList> banners;
  late final String? collectionName;
  late final List<sortSettingList> sortSetting;
  late final bool? multiBooking;

  ProductCollectionV1VM(
      {required this.currentPage,
      required this.totalPages,
      required this.count,
      required this.collection,
      required this.product,
      required this.showDownloadCatalog,
      required this.downloadCatalogForm,
      required this.downloadCatalogButtonName,
      required this.multiBooking,
      required this.catalogUrl,
      required this.collectionCatalog,
      required this.filters,
      required this.sTypename,
      required this.banners,
      required this.sortSetting,
      required this.collectionName});

  ProductCollectionV1VM.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    count = json['count'];
    collection = json['collection'] != null
        ? new CollectionVM.fromJson(json['collection'])
        : null;
    if (json['product'] != null) {
      product = <ProductCollectionListVM>[];
      json['product'].forEach((v) {
        product.add(new ProductCollectionListVM.fromJson(v));
      });
    }
    if (json['filters'] != null) {
      filters = <AttributeListVM>[];
      json['filters'].forEach((v) {
        filters.add(new AttributeListVM.fromJson(v));
      });
    }
    if (json['collectionCatalog'] != null) {
      collectionCatalog = <CatalogFileVM>[];
      json['collectionCatalog'].forEach((v) {
        collectionCatalog.add(new CatalogFileVM.fromJson(v));
      });
    }
    // collectionCatalog = json['collectionCatalog'] != null
    //     ? new CatalogFileVM.fromJson(json['collectionCatalog'])
    //     : null;
    showDownloadCatalog = json['showDownloadCatalog'];
    downloadCatalogForm = json['downloadCatalogForm'];
    multiBooking = json['multiBooking'];
    downloadCatalogButtonName = json['downloadCatalogButtonName'];
    catalogUrl = json['catalogUrl'];
    sTypename = json['__typename'];
    if (json['banners'] != null) {
      banners = <bannerList>[];
      json["banners"].forEach((v) {
        banners.add(new bannerList.fromJson(v));
      });
    } else {
      banners = [];
    }
    if (json['sortSetting'] != null) {
      sortSetting = <sortSettingList>[];
      json['sortSetting'].forEach((v) {
        sortSetting.add(new sortSettingList.fromJson(v));
      });
    } else {
      sortSetting = [];
    }
    collectionName = json['collectionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    data['count'] = this.count;
    if (this.collection != null) {
      data['collection'] = this.collection!.toJson();
    }
    data['filters'] = this.filters.map((v) => v.toJson()).toList();
    data['product'] = this.product.map((v) => v.toJson()).toList();
    data['collectionCatalog'] =
        this.collectionCatalog.map((v) => v.toJson()).toList();
    // if (this.collectionCatalog != null) {
    //   data['collectionCatalog'] = this.collectionCatalog!.toJson();
    // }
    data['showDownloadCatalog'] = this.showDownloadCatalog;
    data['downloadCatalogForm'] = this.downloadCatalogForm;
    data['multiBooking'] = this.multiBooking;
    data['downloadCatalogButtonName'] = this.downloadCatalogButtonName;
    data['catalogUrl'] = this.catalogUrl;
    data['__typename'] = this.sTypename;
    data['banners'] = this.banners.map((v) => v.toJson()).toList();
    data['sortSetting'] = this.sortSetting.map((v) => v.toJson()).toList();
    data['collectionName'] = this.collectionName;
    return data;
  }
}

class sortSettingList {
  late final String? sId;
  late final bool? status;
  late final bool? isDefault;
  late final String? creationDate;
  late final String? clientId;
  late final String? name;
  late final int? type;
  late final String? tagId;
  late final int? sortOrder;
  late final int? v;

  sortSettingList({
    required this.sId,
    required this.status,
    required this.isDefault,
    required this.creationDate,
    required this.clientId,
    required this.name,
    required this.type,
    required this.tagId,
    required this.sortOrder,
    required this.v,
  });

  sortSettingList.fromJson(Map<String, dynamic> json) {
    print("sortSettingList --->>> $json");
    sId = json['_id'];
    status = json['status'];
    isDefault = json['isDefault'];
    creationDate = json['creationDate'];
    clientId = json['clientId'];
    name = json['name'];
    type = json['type'];
    tagId = json['tagId'];
    sortOrder = json['sortOrder'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['status'] = status;
    data['isDefault'] = isDefault;
    data['creationDate'] = creationDate;
    data['clientId'] = clientId;
    data['name'] = name;
    data['type'] = type;
    data['tagId'] = tagId;
    data['sortOrder'] = sortOrder;
    data['__v'] = v;
    return data;
  }
}

class CatalogFileVM {
  late final String? fileName;
  late final String? fileUrl;
  late final String? fileType;
  late final String? name;
  late final String? sId;

  CatalogFileVM(
      {required this.fileName,
      required this.fileUrl,
      required this.fileType,
      required this.name,
      required this.sId});

  CatalogFileVM.fromJson(Map<String, dynamic> json) {
    print("collection $json");
    fileName = json['fileName'] ?? null;
    fileUrl = json['fileUrl'] ?? null;
    fileType = json['fileType'];
    name = json['name'] ?? null;
    sId = json['_id'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['fileUrl'] = this.fileUrl;
    data['fileType'] = this.fileType;
    data['name'] = this.name;
    data['_id'] = this.sId;
    return data;
  }
}

class PageInfoVM {
  late final bool? hasNextPage;
  late final bool? hasPreviousPage;
  late String? endCursor;
  late final String? sTypename;

  PageInfoVM(
      {required this.hasNextPage,
      required this.hasPreviousPage,
      required this.endCursor,
      required this.sTypename});

  PageInfoVM.fromJson(Map<String, dynamic> json) {
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

class CollectionVM {
  late final String? sId;
  late final String? name;
  late final String? sTypename;

  CollectionVM(
      {required this.sId, required this.name, required this.sTypename});

  CollectionVM.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
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

class ProductCollectionListVM {
  late final String? sId;
  late final String? productName;
  late final String? imageUrl;
  late final String? type;
  late final String? vendor;
  late final List<String>? wishlistCollection;
  late final bool? isWishlist;
  late final bool? showPrice;
  late final int? moq;
  late final bool? showPriceRange;
  late final bool? availableForSale;
  late final CollectionProductPrice? price;
  late final CollectionRibbonVM? ribbon;
  late final List<CollectionProductOptions>? options;
  late final List<CollectionProductVariants>? variants;
  late final List<ProductImagesVM>? images;
  late final List<ProductMetafieldsVM>? metafields;
  late final String? sTypename;

  ProductCollectionListVM(
      {required this.sId,
      required this.productName,
      required this.imageUrl,
      required this.availableForSale,
      required this.type,
      required this.vendor,
      required this.price,
      required this.isWishlist,
      required this.showPrice,
      required this.ribbon,
      required this.images,
      required this.moq,
      required this.showPriceRange,
      required this.metafields,
      required this.wishlistCollection,
      required this.variants,
      required this.options,
      required this.sTypename});

  ProductCollectionListVM.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    imageUrl = json['imageUrl'];
    type = json['type'];
    wishlistCollection = json['wishlistCollection'];
    isWishlist = json['isWishlist'];
    moq = json['moq'];
    vendor = json['vendor'];
    showPrice = json['showPrice'];
    showPriceRange = json['showPriceRange'];
    availableForSale = json['availableForSale'];
    price = json['price'] != null
        ? new CollectionProductPrice.fromJson(json['price'])
        : null;
    ribbon = json['ribbon'] != null
        ? new CollectionRibbonVM.fromJson(json['ribbon'])
        : null;
    if (json['options'] != null) {
      options = <CollectionProductOptions>[];
      json['options'].forEach((v) {
        options!.add(new CollectionProductOptions.fromJson(v));
      });
    }
    metafields = <ProductMetafieldsVM>[];
    if (json['metafields'] != null) {
      json['metafields'].forEach((v) {
        metafields!.add(new ProductMetafieldsVM.fromJson(v));
      });
    }
    images = <ProductImagesVM>[];
    if (json['images'] != null) {
      json['images'].forEach((v) {
        images!.add(new ProductImagesVM.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      variants = <CollectionProductVariants>[];
      json['variants'].forEach((v) {
        variants!.add(new CollectionProductVariants.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productName'] = this.productName;
    data['vendor'] = this.vendor;
    data['type'] = this.type;
    data['wishlistCollection'] = this.wishlistCollection;
    data['isWishlist'] = this.isWishlist;
    data['showPrice'] = this.showPrice;
    data['moq'] = this.moq;
    data['showPriceRange'] = this.showPriceRange;
    data['imageUrl'] = this.imageUrl;
    data['availableForSale'] = this.availableForSale;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.ribbon != null) {
      data['ribbon'] = this.ribbon!.toJson();
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

class bannerList {
  late final String? sId;
  late final String? type;
  late final String? image;
  late final String? imageId;

  bannerList({
    required this.sId,
    required this.type,
    required this.image,
    required this.imageId,
  });

  bannerList.fromJson(Map<String, dynamic> json) {
    // print("banner --->>> $json");
    sId = json['_id'];
    type = json['type'];
    image = json['image'];
    imageId = json['imageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['type'] = type;
    data['image'] = image;
    data['imageId'] = imageId;
    return data;
  }
}

class CollectionRibbonVM {
  late final String? name;
  late final String? colorCode;

  CollectionRibbonVM({required this.name, required this.colorCode});

  CollectionRibbonVM.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? null;
    colorCode = json['colorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['colorCode'] = this.colorCode;
    data['name'] = this.name;
    return data;
  }
}

class CollectionProductVariants {
  late final String? sId;
  late final String? title;
  late final bool? availableForSale;
  late final String? sTypename;

  CollectionProductVariants({
    required this.title,
    required this.sId,
    required this.availableForSale,
    required this.sTypename,
  });

  CollectionProductVariants.fromJson(dynamic json) {
    sId = json['id'];
    title = json['title'];
    availableForSale = json['availableForSale'];
    sTypename = json['sTypename'];
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

class CollectionProductOptions {
  late final String? sId;
  late final String? name;
  late final List<CollectionProductionOptionsValue> values;
  late final String? sTypename;

  CollectionProductOptions({
    required this.name,
    required this.sId,
    required this.values,
    required this.sTypename,
  });

  CollectionProductOptions.fromJson(dynamic json) {
    sId = json['_id'];
    if (json['values'] != null) {
      values = <CollectionProductionOptionsValue>[];
      json['values'].forEach((v) {
        values.add(CollectionProductionOptionsValue.fromJson(v));
      });
    }
    name = json['name'];
    sTypename = json['sTypename'];
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

class CollectionProductionOptionsValue {
  late final String? name;

  CollectionProductionOptionsValue({
    required this.name,
  });

  CollectionProductionOptionsValue.fromJson(dynamic json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class CollectionProductPrice {
  late final num? mrp;
  late final num? sellingPrice;
  late final String? currencySymbol;
  late final num? minPrice;
  late final num? maxPrice;
  late final String? sTypename;

  CollectionProductPrice(
      {required this.mrp,
      required this.minPrice,
      required this.maxPrice,
      required this.currencySymbol,
      required this.sTypename});

  CollectionProductPrice.fromJson(dynamic json) {
    sellingPrice = json['sellingPrice'] != null ? json['sellingPrice'] : 0;
    mrp = json['mrp'] != null ? json['mrp'] : 0;
    minPrice = json['minPrice'] != null ? json['minPrice'] : 0;
    maxPrice = json['maxPrice'] != null ? json['maxPrice'] : 0;
    sTypename = json['sTypename'];
    currencySymbol = json['currencySymbol'];
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

List<CartOptions> cartProductFromJson(dynamic str) =>
    (List<CartOptions>.from(str.map((x) => CartOptions.fromJson(x))));

class CartOptions {
  late String? sId;
  late String? name;
  late List<CartOptionsValue> values;

  CartOptions({
    required this.name,
    required this.sId,
    required this.values,
  });

  CartOptions.fromJson(dynamic json) {
    sId = json.sId;
    if (json.values != null) {
      values = <CartOptionsValue>[];
      json.values.forEach((v) {
        values.add(CartOptionsValue.fromJson(v));
      });
    }
    name = json.name;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['values'] = this.values.map((v) => v.toJson()).toList();
    data['name'] = this.name;
    return data;
  }
}

class CartOptionsValue {
  late String? name;

  CartOptionsValue({
    required this.name,
  });

  CartOptionsValue.fromJson(dynamic json) {
    name = json.name;
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
    // print("jsonModelImage $json");
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

class CollectionProductPriceVM {
  late final num? sellingPrice;
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
      required this.discount,
      required this.minPrice,
      required this.maxPrice,
      required this.type,
      required this.isSamePrice,
      required this.sTypename});

  CollectionProductPriceVM.fromJson(Map<String, dynamic> json) {
    // print("jsonModelPrice $json");
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

// CollectionAttributeVM collectionAttributeVMMFromJson(dynamic str) =>
//     (CollectionAttributeVM.fromJson(str));

CollectionAttributeVM collectionAttributeVMFromJson(dynamic str) =>
    (CollectionAttributeVM.fromJson(str.toJson()));

class CollectionAttributeVM {
  late final List<AttributeListVM>? attribute;
  late final String? sTypename;

  CollectionAttributeVM({required this.attribute, required this.sTypename});

  // CollectionAttributeVM.fromJson(Map<String, dynamic> json)
  CollectionAttributeVM.fromJson(dynamic json) {
    if (json['attribute'] != null) {
      attribute = <AttributeListVM>[];
      json['attribute'].forEach((v) {
        attribute!.add(new AttributeListVM.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['attribute'] = this.attribute!.map((v) => v.toJson()).toList();
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
  late final String? filterValue;
  late final int? count;
  String? input;

  AttributeFieldValueVM({
    required this.appletName,
    required this.attributeFieldValue,
    required this.checked,
    required this.filterValue,
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
    input = json['input'] ?? null;
    filterValue = json['filterValue'] ?? null;
    // var inputData = jsonDecode(json['input']);
    // // print("value json ${inputData}");
    // input = (json['input'] != null ? new InputValue.fromJson(inputData) : null);
    // input =
    //     json['input'] != null ? new InputValue.fromJson(json['input']) : null;
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

class ProductSizeOptions {
  late final String? name;
  bool? isAvailable;

  ProductSizeOptions({required this.name, required this.isAvailable});

  ProductSizeOptions.fromJson(dynamic json) {
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
