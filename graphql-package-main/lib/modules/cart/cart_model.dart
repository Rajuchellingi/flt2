List<CartProduct> cartProductFromJson(dynamic str) =>
    (List<CartProduct>.from(str.map((x) => CartProduct.fromJson(x))));
// CartProduct cartProductFromJson(dynamic str) => (CartProduct.fromJson(str));
// CartProduct cartProductFromJson(dynamic str) => CartProduct.fromJson(str);

class CartProduct {
  late final String? sId;
  late final String? code;
  late final String? productName;
  late final String? variantName;
  late final String? productId;
  late final String? imageId;
  late final String? skuId;
  late final String? productDescription;
  late final String? type;
  late final bool? isMultiple;
  late final List<Category>? category;
  late final List<Brand>? brand;
  late final List<DiscountAllocations>? discountAllocations;
  late final List<Attribute>? attribute;
  late final Price? price;
  late final int? totalPieces;
  late final int? qty;
  late final bool? isCustomizable;
  late final String? imageUrl;
  late final List<SkuIds>? skuIds;
  late final List<SelectedCartOptions>? selectedOptions;
  late final List<ProductChildren>? children;
  late final bool outOfStock;
  late final String? sTypename;

  CartProduct(
      {required this.sId,
      required this.code,
      required this.productName,
      required this.variantName,
      required this.productId,
      required this.imageId,
      required this.skuId,
      required this.productDescription,
      required this.type,
      required this.isMultiple,
      required this.category,
      required this.brand,
      required this.selectedOptions,
      required this.attribute,
      required this.price,
      required this.totalPieces,
      required this.qty,
      required this.imageUrl,
      required this.isCustomizable,
      required this.skuIds,
      required this.children,
      required this.discountAllocations,
      required this.outOfStock,
      required this.sTypename});

