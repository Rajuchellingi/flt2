import 'package:black_locust/config/configConstant.dart';

List<CartProduct> cartProductFromJson(dynamic str) =>
    (List<CartProduct>.from(str.map((x) => CartProduct.fromJson(x.toJson()))));

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
  late final List<Attribute>? attribute;
  late final Price? price;
  late final int? totalPieces;
  late final int? qty;
  late final String? imageUrl;
  late final List<SkuIds>? skuIds;
  late final List<ProductChildren>? children;
  late final List<DiscountAllocationsVM>? discountAllocations;
  late final List<SelectedCartOptionsVM>? selectedOptions;
  late final bool? isCustomizable;
  late final bool? outOfStock;
  late final String? sTypename;

  CartProduct(
      {required this.sId,
      required this.code,
      required this.productName,
      required this.variantName,
      required this.productId,
      required this.imageId,
      required this.selectedOptions,
      required this.skuId,
      required this.productDescription,
      required this.type,
      required this.isMultiple,
      required this.category,
      required this.brand,
      required this.attribute,
      required this.price,
      required this.totalPieces,
      required this.qty,
      required this.discountAllocations,
      required this.imageUrl,
      required this.skuIds,
      required this.children,
      required this.isCustomizable,
      required this.outOfStock,
      required this.sTypename});

  CartProduct.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    code = json['code'];
    productName = json['productName'];
    variantName = json['variantName'];
    productId = json['productId'];
    imageId = json['imageId'];
    skuId = json['skuId'];
    productDescription = json['productDescription'];
    type = json['type'];
    isMultiple = json['isMultiple'];
    isCustomizable = json['isCustomizable'];
    outOfStock = json['outOfStock'];
    category = <Category>[];
    if (json['category'] != null) {
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    selectedOptions = <SelectedCartOptionsVM>[];
    if (json['selectedOptions'] != null) {
      json['selectedOptions'].forEach((v) {
        selectedOptions!.add(new SelectedCartOptionsVM.fromJson(v));
      });
    }
    discountAllocations = <DiscountAllocationsVM>[];
    if (json['discountAllocations'] != null) {
      json['discountAllocations'].forEach((v) {
        discountAllocations!.add(new DiscountAllocationsVM.fromJson(v));
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
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    totalPieces = json['totalPieces'];
    qty = json['qty'];
    imageUrl = json['imageUrl'];
    skuIds = <SkuIds>[];
    if (json['skuIds'] != null) {
      json['skuIds'].forEach((v) {
        skuIds!.add(new SkuIds.fromJson(v));
      });
    }
    children = <ProductChildren>[];
    if (json['children'] != null) {
      json['children'].forEach((v) {
        children!.add(new ProductChildren.fromJson(v));
      });
    }
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
    data['skuId'] = this.skuId;
    data['productDescription'] = this.productDescription;
    data['type'] = this.type;
    data['isMultiple'] = this.isMultiple;
    data['isCustomizable'] = this.isCustomizable;
    data['outOfStock'] = this.outOfStock;
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
    if (this.discountAllocations != null) {
      data['discountAllocations'] =
          this.discountAllocations!.map((v) => v.toJson()).toList();
    }
    if (this.attribute != null) {
      data['attribute'] = this.attribute!.map((v) => v.toJson()).toList();
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

class SelectedCartOptionsVM {
  late final String? name;
  late final String? value;

  SelectedCartOptionsVM({required this.name, required this.value});

  SelectedCartOptionsVM.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  SelectedCartOptionsVM.fromRequestJson(dynamic json) {
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

  Price.fromJson(Map<String, dynamic> json) {
    mrp = parseToDouble(json['mrp'].toString());
    sellingPrice = parseToDouble(json['sellingPrice'].toString());
    discount = parseToDouble(json['discount'].toString());
    totalPrice = parseToDouble(json['totalPrice'].toString());
    gstLabelName = parseToDouble(json['gstLabelName'].toString());
    withOutGstPrice = parseToDouble(json['withOutGstPrice'].toString());
    sgstLabelName = parseToDouble(json['sgstLabelName'].toString());
    cgstLabelName = parseToDouble(json['cgstLabelName'].toString());
    totalSgst = parseToDouble(json['totalSgst'].toString());
    totalCgst = parseToDouble(json['totalCgst'].toString());
    subtotalPrice = parseToDouble(json['subtotalPrice'].toString());
    withOutSCGstPrice = parseToDouble(json['withOutSCGstPrice'].toString());
    totalGst = parseToDouble(json['totalGst'].toString());
    sTypename = json['__typename'];
  }

  Price.fromRequestJson(dynamic json) {
    mrp = parseToDouble(json.mrp.toString());
    sellingPrice = parseToDouble(json.sellingPrice.toString());
    discount = parseToDouble(json.discount.toString());
    totalPrice = parseToDouble(json.totalPrice.toString());
    gstLabelName = parseToDouble(json.gstLabelName.toString());
    withOutGstPrice = parseToDouble(json.withOutGstPrice.toString());
    sgstLabelName = parseToDouble(json.sgstLabelName.toString());
    cgstLabelName = parseToDouble(json.cgstLabelName.toString());
    totalSgst = parseToDouble(json.totalSgst.toString());
    totalCgst = parseToDouble(json.totalCgst.toString());
    subtotalPrice = parseToDouble(json.subtotalPrice.toString());
    withOutSCGstPrice = parseToDouble(json.withOutSCGstPrice.toString());
    totalGst = parseToDouble(json.totalGst.toString());
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mrp'] = this.mrp;
    data['subtotalPrice'] = this.subtotalPrice;
    data['sellingPrice'] = this.sellingPrice;
    data['discount'] = this.discount;
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

class SkuIds {
  late final String? skuId;
  late final String? imageId;
  late final String? styleCode;
  late final String? sku;
  late final String? sid;
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
    styleCode = json['styleCode'];
    sku = json['sku'];
    sid = json['sid'];
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
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    qty = json['qty'];
    sTypename = json['__typename'];
  }

  SkuIds.fromRequestJson(dynamic json) {
    skuId = json.skuId;
    imageId = json.imageId;
    styleCode = json.styleCode;
    sid = json.sid;
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
    mrp = parseToDouble(json['mrp'].toString());
    sellingPrice = parseToDouble(json['sellingPrice'].toString());
    discount = parseToDouble(json['discount'].toString());
    rangeDiscount = parseToDouble(json['rangeDiscount'].toString());
    totalPrice = parseToDouble(json['totalPrice'].toString());
    gstLabelName = parseToDouble(json['gstLabelName'].toString());
    withOutGstPrice = parseToDouble(json['withOutGstPrice'].toString());
    sgstLabelName = parseToDouble(json['sgstLabelName'].toString());
    cgstLabelName = parseToDouble(json['cgstLabelName'].toString());
    totalSgst = parseToDouble(json['totalSgst'].toString());
    totalCgst = parseToDouble(json['totalCgst'].toString());
    withOutSCGstPrice = parseToDouble(json['withOutSCGstPrice'].toString());
    totalGst = parseToDouble(json['totalGst'].toString());
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
    data['sid'] = this.sid;
    data['userId'] = this.userId;
    data['type'] = this.type;
    return data;
  }
}

ProductSummary cartSummaryFromJson(dynamic str) =>
    (ProductSummary.fromJson(str.toJson()));

class ProductSummary {
  late final int? totalQuantity;
  late final String? checkoutUrl;
  late final List<DiscountCodesVM>? discountCodes;
  late final CartProductPriceSummary? summary;
  late final List<DiscountAllocationsVM>? discountAllocations;
  late final String? sTypename;

  ProductSummary(
      {required this.summary,
      required this.totalQuantity,
      required this.checkoutUrl,
      required this.discountAllocations,
      required this.discountCodes,
      required this.sTypename});

  ProductSummary.fromJson(Map<String, dynamic> json) {
    summary = json['summary'] != null
        ? new CartProductPriceSummary.fromJson(json['summary'])
        : null;
    if (json['discountCodes'] != null) {
      discountCodes = <DiscountCodesVM>[];
      json['discountCodes'].forEach((v) {
        discountCodes!.add(new DiscountCodesVM.fromJson(v));
      });
    }
    discountAllocations = <DiscountAllocationsVM>[];
    if (json['discountAllocations'] != null) {
      json['discountAllocations'].forEach((v) {
        discountAllocations!.add(new DiscountAllocationsVM.fromJson(v));
      });
    }
    totalQuantity = json['totalQuantity'];
    checkoutUrl = json['checkoutUrl'];
    sTypename = json['__typename'];
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

class DiscountAllocationsVM {
  late String? amount;
  late final String? title;

  DiscountAllocationsVM({required this.amount, required this.title});

  DiscountAllocationsVM.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['title'] = this.title;
    return data;
  }
}

class DiscountCodesVM {
  late final bool? applicable;
  late final String? code;

  DiscountCodesVM({required this.applicable, required this.code});

  DiscountCodesVM.fromJson(Map<String, dynamic> json) {
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
        ? parseToDouble(json['totalSellingPrice'].toString())
        : 0;
    totalMrpPrice = json['totalMrpPrice'] != null
        ? parseToDouble(json['totalMrpPrice'].toString())
        : 0;
    totalGstPrice = json['totalGstPrice'] != null
        ? parseToDouble(json['totalGstPrice'].toString())
        : 0;
    totalWithOutSCGSTPrice = json['totalWithOutSCGSTPrice'] != null
        ? parseToDouble(json['totalWithOutSCGSTPrice'].toString())
        : 0;
    totalWithOutGSTPrice = json['totalWithOutGSTPrice'] != null
        ? parseToDouble(json['totalWithOutGSTPrice'].toString())
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
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
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
    sid = json.sid;
    isMultiple = json.isMultiple;
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

ServerCartCountVM cartCountVMFromJson(dynamic str) =>
    (ServerCartCountVM.fromJson(str));

class ServerCartCountVM {
  late final int totalQuantity;

  ServerCartCountVM({required this.totalQuantity});

  ServerCartCountVM.fromJson(dynamic json) {
    totalQuantity = json.totalQuantity;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalQuantity'] = this.totalQuantity;
    return data;
  }
}
