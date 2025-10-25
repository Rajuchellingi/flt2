CartSetting cartSettingFromJson(dynamic str) => (CartSetting.fromJson(str));

class CartSetting {
  late final String? sId;
  late final String? showDiscountProgressBar;
  late final CartRecommendedProducts? recommendedProducts;
  late final List<DiscountProgressBar>? discountProgressBar;
  late final String? sTypename;

  CartSetting(
      {required this.sId,
      required this.showDiscountProgressBar,
      required this.recommendedProducts,
      required this.discountProgressBar,
      required this.sTypename});

  CartSetting.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    showDiscountProgressBar = json['showDiscountProgressBar'];
    if (json['discountProgressBar'] != null) {
      discountProgressBar = <DiscountProgressBar>[];
      json['discountProgressBar'].forEach((v) {
        discountProgressBar!.add(new DiscountProgressBar.fromJson(v));
      });
    } else {
      discountProgressBar = <DiscountProgressBar>[];
    }
    recommendedProducts = json['recommendedProducts'] != null
        ? new CartRecommendedProducts.fromJson(json['recommendedProducts'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['showDiscountProgressBar'] = this.showDiscountProgressBar;
    if (this.recommendedProducts != null) {
      data['recommendedProducts'] = this.recommendedProducts!.toJson();
    }
    if (this.discountProgressBar != null) {
      data['discountProgressBar'] =
          this.discountProgressBar!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;

    return data;
  }
}

class CartRecommendedProducts {
  late final String? sId;
  late final String? title;
  late final String? type;
  late final String? singleCollectionUrl;
  late final List<CartCollections>? collections;
  late final String? sTypename;

  CartRecommendedProducts(
      {required this.sId,
      required this.title,
      required this.type,
      required this.singleCollectionUrl,
      required this.collections,
      required this.sTypename});

  CartRecommendedProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    type = json['type'];
    singleCollectionUrl = json['singleCollectionUrl'];
    if (json['collections'] != null) {
      collections = <CartCollections>[];
      json['collections'].forEach((v) {
        collections!.add(new CartCollections.fromJson(v));
      });
    } else {
      collections = <CartCollections>[];
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['singleCollectionUrl'] = this.singleCollectionUrl;
    if (this.collections != null) {
      data['collections'] = this.collections!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;

    return data;
  }
}

class DiscountProgressBar {
  late final String? sId;
  late final String? title;
  late final dynamic discountValue;
  late final String? discountType;
  late final String? requirementType;
  late final dynamic requirementValue;
  late final String? sTypename;

  DiscountProgressBar({
    required this.sId,
    required this.title,
    required this.discountValue,
    required this.discountType,
    required this.requirementType,
    required this.requirementValue,
    required this.sTypename,
  });

  DiscountProgressBar.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    discountValue = json['discountValue'];
    discountType = json['discountType'];
    requirementType = json['requirementType'];
    requirementValue = json['requirementValue'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['discountValue'] = this.discountValue;
    data['discountType'] = this.discountType;
    data['requirementType'] = this.requirementType;
    data['requirementValue'] = this.requirementValue;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CartCollections {
  late final String? sId;
  late final String? title;
  late final String? imageName;
  late final String? collectionUrl;
  late final String? sTypename;

  CartCollections({
    required this.sId,
    required this.title,
    required this.imageName,
    required this.collectionUrl,
    required this.sTypename,
  });

  CartCollections.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    imageName = json['imageName'];
    collectionUrl = json['collectionUrl'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['imageName'] = this.imageName;
    data['collectionUrl'] = this.collectionUrl;
    data['__typename'] = this.sTypename;
    return data;
  }
}
