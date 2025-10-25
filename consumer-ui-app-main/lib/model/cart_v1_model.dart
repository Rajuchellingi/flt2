import 'package:black_locust/config/configConstant.dart';

CartVMMOdel cartFromJson(dynamic str) => (CartVMMOdel.fromJson(str.toJson()));

class CartVMMOdel {
  late final CartProductPriceSummary? orderSummary;
  late final List<Cart> products;
  late final List<CartRelatedProductVM> relatedProducts;

  CartVMMOdel({
    required this.products,
    required this.orderSummary,
    required this.relatedProducts,
  });

  CartVMMOdel.fromJson(Map<String, dynamic> json) {
    // print("json data--->>1 ${json}");
    orderSummary = json['orderSummary'] != null
        ? new CartProductPriceSummary.fromJson(json['orderSummary'])
        : null;
    if (json['product'] != null) {
      products = <Cart>[];
      json['product'].forEach((v) {
        products.add(new Cart.fromJson(v));
      });
    }
    if (json['relatedProducts'] != null) {
      relatedProducts = <CartRelatedProductVM>[];
      json['relatedProducts'].forEach((v) {
        relatedProducts.add(new CartRelatedProductVM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderSummary != null) {
      data['orderSummary'] = this.orderSummary!.toJson();
    }
    data['product'] = this.products.map((v) => v.toJson()).toList();
    data['relatedProducts'] =
        this.relatedProducts.map((v) => v.toJson()).toList();
    return data;
  }
}

class CartRelatedProductVM {
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
  late final RelatedProductRibbonVM? ribbon;
  late final RelatedProductPriceVM? price;
  late final bool? isWishlist;
  late final List? wishlistCollection;
  late final bool? showWishlist;
  late final RelatedProductImageVM? images;
  late final String? sTypename;

  CartRelatedProductVM({
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
    required this.wishlistCollection,
    required this.showWishlist,
  });

  CartRelatedProductVM.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['productId'];
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
    price = json['price'] != null
        ? new RelatedProductPriceVM.fromJson(json['price'])
        : null;
    ribbon = json['ribbon'] != null
        ? new RelatedProductRibbonVM.fromJson(json['ribbon'])
        : null;

    images = json['images'] != null
        ? new RelatedProductImageVM.fromJson(json['images'])
        : null;
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
    data['wishlistCollection'] = this.wishlistCollection;
    data['showWishlist'] = this.showWishlist;
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

class RelatedProductPriceVM {
  late final num? sellingPrice;
  late final num? mrp;
  late final num? discount;
  late final num? minPrice;
  late final num? maxPrice;
  late final String? currencySymbol;
  late final String? type;
  late final bool? isSamePrice;
  late final String? sTypename;

  RelatedProductPriceVM(
      {required this.sellingPrice,
      required this.mrp,
      required this.currencySymbol,
      required this.discount,
      required this.minPrice,
      required this.maxPrice,
      required this.type,
      required this.isSamePrice,
      required this.sTypename});

  RelatedProductPriceVM.fromJson(Map<String, dynamic> json) {
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
    data['currencySymbol'] = this.currencySymbol;
    data['type'] = this.type;
    data['isSamePrice'] = this.isSamePrice;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class RelatedProductRibbonVM {
  late final String? name;
  late final String? colorCode;

  RelatedProductRibbonVM({required this.name, required this.colorCode});
  RelatedProductRibbonVM.fromJson(Map<String, dynamic> json) {
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

class RelatedProductImageVM {
  late final String? imageName;
  late final int? position;
  late final String? sTypename;

  RelatedProductImageVM(
      {required this.position,
      required this.imageName,
      required this.sTypename});

  RelatedProductImageVM.fromJson(Map<String, dynamic> json) {
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

class Cart {
  late final String? sId;
  late final String? setId;
  late final String? productId;
  late final String? sTypename;
  late final bool? isCustomizable;
  late final bool? setIsCustomizable;
  late final bool? isAssorted;
  late final String? productName;
  late final String? url;
  late final String? variantId;
  late final int? moq;
  late final Price? price;
  late final bool? isWishlist;
  late final List? wishlistCollection;
  late final Image? image;
  late final int? quantity;
  late final num? totalPrice;
  late final num? priceWithoutDiscount;
  late final int? totalCartQuantity;
  late final SetQuantity? setQuantity;
  late final int? setQuantityValue;
  late final PackQuantity? packQuantity;
  late final CartPreferenceVariantVM? preferenceVariant;
  late final List<Variants>? variants;
  late final List<CartMetafieldVM>? metafields;
  late final bool? trackQuantity;
  late final bool? continueSellingWhenOutOfStock;
  late final List<CartProductVariantVM>? productVariant;

  Cart({
    required this.sId,
    required this.setId,
    required this.productId,
    required this.sTypename,
    required this.isCustomizable,
    required this.setIsCustomizable,
    required this.isAssorted,
    required this.productName,
    required this.setQuantityValue,
    required this.metafields,
    required this.variantId,
    required this.quantity,
    required this.url,
    required this.moq,
    required this.isWishlist,
    required this.wishlistCollection,
    required this.productVariant,
    required this.image,
    required this.price,
    required this.totalPrice,
    required this.priceWithoutDiscount,
    required this.totalCartQuantity,
    required this.setQuantity,
    required this.preferenceVariant,
    required this.packQuantity,
    required this.variants,
    required this.continueSellingWhenOutOfStock,
    required this.trackQuantity,
  });

  Cart.fromJson(Map<String, dynamic> json) {
    // print("object json =>>> ${json['packQuantity']}");
    sId = json['_id'];
    setId = json['setId'] ?? null;
    productId = json['productId'];
    sTypename = json['type'];
    isCustomizable = json['isCustomizable'];
    setIsCustomizable = json['setIsCustomizable'];
    isAssorted = json['isAssorted'];
    variantId = json['variantId'];
    productName = json['productName'];
    setQuantityValue = json['setQuantityValue'];
    quantity = json['quantity'];
    url = json['url'];
    moq = json['moq'];
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    isWishlist = json['isWishlist'];
    wishlistCollection = json['wishlistCollection'];
    continueSellingWhenOutOfStock = json['continueSellingWhenOutOfStock'];
    trackQuantity = json['trackQuantity'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    totalPrice = json['totalPrice'] != null
        ? parseToDouble(json['totalPrice'].toString())
        : 0;
    priceWithoutDiscount = json['priceWithoutDiscount'] != null
        ? parseToDouble(json['priceWithoutDiscount'].toString())
        : 0;
    totalCartQuantity = json['totalCartQuantity'];
    setQuantity = json['setQuantity'] != null
        ? new SetQuantity.fromJson(json['setQuantity'])
        : null;
    packQuantity = json['packQuantity'] != null
        ? new PackQuantity.fromJson(json['packQuantity'])
        : null;
    preferenceVariant = json['preferenceVariant'] != null
        ? new CartPreferenceVariantVM.fromJson(json['preferenceVariant'])
        : null;
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    } else {
      variants = [];
    }
    metafields = <CartMetafieldVM>[];
    if (json['metafields'] != null) {
      json['metafields'].forEach((v) {
        metafields!.add(new CartMetafieldVM.fromJson(v));
      });
    }
    productVariant = <CartProductVariantVM>[];
    if (json['productVariant'] != null) {
      json['productVariant'].forEach((v) {
        productVariant!.add(new CartProductVariantVM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['setId'] = this.setId;
    data['productId'] = this.productId;
    data['type'] = this.sTypename;
    data['isCustomizable'] = this.isCustomizable;
    data['setIsCustomizable'] = this.setIsCustomizable;
    data['variantId'] = this.variantId;
    data['setQuantityValue'] = this.setQuantityValue;
    data['isAssorted'] = this.isAssorted;
    data['productName'] = this.productName;
    data['quantity'] = this.quantity;
    data['url'] = this.url;
    data['moq'] = this.moq;
    data['continueSellingWhenOutOfStock'] = this.continueSellingWhenOutOfStock;
    data['trackQuantity'] = this.trackQuantity;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    data['isWishlist'] = this.isWishlist;
    data['wishlistCollection'] = this.wishlistCollection;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['totalPrice'] = this.totalPrice;
    data['priceWithoutDiscount'] = this.priceWithoutDiscount;
    data['totalCartQuantity'] = this.totalCartQuantity;
    if (this.setQuantity != null) {
      data['setQuantity'] = this.setQuantity!.toJson();
    }
    if (this.preferenceVariant != null) {
      data['preferenceVariant'] = this.preferenceVariant!.toJson();
    }
    if (this.packQuantity != null) {
      data['packQuantity'] = this.packQuantity!.toJson();
    }
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    if (this.metafields != null) {
      data['metafields'] = this.metafields!.map((v) => v.toJson()).toList();
    }
    if (this.productVariant != null) {
      data['productVariant'] =
          this.productVariant!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartMetafieldVM {
  final String? customDataId;
  final String? definition;
  final String? namespace;
  final String? key;
  final String? customDatatype;
  final String? customDataValueType;
  final dynamic reference; // could be Map
  final dynamic references; // could be Map
  final String? id;

  CartMetafieldVM({
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

  factory CartMetafieldVM.fromJson(Map<String, dynamic> json) =>
      CartMetafieldVM(
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

class CartPreferenceVariantVM {
  late final String? attributeLabelName;
  late final String? attributeFieldValue;

  CartPreferenceVariantVM({
    required this.attributeFieldValue,
    required this.attributeLabelName,
  });

  CartPreferenceVariantVM.fromJson(Map<String, dynamic> json) {
    attributeFieldValue = json['attributeFieldValue'];
    attributeLabelName = json['attributeLabelName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeFieldValue'] = this.attributeFieldValue;
    data['attributeLabelName'] = this.attributeLabelName;
    return data;
  }
}

class CartProductVariantVM {
  late final String? attributeLabelName;
  late final String? attributeFieldValue;

  CartProductVariantVM({
    required this.attributeLabelName,
    required this.attributeFieldValue,
  });

  CartProductVariantVM.fromJson(Map<String, dynamic> json) {
    attributeLabelName = json['attributeLabelName'];
    attributeFieldValue = json['attributeFieldValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeLabelName'] = this.attributeLabelName;
    data['attributeFieldValue'] = this.attributeFieldValue;
    return data;
  }
}

class CartProductPriceSummary {
  late final String? currencySymbol;
  late final num? subTotal;
  late final num? total;
  late final int? totalCartQuantity;
  late final num? discount;

  CartProductPriceSummary({
    required this.subTotal,
    required this.currencySymbol,
    required this.total,
    required this.totalCartQuantity,
    required this.discount,
  });

  CartProductPriceSummary.fromJson(Map<String, dynamic> json) {
    // print("CartProductPriceSummary json ${json}");
    currencySymbol = json['currencySymbol'];
    subTotal = json['subTotal'] != null
        ? parseToDouble(json['subTotal'].toString())
        : 0;
    total = json['total'] != null ? parseToDouble(json['total'].toString()) : 0;
    totalCartQuantity = json['totalCartQuantity'];

    discount = json['discount'] != null
        ? parseToDouble(json['discount'].toString())
        : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subTotal'] = this.subTotal;
    data['total'] = this.total;
    data['currencySymbol'] = this.currencySymbol;
    data['totalCartQuantity'] = this.totalCartQuantity;
    data['discount'] = this.discount;
    return data;
  }
}

class Price {
  late final String? currencySymbol;
  late final num? sellingPrice;
  late final num? mrp;
  late final num? discount;

  Price({
    required this.currencySymbol,
    required this.sellingPrice,
    required this.mrp,
    required this.discount,
  });

  Price.fromJson(Map<String, dynamic> json) {
    sellingPrice = json['sellingPrice'] != null
        ? parseToDouble(json['sellingPrice'].toString())
        : 0;
    currencySymbol = json['currencySymbol'];
    mrp = json['mrp'] != null ? parseToDouble(json['mrp'].toString()) : 0;
    discount = json['discount'] != null
        ? parseToDouble(json['discount'].toString())
        : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellingPrice'] = this.sellingPrice;
    data['mrp'] = this.mrp;
    data['discount'] = this.discount;
    data['currencySymbol'] = this.currencySymbol;
    return data;
  }
}

class Image {
  late final String? imageName;
  late final String? imageId;

  Image({
    required this.imageId,
    required this.imageName,
  });

  Image.fromJson(Map<String, dynamic> json) {
    // print("json data--->>1234 $json");
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

class PackQuantity {
  late final int? totalQuantity;
  late final String? variantType;
  late final List<PackSetQuantity>? setQuantities;

  PackQuantity({
    required this.totalQuantity,
    required this.variantType,
    required this.setQuantities,
  });

  PackQuantity.fromJson(Map<String, dynamic> json) {
    totalQuantity = json['totalQuantity'];
    variantType = json['variantType'];
    if (json['setQuantities'] != null) {
      setQuantities = <PackSetQuantity>[];
      json['setQuantities'].forEach((v) {
        setQuantities!.add(new PackSetQuantity.fromJson(v));
      });
    } else {
      setQuantities = [];
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

class PackSetQuantity {
  late final String? attributeFieldValueId;
  late final String? attributeFieldValue;
  late final List<VariantQuantites>? variantQuantites;

  PackSetQuantity({
    required this.attributeFieldValueId,
    required this.attributeFieldValue,
    required this.variantQuantites,
  });

  PackSetQuantity.fromJson(Map<String, dynamic> json) {
    attributeFieldValueId = json['attributeFieldValueId'];
    attributeFieldValue = json['attributeFieldValue'];
    if (json['variantQuantites'] != null) {
      variantQuantites = <VariantQuantites>[];
      json['variantQuantites'].forEach((v) {
        variantQuantites!.add(new VariantQuantites.fromJson(v));
      });
    } else {
      variantQuantites = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeFieldValueId'] = this.attributeFieldValueId;
    data['attributeFieldValue'] = this.attributeFieldValue;
    if (this.variantQuantites != null) {
      data['variantQuantites'] =
          this.variantQuantites!.map((v) => v.toJson()).toList();
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
    } else {
      variantQuantites = [];
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

class VariantQuantites {
  late final String? attributeFieldValue;
  late final int? moq;
  late final num? sellingPrice;

  VariantQuantites({
    required this.attributeFieldValue,
    required this.moq,
    required this.sellingPrice,
  });

  VariantQuantites.fromJson(Map<String, dynamic> json) {
    // print("json VariantQuantites--->>> $json");
    attributeFieldValue = json['attributeFieldValue'];
    moq = json['moq'];
    sellingPrice = json['sellingPrice'] != null
        ? parseToDouble(json['sellingPrice'].toString())
        : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeFieldValue'] = this.attributeFieldValue;
    data['moq'] = this.moq;
    data['sellingPrice'] = this.sellingPrice;
    return data;
  }
}

class Variants {
  late final String? variantId;
  late final String? attributeFieldValue;
  late final double? sellingPrice;
  late final double? mrp;
  late final int? totalQuantity;
  late final bool? trackQuantity;
  late final bool? continueSellingWhenOutOfStock;
  late final int? quantity;
  late final int? moq;

  Variants({
    required this.variantId,
    required this.attributeFieldValue,
    required this.sellingPrice,
    required this.mrp,
    required this.totalQuantity,
    required this.quantity,
    required this.moq,
    required this.trackQuantity,
    required this.continueSellingWhenOutOfStock,
  });

  Variants.fromJson(Map<String, dynamic> json) {
    // print("json PackVariant--->>> $json");
    variantId = json['variantId'];
    attributeFieldValue = json['attributeFieldValue'];
    sellingPrice = json['sellingPrice']?.toDouble();
    mrp = json['mrp']?.toDouble();
    totalQuantity = json['totalQuantity'];
    quantity = json['quantity'];
    moq = json['moq'];
    trackQuantity = json['trackQuantity'];
    continueSellingWhenOutOfStock = json['continueSellingWhenOutOfStock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variantId'] = this.variantId;
    data['attributeFieldValue'] = this.attributeFieldValue;
    data['sellingPrice'] = this.sellingPrice;
    data['mrp'] = this.mrp;
    data['quantity'] = this.quantity;
    data['moq'] = this.moq;
    data['totalQuantity'] = this.totalQuantity;
    data['continueSellingWhenOutOfStock'] = this.continueSellingWhenOutOfStock;
    data['trackQuantity'] = this.trackQuantity;
    return data;
  }
}
