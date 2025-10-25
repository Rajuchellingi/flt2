List<UserAddressVMModel> userByAddressVMFromJson(dynamic str) =>
    List<UserAddressVMModel>.from(
        str.map((x) => UserAddressVMModel.fromJson(x)));

class UserAddressVMModel {
  late final String? firstName;
  late final String? lastName;
  late final String? company;
  late final String? sId;
  late final String? address;
  late final String? address2;
  late final String? city;
  late final String? province;
  late final String? zip;
  late final String? country;
  late final String? phone;
  late final bool? isDefault;

  UserAddressVMModel({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.sId,
    required this.address,
    required this.address2,
    required this.city,
    required this.province,
    required this.zip,
    required this.country,
    required this.phone,
    required this.isDefault,
  });

  UserAddressVMModel.fromJson(dynamic json) {
    firstName = json.firstName;
    lastName = json.lastName;
    company = json.company;
    sId = json.sId;
    address = json.address;
    // address2 = json.address2;
    city = json.city;
    province = json.province;
    zip = json.zip;
    country = json.country;
    phone = json.phone;
    isDefault = json.isDefault;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['company'] = this.company;
    data['id'] = this.sId;
    data['address1'] = this.address;
    // data['address2'] = this.address2;
    data['city'] = this.city;
    data['province'] = this.province;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['isDefault'] = this.isDefault;
    return data;
  }
}

UserBillingAddressVM userBillingAddressVMFromJson(dynamic str) =>
    (UserBillingAddressVM.fromJson(str));

class UserBillingAddressVM {
  late final String sId;
  late final String? companyName;
  late final String? contactName;
  late final String? emailId;
  late final String? mobileNumber;
  late final String? address;
  late final String? pinCode;
  late final String? country;
  late final String? state;
  late final String? city;
  late final bool? billingAddress;
  late final bool? shippingAddress;
  late final String sTypename;

  UserBillingAddressVM(
      {required this.sId,
      required this.companyName,
      required this.contactName,
      required this.emailId,
      required this.mobileNumber,
      required this.address,
      required this.pinCode,
      required this.country,
      required this.state,
      required this.city,
      required this.billingAddress,
      required this.shippingAddress,
      required this.sTypename});

  UserBillingAddressVM.fromJson(dynamic json) {
    sId = json.sId;
    companyName = json.companyName;
    contactName = json.contactName;
    emailId = json.emailId;
    mobileNumber = json.mobileNumber;
    address = json.address;
    pinCode = json.pinCode;
    country = json.country;
    state = json.state;
    city = json.city;
    billingAddress = json.billingAddress ?? false;
    shippingAddress = json.shippingAddress ?? false;
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sId'] = this.sId;
    data['companyName'] = this.companyName;
    data['contactName'] = this.contactName;
    data['emailId'] = this.emailId;
    data['mobileNumber'] = this.mobileNumber;
    data['address'] = this.address;
    data['pinCode'] = this.pinCode;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['billingAddress'] = this.billingAddress;
    data['shippingAddress'] = this.shippingAddress;
    data['sTypename'] = this.sTypename;
    return data;
  }
}

class UpdateShippingAddressRequestModel {
  late final String sId;
  late final bool enable;
  late final String addressId;
  UpdateShippingAddressRequestModel(
      {required this.sId, required this.enable, required this.addressId});
}
