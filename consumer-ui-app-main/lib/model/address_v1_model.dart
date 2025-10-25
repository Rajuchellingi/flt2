AdderssListVM myAddressFromJson(dynamic str) =>
    (AdderssListVM.fromJson(str.toJson()));

class AdderssListVM {
  late final int? count;
  late final List<AddressDetailVM> addresses;

  AdderssListVM({
    required this.count,
    required this.addresses,
  });

  AdderssListVM.fromJson(Map<String, dynamic> json) {
    count = json["count"];
    if (json["addresses"] != null) {
      addresses = <AddressDetailVM>[];
      json["addresses"].forEach((v) {
        addresses.add(new AddressDetailVM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['product'] = this.addresses.map((v) => v.toJson()).toList();
    return data;
  }
}

class AddressDetailVM {
  late final String? sId;
  late final String? city;
  late final String? country;
  late final String? companyName;
  late final String? contactName;
  late final String? emailId;
  // late final int? moq;
  // late final bool? showPriceRange;
  late final String? mobileNumber;
  late final String? address;
  late final String? landmark;
  late final String? pinCode;
  late final String? state;
  late final bool? shippingAddress;
  late final bool? billingAddress;

  AddressDetailVM({
    required this.sId,
    required this.city,
    required this.country,
    required this.companyName,
    required this.contactName,
    required this.emailId,
    // required this.moq,
    // required this.showPriceRange,
    required this.mobileNumber,
    required this.address,
    required this.landmark,
    required this.pinCode,
    required this.state,
    required this.shippingAddress,
    required this.billingAddress,
  });

  AddressDetailVM.fromJson(Map<String, dynamic> json) {
    // print("json data--->>123 $json");
    sId = json['_id'];
    // productId = json['productId'];
    city = json['city'];
    country = json['country'];
    companyName = json['companyName'];
    contactName = json['contactName'];
    emailId = json['emailId'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    landmark = json['landmark'];
    pinCode = json['pinCode'];
    state = json['state'];
    shippingAddress = json['shippingAddress'];
    billingAddress = json['billingAddress'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['city'] = this.city;
    data['country'] = this.country;
    data['companyName'] = this.companyName;
    data['contactName'] = this.contactName;
    data['emailId'] = this.emailId;
    data['mobileNumber'] = this.mobileNumber;
    data['address'] = this.address;
    data['landmark'] = this.landmark;
    data['pinCode'] = this.pinCode;
    data['state'] = this.state;
    data['shippingAddress'] = this.shippingAddress;
    data['billingAddress'] = this.billingAddress;
    return data;
  }
}
