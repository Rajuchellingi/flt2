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
  late final List<AttributeListVM>? filters;
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
        filters?.add(new AttributeListVM.fromJson(v));
      });
    } else {
      filters = [];
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
    data['filters'] = this.filters?.map((v) => v.toJson()).toList();
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
  late final String? producturl;
  late final String? imageUrl;
  late final String? type;
  late final String? vendor;
  late final List<String>? wishlistCollection;
  late final bool? isWishlist;
  late final bool? showPrice;
  late final bool? showUnits;
  late final String? units;
  late final int? moq;
  late final bool? showPriceRange;
  late final bool? availableForSale;
  late final CollectionProductPrice? price;
  late final CollectionRibbonVM? ribbon;
  late final List<CollectionProductOptions>? options;
  late final List<CollectionProductVariants>? variants;
  late final String? sTypename;

  ProductCollectionListVM(
      {required this.sId,
      required this.productName,
      required this.producturl,
      required this.imageUrl,
      required this.availableForSale,
      required this.type,
      required this.vendor,
      required this.price,
      required this.isWishlist,
      required this.showUnits,
      required this.units,
      required this.showPrice,
      required this.ribbon,
      required this.moq,
      required this.showPriceRange,
      required this.wishlistCollection,
      required this.variants,
      required this.options,
      required this.sTypename});

  ProductCollectionListVM.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    producturl = json['url'];
    imageUrl = json['imageUrl'];
    type = json['type'];
    wishlistCollection = json['wishlistCollection'];
    isWishlist = json['isWishlist'];
    showUnits = json['showUnits'];
    units = json['units'];
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
    data['url'] = this.producturl;
    data['vendor'] = this.vendor;
    data['type'] = this.type;
    data['wishlistCollection'] = this.wishlistCollection;
    data['isWishlist'] = this.isWishlist;
    data['showUnits'] = this.showUnits;
    data['units'] = this.units;
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
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
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

GetProductFiltersVM getProductFiltersVMFromJson(dynamic str) =>
    (GetProductFiltersVM.fromJson(str.toJson()));

class GetProductFiltersVM {
  late final List<AttributeListVM>? filters;

  GetProductFiltersVM({
    required this.filters,
  });

  GetProductFiltersVM.fromJson(Map<String, dynamic> json) {
    // print("data 123 --->>> $json");

    // print("json['filters'] ${json['filters']}");
    if (json['filter'] != null) {
      filters = <AttributeListVM>[];
      json['filter'].forEach((v) {
        filters?.add(new AttributeListVM.fromJson(v));
      });
    } else {
      filters = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filter'] = this.filters?.map((v) => v.toJson()).toList();

    return data;
  }
}

BrandProductCollection getProductsByBrandForUIV1VMFromJson(dynamic str) =>
    (BrandProductCollection.fromJson(str.toJson()));

class BrandProductCollection {
  late final String? sTypename;
  late final bool? error;
  late final String? message;
  late final BrandProductCollectionList? collection;
  late final Brand? brand;

  BrandProductCollection({
    required this.sTypename,
    required this.error,
    required this.message,
    this.collection,
    this.brand,
  });

  BrandProductCollection.fromJson(Map<String, dynamic> json) {
    // print("json data--->>getProductsByBrandForUIV1VM ${json}");
    sTypename = json["__typename"];
    error = json["error"];
    message = json["message"];
    collection = json["collection"] != null
        ? BrandProductCollectionList.fromJson(json["collection"])
        : null;
    brand = json["brand"] != null ? Brand.fromJson(json["brand"]) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['__typename'] = sTypename;
    data['error'] = error;
    data['message'] = message;
    if (collection != null) {
      data['collection'] = collection!.toJson();
    }
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    return data;
  }
}

class BrandProductCollectionList {
  late final String? collectionName;
  late final String? collectionId;
  late final List<Banner>? banners;
  late final int? count;
  late final int? totalPages;
  late final List<BrandProduct>? product;
  late final List<SeoTag>? seo;
  late final List<BrandSortSetting>? sortSetting;
  late final bool? showDownloadCatalog;
  late final String? downloadCatalogButtonName;
  late final String? collectionCatalog;
  late final String? paginationType;
  late final bool? showVariantInList;

  BrandProductCollectionList({
    this.collectionName,
    this.collectionId,
    this.banners,
    this.count,
    this.totalPages,
    this.product,
    this.seo,
    this.sortSetting,
    this.showDownloadCatalog,
    this.downloadCatalogButtonName,
    this.collectionCatalog,
    this.paginationType,
    this.showVariantInList,
  });

  BrandProductCollectionList.fromJson(Map<String, dynamic> json) {
    // print("json data--->>BrandProductCollectionList ${json}");
    collectionName = json["collectionName"];
    collectionId = json["collectionId"];
    banners = json["banners"] != null
        ? List.from(json["banners"]).map((e) => Banner.fromJson(e)).toList()
        : null;
    count = json["count"];
    totalPages = json["totalPages"];
    product = json["products"] != null
        ? List.from(json["products"])
            .map((e) => BrandProduct.fromJson(e))
            .toList()
        : null;
    seo = json["seo"] != null
        ? List.from(json["seo"]).map((e) => SeoTag.fromJson(e)).toList()
        : null;
    sortSetting = json["sortSetting"] != null
        ? List.from(json["sortSetting"])
            .map((e) => BrandSortSetting.fromJson(e))
            .toList()
        : null;
    showDownloadCatalog = json["showDownloadCatalog"];
    downloadCatalogButtonName = json["downloadCatalogButtonName"];
    collectionCatalog = json["collectionCatalog"];
    paginationType = json["paginationType"];
    showVariantInList = json["showVariantInList"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['collectionName'] = collectionName;
    data['collectionId'] = collectionId;
    if (banners != null) {
      data['banners'] = banners!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    data['totalPages'] = totalPages;
    if (product != null) {
      data['products'] = product!.map((v) => v.toJson()).toList();
    }
    if (seo != null) {
      data['seo'] = seo!.map((v) => v.toJson()).toList();
    }
    if (sortSetting != null) {
      data['sortSetting'] = sortSetting!.map((v) => v.toJson()).toList();
    }
    data['showDownloadCatalog'] = showDownloadCatalog;
    data['downloadCatalogButtonName'] = downloadCatalogButtonName;
    data['collectionCatalog'] = collectionCatalog;
    data['paginationType'] = paginationType;
    data['showVariantInList'] = showVariantInList;
    return data;
  }
}

class BrandProduct {
  late final String? sId;
  late final String? productName;
  late final String? producturl;
  late final String? type;
  late final int? moq;
  late final String? shortDescription;
  late final String? units;
  late final bool? showUnits;
  late final String? discountDisplayType;
  late final ProductImage? image;
  late final bool? showPrice;
  late final bool? showPriceRange;
  late final bool? showWishlist;
  late final ProductPrice? price;
  late final List<dynamic>? wishlistCollection;
  late final bool? isWishlist;
  late final List<PreferenceVariant>? preferenceVariant;

  BrandProduct({
    this.sId,
    this.productName,
    this.producturl,
    this.type,
    this.moq,
    this.shortDescription,
    this.units,
    this.showUnits,
    this.discountDisplayType,
    this.image,
    this.showPrice,
    this.showPriceRange,
    this.showWishlist,
    this.price,
    this.wishlistCollection,
    this.isWishlist,
    this.preferenceVariant,
  });

  BrandProduct.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    productName = json["productName"];
    producturl = json["url"];
    type = json["type"];
    moq = json["moq"];
    shortDescription = json["shortDescription"];
    units = json["units"];
    showUnits = json["showUnits"];
    discountDisplayType = json["discountDisplayType"];
    image = json["image"] != null ? ProductImage.fromJson(json["image"]) : null;
    showPrice = json["showPrice"];
    showPriceRange = json["showPriceRange"];
    showWishlist = json["showWishlist"];
    price = json["price"] != null ? ProductPrice.fromJson(json["price"]) : null;
    wishlistCollection = json["wishlistCollection"];
    isWishlist = json["isWishlist"];
    preferenceVariant = json["preferenceVariant"] != null
        ? List.from(json["preferenceVariant"])
            .map((e) => PreferenceVariant.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['productName'] = productName;
    data['url'] = producturl;
    data['type'] = type;
    data['moq'] = moq;
    data['shortDescription'] = shortDescription;
    data['units'] = units;
    data['showUnits'] = showUnits;
    data['discountDisplayType'] = discountDisplayType;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['showPrice'] = showPrice;
    data['showPriceRange'] = showPriceRange;
    data['showWishlist'] = showWishlist;
    if (price != null) {
      data['price'] = price!.toJson();
    }
    data['wishlistCollection'] = wishlistCollection;
    data['isWishlist'] = isWishlist;
    if (preferenceVariant != null) {
      data['preferenceVariant'] =
          preferenceVariant!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductImage {
  late final String? imageId;
  late final String? imageName;
  late final int? sortOrder;
  late final String? id;

  ProductImage({
    this.imageId,
    this.imageName,
    this.sortOrder,
    this.id,
  });

  ProductImage.fromJson(Map<String, dynamic> json) {
    imageId = json["imageId"];
    imageName = json["imageName"];
    sortOrder = json["sortOrder"];
    id = json["_id"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['imageId'] = imageId;
    data['imageName'] = imageName;
    data['sortOrder'] = sortOrder;
    data['_id'] = id;
    return data;
  }
}

class ProductPrice {
  late final String? currencySymbol;
  late final String? sellingPrice;
  late final int? discount;

  ProductPrice({
    this.currencySymbol,
    this.sellingPrice,
    this.discount,
  });

  ProductPrice.fromJson(Map<String, dynamic> json) {
    currencySymbol = json["currencySymbol"];
    sellingPrice = json["sellingPrice"];
    discount = json["discount"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['currencySymbol'] = currencySymbol;
    data['sellingPrice'] = sellingPrice;
    data['discount'] = discount;
    return data;
  }
}

class PreferenceVariant {
  late final String? attributeFieldName;
  late final String? attributeFieldId;
  late final String? attributeFieldType;
  late final String? attributeLabelName;
  late final String? attributeFieldSetting;
  late final String? id;
  late final List<VariantValue>? values;

  PreferenceVariant({
    this.attributeFieldName,
    this.attributeFieldId,
    this.attributeFieldType,
    this.attributeLabelName,
    this.attributeFieldSetting,
    this.id,
    this.values,
  });

  PreferenceVariant.fromJson(Map<String, dynamic> json) {
    attributeFieldName = json["attributeFieldName"];
    attributeFieldId = json["attributeFieldId"];
    attributeFieldType = json["attributeFieldType"];
    attributeLabelName = json["attributeLabelName"];
    attributeFieldSetting = json["attributeFieldSetting"];
    id = json["_id"];
    values = json["values"] != null
        ? List.from(json["values"])
            .map((e) => VariantValue.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['attributeFieldName'] = attributeFieldName;
    data['attributeFieldId'] = attributeFieldId;
    data['attributeFieldType'] = attributeFieldType;
    data['attributeLabelName'] = attributeLabelName;
    data['attributeFieldSetting'] = attributeFieldSetting;
    data['_id'] = id;
    if (values != null) {
      data['values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VariantValue {
  late final String? value;
  late final String? colorCode;
  late final ProductImage? image;
  late final int? sortOrder;
  late final String? id;

  VariantValue({
    this.value,
    this.colorCode,
    this.image,
    this.sortOrder,
    this.id,
  });

  VariantValue.fromJson(Map<String, dynamic> json) {
    value = json["value"];
    colorCode = json["colorCode"];
    image = json["image"] != null ? ProductImage.fromJson(json["image"]) : null;
    sortOrder = json["sortOrder"];
    id = json["_id"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    data['colorCode'] = colorCode;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['sortOrder'] = sortOrder;
    data['_id'] = id;
    return data;
  }
}

class Brand {
  late final String? id;
  late final String? createdDate;
  late final List<BrandCollection>? collections;
  late final List<BrandBanner>? banners;
  late final String? brandName;
  late final String? brandDescription;
  late final int? sortOrder;
  late final String? link;
  late final String? clientId;
  late final int? v;
  late final bool? brandStatus;
  late final String? modifiedDate;
  late final List<Metafield>? metafields;

  Brand({
    this.id,
    this.createdDate,
    this.collections,
    this.banners,
    this.brandName,
    this.brandDescription,
    this.sortOrder,
    this.link,
    this.clientId,
    this.v,
    this.brandStatus,
    this.modifiedDate,
    this.metafields,
  });

  Brand.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    createdDate = json["createdDate"];
    collections = json["collections"] != null
        ? List.from(json["collections"])
            .map((e) => BrandCollection.fromJson(e))
            .toList()
        : null;
    banners = json["banners"] != null
        ? List.from(json["banners"])
            .map((e) => BrandBanner.fromJson(e))
            .toList()
        : null;
    brandName = json["brandName"];
    brandDescription = json["brandDescription"];
    sortOrder = json["sortOrder"];
    link = json["link"];
    clientId = json["clientId"];
    v = json["__v"];
    brandStatus = json["brandStatus"];
    modifiedDate = json["modifiedDate"];
    metafields = json["metafields"] != null
        ? List.from(json["metafields"])
            .map((e) => Metafield.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['createdDate'] = createdDate;
    if (collections != null) {
      data['collections'] = collections!.map((v) => v.toJson()).toList();
    }
    if (banners != null) {
      data['banners'] = banners!.map((v) => v.toJson()).toList();
    }
    data['brandName'] = brandName;
    data['brandDescription'] = brandDescription;
    data['sortOrder'] = sortOrder;
    data['link'] = link;
    data['clientId'] = clientId;
    data['__v'] = v;
    data['brandStatus'] = brandStatus;
    data['modifiedDate'] = modifiedDate;
    if (metafields != null) {
      data['metafields'] = metafields!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrandCollection {
  late final String? collectionId;
  late final String? collectionName;
  late final int? sortOrder;
  late final bool? enable;
  late final String? id;

  BrandCollection({
    this.collectionId,
    this.collectionName,
    this.sortOrder,
    this.enable,
    this.id,
  });

  BrandCollection.fromJson(Map<String, dynamic> json) {
    collectionId = json["collectionId"];
    collectionName = json["collectionName"];
    sortOrder = json["sortOrder"];
    enable = json["enable"];
    id = json["_id"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['collectionId'] = collectionId;
    data['collectionName'] = collectionName;
    data['sortOrder'] = sortOrder;
    data['enable'] = enable;
    data['_id'] = id;
    return data;
  }
}

class BrandBanner {
  late final String? type;
  late final String? image;
  late final String? imageId;
  late final String? id;

  BrandBanner({
    this.type,
    this.image,
    this.imageId,
    this.id,
  });

  BrandBanner.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    image = json["image"];
    imageId = json["imageId"];
    id = json["_id"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['image'] = image;
    data['imageId'] = imageId;
    data['_id'] = id;
    return data;
  }
}

class Banner {
  late final String? type;
  late final String? image;
  late final String? imageId;
  late final String? id;

  Banner({
    this.type,
    this.image,
    this.imageId,
    this.id,
  });

  Banner.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    image = json["image"];
    imageId = json["imageId"];
    id = json["_id"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['image'] = image;
    data['imageId'] = imageId;
    data['_id'] = id;
    return data;
  }
}

class SeoTag {
  late final String? attribute;
  late final String? value;
  late final String? content;

  SeoTag({
    this.attribute,
    this.value,
    this.content,
  });

  SeoTag.fromJson(Map<String, dynamic> json) {
    attribute = json["attribute"];
    value = json["value"];
    content = json["content"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['attribute'] = attribute;
    data['value'] = value;
    data['content'] = content;
    return data;
  }
}

class BrandSortSetting {
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

  BrandSortSetting({
    this.sId,
    this.status,
    this.isDefault,
    this.creationDate,
    this.clientId,
    this.name,
    this.type,
    this.tagId,
    this.sortOrder,
    this.v,
  });

  BrandSortSetting.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    status = json["status"];
    isDefault = json["isDefault"];
    creationDate = json["creationDate"];
    clientId = json["clientId"];
    name = json["name"];
    type = json["type"];
    tagId = json["tagId"];
    sortOrder = json["sortOrder"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
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

class Metafield {
  late final String? customDataId;
  late final String? definition;
  late final String? namespace;
  late final String? key;
  late final String? customDatatype;
  late final String? customDataValueType;
  late final MetafieldReference? reference;
  late final String? id;

  Metafield({
    this.customDataId,
    this.definition,
    this.namespace,
    this.key,
    this.customDatatype,
    this.customDataValueType,
    this.reference,
    this.id,
  });

  Metafield.fromJson(Map<String, dynamic> json) {
    customDataId = json["customDataId"];
    definition = json["definition"];
    namespace = json["namespace"];
    key = json["key"];
    customDatatype = json["customDatatype"];
    customDataValueType = json["customDataValueType"];
    reference = json["reference"] != null
        ? MetafieldReference.fromJson(json["reference"])
        : null;
    id = json["_id"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['customDataId'] = customDataId;
    data['definition'] = definition;
    data['namespace'] = namespace;
    data['key'] = key;
    data['customDatatype'] = customDatatype;
    data['customDataValueType'] = customDataValueType;
    if (reference != null) {
      data['reference'] = reference!.toJson();
    }
    data['_id'] = id;
    return data;
  }
}

class MetafieldReference {
  late final MetafieldFile? file;
  late final String? id;

  MetafieldReference({
    this.file,
    this.id,
  });

  MetafieldReference.fromJson(Map<String, dynamic> json) {
    file = json["file"] != null ? MetafieldFile.fromJson(json["file"]) : null;
    id = json["_id"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (file != null) {
      data['file'] = file!.toJson();
    }
    data['_id'] = id;
    return data;
  }
}

class MetafieldFile {
  late final String? fileName;
  late final String? fileUrl;
  late final String? fileType;
  late final String? id;

  MetafieldFile({
    this.fileName,
    this.fileUrl,
    this.fileType,
    this.id,
  });

  MetafieldFile.fromJson(Map<String, dynamic> json) {
    fileName = json["fileName"];
    fileUrl = json["fileUrl"];
    fileType = json["fileType"];
    id = json["_id"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fileName'] = fileName;
    data['fileUrl'] = fileUrl;
    data['fileType'] = fileType;
    data['_id'] = id;
    return data;
  }
}
