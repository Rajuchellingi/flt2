import 'package:black_locust/config/configConstant.dart';

List<AllWishlistVMModel> allWishListVMFromJson(dynamic str) =>
    List<AllWishlistVMModel>.from(
        str.map((x) => AllWishlistVMModel.fromJson(x)));

class AllWishlistVMModel {
  late String sId;
  late final String? packId;
  late final String? setId;
  late final String? productId;
  late final String? packImage;
  late final String? packName;
  late final int? setPrice;
  late final String? sTypename;

  AllWishlistVMModel(
      {required this.sId,
      required this.packId,
      required this.setId,
      required this.productId,
      required this.packImage,
      required this.packName,
      required this.setPrice,
      required this.sTypename});

  AllWishlistVMModel.fromJson(dynamic json) {
    sId = json.sId;
    packId = json.packId;
    setId = json.setId;
    productId = json.productId;
    packImage = json.packImage;
    packName = json.packName;
    setPrice = json.setPrice;
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sId'] = this.sId;
    data['packId'] = this.packId;
    data['setId'] = this.setId;
    data['productId'] = this.productId;
    data['packImage'] = this.packImage;
    data['packName'] = this.packName;
    data['setPrice'] = this.setPrice;
    data['sTypename'] = this.sTypename;
    return data;
  }
}

List<WishlistProductDetailVM> wishlistProductDetailVMFromJson(dynamic str) =>
    List<WishlistProductDetailVM>.from(
        str.map((x) => WishlistProductDetailVM.fromJson(x.toJson())));
// WishlistProductDetailVM wishlistProductDetailVMFromJson(dynamic str) =>
//     (WishlistProductDetailVM.fromJson(str.toJson()));

class WishlistProductDetailVM {
  late final String sId;
  late final String? name;
  late final String? vendor;
  late final String? description;
  late final String? type;
  late final int? moq;
  late final bool? isOutofstock;
  late final bool? isMultiple;
  late final String? imageId;
  late final List<WishlistProductOptionsVM>? options;
  late final List<WishlistProductVariantsVM>? variants;
  late final String? priceType;
  late final WishlistPriceUI? price;
  late final List<WishlistImageUI>? images;

  WishlistProductDetailVM(
      {required this.sId,
      required this.name,
      required this.vendor,
      required this.description,
      required this.type,
      required this.moq,
      required this.isOutofstock,
      required this.isMultiple,
      required this.options,
      required this.variants,
      required this.imageId,
      required this.price,
      required this.priceType,
      required this.images});

