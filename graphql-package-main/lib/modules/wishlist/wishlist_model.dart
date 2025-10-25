List<AllWishlistWithProduct> allWishListWithProductFromJson(dynamic str) =>
    List<AllWishlistWithProduct>.from(
        str.map((x) => AllWishlistWithProduct.fromJson(x)));

class AllWishlistWithProduct {
  late final String sId;
  late final String? name;
  late final String? description;
  late final String? type;
  late final int? moq;
  late final bool? isOutofstock;
  late final bool? isMultiple;
  late final String? imageId;
  late final String? vendor;
  late final String? priceType;
  late final List<WishlistProductOptions>? options;
  late final List<WishlistProductVariants>? variants;
  late final WishlistPrice? price;
  late final List<WishlistImage>? images;

  AllWishlistWithProduct(
      {required this.sId,
      required this.name,
      required this.description,
      required this.type,
      required this.moq,
      required this.isOutofstock,
      required this.isMultiple,
      required this.variants,
      required this.priceType,
      required this.vendor,
      required this.imageId,
      required this.price,
      required this.images});

  AllWishlistWithProduct.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    name = json['title'];
    description = json['description'];
    vendor = json['vendor'];
    priceType = json['priceType'] ?? null;
    type = json['type'] ?? "product";
    moq = 1;
    isOutofstock = json['availableForSale'];
    isMultiple = json['isMultiple'] ?? null;
    imageId = json['featuredImage']['id'];
    // price = WishlistPrice.fromJson(json['priceRange']);
    // images = WishlistImageFromJson(json['featuredImage']);
    if (json['featuredImage'] != null) {
      images = <WishlistImage>[];
      images!.add(new WishlistImage.fromJson(json['featuredImage']));
    }
    if (json['options'] != null) {
      options = <WishlistProductOptions>[];
      json['options'].forEach((v) {
        options!.add(WishlistProductOptions.fromJson(v));
      });
    } else {
      options = [];
    }
    if (json['variants'] != null && json['variants']['edges'] != null) {
      variants = <WishlistProductVariants>[];
      json['variants']['edges'].forEach((v) {
        var data = {
          "id": v['node'] != null ? v['node']['id'] : null,
          "title": v['node'] != null ? v['node']['title'] : null,
          "availableForSale":
              v['node'] != null ? v['node']['availableForSale'] : null,
        };
        variants!.add(WishlistProductVariants.fromJson(data));
      });
    } else {
      variants = [];
    }
    price =
        json['priceRange'] != null ? new WishlistPrice.fromJson(json) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['vendor'] = this.vendor;
    data['moq'] = this.moq;
    data['isOutofstock'] = this.isOutofstock;
    data['isMultiple'] = this.isMultiple;
    data['imageId'] = this.imageId;
    data['priceType'] = this.priceType;
    // data['priceRange'] = this.price;
    // data['featuredImage'] = this.images;
    if (this.price != null) {
      data['priceType'] = this.price!.toJson();
    }
    if (this.images != null) {
      data['featuredImage'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishlistProductOptions {
  late final String? sId;
  late final String? name;
  late final List<WishlistProductOptionsValue> values;
  late final String? sTypename;

  WishlistProductOptions({
    required this.name,
    required this.sId,
    required this.values,
    required this.sTypename,
  });

  WishlistProductOptions.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    if (json['values'] != null) {
      values = <WishlistProductOptionsValue>[];
      json['values'].forEach((v) {
        var optionValue = {"name": v};
        values.add(WishlistProductOptionsValue.fromJson(optionValue));
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

class WishlistProductOptionsValue {
  late final String? name;

  WishlistProductOptionsValue({
    required this.name,
  });

  WishlistProductOptionsValue.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class WishlistProductVariants {
  late final String? sId;
  late final String? title;
  late final bool? availableForSale;
  late final String? sTypename;

  WishlistProductVariants({
    required this.title,
    required this.sId,
    required this.availableForSale,
    required this.sTypename,
  });

  WishlistProductVariants.fromJson(Map<String, dynamic> json) {
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

class WishlistImage {
  late final String? imageName;
  late final int? position;

  WishlistImage({required this.imageName, required this.position});

  WishlistImage.fromJson(Map<String, dynamic> json) {
    imageName = json['url'];
    position = json['position'] ?? null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageName'] = this.imageName;
    data['position'] = this.position;
    return data;
  }
}

class WishlistPrice {
  late final num? sellingPrice;
  late final num? mrp;
  late final num? discount;
  late final num? minPrice;
  late final num? maxPrice;
  late final String? type;
  late final String? sTypename;
  late final bool? isSamePrice;
  WishlistPrice(
      {required this.sellingPrice,
      required this.mrp,
      required this.discount,
      required this.minPrice,
      required this.maxPrice,
      required this.type,
      required this.sTypename,
      required this.isSamePrice});
  WishlistPrice.fromJson(Map<String, dynamic> json) {
    mrp = (json['compareAtPriceRange'] != null &&
            json['compareAtPriceRange']['maxVariantPrice'] != null)
        ? num.parse(json['compareAtPriceRange']['maxVariantPrice']['amount'])
        : 0;
    sellingPrice = (json['priceRange'] != null &&
            json['priceRange']['minVariantPrice'] != null)
        ? num.parse(json['priceRange']['minVariantPrice']['amount'])
        : 0;
    discount = 0;
    minPrice = 0;
    maxPrice = 0;
    type = json['type'] ?? null;
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
    return data;
  }
}

WishlilstData wishilstDataFromJson(dynamic str) =>
    (WishlilstData.fromJson(str));
List<WishlilstProductData> wishlistProductDataFromJson(dynamic str) =>
    List<WishlilstProductData>.from(
        str.map((x) => WishlilstProductData.fromJson(x)));

class WishlilstData {
  late final int? count;
  late final int? totalPages;
  late final List<WishlilstProductData>? wishlistData;
  late final String? sTypename;

  WishlilstData(
      {required this.count,
      required this.totalPages,
      required this.wishlistData,
      required this.sTypename});

  WishlilstData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalPages = json['totalPages'];
    wishlistData = <WishlilstProductData>[];
    if (json['wishlistData'] != null) {
      json['wishlistData'].forEach((v) {
        wishlistData!.add(new WishlilstProductData.fromJson(v));
      });
    }
    sTypename = json['__typename'];
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

class WishlilstProductData {
  late final String? sId;
  late final String? userId;
  late final String? productId;

  WishlilstProductData(
      {required this.sId, required this.userId, required this.productId});

  WishlilstProductData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['productId'] = this.productId;

    return data;
  }
}