  CartProduct.fromJson(Map<String, dynamic> json) {
    // print("cart cost---> ${json}");
    sId = json['id'];
    code = json['code'] ?? null;
    productName = json['merchandise']['product']['title'] ?? null;
    variantName = json['merchandise']['title'] ?? null;
    productId = json['merchandise']['product']['id'] ?? null;
    imageId = json['imageId'] ?? null;
    skuId = json['merchandise']['id'] ?? null;
    productDescription = json['productDescription'] ?? null;
    type = json['type'] ?? "products";
    isMultiple = json['isMultiple'] ?? null;
    isCustomizable = json['isCustomizable'] ?? null;
    category = <Category>[];
    if (json['category'] != null) {
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    selectedOptions = <SelectedCartOptions>[];
    if (json['merchandise'] != null &&
        json['merchandise']['selectedOptions'] != null) {
      json['merchandise']['selectedOptions'].forEach((v) {
        selectedOptions!.add(new SelectedCartOptions.fromJson(v));
      });
    }
    brand = <Brand>[];
    if (json['brand'] != null) {
      json['brand'].forEach((v) {
        brand!.add(new Brand.fromJson(v));
      });
    }
    attribute = <Attribute>[];
    if (json['attribute'] != null) {
      json['attribute'].forEach((v) {
        attribute!.add(new Attribute.fromJson(v));
      });
    }
    price = json['merchandise'] != null
        ? new Price.fromJson(json, json['merchandise'])
        : null;
    totalPieces = json['totalPieces'] ?? null;
    qty = json['quantity'];
    imageUrl = json['merchandise']['image']['src'];
    skuIds = <SkuIds>[];
    if (json['skuIds'] != null) {
      json['skuIds'].forEach((v) {
        skuIds!.add(new SkuIds.fromJson(v));
      });
    }
    discountAllocations = <DiscountAllocations>[];
    if (json['discountAllocations'] != null) {
      json['discountAllocations'].forEach((v) {
        discountAllocations!.add(new DiscountAllocations.fromJson(v));
      });
    }
    children = <ProductChildren>[];
    if (json['children'] != null) {
      json['children'].forEach((v) {
        children!.add(new ProductChildren.fromJson(v));
      });
    }
    outOfStock = json['merchandise']['availableForSale'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['code'] = this.code;
    data['productName'] = this.productName;
    data['variantName'] = this.variantName;
    data['productId'] = this.productId;
    data['imageId'] = this.imageId;
    data['outOfStock'] = this.outOfStock;
    data['skuId'] = this.skuId;
    data['productDescription'] = this.productDescription;
    data['type'] = this.type;
    data['isMultiple'] = this.isMultiple;
    data['isCustomizable'] = this.isCustomizable;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.selectedOptions != null) {
      data['selectedOptions'] =
          this.selectedOptions!.map((v) => v.toJson()).toList();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.map((v) => v.toJson()).toList();
    }
    if (this.attribute != null) {
      data['attribute'] = this.attribute!.map((v) => v.toJson()).toList();
    }
    if (this.discountAllocations != null) {
      data['discountAllocations'] =
          this.discountAllocations!.map((v) => v.toJson()).toList();
    }
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    data['totalPieces'] = this.totalPieces;
    data['qty'] = this.qty;
    data['imageUrl'] = this.imageUrl;
    if (this.skuIds != null) {
      data['skuIds'] = this.skuIds!.map((v) => v.toJson()).toList();
    }
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Category {
  late final String? sId;
  late final String? categoryName;
  late final String? sTypename;

  Category(
      {required this.sId, required this.categoryName, required this.sTypename});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['categoryName'];
    sTypename = json['__typename'];
  }

  Category.fromRequestJson(dynamic json) {
    sId = json.sId;
    categoryName = json.categoryName;
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['categoryName'] = this.categoryName;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Brand {
  late final String? sId;
  late final String? brandName;
  late final String? sTypename;

  Brand({required this.sId, required this.brandName, required this.sTypename});

  Brand.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    brandName = json['brandName'];
    sTypename = json['__typename'];
  }

  Brand.fromRequestJson(dynamic json) {
    sId = json.sId;
    brandName = json.brandName;
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['brandName'] = this.brandName;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SelectedCartOptions {
  late final String? name;
  late final String? value;

  SelectedCartOptions({required this.name, required this.value});

  SelectedCartOptions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  SelectedCartOptions.fromRequestJson(dynamic json) {
    name = json.name;
    value = json.value;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class Attribute {
  late final String? fieldName;
  late final String? fieldValue;
  late final String? colorCode;
  late final String? sTypename;

  Attribute(
      {required this.fieldName,
      required this.fieldValue,
      required this.colorCode,
      required this.sTypename});

  Attribute.fromJson(Map<String, dynamic> json) {
    fieldName = json['fieldName'];
    fieldValue = json['fieldValue'];
    colorCode = json['colorCode'];
    sTypename = json['__typename'];
  }

  Attribute.fromRequestJson(dynamic json) {
    fieldName = json.fieldName;
    fieldValue = json.fieldValue;
    colorCode = json.colorCode;
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldName'] = this.fieldName;
    data['fieldValue'] = this.fieldValue;
    data['colorCode'] = this.colorCode;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Price {
  late final num? mrp;
  late final num? sellingPrice;
  late final num? discount;
  late final num? totalPrice;
  late final num? gstLabelName;
  late final num? withOutGstPrice;
  late final num? sgstLabelName;
  late final num? cgstLabelName;
  late final num? totalSgst;
  late final num? totalCgst;
  late final num? subtotalPrice;
  late final num? withOutSCGstPrice;
  late final num? totalGst;
  late final String? sTypename;

  Price(
      {required this.mrp,
      required this.sellingPrice,
      required this.discount,
      required this.totalPrice,
      required this.gstLabelName,
      required this.withOutGstPrice,
      required this.sgstLabelName,
      required this.cgstLabelName,
      required this.totalSgst,
      required this.subtotalPrice,
      required this.totalCgst,
      required this.withOutSCGstPrice,
      required this.totalGst,
      required this.sTypename});

  Price.fromJson(Map<String, dynamic> product, json) {
    // mrp = makeDouble(json['amount']);
    // mrp = json['price']['amount'] != null
    //     ? num.parse(json['price']['amount'])
    //     : 0;
    sellingPrice = json['price'] != null
        ? (json['price']['amount'] != null
            ? num.parse(json['price']['amount'])
            : 0)
        : 0;

    // sellingPrice = makeDouble(json['amount']);
    mrp = json['compareAtPrice'] != null
        ? num.parse(json['compareAtPrice']['amount'])
        : 0;
    // sellingPrice = json['compareAtPrice'] != null
    //     ? (json['compareAtPrice']['amount'] != null
    //         ? num.parse(json['compareAtPrice']['amount'])
    //         : 0)
    //     : 0;
    // discount = makeDouble(json['discount'] ?? null);
    discount = json['discount'] != null ? num.parse(json['discount']) : 0;
    // totalPrice = makeDouble(json['amount']);
    // totalPrice = json['price'] != null
    //     ? (json['price']['amount'] != null
    //         ? num.parse(json['price']['amount'])
    //         : 0)
    //     : 0;
    totalPrice = product['cost']['totalAmount'] != null
        ? num.parse(product['cost']['totalAmount']['amount'])
        : 0;
    subtotalPrice = product['cost']['subtotalAmount'] != null
        ? num.parse(product['cost']['subtotalAmount']['amount'])
        : 0;
    gstLabelName = makeDouble(json['currencyCode']);
    withOutGstPrice = makeDouble(json['withOutGstPrice'] ?? null);
    sgstLabelName = makeDouble(json['sgstLabelName'] ?? null);
    cgstLabelName = makeDouble(json['cgstLabelName'] ?? null);
    totalSgst = makeDouble(json['totalSgst'] ?? null);
    totalCgst = makeDouble(json['totalCgst'] ?? null);
    withOutSCGstPrice = makeDouble(json['withOutSCGstPrice'] ?? null);
    totalGst = makeDouble(json['totalGst'] ?? null);
    sTypename = json['__typename'];
  }

  Price.fromRequestJson(dynamic json) {
    mrp = makeDouble(json.mrp);
    sellingPrice = makeDouble(json.sellingPrice);
    discount = makeDouble(json.discount);
    totalPrice = makeDouble(json.totalPrice);
    gstLabelName = makeDouble(json.gstLabelName);
    withOutGstPrice = makeDouble(json.withOutGstPrice);
    sgstLabelName = makeDouble(json.sgstLabelName);
    cgstLabelName = makeDouble(json.cgstLabelName);
    totalSgst = makeDouble(json.totalSgst);
    totalCgst = makeDouble(json.totalCgst);
    subtotalPrice = makeDouble(json.subtotalPrice);
    withOutSCGstPrice = makeDouble(json.withOutSCGstPrice);
    totalGst = makeDouble(json.totalGst);
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mrp'] = this.mrp;
    data['sellingPrice'] = this.sellingPrice;
    data['discount'] = this.discount;
    data['totalPrice'] = this.totalPrice;
    data['gstLabelName'] = this.gstLabelName;
    data['withOutGstPrice'] = this.withOutGstPrice;
    data['sgstLabelName'] = this.sgstLabelName;
    data['subtotalPrice'] = this.subtotalPrice;
    data['cgstLabelName'] = this.cgstLabelName;
    data['totalSgst'] = this.totalSgst;
    data['totalCgst'] = this.totalCgst;
    data['withOutSCGstPrice'] = this.withOutSCGstPrice;
    data['totalGst'] = this.totalGst;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SkuIds {
  late final String? skuId;
  late final String? imageId;
  late final String? styleCode;
  late final String? sku;
  late final List<Attribute>? attribute;
  late final List<Category>? category;
  late final Brand? brand;
  late final String? productDimension;
  late final String? packingDimension;
  late final num? weight;
  late final String? productId;
  late final String? type;
  late final bool? isMultiple;
  late final String? productName;
  late final String? imageUrl;
  late final String? productDescription;
  late final Price? price;
  late final int? qty;
  late final String? sTypename;
  late final String? sid;

  SkuIds(
      {required this.skuId,
      required this.imageId,
      required this.styleCode,
      required this.sku,
      required this.attribute,
      required this.category,
      required this.brand,
      required this.productDimension,
      required this.packingDimension,
      required this.weight,
      required this.productId,
      required this.type,
      required this.isMultiple,
      required this.productName,
      required this.imageUrl,
      required this.productDescription,
      required this.price,
      required this.qty,
      required this.sid,
      required this.sTypename});

  SkuIds.fromJson(Map<String, dynamic> json) {
    skuId = json['skuId'];
    imageId = json['imageId'];
    sid = json['sid'];
    styleCode = json['styleCode'];
    sku = json['sku'];
    if (json['attribute'] != null) {
      attribute = <Attribute>[];
      json['attribute'].forEach((v) {
        attribute!.add(new Attribute.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    productDimension = json['productDimension'];
    packingDimension = json['packingDimension'];
    weight = json['weight'];
    productId = json['productId'];
    type = json['type'];
    isMultiple = json['isMultiple'];
    productName = json['productName'];
    imageUrl = json['imageUrl'];
    productDescription = json['productDescription'];
    price =
        json['price'] != null ? new Price.fromJson(json, json['price']) : null;
    qty = json['qty'];
    sTypename = json['__typename'];
  }

  SkuIds.fromRequestJson(dynamic json) {
    skuId = json.skuId;
    imageId = json.imageId;
    sid = json.sid;
    styleCode = json.styleCode;
    sku = json.sku;
    if (json.attribute != null) {
      attribute = <Attribute>[];
      json.attribute.forEach((v) {
        attribute!.add(new Attribute.fromRequestJson(v));
      });
    }
    if (json.category != null) {
      category = <Category>[];
      json.category.forEach((v) {
        category!.add(new Category.fromRequestJson(v));
      });
    }
    brand = json.brand != null ? new Brand.fromRequestJson(json.brand) : null;
    productDimension = json.productDimension;
    packingDimension = json.packingDimension;
    weight = json.weight;
    productId = json.productId;
    type = json.type;
    isMultiple = json.isMultiple;
    productName = json.productName;
    imageUrl = json.imageUrl;
    productDescription = json.productDescription;
    price = json.price != null ? new Price.fromRequestJson(json.price) : null;
    qty = json.qty;
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['skuId'] = this.skuId;
    data['imageId'] = this.imageId;
    data['styleCode'] = this.styleCode;
    data['sid'] = this.sid;
    data['sku'] = this.sku;
    if (this.attribute != null) {
      data['attribute'] = this.attribute!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    data['productDimension'] = this.productDimension;
    data['packingDimension'] = this.packingDimension;
    data['weight'] = this.weight;
    data['productId'] = this.productId;
    data['type'] = this.type;
    data['isMultiple'] = this.isMultiple;
    data['productName'] = this.productName;
    data['imageUrl'] = this.imageUrl;
    data['productDescription'] = this.productDescription;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    data['qty'] = this.qty;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SkuPrice {
  late final num? mrp;
  late final num? sellingPrice;
  late final num? discount;
  late final num? rangeDiscount;
  late final num? totalPrice;
  late final num? gstLabelName;
  late final num? withOutGstPrice;
  late final num? sgstLabelName;
  late final num? cgstLabelName;
  late final num? totalSgst;
  late final num? totalCgst;
  late final num? withOutSCGstPrice;
  late final num? totalGst;
  late final String? sTypename;

  SkuPrice(
      {required this.mrp,
      required this.sellingPrice,
      required this.discount,
      required this.rangeDiscount,
      required this.totalPrice,
      required this.gstLabelName,
      required this.withOutGstPrice,
      required this.sgstLabelName,
      required this.cgstLabelName,
      required this.totalSgst,
      required this.totalCgst,
      required this.withOutSCGstPrice,
      required this.totalGst,
      required this.sTypename});

  SkuPrice.fromJson(Map<String, dynamic> json) {
    mrp = makeDouble(json['mrp']);
    sellingPrice = makeDouble(json['sellingPrice']);
    discount = makeDouble(json['discount']);
    rangeDiscount = makeDouble(json['rangeDiscount']);
    totalPrice = makeDouble(json['totalPrice']);
    gstLabelName = makeDouble(json['gstLabelName']);
    withOutGstPrice = makeDouble(json['withOutGstPrice']);
    sgstLabelName = makeDouble(json['sgstLabelName']);
    cgstLabelName = makeDouble(json['cgstLabelName']);
    totalSgst = makeDouble(json['totalSgst']);
    totalCgst = makeDouble(json['totalCgst']);
    withOutSCGstPrice = makeDouble(json['withOutSCGstPrice']);
    totalGst = makeDouble(json['totalGst']);
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mrp'] = this.mrp;
    data['sellingPrice'] = this.sellingPrice;
    data['discount'] = this.discount;
    data['rangeDiscount'] = this.rangeDiscount;
    data['totalPrice'] = this.totalPrice;
    data['gstLabelName'] = this.gstLabelName;
    data['withOutGstPrice'] = this.withOutGstPrice;
    data['sgstLabelName'] = this.sgstLabelName;
    data['cgstLabelName'] = this.cgstLabelName;
    data['totalSgst'] = this.totalSgst;
    data['totalCgst'] = this.totalCgst;
    data['withOutSCGstPrice'] = this.withOutSCGstPrice;
    data['totalGst'] = this.totalGst;
    data['__typename'] = this.sTypename;
    return data;
  }
}

num makeDouble(num? value) {
  return value != null ? value.toDouble() : 0.0;
  // return (field ?? 0).toDouble();
}

class UpdateCartQty {
  late final String id;
  late final int qty;
  late final String? sid;
  late final String type;
  late final String userId;

  UpdateCartQty({
    required this.id,
    required this.qty,
    required this.userId,
    required this.type,
    this.sid,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qty'] = this.qty;
    data['userId'] = this.userId;
    data['type'] = this.type;
    if (this.sid != null) {
      data['sid'] = this.sid;
    }
    return data;
  }
}

ProductSummary summaryProductCollectionFromJson(dynamic str) =>
    (ProductSummary.fromJson(str));

class ProductSummary {
  late final int? totalQuantity;
  late final String? checkoutUrl;
  late final ProductPriceSummary? summary;
  late final List<DiscountCodes>? discountCodes;
  late final List<DiscountAllocations>? discountAllocations;
  late final String? sTypename;

  ProductSummary(
      {required this.summary,
      required this.totalQuantity,
      required this.discountAllocations,
      required this.discountCodes,
      required this.checkoutUrl,
      required this.sTypename});

  ProductSummary.fromJson(Map<String, dynamic> json) {
    summary = json['cost'] != null
        ? new ProductPriceSummary.fromJson(json['cost'])
        : null;
    if (json['discountCodes'] != null) {
      discountCodes = <DiscountCodes>[];
      json['discountCodes'].forEach((v) {
        discountCodes!.add(new DiscountCodes.fromJson(v));
      });
    }
    discountAllocations = <DiscountAllocations>[];
    if (json['discountAllocations'] != null) {
      json['discountAllocations'].forEach((v) {
        discountAllocations!.add(new DiscountAllocations.fromJson(v));
      });
    }
    totalQuantity = json['totalQuantity'];
    checkoutUrl = json['checkoutUrl'];
    sTypename = json['__typename'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
    if (this.discountCodes != null) {
      data['discountCodes'] =
          this.discountCodes!.map((v) => v.toJson()).toList();
    }
    if (this.discountAllocations != null) {
      data['discountAllocations'] =
          this.discountAllocations!.map((v) => v.toJson()).toList();
    }
    data['totalQuantity'] = this.totalQuantity;
    data['checkoutUrl'] = this.checkoutUrl;
    data['sTypename'] = this.sTypename;
    return data;
  }
}

class ProductPriceSummary {
  late final num? totalSellingPrice;
  late final num? totalMrpPrice;
  late final int? totalQty;
  late final num? totalGstPrice;
  late final num? totalWithOutSCGSTPrice;
  late final num? totalWithOutGSTPrice;
  late final String? sTypename;

  ProductPriceSummary(
      {required this.totalSellingPrice,
      required this.totalMrpPrice,
      required this.totalQty,
      required this.totalGstPrice,
      required this.totalWithOutSCGSTPrice,
      required this.totalWithOutGSTPrice,
      required this.sTypename});

  ProductPriceSummary.fromJson(Map<String, dynamic> json) {
    totalSellingPrice = json['subtotalAmount']['amount'] != null
        ? num.parse(json['subtotalAmount']['amount'])
        : 0;
    totalMrpPrice = json['totalAmount']['amount'] != null
        ? num.parse(json['totalAmount']['amount'])
        : 0;
    totalGstPrice = json['totalTaxAmount'] != null &&
            json['totalTaxAmount']['amount'] != null
        ? num.parse(json['totalTaxAmount']['amount'])
        : 0;
    totalWithOutSCGSTPrice = json['totalWithOutSCGSTPrice'] != null
        ? num.parse(json['totalWithOutSCGSTPrice'])
        : 0;
    totalWithOutGSTPrice = json['totalWithOutGSTPrice'] != null
        ? num.parse(json['totalWithOutGSTPrice'])
        : 0;
    // totalSellingPrice = json['subtotalAmount']['amount'] != null
    //     ? json['subtotalAmount']['amount'].toDouble()
    //     : 0;
    // totalMrpPrice = json['totalAmount']['amount'] != null
    //     ? json['totalAmount']['amount'].toDouble()
    //     : 0;
    // totalGstPrice = json['totalTaxAmount']['amount'] != null
    //     ? json['totalTaxAmount']['amount'].toDouble()
    //     : 0;
    // totalWithOutSCGSTPrice = json['totalWithOutSCGSTPrice'] != null
    //     ? json['totalWithOutSCGSTPrice'].toDouble()
    //     : 0;
    // totalWithOutGSTPrice = json['totalWithOutGSTPrice'] != null
    //     ? json['totalWithOutGSTPrice'].toDouble()
    //     : 0;
    totalQty = json['totalQty'] ?? null;
    sTypename = json['__typename'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalSellingPrice'] = this.totalSellingPrice;
    data['totalMrpPrice'] = this.totalMrpPrice;
    data['totalGstPrice'] = this.totalGstPrice;
    data['totalWithOutSCGSTPrice'] = this.totalWithOutSCGSTPrice;
    data['totalWithOutGSTPrice'] = this.totalWithOutGSTPrice;
    data['totalQty'] = this.totalQty;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DiscountAllocations {
  late final String? amount;
  late final String? title;

  DiscountAllocations({required this.amount, required this.title});

  DiscountAllocations.fromJson(Map<String, dynamic> json) {
    amount = (json['discountedAmount'] != null &&
            json['discountedAmount'].isNotEmpty)
        ? json['discountedAmount']['amount']
        : '0.0';
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['title'] = this.title;
    return data;
  }
}

class DiscountCodes {
  late final bool? applicable;
  late final String? code;

  DiscountCodes({required this.applicable, required this.code});

  DiscountCodes.fromJson(Map<String, dynamic> json) {
    applicable = json['applicable'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applicable'] = this.applicable;
    data['code'] = this.code;
    return data;
  }
}

CartSummary cartSummaryFromJson(dynamic str) => (CartSummary.fromJson(str));

class CartSummary {
  late final CartProductPriceSummary? summary;
  late final String? sTypename;

  CartSummary({required this.summary, required this.sTypename});

  CartSummary.fromJson(Map<String, dynamic> json) {
    summary = json['summary'] != null
        ? new CartProductPriceSummary.fromJson(json['summary'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
    data['sTypename'] = this.sTypename;
    return data;
  }
}

class CartProductPriceSummary {
  late final num? totalSellingPrice;
  late final num? totalMrpPrice;
  late final int? totalQty;
  late final num? totalGstPrice;
  late final num? totalWithOutSCGSTPrice;
  late final num? totalWithOutGSTPrice;
  late final String? sTypename;

  CartProductPriceSummary(
      {required this.totalSellingPrice,
      required this.totalMrpPrice,
      required this.totalQty,
      required this.totalGstPrice,
      required this.totalWithOutSCGSTPrice,
      required this.totalWithOutGSTPrice,
      required this.sTypename});

  CartProductPriceSummary.fromJson(Map<String, dynamic> json) {
    totalSellingPrice = json['totalSellingPrice'] != null
        ? json['totalSellingPrice'].toDouble()
        : 0;
    totalMrpPrice =
        json['totalMrpPrice'] != null ? json['totalMrpPrice'].toDouble() : 0;
    totalGstPrice =
        json['totalGstPrice'] != null ? json['totalGstPrice'].toDouble() : 0;
    totalWithOutSCGSTPrice = json['totalWithOutSCGSTPrice'] != null
        ? json['totalWithOutSCGSTPrice'].toDouble()
        : 0;
    totalWithOutGSTPrice = json['totalWithOutGSTPrice'] != null
        ? json['totalWithOutGSTPrice'].toDouble()
        : 0;
    totalQty = json['totalQty'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalSellingPrice'] = this.totalSellingPrice;
    data['totalMrpPrice'] = this.totalMrpPrice;
    data['totalGstPrice'] = this.totalGstPrice;
    data['totalWithOutSCGSTPrice'] = this.totalWithOutSCGSTPrice;
    data['totalWithOutGSTPrice'] = this.totalWithOutGSTPrice;
    data['totalQty'] = this.totalQty;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ProductChildren {
  late final String? productId;
  late final String? imageId;
  late final String? productName;
  late final String? productDescription;
  late final List<Category>? category;
  late final Brand? brand;
  late final String? imageUrl;
  late final String? type;
  late final bool? isMultiple;
  late final List<Attribute>? attribute;
  late final int? qty;
  late final int? totalPieces;
  late final Price? price;
  late final int? originalQty;
  late final String? sid;
  late final List<SkuIds>? skuIds;

  ProductChildren(
      {required this.skuIds,
      required this.imageId,
      required this.attribute,
      required this.category,
      required this.brand,
      required this.productId,
      required this.type,
      required this.isMultiple,
      required this.productName,
      required this.imageUrl,
      required this.productDescription,
      required this.price,
      required this.qty,
      required this.sid,
      required this.totalPieces,
      required this.originalQty});

  ProductChildren.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    if (json['attribute'] != null) {
      attribute = <Attribute>[];
      json['attribute'].forEach((v) {
        attribute!.add(new Attribute.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['skuIds'] != null) {
      skuIds = <SkuIds>[];
      json['skuIds'].forEach((v) {
        skuIds!.add(new SkuIds.fromJson(v));
      });
    }
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    productId = json['productId'];
    totalPieces = json['totalPieces'];
    originalQty = json['originalQty'];
    type = json['type'];
    isMultiple = json['isMultiple'];
    productName = json['productName'];
    imageUrl = json['imageUrl'];
    sid = json['sid'];
    productDescription = json['productDescription'];
    price =
        json['price'] != null ? new Price.fromJson(json, json['price']) : null;
    qty = json['qty'];
  }

  ProductChildren.fromRequestJson(dynamic json) {
    imageId = json.imageId;
    if (json.attribute != null) {
      attribute = <Attribute>[];
      json.attribute.forEach((v) {
        attribute!.add(new Attribute.fromRequestJson(v));
      });
    }
    if (json.category != null) {
      category = <Category>[];
      json.category.forEach((v) {
        category!.add(new Category.fromRequestJson(v));
      });
    }
    if (json?.skuIds != null) {
      skuIds = <SkuIds>[];
      json.skuIds.forEach((v) {
        skuIds!.add(new SkuIds.fromRequestJson(v));
      });
    }
    brand = json.brand != null ? new Brand.fromRequestJson(json.brand) : null;
    totalPieces = json.totalPieces;
    originalQty = json.originalQty;
    productId = json.productId;
    type = json.type;
    isMultiple = json.isMultiple;
    sid = json.sid;
    productName = json.productName;
    imageUrl = json.imageUrl;
    productDescription = json.productDescription;
    price = json.price != null ? new Price.fromRequestJson(json.price) : null;
    qty = json.qty;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPieces'] = this.totalPieces;
    data['imageId'] = this.imageId;
    data['originalQty'] = this.originalQty;
    if (this.attribute != null) {
      data['attribute'] = this.attribute!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.skuIds != null) {
      data['skuIds'] = this.skuIds!.map((v) => v.toJson()).toList();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }

    data['productId'] = this.productId;
    data['type'] = this.type;
    data['isMultiple'] = this.isMultiple;
    data['productName'] = this.productName;
    data['imageUrl'] = this.imageUrl;
    data['sid'] = this.sid;
    data['productDescription'] = this.productDescription;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    data['qty'] = this.qty;

    return data;
  }
}

ServerCartCount cartCountFromJson(dynamic str) =>
    (ServerCartCount.fromJson(str));

class ServerCartCount {
  late final int totalQuantity;

  ServerCartCount({required this.totalQuantity});

  ServerCartCount.fromJson(Map<String, dynamic> json) {
    totalQuantity = json["totalQuantity"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalQuantity'] = this.totalQuantity;
    return data;
  }
}
