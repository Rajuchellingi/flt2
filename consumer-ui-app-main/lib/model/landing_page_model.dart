List<PromotionProductsVM> productPromotionFromJson(dynamic str) =>
    List<PromotionProductsVM>.from(
        str.map((x) => PromotionProductsVM.fromJson(x)));

class ProductPromotionVM {
  late final List<PromotionProductsVM>? products;
  late final String? collectionId;
  late final String? sTypename;

  ProductPromotionVM(
      {required this.products,
      required this.collectionId,
      required this.sTypename});

  ProductPromotionVM.fromJson(dynamic json) {
    if (json.products != null) {
      products = <PromotionProductsVM>[];
      json.products.forEach((v) {
        products!.add(new PromotionProductsVM.fromJson(v));
      });
    }
    collectionId = json.collectionId;
    sTypename = json.sTypename;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['collectionId'] = this.collectionId;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class PromotionProductsVM {
  late final String? sId;
  late final String? productName;
  late final String? producturl;
  late final String? imageUrl;
  late final String? type;
  late final String? vendor;
  late final List<String>? wishlistCollection;
  late final bool? isWishlist;
  late final bool? showPrice;
  late final bool? showPriceRange;
  late final bool? showUnits;
  late final String? units;
  late final int? moq;
  late final bool? availableForSale;
  late final ProductRibbonVM? ribbon;
  late final PromotionProductPriceVM? price;
  late final List<ProductMetafieldsVM>? metafields;
  late final List<ProductImagesVM>? images;
  late final List<PromotionProductOptionsVM>? options;
  late final List<PromotionProductVariantsVM>? variants;
  late final String? sTypename;

  PromotionProductsVM(
      {required this.sId,
      required this.productName,
      required this.producturl,
      required this.imageUrl,
      required this.moq,
      required this.availableForSale,
      required this.type,
      required this.vendor,
      required this.price,
      required this.isWishlist,
      required this.images,
      required this.showPrice,
      required this.showUnits,
      required this.units,
      required this.ribbon,
      required this.showPriceRange,
      required this.wishlistCollection,
      required this.metafields,
      required this.variants,
      required this.options,
      required this.sTypename});

  PromotionProductsVM.fromJson(dynamic json) {
    sId = json.sId;
    productName = json.productName;
    producturl = json.producturl;
    imageUrl = json.imageUrl;
    vendor = json.vendor;
    type = json.type;
    availableForSale = json.availableForSale;
    moq = json.moq;
    isWishlist = json.isWishlist;
    showUnits = json.showUnits;
    units = json.units;
    showPrice = json.showPrice;
    showPriceRange = json.showPriceRange;
    wishlistCollection = json.wishlistCollection;
    price = json.price != null
        ? new PromotionProductPriceVM.fromJson(json.price)
        : null;
    ribbon =
        json.ribbon != null ? new ProductRibbonVM.fromJson(json.ribbon) : null;
    if (json.options != null) {
      options = <PromotionProductOptionsVM>[];
      json.options.forEach((v) {
        options!.add(new PromotionProductOptionsVM.fromJson(v));
      });
    }
    if (json.variants != null) {
      variants = <PromotionProductVariantsVM>[];
      json.variants.forEach((v) {
        variants!.add(new PromotionProductVariantsVM.fromJson(v));
      });
    }
    metafields = <ProductMetafieldsVM>[];
    if (json.metafields != null) {
      json.metafields.forEach((v) {
        metafields!.add(new ProductMetafieldsVM.fromJson(v));
      });
    }
    images = <ProductImagesVM>[];
    if (json.images != null) {
      json.images.forEach((v) {
        images!.add(new ProductImagesVM.fromJson(v));
      });
    }
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productName'] = this.productName;
    data['producturl'] = this.producturl;
    data['type'] = this.type;
    data['wishlistCollection'] = this.wishlistCollection;
    data['isWishlist'] = this.isWishlist;
    data['showPrice'] = this.showPrice;
    data['vendor'] = this.vendor;
    data['moq'] = this.moq;
    data['showPriceRange'] = this.showPriceRange;
    data['imageUrl'] = this.imageUrl;
    data['showUnits'] = this.showUnits;
    data['units'] = this.units;
    data['availableForSale'] = this.availableForSale;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.ribbon != null) {
      data['ribbon'] = this.ribbon!.toJson();
    }
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    if (this.metafields != null) {
      data['metafields'] = this.metafields!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
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
  ProductImagesVM.fromJson(dynamic json) {
    url = json.url;
    height = json.height;
    width = json.width;
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

  ProductMetafieldsVM.fromJson(dynamic json) {
    type = json.type;
    value = json.value;
    key = json.key;
    namespace = json.namespace;
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

class ProductRibbonVM {
  late final String? name;
  late final String? colorCode;

  ProductRibbonVM({required this.name, required this.colorCode});

  ProductRibbonVM.fromJson(dynamic json) {
    name = json.name;
    colorCode = json.colorCode;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['colorCode'] = this.colorCode;
    data['name'] = this.name;
    return data;
  }
}

class PromotionProductVariantsVM {
  late final String? sId;
  late final String? title;
  late final bool? availableForSale;
  late final String? sTypename;

  PromotionProductVariantsVM({
    required this.title,
    required this.sId,
    required this.availableForSale,
    required this.sTypename,
  });

  PromotionProductVariantsVM.fromJson(dynamic json) {
    sId = json.sId;
    title = json.title;
    availableForSale = json.availableForSale;
    sTypename = json.sTypename;
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

class PromotionProductOptionsVM {
  late final String? sId;
  late final String? name;
  late final List<PromotionProductOptionsValueVM> values;
  late final String? sTypename;

  PromotionProductOptionsVM({
    required this.name,
    required this.sId,
    required this.values,
    required this.sTypename,
  });

  PromotionProductOptionsVM.fromJson(dynamic json) {
    sId = json.sId;
    if (json.values != null) {
      values = <PromotionProductOptionsValueVM>[];
      json.values.forEach((v) {
        values.add(PromotionProductOptionsValueVM.fromJson(v));
      });
    }
    name = json.name;
    sTypename = json.sTypename;
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

class PromotionProductOptionsValueVM {
  late final String? name;

  PromotionProductOptionsValueVM({
    required this.name,
  });

  PromotionProductOptionsValueVM.fromJson(dynamic json) {
    name = json.name;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class PromotionProductPriceVM {
  late final num? mrp;
  late final num? sellingPrice;
  late final String? currencySymbol;
  late final num? minPrice;
  late final num? maxPrice;
  late final String? sTypename;

  PromotionProductPriceVM(
      {required this.mrp,
      required this.minPrice,
      required this.maxPrice,
      required this.currencySymbol,
      required this.sTypename});

  PromotionProductPriceVM.fromJson(dynamic json) {
    sellingPrice = json.sellingPrice != null ? json.sellingPrice : 0;
    mrp = json.mrp != null ? json.mrp : 0;
    minPrice = json.minPrice != null ? json.minPrice : 0;
    maxPrice = json.maxPrice != null ? json.maxPrice : 0;
    sTypename = json.sTypename;
    currencySymbol = json.currencySymbol;
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

GetMetaValueForDownloadVM getMetaValueForDownloadVMFromJson(dynamic str) =>
    GetMetaValueForDownloadVM.fromJson(str.toJson());

class GetMetaValueForDownloadVM {
  late final bool error;
  late final String message;
  late final List<DownloadFileData> data;

  GetMetaValueForDownloadVM({
    required this.error,
    required this.message,
    required this.data,
  });

  GetMetaValueForDownloadVM.fromJson(Map<String, dynamic> json) {
    print("json data--->> GetMetaValueForDownload $json");
    error = json['error'] ?? false;
    message = json['message'] ?? "";
    data = (json['data'] as List<dynamic>?)
            ?.map((e) => DownloadFileData.fromJson(e))
            .toList() ??
        [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['error'] = error;
    dataMap['message'] = message;
    dataMap['data'] = data.map((e) => e.toJson()).toList();
    return dataMap;
  }
}

class DownloadFileData {
  late final String fileUrl;
  late final String fileName;

  DownloadFileData({
    required this.fileUrl,
    required this.fileName,
  });

  DownloadFileData.fromJson(Map<String, dynamic> json) {
    fileUrl = json['fileUrl'] ?? "";
    fileName = json['fileName'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['fileUrl'] = fileUrl;
    dataMap['fileName'] = fileName;
    return dataMap;
  }
}
