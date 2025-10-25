SubscriptionModelVM subscriptionModelVMFromJson(dynamic str) =>
    (SubscriptionModelVM.fromJson(str));
TokenConfigurationVM tokenConfigurationVMFromJson(dynamic str) =>
    (TokenConfigurationVM.fromJson(str));

class SubscriptionModelVM {
  late final String? sId;
  late final bool? error;
  late final String? type;
  late final int? expiryDate;
  late final String? message;
  late final String? sTypename;

  SubscriptionModelVM(
      {required this.sId,
      required this.error,
      required this.type,
      required this.expiryDate,
      required this.message,
      required this.sTypename});

  SubscriptionModelVM.fromJson(dynamic json) {
    sId = json.sId;
    error = json.error;
    expiryDate = json.expiryDate;
    type = json.type;
    message = json.message;
    sTypename = json.sTypename;
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

class TokenConfigurationVM {
  late final String? accessToken;
  late final String? storefrontAccessToken;
  late final String? shop;
  late final String? name;
  late final bool? error;
  late final String? message;
  late final String? sTypename;

  TokenConfigurationVM(
      {required this.accessToken,
      required this.error,
      required this.shop,
      required this.name,
      required this.storefrontAccessToken,
      required this.message,
      required this.sTypename});

  TokenConfigurationVM.fromJson(dynamic json) {
    accessToken = json.accessToken;
    storefrontAccessToken = json.storefrontAccessToken;
    shop = json.shop;
    name = json.name;
    error = json.error;
    message = json.message;
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['shop'] = this.shop;
    data['name'] = this.name;
    data['storefrontAccessToken'] = this.storefrontAccessToken;
    data['error'] = this.error;
    data['message'] = this.message;
    data['__typename'] = this.sTypename;
    return data;
  }
}
