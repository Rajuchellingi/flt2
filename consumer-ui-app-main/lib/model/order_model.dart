MyOrdersVM myOrdersVMFromJson(dynamic str) => (MyOrdersVM.fromJson(str));
MyOrderDetailVM myOrderDetailVMFromJson(dynamic str) =>
    (MyOrderDetailVM.fromJson(str));

class MyOrdersVM {
  late final int? count;
  late final int? totalPages;
  late final List<MyOrderDataVM> orderData;

  MyOrdersVM({
    required this.orderData,
    required this.count,
    required this.totalPages,
  });

  MyOrdersVM.fromJson(dynamic json) {
    count = json.count;
    totalPages = json.totalPages;
    if (json.orderData != null) {
      orderData = <MyOrderDataVM>[];
      json.orderData.forEach((v) {
        orderData.add(new MyOrderDataVM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['totalPages'] = this.totalPages;
    if (data['orderData'] != null)
      data['orderData'] = this.orderData.map((v) => v.toJson()).toList();
    return data;
  }
}

class MyOrderDataVM {
  late final String? sId;
  late final String? status;
  late final String? creationDate;
  late final String? currencySymbol;
  late final String? orderNo;
  late final List<String>? productNames;
  late final int? orderType;
  late final num? totalPrice;

  MyOrderDataVM(
      {required this.sId,
      required this.status,
      required this.orderType,
      required this.currencySymbol,
      required this.creationDate,
      required this.orderNo,
      required this.productNames,
      required this.totalPrice});

  MyOrderDataVM.fromJson(dynamic json) {
    sId = json.sId;
    orderType = 2;
    status = json.status;
    productNames = json.productNames;
    currencySymbol = json.currencySymbol;
    creationDate = json.creationDate;
    orderNo = json.orderNo;
    totalPrice = json.totalPrice;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['currencySymbol'] = this.currencySymbol;
    data['orderType'] = this.orderType;
    data['creationDate'] = this.creationDate;
    data['productNames'] = this.productNames;
    data['orderNo'] = this.orderNo;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}

class MyOrderDetailVM {
  late final String? sId;
  late final OrderAddressVM? billingAddress;
  late final OrderAddressVM? shippingAddress;
  late final OrderUserDetailsVM? user;
  late final OrderPriceVM? price;
  late final String? status;
  late final String? statusUrl;
  late final String? orderNo;
  late final String? orderNumber;
  late final String? creationDate;
  late final List<OrderProductsVM> products;

  MyOrderDetailVM({
    required this.sId,
    required this.billingAddress,
    required this.shippingAddress,
    required this.user,
    required this.price,
    required this.status,
    required this.statusUrl,
    required this.orderNumber,
    required this.orderNo,
    required this.creationDate,
    required this.products,
  });

  MyOrderDetailVM.fromJson(dynamic json) {
    sId = json.sId;
    status = json.status;
    orderNo = json.orderNo;
    orderNumber = json.orderNumber;
    statusUrl = json.statusUrl;
    creationDate = json.creationDate;
    billingAddress = json.billingAddress != null
        ? new OrderAddressVM.fromJson(json.billingAddress)
        : null;
    shippingAddress = json.shippingAddress != null
        ? new OrderAddressVM.fromJson(json.shippingAddress)
        : null;
    user =
        json.user != null ? new OrderUserDetailsVM.fromJson(json.user) : null;
    price = json.price != null ? new OrderPriceVM.fromJson(json.price) : null;

    if (json.products != null) {
      products = <OrderProductsVM>[];
      json.products.forEach((v) {
        products.add(new OrderProductsVM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sId'] = this.sId;
    data['status'] = this.status;
    data['statusUrl'] = this.statusUrl;
    data['orderNumber'] = this.orderNumber;
    data['orderNo'] = this.orderNo;
    data['creationDate'] = this.creationDate;
    if (this.billingAddress != null) {
      data['billingAddress'] = this.billingAddress!.toJson();
    }
    if (this.shippingAddress != null) {
      data['shippingAddress'] = this.shippingAddress!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (data['products'] != null)
      data['products'] = this.products.map((v) => v.toJson()).toList();
    return data;
  }
}

class OrderProductsVM {
  late final String? sId;
  late final String? setId;
  late final String? productId;
  late final String? type;
  late final bool? isCustomizable;
  late final bool? isAssorted;
  late final String? productName;
  late final String? url;
  late final int? moq;
  late final OrderProductPriceVM? price;
  late final OrderProductImageVM? image;
  late final int? quantity;
  late final num? totalPrice;
  late final num? priceWithoutDiscount;
  late final int? totalCartQuantity;
  late final OrderSetQuantityVM? setQuantity;
  late final OrderPackQuantityVM? packQuantity;
  late final bool? setIsCustomizable;
  late final OrderPreferenceVariantVM? preferenceVariant;
  late final int? setMoqPieces;
  late final int? setQuantityValue;
  late final List<OrderVariantsVM>? variants;
  late final List<OrderProductVariantVM>? productVariant;

  OrderProductsVM({
    required this.sId,
    required this.setId,
    required this.productId,
    required this.type,
    required this.isCustomizable,
    required this.isAssorted,
    required this.productName,
    required this.quantity,
    required this.url,
    required this.moq,
    required this.image,
    required this.price,
    required this.setIsCustomizable,
    required this.preferenceVariant,
    required this.setMoqPieces,
    required this.setQuantityValue,
    required this.totalPrice,
    required this.priceWithoutDiscount,
    required this.totalCartQuantity,
    required this.setQuantity,
    required this.variants,
    required this.packQuantity,
    required this.productVariant,
  });

  OrderProductsVM.fromJson(dynamic json) {
    sId = json.sId;
    setId = json.setId;
    productId = json.productId;
    type = json.type;
    isCustomizable = json.isCustomizable;
    isAssorted = json.isAssorted;
    productName = json.productName;
    setQuantityValue = json.setQuantityValue;
    quantity = json.quantity;
    url = json.url;
    moq = json.moq;
    price = json.price != null
        ? new OrderProductPriceVM.fromJson(json.price)
        : null;
    image = json.image != null
        ? new OrderProductImageVM.fromJson(json.image)
        : null;
    setIsCustomizable = json.setIsCustomizable;
    setMoqPieces = json.setMoqPieces;
    preferenceVariant = json.preferenceVariant != null
        ? new OrderPreferenceVariantVM.fromJson(json.preferenceVariant)
        : null;
    totalPrice = json.totalPrice;
    priceWithoutDiscount = json.priceWithoutDiscount;
    totalCartQuantity = json.totalCartQuantity;
    setQuantity = json.setQuantity != null
        ? new OrderSetQuantityVM.fromJson(json.setQuantity)
        : null;
    packQuantity = json.packQuantity != null
        ? new OrderPackQuantityVM.fromJson(json.packQuantity)
        : null;
    if (json.variants != null) {
      variants = <OrderVariantsVM>[];
      json.variants.forEach((v) {
        variants!.add(new OrderVariantsVM.fromJson(v));
      });
    } else {
      variants = [];
    }
    if (json.productVariant != null) {
      productVariant = <OrderProductVariantVM>[];
      json.productVariant.forEach((v) {
        productVariant!.add(new OrderProductVariantVM.fromJson(v));
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
    data['isAssorted'] = this.isAssorted;
    data['productName'] = this.productName;
    data['quantity'] = this.quantity;
    data['url'] = this.url;
    data['moq'] = this.moq;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['totalPrice'] = this.totalPrice;
    data['priceWithoutDiscount'] = this.priceWithoutDiscount;
    data['totalCartQuantity'] = this.totalCartQuantity;
    data['setMoqPieces'] = this.setMoqPieces;
    data['setQuantityValue'] = this.setQuantityValue;
    data['setIsCustomizable'] = this.setIsCustomizable;
    if (this.preferenceVariant != null) {
      data['preferenceVariant'] = this.preferenceVariant!.toJson();
    }
    if (this.setQuantity != null) {
      data['setQuantity'] = this.setQuantity!.toJson();
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

class OrderPreferenceVariantVM {
  late final String? attributeLabelName;
  late final String? attributeFieldValue;

  OrderPreferenceVariantVM({
    required this.attributeFieldValue,
    required this.attributeLabelName,
  });

  OrderPreferenceVariantVM.fromJson(dynamic json) {
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

class OrderPriceVM {
  late final String? currencySymbol;
  late final num? totalMrp;
  late final num? discount;
  late final num? subTotalPrice;
  late final num? totalPrice;
  late final num? totalGstPrice;
  late final num? refundedPrice;

  OrderPriceVM({
    required this.totalMrp,
    required this.currencySymbol,
    required this.subTotalPrice,
    required this.totalPrice,
    required this.discount,
    required this.totalGstPrice,
    required this.refundedPrice,
  });

  OrderPriceVM.fromJson(dynamic json) {
    totalMrp = json.totalMrp;
    currencySymbol = json.currencySymbol;
    subTotalPrice = json.subTotalPrice;
    refundedPrice = json.refundedPrice;
    totalPrice = json.totalPrice;
    totalGstPrice = json.totalGstPrice;
    discount = json.discount;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalMrp'] = this.totalMrp;
    data['currencySymbol'] = this.currencySymbol;
    data['subTotalPrice'] = this.subTotalPrice;
    data['refundedPrice'] = this.refundedPrice;
    data['totalPrice'] = this.totalPrice;
    data['discount'] = this.discount;
    data['totalGstPrice'] = this.totalGstPrice;
    return data;
  }
}

class OrderProductPriceVM {
  late final String? currencySymbol;
  late final num? sellingPrice;
  late final num? mrp;
  late final num? discount;

  OrderProductPriceVM({
    required this.sellingPrice,
    required this.currencySymbol,
    required this.mrp,
    required this.discount,
  });

  OrderProductPriceVM.fromJson(dynamic json) {
    sellingPrice = json.sellingPrice;
    currencySymbol = json.currencySymbol;
    mrp = json.mrp;
    discount = json.discount;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellingPrice'] = this.sellingPrice;
    data['currencySymbol'] = this.currencySymbol;
    data['mrp'] = this.mrp;
    data['discount'] = this.discount;
    return data;
  }
}

class OrderProductImageVM {
  late final String? imageName;
  late final String? imageId;

  OrderProductImageVM({
    required this.imageId,
    required this.imageName,
  });

  OrderProductImageVM.fromJson(dynamic json) {
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

class OrderPackQuantityVM {
  late final int? totalQuantity;
  late final String? variantType;
  late final List<OrderPackSetQuantityVM>? setQuantities;

  OrderPackQuantityVM({
    required this.totalQuantity,
    required this.variantType,
    required this.setQuantities,
  });

  OrderPackQuantityVM.fromJson(dynamic json) {
    totalQuantity = json.totalQuantity;
    variantType = json.variantType;
    if (json.setQuantities != null) {
      setQuantities = <OrderPackSetQuantityVM>[];
      json.setQuantities.forEach((v) {
        setQuantities!.add(new OrderPackSetQuantityVM.fromJson(v));
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

class OrderPackSetQuantityVM {
  late final String? attributeFieldValueId;
  late final String? attributeFieldValue;
  late final List<OrderVariantQuantitesVM>? variantQuantites;

  OrderPackSetQuantityVM({
    required this.attributeFieldValueId,
    required this.attributeFieldValue,
    required this.variantQuantites,
  });

  OrderPackSetQuantityVM.fromJson(dynamic json) {
    attributeFieldValueId = json.attributeFieldValueId;
    attributeFieldValue = json.attributeFieldValue;
    if (json.variantQuantites != null) {
      variantQuantites = <OrderVariantQuantitesVM>[];
      json.variantQuantites.forEach((v) {
        variantQuantites!.add(new OrderVariantQuantitesVM.fromJson(v));
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

class OrderSetQuantityVM {
  late final int? totalQuantity;
  late final String? variantType;
  late final List<OrderVariantQuantitesVM>? variantQuantites;

  OrderSetQuantityVM({
    required this.totalQuantity,
    required this.variantType,
    required this.variantQuantites,
  });

  OrderSetQuantityVM.fromJson(dynamic json) {
    totalQuantity = json.totalQuantity;
    variantType = json.variantType;
    if (json.variantQuantites != null) {
      variantQuantites = <OrderVariantQuantitesVM>[];
      json.variantQuantites.forEach((v) {
        variantQuantites!.add(new OrderVariantQuantitesVM.fromJson(v));
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

class OrderVariantQuantitesVM {
  late final String? attributeFieldValue;
  late final int? moq;
  late final num? sellingPrice;

  OrderVariantQuantitesVM({
    required this.attributeFieldValue,
    required this.moq,
    required this.sellingPrice,
  });

  OrderVariantQuantitesVM.fromJson(dynamic json) {
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

class OrderProductVariantVM {
  late final String? attributeLabelName;
  late final String? attributeFieldValue;

  OrderProductVariantVM({
    required this.attributeLabelName,
    required this.attributeFieldValue,
  });

  OrderProductVariantVM.fromJson(dynamic json) {
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

class OrderVariantsVM {
  late final String? variantId;
  late final String? attributeFieldValue;
  late final num? sellingPrice;
  late final num? totalPrice;
  late final int? totalQuantity;
  late final int? quantity;
  late final int? moq;

  OrderVariantsVM({
    required this.variantId,
    required this.attributeFieldValue,
    required this.sellingPrice,
    required this.totalPrice,
    required this.totalQuantity,
    required this.moq,
    required this.quantity,
  });

  OrderVariantsVM.fromJson(dynamic json) {
    variantId = json.variantId;
    attributeFieldValue = json.attributeFieldValue;
    sellingPrice = json.sellingPrice;
    totalPrice = json.totalPrice;
    totalQuantity = json.totalQuantity;
    moq = json.moq;
    quantity = json.quantity;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variantId'] = this.variantId;
    data['attributeFieldValue'] = this.attributeFieldValue;
    data['sellingPrice'] = this.sellingPrice;
    data['quantity'] = this.quantity;
    data['totalQuantity'] = this.totalQuantity;
    data['moq'] = this.moq;
    return data;
  }
}

class OrderUserDetailsVM {
  late final String? sId;
  late final String? firstName;
  late final String? lastName;
  late final String? name;
  late final String? emailId;
  late final String? mobileNumber;

  OrderUserDetailsVM({
    required this.sId,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.emailId,
    required this.mobileNumber,
  });

  OrderUserDetailsVM.fromJson(dynamic json) {
    sId = json.sId;
    firstName = json.firstName;
    lastName = json.lastName;
    name = json.name;
    emailId = json.emailId;
    mobileNumber = json.mobileNumber;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['name'] = this.name;
    data['emailId'] = this.emailId;
    data['mobileNumber'] = this.mobileNumber;
    return data;
  }
}

class OrderAddressVM {
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

  OrderAddressVM({
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
  });

  OrderAddressVM.fromJson(dynamic json) {
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
    return data;
  }
}
