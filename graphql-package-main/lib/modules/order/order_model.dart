// ignore_for_file: unnecessary_null_comparison

Checkout createCheckoutFromJson(dynamic str) => (Checkout.fromJson(str));

class Checkout {
  late final String? sId;
  late final String? webUrl;
  late final String sTypename;

  Checkout({required this.sId, required this.webUrl, required this.sTypename});

  Checkout.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    webUrl = json['webUrl'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['webUrl'] = this.webUrl;
    data['__typename'] = this.sTypename;
    return data;
  }
}

OrderListModel orderListModelFromJson(
        dynamic str, dynamic pageModel, dynamic customer) =>
    (OrderListModel.fromJson(str, pageModel, customer));

class OrderListModel {
  late final List<Order> order;
  late final Page? pageInfo;
  OrderListModel({
    required this.order,
    required this.pageInfo,
  });

  OrderListModel.fromJson(dynamic json, dynamic pageModel, dynamic customer) {
    if (json != null) {
      order = [];
      json.forEach((v) {
        order.add(new Order.fromJson(v, pageModel, customer));
      });
    }
    pageInfo =
        pageModel['page'] != null ? new Page.fromJson(pageModel['page']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order.map((v) => v.toJson()).toList();
    }
    if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo!.toJson();
    }
    return data;
  }
}

List<Order> orderListFromJson(
        dynamic str, dynamic pageModel, dynamic customer) =>
    List<Order>.from(str.map((x) => Order.fromJson(x, pageModel, customer)));

class Order {
  late final String? sId;
  late final OrderAddress? billingAddress;
  late final OrderAddress? shippingAddress;
  late final OrderUserDetails? user;
  late final OrderPrice? price;
  late final String? status;
  late final String? orderNo;
  late final String? orderNumber;
  late final String? creationDate;
  late final String? statusUrl;
  late final List<OrderProducts> products;

  Order({
    required this.sId,
    required this.billingAddress,
    required this.shippingAddress,
    required this.user,
    required this.price,
    required this.orderNumber,
    required this.status,
    required this.orderNo,
    required this.creationDate,
    required this.statusUrl,
    required this.products,
  });