  WishlistProductDetailVM.fromJson(dynamic json) {
    sId = json['id'];
    name = json['name'];
    vendor = json['vendor'];
    description = json['description'];
    type = json['type'];
    moq = json['moq'];
    isOutofstock = json['isOutofstock'];
    isMultiple = json['isMultiple'];
    // priceType = json['priceType'];
    imageId = json['imageId'];
    // price = WishlistPriceUI.fromJson(json.price);
    // images = WishlistImageUIFromJson(json.images);
    // if (json['featuredImage'] != null) {
    //   images = <WishlistImageUI>[];
    //   images!.add(new WishlistImageUI.fromJson(json['featuredImage']));
    // }
    if (json['featuredImage'] != null) {
      images = <WishlistImageUI>[];
      json['featuredImage'].forEach((v) {
        images!.add(new WishlistImageUI.fromJson(v));
      });
    }
    if (json['options'] != null) {
      options = <WishlistProductOptionsVM>[];
      json['options'].forEach((v) {
        options!.add(new WishlistProductOptionsVM.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      variants = <WishlistProductVariantsVM>[];
      json['variants'].forEach((v) {
        variants!.add(new WishlistProductVariantsVM.fromJson(v));
      });
    }
    price = json['priceType'] != null
        ? new WishlistPriceUI.fromJson(json['priceType'])
        : null;
    // price = json['priceRange'] != null
    //     ? new WishlistPriceUI.fromJson(json['priceRange'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['vendor'] = this.vendor;
    data['type'] = this.type;
    data['moq'] = this.moq;
    data['isOutofstock'] = this.isOutofstock;
    data['isMultiple'] = this.isMultiple;
    // data['priceType'] = this.priceType;
    data['imageId'] = this.imageId;
    data['priceType'] = this.price;
    data['featuredImage'] = this.images;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishlistProductOptionsVM {
  late final String? sId;
  late final String? name;
  late final List<WishlistProductOptionsValueVM> values;
  late final String? sTypename;

  WishlistProductOptionsVM({
    required this.name,
    required this.sId,
    required this.values,
    required this.sTypename,
  });

  WishlistProductOptionsVM.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    if (json['values'] != null) {
      values = <WishlistProductOptionsValueVM>[];
      json['values'].forEach((v) {
        values.add(WishlistProductOptionsValueVM.fromJson(v));
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

class WishlistProductOptionsValueVM {
  late final String? name;

  WishlistProductOptionsValueVM({
    required this.name,
  });

  WishlistProductOptionsValueVM.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class WishlistProductVariantsVM {
  late final String? sId;
  late final String? title;
  late final bool? availableForSale;
  late final String? sTypename;

  WishlistProductVariantsVM({
    required this.title,
    required this.sId,
    required this.availableForSale,
    required this.sTypename,
  });

  WishlistProductVariantsVM.fromJson(Map<String, dynamic> json) {
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

class WishlistImageUI {
  late final String? imageName;
  late final int? position;

  WishlistImageUI({required this.imageName, required this.position});
  WishlistImageUI.fromJson(dynamic json) {
    imageName = json['imageName'];
    position = json['position'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageName'] = this.imageName;
    data['position'] = this.position;
    return data;
  }
}

class WishlistPriceUI {
  late final num? sellingPrice;
  late final num? mrp;
  late final num? discount;
  late final num? minPrice;
  late final num? maxPrice;
  late final String? type;
  late final bool? isSamePrice;
  WishlistPriceUI(
      {required this.sellingPrice,
      required this.mrp,
      required this.discount,
      required this.minPrice,
      required this.maxPrice,
      required this.type,
      required this.isSamePrice});
  WishlistPriceUI.fromJson(dynamic json) {
    sellingPrice = json['sellingPrice'];
    mrp = json['mrp'];
    discount = json['discount'];
    minPrice = json['minPrice'];
    maxPrice = json['maxPrice'];
    type = json['type'];
    isSamePrice = json['isSamePrice'];
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
    return data;
  }
}

List<WishlistCollectionVM> wishlistCollectionVMFromJson(dynamic str) =>
    List<WishlistCollectionVM>.from(
        str.map((x) => WishlistCollectionVM.fromJson(x)));

class WishlistCollectionVM {
  late final String? sId;
  late final String? name;
  late final bool? isDefault;

  WishlistCollectionVM({
    required this.sId,
    required this.name,
    required this.isDefault,
  });

  WishlistCollectionVM.fromJson(dynamic json) {
    sId = json.sId;
    name = json.name;
    isDefault = json.isDefault;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['isDefault'] = this.isDefault;
    return data;
  }
}

WiseListCollection wishListCollectionListVMFromJson(dynamic str) =>
    (WiseListCollection.fromJson(str.toJson()));

class WiseListCollection {
  late final List<WishListPopupCollectionList> product;
  WiseListCollection({
    required this.product,
  });

  WiseListCollection.fromJson(Map<String, dynamic> json) {
    // print("toJson WiseListCollection--->>> ${json}");
    if (json["collection"] != null) {
      product = <WishListPopupCollectionList>[];
      json["collection"].forEach((v) {
        product.add(new WishListPopupCollectionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collection'] = this.product.map((v) => v.toJson()).toList();
    return data;
  }
}

class WishListPopupCollectionList {
  late final String? sId;
  late final String? name;
  late final bool? isDefault;

  WishListPopupCollectionList({
    required this.sId,
    required this.name,
    required this.isDefault,
  });

  WishListPopupCollectionList.fromJson(Map<String, dynamic> json) {
    // print("toJson WishListPopupCollectionList--->>123 $json");
    sId = json['_id'];
    name = json['name'];
    isDefault = json['isDefault'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['isDefault'] = this.isDefault;
    return data;
  }
}

ProductCollectionVMM productCollectionWishlistVMFromJson(dynamic str) =>
    (ProductCollectionVMM.fromJson(str.toJson()));
// ProductCollection productCollectionWishlistVMFromJson(dynamic str) =>
//     (ProductCollection.fromJson(str));

class ProductCollectionVMM {
  late final int? currentPage;
  late final int? totalPages;
  late final int? count;
  // late final Collection? collection;
  late final List<ProductCollectionList> product;
  // late final List<AttributeList> filters;
  late final String? sTypename;
  late final String? collectionName;

  ProductCollectionVMM(
      {required this.currentPage,
      required this.totalPages,
      required this.count,
      // required this.collection,
      required this.product,
      // required this.filters,
      required this.collectionName,
      required this.sTypename});

  ProductCollectionVMM.fromJson(Map<String, dynamic> json) {
    // print("json data--->>1 ${json}");
    // print("json data--->>1 ${json['collection']["collectionName"]}");
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    count = json['count'] ?? null;
    // collection = json['collection'] != null
    //     ? new Collection.fromJson(json['collection'])
    //     : null;
    if (json['product'] != null) {
      product = <ProductCollectionList>[];
      json['product'].forEach((v) {
        product.add(new ProductCollectionList.fromJson(v));
      });
    }
    //  if (json["collection"]['filters'] != null) {
    //   filters = <AttributeList>[];
    //   json["collection"]['filters'].forEach((v) {
    //     filters.add(new AttributeList.fromJson(v));
    //   });
    // }
    collectionName = json['collectionName'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    data['count'] = this.count;
    // if (this.collection != null) {
    //   data['collection'] = this.collection!.toJson();
    // }
    data['product'] = this.product.map((v) => v.toJson()).toList();
    // data['filters'] = this.filters.map((v) => v.toJson()).toList();
    data['collectionName'] = this.collectionName;
    data['__typename'] = this.sTypename;

    return data;
  }
}

class ProductCollectionList {
  late final String? sId;
  late final String? wishlistId;
  late final String? name;
  late final String? description;
  late final String? type;
  late final String? url;
  late final int? moq;
  late final bool? isOutofstock;
  late final bool? isMultiple;
  late final bool? isCustomizable;
  late final bool? showPrice;
  late final bool? showPriceRange;
  late final String? imageId;
  late final String? priceType;
  // late final CollectionProductRibbon? ribbon;
  late final CollectionProductPrice? price;

  late final CollectionProductImage? images;

//   late final List<CollectionProductImage>? images;
  late final String? sTypename;

  ProductCollectionList(
      {required this.sId,
      required this.wishlistId,
      required this.name,
      required this.description,
      required this.type,
      required this.url,
      required this.moq,
      required this.isOutofstock,
      required this.isMultiple,
      required this.isCustomizable,
      required this.showPrice,
      required this.showPriceRange,
      required this.imageId,
      required this.priceType,
      // required this.ribbon,
      required this.price,
      required this.images,
      required this.sTypename});

  ProductCollectionList.fromJson(Map<String, dynamic> json) {
    // print("json data--->>123 $json");
    sId = json['_id'];
    wishlistId = json['wishlistId'];
    name = json['productName'];
    description = json['description'];
    type = json['type'];
    url = json['url'];
    moq = json['moq'];
    isOutofstock = json['isOutofstock'] == true ? true : false;
    isMultiple = json['isMultiple'];
    isCustomizable = json['isCustomizable'];
    showPrice = json["showPrice"];
    showPriceRange = json["showPriceRange"];
    imageId = json['imageId'];
    priceType = json['priceType'];
    price = json['price'] != null
        ? new CollectionProductPrice.fromJson(json['price'])
        : null;
    // ribbon = json['ribbon'] != null
    //     ? new CollectionProductRibbon.fromJson(json['ribbon'])
    //     : null;

    images = json['images'] != null
        ? new CollectionProductImage.fromJson(json['images'])
        : null;

    // if (json['images'] != null) {
    //   images = <CollectionProductImage>[];
    //   json['images'].forEach((v) {
    //     images!.add(new CollectionProductImage.fromJson(v));
    //   });
    // }

    sTypename = json['__typename'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sId'] = this.sId;
    data['wishlistId'] = this.wishlistId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['url'] = this.url;
    data['moq'] = this.moq;
    data['isOutofstock'] = this.isOutofstock;
    data['isMultiple'] = this.isMultiple;
    data['isCustomizable'] = this.isCustomizable;
    data['showPrice'] = this.showPrice;
    data['showPriceRange'] = this.showPriceRange;
    data['imageId'] = this.imageId;
    data['priceType'] = this.priceType;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    // if (this.ribbon != null) {
    //   data['ribbon'] = this.ribbon!.toJson();
    // }

    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }

    // if (this.images != null) {
    //   data['images'] = this.images!.map((v) => v.toJson()).toList();
    // }
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

class CollectionProductPrice {
  late final String? currencySymbol;
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
      required this.currencySymbol,
      required this.maxPrice,
      required this.type,
      required this.isSamePrice,
      required this.sTypename});

  CollectionProductPrice.fromJson(Map<String, dynamic> json) {
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
    data['maxPrice'] = this.maxPrice;
    data['type'] = this.type;
    data['currencySymbol'] = this.currencySymbol;
    data['isSamePrice'] = this.isSamePrice;
    data['__typename'] = this.sTypename;
    return data;
  }
}

WishlilstDataVM wishilstDataVMFromJson(dynamic str) =>
    (WishlilstDataVM.fromJson(str));
List<WishlilstProductDataVM> wishlistProductDataVMFromJson(dynamic str) =>
    List<WishlilstProductDataVM>.from(
        str.map((x) => WishlilstProductDataVM.fromJson(x)));

class WishlilstDataVM {
  late final int? count;
  late final int? totalPages;
  late final List<WishlilstProductDataVM>? wishlistData;
  late final String? sTypename;

  WishlilstDataVM(
      {required this.count,
      required this.totalPages,
      required this.wishlistData,
      required this.sTypename});

  WishlilstDataVM.fromJson(dynamic json) {
    count = json.count;
    totalPages = json.totalPages;
    if (json.wishlistData != null) {
      wishlistData = <WishlilstProductDataVM>[];
      json.wishlistData.forEach((v) {
        wishlistData!.add(new WishlilstProductDataVM.fromJson(v));
      });
    }
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['totalPages'] = this.totalPages;
    if (this.wishlistData != null)
      data['wishlistData'] = this.wishlistData!.map((v) => v.toJson()).toList();
    data['__typename'] = this.sTypename;

    return data;
  }
}

class WishlilstProductDataVM {
  late final String? sId;
  late final String? userId;
  late final String? productId;

  WishlilstProductDataVM(
      {required this.sId, required this.userId, required this.productId});

  WishlilstProductDataVM.fromJson(dynamic json) {
    sId = json.sId;
    userId = json.userId;
    productId = json.productId;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['productId'] = this.productId;

    return data;
  }
}
