SubscriptionModel subscriptionModelFromJson(dynamic str) =>
    (SubscriptionModel.fromJson(str));
TokenConfiguration tokenConfigurationFromJson(dynamic str) =>
    (TokenConfiguration.fromJson(str));

class SubscriptionModel {
  late final String? sId;
  late final bool? error;
  late final String? type;
  late final int? expiryDate;
  late final String? message;
  late final String? sTypename;

  SubscriptionModel(
      {required this.sId,
      required this.error,
      required this.type,
      required this.expiryDate,
      required this.message,
      required this.sTypename});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    error = json['error'];
    expiryDate = json['expiryDate'];
    type = json['type'];
    message = json['message'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['error'] = this.error;
    data['type'] = this.type;
    data['expiryDate'] = this.expiryDate;
    data['message'] = this.message;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class TokenConfiguration {
  late final String? accessToken;
  late final String? storefrontAccessToken;
  late final String? shop;
  late final String? name;
  late final bool? error;
  late final String? message;
  late final String? sTypename;

  TokenConfiguration(
      {required this.accessToken,
      required this.storefrontAccessToken,
      required this.shop,
      required this.error,
      required this.name,
      required this.message,
      required this.sTypename});

  TokenConfiguration.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    error = json['error'];
    name = json['name'];
    shop = json['shop'];
    storefrontAccessToken = json['storefrontAccessToken'];
    message = json['message'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['error'] = this.error;
    data['name'] = this.name;
    data['shop'] = this.shop;
    data['storefrontAccessToken'] = this.storefrontAccessToken;
    data['message'] = this.message;
    data['__typename'] = this.sTypename;
    return data;
  }
}
