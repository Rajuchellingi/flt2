MyBookingsVM myBookingsVMFromJson(dynamic str) => (MyBookingsVM.fromJson(str));
MyBookingDetailVM myBookingDetailVMFromJson(dynamic str) =>
    (MyBookingDetailVM.fromJson(str));
BookingPaymentVM bookingPaymentVMFromJson(dynamic str) =>
    (BookingPaymentVM.fromJson(str));

class BookingPaymentVM {
  late final String? key;
  late final String? paymentId;
  late final String? userId;
  late final String? link;
  late final String? type;
  late final String? tempTransactionId;
  late final String? signature;
  late final String? payload;
  late final bool? error;
  late final String? storeUrl;
  late final String? environment;
  late final String? message;

  BookingPaymentVM({
    required this.key,
    required this.paymentId,
    required this.userId,
    required this.link,
    required this.type,
    required this.tempTransactionId,
    required this.signature,
    required this.payload,
    required this.error,
    required this.storeUrl,
    required this.environment,
    required this.message,
  });

  BookingPaymentVM.fromJson(dynamic json) {
    key = json.key;
    paymentId = json.paymentId;
    userId = json.userId;
    link = json.link;
    type = json.type;
    tempTransactionId = json.tempTransactionId;
    signature = json.signature;
    payload = json.payload;
    error = json.error;
    storeUrl = json.storeUrl;
    environment = json.environment;
    message = json.message;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['paymentId'] = this.paymentId;
    data['userId'] = this.userId;
    data['link'] = this.link;
    data['type'] = this.type;
    data['tempTransactionId'] = this.tempTransactionId;
    data['signature'] = this.signature;
    data['payload'] = this.payload;
    data['error'] = this.error;
    data['storeUrl'] = this.storeUrl;
    data['environment'] = this.environment;
    data['message'] = this.message;
    return data;
  }
}

class MyBookingsVM {
  late final int? count;
  late final int? totalPages;
  late final List<MyBookingDataVM> bookingData;

  MyBookingsVM({
    required this.bookingData,
    required this.count,
    required this.totalPages,
  });

