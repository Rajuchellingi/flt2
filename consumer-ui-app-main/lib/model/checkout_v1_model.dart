CheckoutDataVM checkoutDataVMFromJson(dynamic str) =>
    (CheckoutDataVM.fromJson(str));
List<CheckoutAddressVM> checkoutAddressVMFromJson(dynamic str) =>
    List<CheckoutAddressVM>.from(str.map((x) => CheckoutAddressVM.fromJson(x)));

class CheckoutDataVM {
  late final CheckoutPriceSummaryVM? orderSummary;
  late final List<CartProductsVM> products;

  CheckoutDataVM({
    required this.products,
    required this.orderSummary,
  });

  CheckoutDataVM.fromJson(dynamic json) {
    orderSummary = json.orderSummary != null
        ? new CheckoutPriceSummaryVM.fromJson(json.orderSummary)
        : null;
    if (json.products != null) {
      products = <CartProductsVM>[];
      json.products.forEach((v) {
        products.add(new CartProductsVM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderSummary != null) {
      data['orderSummary'] = this.orderSummary!.toJson();
    }
    data['product'] = this.products.map((v) => v.toJson()).toList();
    return data;
  }
}

class CartProductsVM {
  late final String? sId;
  late final String? setId;
  late final String? productId;
  late final String? type;
  late final bool? isCustomizable;
  late final bool? setIsCustomizable;
  late final bool? isAssorted;
  late final String? productName;
  late final String? url;
  late final int? moq;
  late final int? setQuantityValue;
  late final CheckoutProductPriceVM? price;
  late final bool? isWishlist;
  late final List? wishlistCollection;
  late final CartProductImageVM? image;
  late final int? quantity;
  late final num? totalPrice;
  late final num? priceWithoutDiscount;
  late final int? totalCartQuantity;
  late final CheckoutSetQuantityVM? setQuantity;
  late final CheckoutPackQuantityVM? packQuantity;
  late final CheckoutPreferenceVariantVM? preferenceVariant;
  late final List<CheckoutVariantsVM>? variants;
  late final List<CheckoutProductVariantVM>? productVariant;

  CartProductsVM({
    required this.sId,
    required this.setId,
    required this.productId,
    required this.type,
    required this.isCustomizable,
    required this.setIsCustomizable,
    required this.isAssorted,
    required this.productName,
    required this.quantity,
    required this.url,
    required this.moq,
    required this.isWishlist,
    required this.wishlistCollection,
    required this.preferenceVariant,
    required this.image,
    required this.price,
    required this.setQuantityValue,
    required this.totalPrice,
    required this.priceWithoutDiscount,
    required this.totalCartQuantity,
    required this.setQuantity,
    required this.variants,
    required this.productVariant,
    required this.packQuantity,
  });

  CartProductsVM.fromJson(dynamic json) {
    sId = json.sId;
    setId = json.setId;
    productId = json.productId;
    type = json.type;
    isCustomizable = json.isCustomizable;
    isAssorted = json.isAssorted;
    setIsCustomizable = json.setIsCustomizable;
    setQuantityValue = json.setQuantityValue;
    productName = json.productName;
    quantity = json.quantity;
    url = json.url;
    moq = json.moq;
    price = json.price != null
        ? new CheckoutProductPriceVM.fromJson(json.price)
        : null;
    isWishlist = json.isWishlist;
    wishlistCollection = json.wishlistCollection;
    image =
        json.image != null ? new CartProductImageVM.fromJson(json.image) : null;
    totalPrice = json.totalPrice;
    priceWithoutDiscount = json.priceWithoutDiscount;
    totalCartQuantity = json.totalCartQuantity;
    setQuantity = json.setQuantity != null
        ? new CheckoutSetQuantityVM.fromJson(json.setQuantity)
        : null;
    packQuantity = json.packQuantity != null
        ? new CheckoutPackQuantityVM.fromJson(json.packQuantity)
        : null;
    preferenceVariant = json.preferenceVariant != null
        ? new CheckoutPreferenceVariantVM.fromJson(json.preferenceVariant)
        : null;
    if (json.variants != null) {
      variants = <CheckoutVariantsVM>[];
      json.variants.forEach((v) {
        variants!.add(new CheckoutVariantsVM.fromJson(v));
      });
    } else {
      variants = [];
    }
    if (json.productVariant != null) {
      productVariant = <CheckoutProductVariantVM>[];
      json.productVariant.forEach((v) {
        productVariant!.add(new CheckoutProductVariantVM.fromJson(v));
      });
    } else {
      productVariant = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['setId'] = this.setId;
    data['productId'] = this.productId;
    data['type'] = this.type;
    data['isCustomizable'] = this.isCustomizable;
    data['setIsCustomizable'] = this.setIsCustomizable;
    data['setQuantityValue'] = this.setQuantityValue;
    data['isAssorted'] = this.isAssorted;
    data['productName'] = this.productName;
    data['quantity'] = this.quantity;
    data['url'] = this.url;
    data['moq'] = this.moq;
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
    if (this.productVariant != null) {
      data['productVariant'] =
          this.productVariant!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckoutProductVariantVM {
  late final String? attributeLabelName;
  late final String? attributeFieldValue;

  CheckoutProductVariantVM({
    required this.attributeLabelName,
    required this.attributeFieldValue,
  });

  CheckoutProductVariantVM.fromJson(dynamic json) {
    attributeLabelName = json.attributeLabelName;
    attributeFieldValue = json.attributeFieldValue;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeLabelName'] = this.attributeLabelName;
    data['attributeFieldValue'] = this.attributeFieldValue;
    return data;
  }
}

class CheckoutPreferenceVariantVM {
  late final String? attributeLabelName;
  late final String? attributeFieldValue;

  CheckoutPreferenceVariantVM({
    required this.attributeFieldValue,
    required this.attributeLabelName,
  });

  CheckoutPreferenceVariantVM.fromJson(dynamic json) {
    attributeFieldValue = json.attributeFieldValue;
    attributeLabelName = json.attributeLabelName;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeFieldValue'] = this.attributeFieldValue;
    data['attributeLabelName'] = this.attributeLabelName;
    return data;
  }
}

class CheckoutTaxDetailsVM {
  late final String? labelName;
  late final num? amount;
  late final num? value;

  CheckoutTaxDetailsVM(
      {required this.labelName, required this.amount, required this.value});

  CheckoutTaxDetailsVM.fromJson(dynamic json) {
    labelName = json.labelName;
    amount = json.amount;
    value = json.value;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subTotal'] = this.labelName;
    data['amount'] = this.amount;
    data['value'] = this.value;
    return data;
  }
}

class CheckoutPriceSummaryVM {
  late final num? subTotal;
  late final String? currencySymbol;
  late final num? total;
  late final int? totalCartQuantity;
  late final num? discount;
  late final num? totalTax;
  late final List<CheckoutTaxDetailsVM>? taxes;

  CheckoutPriceSummaryVM(
      {required this.subTotal,
      required this.total,
      required this.totalCartQuantity,
      required this.currencySymbol,
      required this.discount,
      required this.totalTax,
      required this.taxes});

  CheckoutPriceSummaryVM.fromJson(dynamic json) {
    subTotal = json.subTotal;
    total = json.total;
    totalCartQuantity = json.totalCartQuantity;
    currencySymbol = json.currencySymbol;
    totalTax = json.totalTax;
    discount = json.discount;
    if (json.taxes != null) {
      taxes = <CheckoutTaxDetailsVM>[];
      json.taxes.forEach((v) {
        taxes!.add(new CheckoutTaxDetailsVM.fromJson(v));
      });
    } else {
      taxes = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subTotal'] = this.subTotal;
    data['total'] = this.total;
    data['totalCartQuantity'] = this.totalCartQuantity;
    data['currencySymbol'] = this.currencySymbol;
    data['discount'] = this.discount;
    data['totalTax'] = this.totalTax;
    if (this.taxes != null) {
      data['taxes'] = this.taxes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckoutProductPriceVM {
  late final num? sellingPrice;
  late final String? currencySymbol;
  late final num? mrp;
  late final num? discount;

  CheckoutProductPriceVM({
    required this.sellingPrice,
    required this.currencySymbol,
    required this.mrp,
    required this.discount,
  });

  CheckoutProductPriceVM.fromJson(dynamic json) {
    sellingPrice = json.sellingPrice;
    mrp = json.mrp;
    discount = json.discount;
    currencySymbol = json.currencySymbol;
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

class CartProductImageVM {
  late final String? imageName;
  late final String? imageId;

  CartProductImageVM({
    required this.imageId,
    required this.imageName,
  });

  CartProductImageVM.fromJson(dynamic json) {
    imageId = json.imageId;
    imageName = json.imageName;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageId'] = this.imageId;
    data['imageName'] = this.imageName;
    return data;
  }
}

class CheckoutPackQuantityVM {
  late final int? totalQuantity;
  late final String? variantType;
  late final List<CheckoutPackSetQuantityVM>? setQuantities;

  CheckoutPackQuantityVM({
    required this.totalQuantity,
    required this.variantType,
    required this.setQuantities,
  });

  CheckoutPackQuantityVM.fromJson(dynamic json) {
    totalQuantity = json.totalQuantity;
    variantType = json.variantType;
    if (json.setQuantities != null) {
      setQuantities = <CheckoutPackSetQuantityVM>[];
      json.setQuantities.forEach((v) {
        setQuantities!.add(new CheckoutPackSetQuantityVM.fromJson(v));
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

class CheckoutPackSetQuantityVM {
  late final String? attributeFieldValueId;
  late final String? attributeFieldValue;
  late final List<CheckoutVariantQuantitesVM>? variantQuantites;

  CheckoutPackSetQuantityVM({
    required this.attributeFieldValueId,
    required this.attributeFieldValue,
    required this.variantQuantites,
  });

  CheckoutPackSetQuantityVM.fromJson(dynamic json) {
    attributeFieldValueId = json.attributeFieldValueId;
    attributeFieldValue = json.attributeFieldValue;
    if (json.variantQuantites != null) {
      variantQuantites = <CheckoutVariantQuantitesVM>[];
      json.variantQuantites.forEach((v) {
        variantQuantites!.add(new CheckoutVariantQuantitesVM.fromJson(v));
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

class CheckoutSetQuantityVM {
  late final int? totalQuantity;
  late final String? variantType;
  late final List<CheckoutVariantQuantitesVM>? variantQuantites;

  CheckoutSetQuantityVM({
    required this.totalQuantity,
    required this.variantType,
    required this.variantQuantites,
  });

  CheckoutSetQuantityVM.fromJson(dynamic json) {
    totalQuantity = json.totalQuantity;
    variantType = json.variantType;
    if (json.variantQuantites != null) {
      variantQuantites = <CheckoutVariantQuantitesVM>[];
      json.variantQuantites.forEach((v) {
        variantQuantites!.add(new CheckoutVariantQuantitesVM.fromJson(v));
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

class CheckoutVariantQuantitesVM {
  late final String? attributeFieldValue;
  late final int? moq;
  late final num? sellingPrice;

  CheckoutVariantQuantitesVM({
    required this.attributeFieldValue,
    required this.moq,
    required this.sellingPrice,
  });

  CheckoutVariantQuantitesVM.fromJson(dynamic json) {
    attributeFieldValue = json.attributeFieldValue;
    moq = json.moq;
    sellingPrice = json.sellingPrice;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeFieldValue'] = this.attributeFieldValue;
    data['moq'] = this.moq;
    data['sellingPrice'] = this.sellingPrice;
    return data;
  }
}

class CheckoutVariantsVM {
  late final String? variantId;
  late final String? attributeFieldValue;
  late final num? sellingPrice;
  late final int? totalQuantity;
  late final num? totalPrice;
  late final int? quantity;
  late final int? moq;

  CheckoutVariantsVM({
    required this.variantId,
    required this.attributeFieldValue,
    required this.sellingPrice,
    required this.totalQuantity,
    required this.quantity,
    required this.totalPrice,
    required this.moq,
  });

  CheckoutVariantsVM.fromJson(dynamic json) {
    variantId = json.variantId;
    attributeFieldValue = json.attributeFieldValue;
    sellingPrice = json.sellingPrice;
    totalQuantity = json.totalQuantity;
    quantity = json.quantity;
    totalPrice = json.totalPrice;
    moq = json.moq;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variantId'] = this.variantId;
    data['attributeFieldValue'] = this.attributeFieldValue;
    data['sellingPrice'] = this.sellingPrice;
    data['quantity'] = this.quantity;
    data['totalQuantity'] = this.totalQuantity;
    data['totalPrice'] = this.totalPrice;
    data['moq'] = this.moq;
    return data;
  }
}

class CheckoutAddressVM {
  late final String? sId;
  late final String? city;
  late final String? country;
  late final String? contactName;
  late final String? emailId;
  late final String? mobileNumber;
  late final String? address;
  late final String? landmark;
  late final String? pinCode;
  late final String? state;
  late final bool? shippingAddress;
  late final bool? billingAddress;

  CheckoutAddressVM({
    required this.sId,
    required this.city,
    required this.country,
    required this.contactName,
    required this.emailId,
    required this.mobileNumber,
    required this.address,
    required this.landmark,
    required this.pinCode,
    required this.state,
    required this.shippingAddress,
    required this.billingAddress,
  });

  CheckoutAddressVM.fromJson(dynamic json) {
    sId = json.sId;
    city = json.city;
    country = json.country;
    contactName = json.contactName;
    emailId = json.emailId;
    mobileNumber = json.mobileNumber;
    address = json.address;
    landmark = json.landmark;
    pinCode = json.pinCode;
    state = json.state;
    shippingAddress = json.shippingAddress;
    billingAddress = json.billingAddress;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['city'] = this.city;
    data['country'] = this.country;
    data['contactName'] = this.contactName;
    data['emailId'] = this.emailId;
    data['mobileNumber'] = this.mobileNumber;
    data['address'] = this.address;
    data['landmark'] = this.landmark;
    data['pinCode'] = this.pinCode;
    data['state'] = this.state;
    data['shippingAddress'] = this.shippingAddress;
    data['billingAddress'] = this.billingAddress;
    return data;
  }
}