  Order.fromJson(
      Map<String, dynamic> json, dynamic pageModel, dynamic customer) {
    sId = json['id'];
    orderNo = json['name'];
    orderNumber =
        json['orderNumber'] != null ? json['orderNumber'].toString() : null;
    status =
        json['cancelReason'] != null ? 'CANCELED' : json['fulfillmentStatus'];
    price = new OrderPrice.fromJson(json);
    billingAddress = json['billingAddress'] != null
        ? new OrderAddress.fromJson(json['billingAddress'])
        : null;
    user = customer != null ? new OrderUserDetails.fromJson(customer) : null;
    shippingAddress = json['shippingAddress'] != null
        ? new OrderAddress.fromJson(json['shippingAddress'])
        : null;
    statusUrl = json['statusUrl'] ?? null;
    creationDate = json['processedAt'] ?? "null";
    if (json['lineItems'] != null && json['lineItems']['nodes'] != null) {
      products = <OrderProducts>[];
      json['lineItems']['nodes'].forEach((v) {
        products.add(new OrderProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sId'] = this.sId;
    data['status'] = this.status;
    data['orderNo'] = this.orderNo;
    data['creationDate'] = this.creationDate;
    data['statusUrl'] = this.statusUrl;
    data['orderNumber'] = this.orderNumber;
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
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (data['products'] != null)
      data['products'] = this.products.map((v) => v.toJson()).toList();
    return data;
  }
}

class OrderPrice {
  late final String? currencySymbol;
  late final num? totalPrice;
  late final num? discount;
  late final num? subTotalPrice;
  late final num? totalMrp;
  late final num? totalGstPrice;
  late final num? refundedPrice;

  OrderPrice(
      {required this.totalPrice,
      required this.discount,
      required this.currencySymbol,
      required this.subTotalPrice,
      required this.refundedPrice,
      required this.totalMrp,
      required this.totalGstPrice});

  OrderPrice.fromJson(Map<String, dynamic> json) {
    var totalPriceValue = json['totalPrice'];
    var subtotalPriceValue = json['subtotalPrice'];
    var totalTaxValue = json['totalTax'];
    var refundValue = json['totalRefunded'];
    totalPrice = (totalPriceValue != null && totalPriceValue['amount'] != null)
        ? num.parse(totalPriceValue['amount'])
        : 0.0;
    totalMrp = (totalPriceValue != null && totalPriceValue['amount'] != null)
        ? num.parse(totalPriceValue['amount'])
        : 0.0;
    discount = (totalPriceValue != null && totalPriceValue['discount'] != null)
        ? num.parse(totalPriceValue['discount'])
        : 0.0;
    subTotalPrice =
        (subtotalPriceValue != null && subtotalPriceValue['amount'] != null)
            ? num.parse(subtotalPriceValue['amount'])
            : 0.0;
    refundedPrice = (refundValue != null && refundValue['amount'] != null)
        ? num.parse(refundValue['amount'])
        : 0.0;
    totalGstPrice = (totalTaxValue != null && totalTaxValue['amount'] != null)
        ? num.parse(totalTaxValue['amount'])
        : 0.0;
    currencySymbol = json['currencySymbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPrice'] = this.totalPrice;
    data['totalGstPrice'] = this.totalGstPrice;
    data['subTotalPrice'] = this.subTotalPrice;
    data['discount'] = this.discount;
    data['currencySymbol'] = this.currencySymbol;
    data['totalMrp'] = this.totalMrp;
    return data;
  }
}

class OrderUserDetails {
  late final String? sId;
  late final String? firstName;
  late final String? lastName;
  late final String? name;
  late final String? emailId;
  late final String? mobileNumber;

  OrderUserDetails({
    required this.sId,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.emailId,
    required this.mobileNumber,
  });

  OrderUserDetails.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    name = json['displayName'];
    emailId = json['email'];
    mobileNumber = json['phone'];
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

class Page {
  late final bool? hasNextPage;
  late final String? endCursor;
  late final String? sTypename;

  Page(
      {required this.hasNextPage,
      required this.endCursor,
      required this.sTypename});

  Page.fromJson(Map<String, dynamic> json) {
    hasNextPage = json['hasNextPage'];
    endCursor = json['endCursor'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasNextPage'] = this.hasNextPage;
    data['endCursor'] = this.endCursor;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class OrderAddress {
  late final String? sId;
  late final String? contactName;
  late final String? emailId;
  late final String? mobileNumber;
  late final String? address;
  late final String? city;
  late final String? state;
  late final String? pinCode;
  late final String? landmark;
  late final String? country;
  late final String sTypename;

  OrderAddress(
      {required this.contactName,
      required this.sId,
      required this.emailId,
      required this.mobileNumber,
      required this.address,
      required this.city,
      required this.state,
      required this.country,
      required this.pinCode,
      required this.sTypename});

  OrderAddress.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    contactName = json['name'];
    emailId = json['emailId'];
    mobileNumber = json['phone'];
    address = json['address1'];
    landmark = json['address2'];
    city = json['city'];
    state = json['province'];
    pinCode = json['zip'];
    country = json['formattedArea'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['contactName'] = this.contactName;
    data['emailId'] = this.emailId;
    data['mobileNumber'] = this.mobileNumber;
    data['address'] = this.address;
    data['landmark'] = this.landmark;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pinCode;
    data['country'] = this.country;
    return data;
  }
}

class OrderProducts {
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
  late final OrderProductPrice? price;
  late final bool? isWishlist;
  late final List? wishlistCollection;
  late final OrderProductImage? image;
  late final int? quantity;
  late final num? totalPrice;
  late final num? priceWithoutDiscount;
  late final int? totalCartQuantity;
  late final OrderSetQuantity? setQuantity;
  late final OrderPreferenceVariant? preferenceVariant;
  late final OrderPackQuantity? packQuantity;
  late final int? setMoqPieces;
  late final List<OrderVariants>? variants;
  late final List<OrderProductVariant>? productVariant;

  OrderProducts({
    required this.sId,
    required this.setId,
    required this.productId,
    required this.type,
    required this.isCustomizable,
    required this.isAssorted,
    required this.preferenceVariant,
    required this.productName,
    required this.setIsCustomizable,
    required this.quantity,
    required this.url,
    required this.moq,
    required this.isWishlist,
    required this.wishlistCollection,
    required this.setQuantityValue,
    required this.image,
    required this.price,
    required this.totalPrice,
    required this.priceWithoutDiscount,
    required this.totalCartQuantity,
    required this.setQuantity,
    required this.setMoqPieces,
    required this.variants,
    required this.packQuantity,
    required this.productVariant,
  });

  OrderProducts.fromJson(Map<String, dynamic> json) {
    var variant = json['variant'];
    var product = variant != null ? variant['product'] : null;
    var totalPriceAmount = json['discountedTotalPrice'];
    var originalPrice = json['originalTotalPrice'];
    sId = product != null ? product['id'] : null;
    setId = variant != null ? variant['setId'] : null;
    productId = product != null ? product['sId'] : null;
    type = 'product';
    isCustomizable = false;
    setIsCustomizable = false;
    isAssorted = false;
    preferenceVariant = null;
    productName = product != null ? product['title'] : json['title'];
    quantity = json['quantity'];
    url = product != null ? product['handle'] : null;
    moq = 1;
    setQuantityValue = 0;
    setMoqPieces = 0;
    price = variant != null ? new OrderProductPrice.fromJson(variant) : null;
    isWishlist = false;
    wishlistCollection = [];
    image = (variant != null && variant['image'] != null)
        ? new OrderProductImage.fromJson(variant['image'])
        : null;
    totalPrice =
        (totalPriceAmount != null && totalPriceAmount['amount'] != null)
            ? num.tryParse(totalPriceAmount['amount'])
            : 0.0;
    priceWithoutDiscount =
        (originalPrice != null && originalPrice['amount'] != null)
            ? num.tryParse(originalPrice['amount'])
            : 0.0;
    totalCartQuantity = json['quantity'];
    setQuantity = null;
    packQuantity = null;
    variants = [];
    if (variant != null && variant['selectedOptions'] != null) {
      productVariant = <OrderProductVariant>[];
      variant['selectedOptions'].forEach((v) {
        productVariant!.add(new OrderProductVariant.fromJson(v));
      });
    } else {
      productVariant = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['setId'] = this.setId;
    data['setQuantityValue'] = this.setQuantityValue;
    data['setIsCustomizable'] = this.setIsCustomizable;
    data['productId'] = this.productId;
    data['type'] = this.type;
    data['preferenceVariant'] = this.preferenceVariant;
    data['isCustomizable'] = this.isCustomizable;
    data['setMoqPieces'] = this.setMoqPieces;
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

class OrderPreferenceVariant {
  late final String? attributeLabelName;
  late final String? attributeFieldValue;

  OrderPreferenceVariant({
    required this.attributeFieldValue,
    required this.attributeLabelName,
  });

  OrderPreferenceVariant.fromJson(dynamic json) {
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

class OrderSetQuantity {
  late final int? totalQuantity;
  late final String? variantType;
  late final List<OrderVariantQuantites>? variantQuantites;

  OrderSetQuantity({
    required this.totalQuantity,
    required this.variantType,
    required this.variantQuantites,
  });

  OrderSetQuantity.fromJson(Map<String, dynamic> json) {
    totalQuantity = json['totalQuantity'];
    variantType = json['variantType'];
    if (json['variantQuantites'] != null) {
      variantQuantites = <OrderVariantQuantites>[];
      json['variantQuantites'].forEach((v) {
        variantQuantites!.add(new OrderVariantQuantites.fromJson(v));
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

class OrderVariants {
  late final String? variantId;
  late final String? attributeFieldValue;
  late final num? sellingPrice;
  late final num? totalPrice;
  late final int? totalQuantity;
  late final int? quantity;

  OrderVariants({
    required this.variantId,
    required this.attributeFieldValue,
    required this.sellingPrice,
    required this.totalPrice,
    required this.totalQuantity,
    required this.quantity,
  });

  OrderVariants.fromJson(Map<String, dynamic> json) {
    variantId = json['variantId'];
    attributeFieldValue = json['attributeFieldValue'];
    sellingPrice =
        json['sellingPrice'] != null ? json['sellingPrice'].toDouble() : null;
    totalPrice =
        json['totalPrice'] != null ? json['totalPrice'].toDouble() : null;
    totalQuantity = json['totalQuantity'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variantId'] = this.variantId;
    data['attributeFieldValue'] = this.attributeFieldValue;
    data['sellingPrice'] = this.sellingPrice;
    data['quantity'] = this.quantity;
    data['totalQuantity'] = this.totalQuantity;
    return data;
  }
}

class OrderVariantQuantites {
  late final String? attributeFieldValue;
  late final int? moq;
  late final num? sellingPrice;

  OrderVariantQuantites({
    required this.attributeFieldValue,
    required this.moq,
    required this.sellingPrice,
  });

  OrderVariantQuantites.fromJson(Map<String, dynamic> json) {
    attributeFieldValue = json['attributeFieldValue'];
    moq = json['moq'];
    sellingPrice =
        json['sellingPrice'] != null ? json['sellingPrice'].toDouble() : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeFieldValue'] = this.attributeFieldValue;
    data['moq'] = this.moq;
    data['sellingPrice'] = this.sellingPrice;
    return data;
  }
}

class OrderProductVariant {
  late final String? attributeLabelName;
  late final String? attributeFieldValue;

  OrderProductVariant({
    required this.attributeLabelName,
    required this.attributeFieldValue,
  });

  OrderProductVariant.fromJson(Map<String, dynamic> json) {
    attributeLabelName = json['name'];
    attributeFieldValue = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeLabelName'] = this.attributeLabelName;
    data['attributeFieldValue'] = this.attributeFieldValue;
    return data;
  }
}

class OrderPackQuantity {
  late final int? totalQuantity;
  late final String? variantType;
  late final List<BookingPackSetQuantity>? setQuantities;

  OrderPackQuantity({
    required this.totalQuantity,
    required this.variantType,
    required this.setQuantities,
  });

  OrderPackQuantity.fromJson(Map<String, dynamic> json) {
    totalQuantity = json['totalQuantity'];
    variantType = json['variantType'];
    if (json['setQuantities'] != null) {
      setQuantities = <BookingPackSetQuantity>[];
      json['setQuantities'].forEach((v) {
        setQuantities!.add(new BookingPackSetQuantity.fromJson(v));
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

class BookingPackSetQuantity {
  late final String? attributeFieldValueId;
  late final String? attributeFieldValue;
  late final List<OrderVariantQuantites>? variantQuantites;

  BookingPackSetQuantity({
    required this.attributeFieldValueId,
    required this.attributeFieldValue,
    required this.variantQuantites,
  });

  BookingPackSetQuantity.fromJson(Map<String, dynamic> json) {
    attributeFieldValueId = json['attributeFieldValueId'];
    attributeFieldValue = json['attributeFieldValue'];
    if (json['variantQuantites'] != null) {
      variantQuantites = <OrderVariantQuantites>[];
      json['variantQuantites'].forEach((v) {
        variantQuantites!.add(new OrderVariantQuantites.fromJson(v));
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

class OrderProductImage {
  late final String? imageName;
  late final String? imageId;

  OrderProductImage({
    required this.imageId,
    required this.imageName,
  });

  OrderProductImage.fromJson(Map<String, dynamic> json) {
    imageId = json['id'];
    imageName = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageId'] = this.imageId;
    data['imageName'] = this.imageName;
    return data;
  }
}

class OrderProductPrice {
  late final String? currencySymbol;
  late final num? sellingPrice;
  late final num? mrp;
  late final num? discount;

  OrderProductPrice({
    required this.currencySymbol,
    required this.sellingPrice,
    required this.mrp,
    required this.discount,
  });

  OrderProductPrice.fromJson(Map<String, dynamic> json) {
    var totalPrice = json['price'];
    var originalPrice = json['compareAtPrice'];
    sellingPrice = (totalPrice != null && totalPrice['amount'] != null)
        ? num.tryParse(totalPrice['amount'])
        : 0.0;
    mrp = (originalPrice != null && originalPrice['amount'] != null)
        ? num.tryParse(originalPrice['amount'])
        : 0.0;
    discount = (originalPrice != null && originalPrice['discount'] != null)
        ? num.tryParse(originalPrice['discount'])
        : 0.0;
    currencySymbol = json['currencySymbol'];
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