  MyBookingsVM.fromJson(dynamic json) {
    count = json.count;
    totalPages = json.totalPages;
    if (json.bookingData != null) {
      bookingData = <MyBookingDataVM>[];
      json.bookingData.forEach((v) {
        bookingData.add(new MyBookingDataVM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['totalPages'] = this.totalPages;
    if (data['bookingData'] != null)
      data['bookingData'] = this.bookingData.map((v) => v.toJson()).toList();
    return data;
  }
}

class MyBookingDataVM {
  late final String? sId;
  late final String? status;
  late final String? creationDate;
  late final String? bookingNo;
  late final String? currencySymbol;
  late final List<String>? productNames;
  late final num? totalPrice;

  MyBookingDataVM(
      {required this.sId,
      required this.status,
      required this.creationDate,
      required this.currencySymbol,
      required this.productNames,
      required this.bookingNo,
      required this.totalPrice});

  MyBookingDataVM.fromJson(dynamic json) {
    sId = json.sId;
    status = json.status;
    creationDate = json.creationDate;
    currencySymbol = json.currencySymbol;
    bookingNo = json.bookingNo;
    productNames = json.productNames;
    totalPrice = json.totalPrice;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['creationDate'] = this.creationDate;
    data['bookingNo'] = this.bookingNo;
    data['totalPrice'] = this.totalPrice;
    data['productNames'] = this.productNames;
    data['currencySymbol'] = this.currencySymbol;
    return data;
  }
}

class MyBookingDetailVM {
  late final String? sId;
  late final BookingAddressVM? billingAddress;
  late final BookingAddressVM? shippingAddress;
  late final BookingUserDetailsVM? user;
  late final BookingPriceVM? price;
  late final String? status;
  late final String? bookingNo;
  late final String? paymentStatus;
  late final String? creationDate;
  late final List<BookingProductsVM> products;

  MyBookingDetailVM({
    required this.sId,
    required this.billingAddress,
    required this.shippingAddress,
    required this.user,
    required this.price,
    required this.status,
    required this.bookingNo,
    required this.creationDate,
    required this.paymentStatus,
    required this.products,
  });

  MyBookingDetailVM.fromJson(dynamic json) {
    sId = json.sId;
    status = json.status;
    bookingNo = json.bookingNo;
    creationDate = json.creationDate;
    paymentStatus = json.paymentStatus;
    billingAddress = json.billingAddress != null
        ? new BookingAddressVM.fromJson(json.billingAddress)
        : null;
    shippingAddress = json.shippingAddress != null
        ? new BookingAddressVM.fromJson(json.shippingAddress)
        : null;
    user =
        json.user != null ? new BookingUserDetailsVM.fromJson(json.user) : null;
    price = json.price != null ? new BookingPriceVM.fromJson(json.price) : null;

    if (json.products != null) {
      products = <BookingProductsVM>[];
      json.products.forEach((v) {
        products.add(new BookingProductsVM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sId'] = this.sId;
    data['status'] = this.status;
    data['bookingNo'] = this.bookingNo;
    data['creationDate'] = this.creationDate;
    data['paymentStatus'] = this.paymentStatus;
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

class BookingProductsVM {
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
  late final BookingProductPriceVM? price;
  late final BookingProductImageVM? image;
  late final BookingPreferenceVariantVM? preferenceVariant;
  late final int? quantity;
  late final int? setQuantityValue;
  late final num? totalPrice;
  late final num? priceWithoutDiscount;
  late final int? totalCartQuantity;
  late final int? setMoqPieces;
  late final BookingSetQuantityVM? setQuantity;
  late final BookingPackQuantityVM? packQuantity;
  late final List<BookingVariantsVM>? variants;
  late final List<BookingProductVariantVM>? productVariant;

  BookingProductsVM({
    required this.sId,
    required this.setId,
    required this.productId,
    required this.type,
    required this.isCustomizable,
    required this.setIsCustomizable,
    required this.isAssorted,
    required this.productName,
    required this.quantity,
    required this.preferenceVariant,
    required this.url,
    required this.moq,
    required this.setQuantityValue,
    required this.image,
    required this.price,
    required this.setMoqPieces,
    required this.totalPrice,
    required this.priceWithoutDiscount,
    required this.totalCartQuantity,
    required this.setQuantity,
    required this.variants,
    required this.packQuantity,
    required this.productVariant,
  });

  BookingProductsVM.fromJson(dynamic json) {
    sId = json.sId;
    setId = json.setId;
    productId = json.productId;
    type = json.type;
    isCustomizable = json.isCustomizable;
    setIsCustomizable = json.setIsCustomizable;
    isAssorted = json.isAssorted;
    productName = json.productName;
    quantity = json.quantity;
    url = json.url;
    moq = json.moq;
    setMoqPieces = json.setMoqPieces;
    setQuantityValue = json.setQuantityValue;
    price = json.price != null
        ? new BookingProductPriceVM.fromJson(json.price)
        : null;
    image = json.image != null
        ? new BookingProductImageVM.fromJson(json.image)
        : null;
    preferenceVariant = json.preferenceVariant != null
        ? new BookingPreferenceVariantVM.fromJson(json.preferenceVariant)
        : null;
    totalPrice = json.totalPrice;
    priceWithoutDiscount = json.priceWithoutDiscount;
    totalCartQuantity = json.totalCartQuantity;
    setQuantity = json.setQuantity != null
        ? new BookingSetQuantityVM.fromJson(json.setQuantity)
        : null;
    packQuantity = json.packQuantity != null
        ? new BookingPackQuantityVM.fromJson(json.packQuantity)
        : null;
    if (json.variants != null) {
      variants = <BookingVariantsVM>[];
      json.variants.forEach((v) {
        variants!.add(new BookingVariantsVM.fromJson(v));
      });
    } else {
      variants = [];
    }
    if (json.productVariant != null) {
      productVariant = <BookingProductVariantVM>[];
      json.productVariant.forEach((v) {
        productVariant!.add(new BookingProductVariantVM.fromJson(v));
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
    data['setMoqPieces'] = this.setMoqPieces;
    data['setQuantityValue'] = this.setQuantityValue;
    data['setIsCustomizable'] = this.setIsCustomizable;
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
    if (this.setQuantity != null) {
      data['setQuantity'] = this.setQuantity!.toJson();
    }
    if (this.packQuantity != null) {
      data['packQuantity'] = this.packQuantity!.toJson();
    }
    if (this.preferenceVariant != null) {
      data['preferenceVariant'] = this.preferenceVariant!.toJson();
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

class BookingPreferenceVariantVM {
  late final String? attributeLabelName;
  late final String? attributeFieldValue;

  BookingPreferenceVariantVM({
    required this.attributeFieldValue,
    required this.attributeLabelName,
  });

  BookingPreferenceVariantVM.fromJson(dynamic json) {
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

class BookingPriceVM {
  late final String? currencySymbol;
  late final num? totalMrp;
  late final num? discount;
  late final num? subTotalPrice;
  late final num? totalPrice;
  late final num? totalGstPrice;

  BookingPriceVM({
    required this.totalMrp,
    required this.currencySymbol,
    required this.subTotalPrice,
    required this.totalPrice,
    required this.discount,
    required this.totalGstPrice,
  });

  BookingPriceVM.fromJson(dynamic json) {
    totalMrp = json.totalMrp;
    subTotalPrice = json.subTotalPrice;
    totalPrice = json.totalPrice;
    totalGstPrice = json.totalGstPrice;
    discount = json.discount;
    currencySymbol = json.currencySymbol;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalMrp'] = this.totalMrp;
    data['currencySymbol'] = this.currencySymbol;
    data['subTotalPrice'] = this.subTotalPrice;
    data['totalPrice'] = this.totalPrice;
    data['discount'] = this.discount;
    data['totalGstPrice'] = this.totalGstPrice;
    return data;
  }
}

class BookingProductPriceVM {
  late final String? currencySymbol;
  late final num? sellingPrice;
  late final num? mrp;
  late final num? discount;

  BookingProductPriceVM({
    required this.sellingPrice,
    required this.currencySymbol,
    required this.mrp,
    required this.discount,
  });

  BookingProductPriceVM.fromJson(dynamic json) {
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

class BookingProductImageVM {
  late final String? imageName;
  late final String? imageId;

  BookingProductImageVM({
    required this.imageId,
    required this.imageName,
  });

  BookingProductImageVM.fromJson(dynamic json) {
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

class BookingPackQuantityVM {
  late final int? totalQuantity;
  late final String? variantType;
  late final List<BookingPackSetQuantityVM>? setQuantities;

  BookingPackQuantityVM({
    required this.totalQuantity,
    required this.variantType,
    required this.setQuantities,
  });

  BookingPackQuantityVM.fromJson(dynamic json) {
    totalQuantity = json.totalQuantity;
    variantType = json.variantType;
    if (json.setQuantities != null) {
      setQuantities = <BookingPackSetQuantityVM>[];
      json.setQuantities.forEach((v) {
        setQuantities!.add(new BookingPackSetQuantityVM.fromJson(v));
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

class BookingPackSetQuantityVM {
  late final String? attributeFieldValueId;
  late final String? attributeFieldValue;
  late final List<BookingVariantQuantitesVM>? variantQuantites;

  BookingPackSetQuantityVM({
    required this.attributeFieldValueId,
    required this.attributeFieldValue,
    required this.variantQuantites,
  });

  BookingPackSetQuantityVM.fromJson(dynamic json) {
    attributeFieldValueId = json.attributeFieldValueId;
    attributeFieldValue = json.attributeFieldValue;
    if (json.variantQuantites != null) {
      variantQuantites = <BookingVariantQuantitesVM>[];
      json.variantQuantites.forEach((v) {
        variantQuantites!.add(new BookingVariantQuantitesVM.fromJson(v));
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

class BookingSetQuantityVM {
  late final int? totalQuantity;
  late final String? variantType;
  late final List<BookingVariantQuantitesVM>? variantQuantites;

  BookingSetQuantityVM({
    required this.totalQuantity,
    required this.variantType,
    required this.variantQuantites,
  });

  BookingSetQuantityVM.fromJson(dynamic json) {
    totalQuantity = json.totalQuantity;
    variantType = json.variantType;
    if (json.variantQuantites != null) {
      variantQuantites = <BookingVariantQuantitesVM>[];
      json.variantQuantites.forEach((v) {
        variantQuantites!.add(new BookingVariantQuantitesVM.fromJson(v));
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

class BookingVariantQuantitesVM {
  late final String? attributeFieldValue;
  late final int? moq;
  late final num? sellingPrice;

  BookingVariantQuantitesVM({
    required this.attributeFieldValue,
    required this.moq,
    required this.sellingPrice,
  });

  BookingVariantQuantitesVM.fromJson(dynamic json) {
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

class BookingProductVariantVM {
  late final String? attributeLabelName;
  late final String? attributeFieldValue;

  BookingProductVariantVM({
    required this.attributeLabelName,
    required this.attributeFieldValue,
  });

  BookingProductVariantVM.fromJson(dynamic json) {
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

class BookingVariantsVM {
  late final String? variantId;
  late final String? attributeFieldValue;
  late final num? sellingPrice;
  late final num? totalPrice;
  late final int? totalQuantity;
  late final int? quantity;
  late final int? moq;

  BookingVariantsVM({
    required this.variantId,
    required this.attributeFieldValue,
    required this.sellingPrice,
    required this.totalPrice,
    required this.totalQuantity,
    required this.quantity,
    required this.moq,
  });

  BookingVariantsVM.fromJson(dynamic json) {
    variantId = json.variantId;
    attributeFieldValue = json.attributeFieldValue;
    sellingPrice = json.sellingPrice;
    totalPrice = json.totalPrice;
    totalQuantity = json.totalQuantity;
    quantity = json.quantity;
    moq = json.moq;
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

class BookingUserDetailsVM {
  late final String? sId;
  late final String? firstName;
  late final String? lastName;
  late final String? name;
  late final String? emailId;
  late final String? mobileNumber;

  BookingUserDetailsVM({
    required this.sId,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.emailId,
    required this.mobileNumber,
  });

  BookingUserDetailsVM.fromJson(dynamic json) {
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

class BookingAddressVM {
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

  BookingAddressVM({
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

  BookingAddressVM.fromJson(dynamic json) {
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
