ProductSettingVM productSettingVMFromJson(dynamic str) =>
    (ProductSettingVM.fromJson(str));

class ProductSettingVM {
  late final String? showAvailableSize;
  late final String? showSimilarStyles;
  late final String? showRecentlyViewed;
  late final String? showAddToCart;
  late final String? priceDisplayType;
  late final String? cartSummaryType;
  late final bool? showVariantPrice;
  late final bool? showPrice;
  late final List<ProductPolicyVM>? productPolicy;
  late final String? sTypename;

  ProductSettingVM(
      {required this.showAvailableSize,
      required this.productPolicy,
      required this.priceDisplayType,
      required this.cartSummaryType,
      required this.showVariantPrice,
      required this.showPrice,
      required this.showSimilarStyles,
      required this.showRecentlyViewed,
      required this.showAddToCart,
      required this.sTypename});

  ProductSettingVM.fromJson(dynamic json) {
    showAvailableSize = json.showAvailableSize;
    showSimilarStyles = json.showSimilarStyles;
    showRecentlyViewed = json.showRecentlyViewed;
    priceDisplayType = json.priceDisplayType;
    cartSummaryType = json.cartSummaryType;
    showVariantPrice = json.showVariantPrice;
    showPrice = json.showPrice;
    showAddToCart = json.showAddToCart;
    sTypename = json.sTypename;
    if (json.productPolicy != null) {
      productPolicy = <ProductPolicyVM>[];
      json.productPolicy.forEach((v) {
        productPolicy!.add(new ProductPolicyVM.fromJson(v));
      });
    }
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

class ProductPolicyVM {
  late final String? sId;
  late final String? title;
  late final String? description;
  late final String? sTypename;

  ProductPolicyVM({
    required this.sId,
    required this.title,
    required this.description,
    required this.sTypename,
  });

  ProductPolicyVM.fromJson(dynamic json) {
    sId = json.sId;
    title = json.title;
    description = json.description;
    sTypename = json.sTypename;
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

SiteSettingVM siteSettingVMFromJson(dynamic str) =>
    (SiteSettingVM.fromJson(str));

class SiteSettingVM {
  late final String? googleAnalyticsId;
  late final String? googleAnalyticsMeasurementId;
  late final String? enhancedEcommerce;
  late final String? googleTagManagerId;
  late final String? facebookPixelId;
  late final String? measurementProtocolApiSecret;
  late final String? facebookPixelAccessToken;
  late final String? dynamicAds;
  late final String? customRobotsUrl;
  late final String? customSitemapUrl;
  late final ReCaptchaSetting? reCaptcha;
  late final String? themeColor;

  SiteSettingVM({
    required this.googleAnalyticsId,
    required this.googleAnalyticsMeasurementId,
    required this.enhancedEcommerce,
    required this.googleTagManagerId,
    required this.reCaptcha,
    required this.facebookPixelId,
    required this.measurementProtocolApiSecret,
    required this.facebookPixelAccessToken,
    required this.dynamicAds,
    required this.customRobotsUrl,
    required this.customSitemapUrl,
    required this.themeColor,
  });

  SiteSettingVM.fromJson(dynamic json) {
    googleAnalyticsId = json.googleAnalyticsId;
    googleAnalyticsMeasurementId = json.googleAnalyticsMeasurementId;
    enhancedEcommerce = json.enhancedEcommerce;
    googleTagManagerId = json.googleTagManagerId;
    facebookPixelId = json.facebookPixelId;
    measurementProtocolApiSecret = json.measurementProtocolApiSecret;
    facebookPixelAccessToken = json.facebookPixelAccessToken;
    dynamicAds = json.dynamicAds;
    customRobotsUrl = json.customRobotsUrl;
    customSitemapUrl = json.customSitemapUrl;
    reCaptcha = json.reCaptcha != null
        ? new ReCaptchaSetting.fromJson(json.reCaptcha)
        : null;
    themeColor = json.themeColor;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['googleAnalyticsId'] = this.googleAnalyticsId;
    data['googleAnalyticsMeasurementId'] = this.googleAnalyticsMeasurementId;
    data['enhancedEcommerce'] = this.enhancedEcommerce;
    data['googleTagManagerId'] = this.googleTagManagerId;
    data['facebookPixelId'] = this.facebookPixelId;
    data['measurementProtocolApiSecret'] = this.measurementProtocolApiSecret;
    data['facebookPixelAccessToken'] = this.facebookPixelAccessToken;
    data['dynamicAds'] = this.dynamicAds;
    data['customRobotsUrl'] = this.customRobotsUrl;
    data['customSitemapUrl'] = this.customSitemapUrl;
    data['themeColor'] = this.themeColor;
    if (this.reCaptcha != null) {
      data['reCaptcha'] = this.reCaptcha!.toJson();
    }
    return data;
  }
}

class ReCaptchaSetting {
  late final String? status;
  late final String? siteKey;
  late final List<ReCaptchaForms>? forms;

  ReCaptchaSetting({
    required this.status,
    required this.siteKey,
    required this.forms,
  });

  ReCaptchaSetting.fromJson(dynamic json) {
    status = json.status;
    siteKey = json.siteKey;
    forms = <ReCaptchaForms>[];
    if (json.forms != null) {
      json.forms.forEach((v) {
        forms!.add(new ReCaptchaForms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['siteKey'] = this.siteKey;
    if (this.forms != null) {
      data['forms'] = this.forms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReCaptchaForms {
  late final String? formId;
  late final String? formName;

  ReCaptchaForms({
    required this.formId,
    required this.formName,
  });

  ReCaptchaForms.fromJson(dynamic json) {
    formId = json.formId;
    formName = json.formName;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formId'] = this.formId;
    data['formName'] = this.formName;
    return data;
  }
}
