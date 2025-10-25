import 'package:b2b_graphql_package/modules/product_detail/product_detail_model.dart';

UserDetails userDetailsFromJson(dynamic str) => (UserDetails.fromJson(str));

class UserDetails {
  late final String? sId;
  late final String? contactName;
  late final String? mobileNumber;
  late final String? firstName;
  late final String? lastName;
  late final int? isdCode;
  late final int? altIsdCode;
  late final int? numberOfOrders;
  late final int? numberOfAddresses;
  late final String? emailId;
  late final String? companyName;
  late final String? userTypeName;
  late final String? altMobileNumber;
  late final String? gstNumber;
  late final DefaultAddress? defaultAddress;
  late final List<Metafield>? metafields;
  // late final List<Addressarray>? addresses;

  UserDetails(
      {required this.sId,
      required this.contactName,
      required this.mobileNumber,
      required this.firstName,
      required this.lastName,
      required this.isdCode,
      required this.altIsdCode,
      required this.userTypeName,
      required this.numberOfOrders,
      required this.numberOfAddresses,
      required this.emailId,
      required this.companyName,
      required this.altMobileNumber,
      required this.metafields,
      required this.defaultAddress,
      // required this.addresses,
      required this.gstNumber});

  UserDetails.fromJson(Map<String, dynamic> json) {
    // print("json---> $json");
    // print("json---> ${json['addresses']['edges']}");
    sId = json['id'];
    contactName = json['contactName'];
    mobileNumber = json['phone'];
    firstName = json['firstName'];
    userTypeName = json['userTypeName'];
    numberOfAddresses =
        (json['addresses'] != null && json['addresses']['edges'] != null)
            ? json['addresses']['edges'].length
            : 0;
    numberOfOrders = (json['orders'] != null)
        ? int.tryParse(json['orders']['totalCount'])
        : 0;
    lastName = json['lastName'];
    isdCode = json['isdCode'] ?? null;
    altIsdCode = json['altIsdCode'] ?? null;
    emailId = json['email'];
    companyName = json['companyName'] ?? null;
    altMobileNumber = json['altMobileNumber'] ?? null;
    gstNumber = json['gstNumber'] ?? null;
    defaultAddress = json['defaultAddress'] != null
        ? new DefaultAddress.fromJson(json['defaultAddress'])
        : null;
    metafields = <Metafield>[];
    if (json['metafields'] != null && json['metafields'].length > 0) {
      var value = json['metafields'].where((element) => element != null);
      value.forEach((v) {
        metafields!.add(new Metafield.fromJson(v));
      });
    }
    // if (json['addresses']["edges"] != null) {
    //   addresses = <Addressarray>[];
    //   json['addresses']["edges"].forEach((v) {
    //     addresses!.add(new Addressarray.fromJson(v['node']));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['contactName'] = this.contactName;
    data['mobileNumber'] = this.mobileNumber;
    data['firstName'] = this.firstName;
    data['numberOfOrders'] = this.numberOfOrders;
    data['numberOfAddresses'] = this.numberOfAddresses;
    data['lastName'] = this.lastName;
    data['isdCode'] = this.isdCode;
    data['altIsdCode'] = this.altIsdCode;
    data['emailId'] = this.emailId;
    data['userTypeName'] = this.userTypeName;
    data['companyName'] = this.companyName;
    data['altMobileNumber'] = this.altMobileNumber;
    data['gstNumber'] = this.gstNumber;
    if (this.defaultAddress != null) {
      data['defaultAddress'] = this.defaultAddress!.toJson();
    }
    if (this.metafields != null) {
      data['metafields'] = this.metafields!.map((v) => v.toJson()).toList();
    }
    // data['addresses'] = this.addresses;
    return data;
  }
}

class DefaultAddress {
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

  DefaultAddress({
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
  });

  DefaultAddress.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    company = json['company'];
    sId = json['id'];
    address = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    province = json['province'];
    zip = json['zip'];
    country = json['country'];
    phone = json['phone'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['company'] = this.company;
    data['id'] = this.sId;
    data['address1'] = this.address;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['province'] = this.province;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['phone'] = this.phone;
    return data;
  }
}

List<Addressarray> userDetailsArrayFromJson(
        dynamic str, dynamic defaultAdrees) =>
    List<Addressarray>.from(
        str.map((x) => Addressarray.fromJson(x, defaultAdrees)));

class Addressarray {
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

  Addressarray(
      {required this.firstName,
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
      required this.isDefault});

  Addressarray.fromJson(Map<String, dynamic> json, dynamic defaultAdrees) {
    // print("addressArray------------>1111 ${json['id'] == defaultAdrees['id']}");
    // print("addressArray------------>2222 ${defaultAdrees['id']}");

    firstName = json['firstName'];
    lastName = json['lastName'];
    company = json['company'];
    sId = json['id'];
    address = json['address1'];
    // address2 = json['address2'];
    city = json['city'];
    province = json['province'];
    zip = json['zip'];
    country = json['country'];
    phone = json['phone'];
    isDefault = defaultAdrees['id'] == json['id'] ? true : false;
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

class UpdateShippingAddressRequestModel {
  late final String sId;
  late final bool enable;
  late final String addressId;
  UpdateShippingAddressRequestModel(
      {required this.sId, required this.enable, required this.addressId});
}

RegistrationModel registrationModelFromJson(dynamic str) =>
    (RegistrationModel.fromJson(str));

class RegistrationModel {
  late final RegisteredCustomer? customer;
  late final RegisteredCustomerError? error;
  late final String? sTypename;

  RegistrationModel(
      {required this.customer, required this.error, required this.sTypename});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    // print("updateMobile json ${json}");
    customer = json['customer'] != null
        ? new RegisteredCustomer.fromJson(json['customer'])
        : null;
    var userError = (json['customerUserErrors'] != null &&
            json['customerUserErrors'].length > 0)
        ? json['customerUserErrors'].first
        : (json['userErrors'] != null && json['userErrors'].length > 0)
            ? json['userErrors'].first
            : null;
    error = userError != null
        ? new RegisteredCustomerError.fromJson(userError)
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.error != null) {
      data['error'] = this.error!.toJson();
    } else {
      data['error'] = this.error;
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class RegisteredCustomer {
  late final String? firstName;
  late final String? lastName;
  late final String? email;
  late final String? sTypename;

  RegisteredCustomer(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.sTypename});

  RegisteredCustomer.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class RegisteredCustomerError {
  late final String message;
  late final String sTypename;

  RegisteredCustomerError({required this.message, required this.sTypename});

  RegisteredCustomerError.fromJson(Map<String, dynamic> json) {
    // print("updateMobile json ${json}");
    message = json['message'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['__typename'] = this.sTypename;
    return data;
  }
}
