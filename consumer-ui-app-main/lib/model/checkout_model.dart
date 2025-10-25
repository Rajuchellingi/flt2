CheckoutVM createCheckoutVMFromJson(dynamic str) => (CheckoutVM.fromJson(str));

class CheckoutVM {
  late final String? sId;
  late final String? webUrl;
  late final String sTypename;

  CheckoutVM(
      {required this.sId, required this.webUrl, required this.sTypename});

  CheckoutVM.fromJson(dynamic json) {
    sId = json.sId;
    webUrl = json.webUrl;
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['webUrl'] = this.webUrl;
    data['__typename'] = this.sTypename;
    return data;
  }
}
