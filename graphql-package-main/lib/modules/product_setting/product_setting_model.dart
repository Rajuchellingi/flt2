ProductSetting productSettingFromJson(dynamic str) =>
    (ProductSetting.fromJson(str));

class ProductSetting {
  late final String? showAvailableSize;
  late final String? showSimilarStyles;
  late final String? showRecentlyViewed;
  late final String? showAddToCart;
  late final String? priceDisplayType;
  late final String? cartSummaryType;
  late final bool? showVariantPrice;
  late final bool? showPrice;
  late final List<ProductPolicy>? productPolicy;
  late final String? sTypename;

  ProductSetting(
      {required this.showAvailableSize,
      required this.productPolicy,
      required this.showSimilarStyles,
      required this.showRecentlyViewed,
      required this.showAddToCart,
      required this.priceDisplayType,
      required this.cartSummaryType,
      required this.showVariantPrice,
      required this.showPrice,
      required this.sTypename});

  ProductSetting.fromJson(Map<String, dynamic> json) {
    showAvailableSize = json['showAvailableSize'];
    showSimilarStyles = json['showSimilarStyles'];
    showRecentlyViewed = json['showRecentlyViewed'];
    priceDisplayType = json['priceDisplayType'];
    cartSummaryType = json['cartSummaryType'];
    showVariantPrice = json['showVariantPrice'];
    showPrice = json['showPrice'];
    showAddToCart = json['showAddToCart'];
    if (json['productPolicy'] != null) {
      productPolicy = <ProductPolicy>[];
      json['productPolicy'].forEach((v) {
        productPolicy!.add(new ProductPolicy.fromJson(v));
      });
    } else {
      productPolicy = <ProductPolicy>[];
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['showAvailableSize'] = this.showAvailableSize;
    data['showSimilarStyles'] = this.showSimilarStyles;
    data['showRecentlyViewed'] = this.showRecentlyViewed;
    data['priceDisplayType'] = this.priceDisplayType;
    data['cartSummaryType'] = this.cartSummaryType;
    data['showVariantPrice'] = this.showVariantPrice;
    data['showPrice'] = this.showPrice;
    data['showAddToCart'] = this.showAddToCart;
    if (this.productPolicy != null) {
      data['productPolicy'] =
          this.productPolicy!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;

    return data;
  }
}

class ProductPolicy {
  late final String? sId;
  late final String? title;
  late final String? description;
  late final String? sTypename;

  ProductPolicy({
    required this.sId,
    required this.title,
    required this.description,
    required this.sTypename,
  });

  ProductPolicy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['__typename'] = this.sTypename;
    return data;
  }
}
