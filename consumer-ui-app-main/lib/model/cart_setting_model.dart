CartSettingVM cartSettingVMFromJson(dynamic str) =>
    (CartSettingVM.fromJson(str));

class CartSettingVM {
  late final String? sId;
  late final String? showDiscountProgressBar;
  late final CartRecommendedProductsVM? recommendedProducts;
  late final List<DiscountProgressBarVM>? discountProgressBar;
  late final String? sTypename;

  CartSettingVM(
      {required this.sId,
      required this.showDiscountProgressBar,
      required this.discountProgressBar,
      required this.recommendedProducts,
      required this.sTypename});

  CartSettingVM.fromJson(dynamic json) {
    sId = json.sId;
    showDiscountProgressBar = json.showDiscountProgressBar;
    recommendedProducts = json.recommendedProducts != null
        ? new CartRecommendedProductsVM.fromJson(json.recommendedProducts)
        : null;
    if (json.discountProgressBar != null) {
      discountProgressBar = <DiscountProgressBarVM>[];
      json.discountProgressBar.forEach((v) {
        discountProgressBar!.add(new DiscountProgressBarVM.fromJson(v));
      });
    } else {
      discountProgressBar = <DiscountProgressBarVM>[];
    }
    sTypename = json.sTypename;
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

class CartRecommendedProductsVM {
  late final String? sId;
  late final String? title;
  late final String? type;
  late final String? singleCollectionUrl;
  late final List<CartCollectionsVM>? collections;
  late final String? sTypename;

  CartRecommendedProductsVM(
      {required this.sId,
      required this.title,
      required this.type,
      required this.singleCollectionUrl,
      required this.collections,
      required this.sTypename});

  CartRecommendedProductsVM.fromJson(dynamic json) {
    sId = json.sId;
    title = json.title;
    type = json.type;
    singleCollectionUrl = json.singleCollectionUrl;
    if (json.collections != null) {
      collections = <CartCollectionsVM>[];
      json.collections.forEach((v) {
        collections!.add(new CartCollectionsVM.fromJson(v));
      });
    } else {
      collections = <CartCollectionsVM>[];
    }
    sTypename = json.sTypename;
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

class CartCollectionsVM {
  late final String? sId;
  late final String? title;
  late final String? imageName;
  late final String? collectionUrl;
  late final String? sTypename;

  CartCollectionsVM({
    required this.sId,
    required this.title,
    required this.imageName,
    required this.collectionUrl,
    required this.sTypename,
  });

  CartCollectionsVM.fromJson(dynamic json) {
    sId = json.sId;
    title = json.title;
    imageName = json.imageName;
    collectionUrl = json.collectionUrl;
    sTypename = json.sTypename;
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

class DiscountProgressBarVM {
  late final String? sId;
  late final String? title;
  late final dynamic discountValue;
  late final String? discountType;
  late final String? requirementType;
  late final dynamic requirementValue;
  late final String? sTypename;

  DiscountProgressBarVM({
    required this.sId,
    required this.title,
    required this.discountValue,
    required this.discountType,
    required this.requirementType,
    required this.requirementValue,
    required this.sTypename,
  });

  DiscountProgressBarVM.fromJson(dynamic json) {
    sId = json.sId;
    title = json.title;
    discountValue = json.discountValue;
    discountType = json.discountType;
    requirementType = json.requirementType;
    requirementValue = json.requirementValue;
    sTypename = json.sTypename;
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
