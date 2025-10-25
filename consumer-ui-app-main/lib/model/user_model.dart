import 'package:black_locust/model/product_detail_model.dart';

UserVMModel userByIdVMFromJson(dynamic str) => (UserVMModel.fromPkModel(str));
UserBankDetailVMModel userBandDetailVMFromJson(dynamic str) =>
    (UserBankDetailVMModel.fromPkModel(str));

class UserVMModel {
  late final String? sId;
  late final String? contactName;
  late final String? mobileNumber;
  late final String? firstName;
  late final String? lastName;
  late final int? isdCode;
  late final int? altIsdCode;
  late final String? emailId;
  late final String? companyName;
  late final String? altMobileNumber;
  late final String? gstNumber;
  late final DefaultAddressVM? defaultAddress;

  UserVMModel(
      {required this.sId,
      required this.contactName,
      required this.mobileNumber,
      required this.firstName,
      required this.lastName,
      required this.isdCode,
      required this.altIsdCode,
      required this.emailId,
      required this.companyName,
      required this.altMobileNumber,
      required this.defaultAddress,
      required this.gstNumber});

  UserVMModel.fromPkModel(dynamic json) {
    sId = json.sId;
    contactName = json.contactName;
    mobileNumber = json.mobileNumber;
    firstName = json.firstName;
    lastName = json.lastName;
    isdCode = json.isdCode;
    altIsdCode = json.altIsdCode;
    emailId = json.emailId;
    companyName = json.companyName;
    altMobileNumber = json.altMobileNumber;
    gstNumber = json.gstNumber;
    defaultAddress = json.defaultAddress != null
        ? new DefaultAddressVM.fromJson(json.defaultAddress.toJson())
        : null;
  }
}

UserDetailsVM userDetailsVMFromJson(dynamic str) =>
    (UserDetailsVM.fromJson(str));

class UserDetailsVM {
  late final String? sId;
  late final String? contactName;
  late final String? mobileNumber;
  late final String? firstName;
  late final String? lastName;
  late final String? userTypeName;
  late final int? isdCode;
  late final int? altIsdCode;
  late final int? numberOfAddresses;
  late final int? numberOfOrders;
  late final String? emailId;
  late final String? companyName;
  late final String? altMobileNumber;
  late final String? gstNumber;
  late final List<MetafieldVM>? metafields;

  UserDetailsVM({
    required this.sId,
    required this.contactName,
    required this.mobileNumber,
    required this.firstName,
    required this.lastName,
    required this.isdCode,
    required this.userTypeName,
    required this.altIsdCode,
    required this.numberOfOrders,
    required this.numberOfAddresses,
    required this.emailId,
    required this.companyName,
    required this.altMobileNumber,
    required this.gstNumber,
    required this.metafields,
  });

  UserDetailsVM.fromJson(dynamic json) {
    sId = json.sId;
    contactName = json.contactName;
    mobileNumber = json.mobileNumber;
    firstName = json.firstName;
    lastName = json.lastName;
    isdCode = json.isdCode;
    userTypeName = json.userTypeName;
    altIsdCode = json.altIsdCode;
    numberOfAddresses = json.numberOfAddresses;
    numberOfOrders = json.numberOfOrders;
    emailId = json.emailId;
    companyName = json.companyName;
    altMobileNumber = json.altMobileNumber;
    gstNumber = json.gstNumber;
    metafields = <MetafieldVM>[];
    if (json.metafields != null) {
      json.metafields.forEach((v) {
        metafields!.add(new MetafieldVM.fromJson(v.toJson()));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sId'] = this.sId;
    data['contactName'] = this.contactName;
    data['mobileNumber'] = this.mobileNumber;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['isdCode'] = this.isdCode;
    data['altIsdCode'] = this.altIsdCode;
    data['numberOfOrders'] = this.numberOfOrders;
    data['numberOfAddresses'] = this.numberOfAddresses;
    data['userTypeName'] = this.userTypeName;
    data['emailId'] = this.emailId;
    data['companyName'] = this.companyName;
    data['altMobileNumber'] = this.altMobileNumber;
    data['gstNumber'] = this.gstNumber;
    if (this.metafields != null) {
      data['metafields'] = this.metafields!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DefaultAddressVM {
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

  DefaultAddressVM({
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

  DefaultAddressVM.fromJson(Map<String, dynamic> json) {
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

LoginUserDetails loginUserDetailsVMFromJson(dynamic str) =>
    (LoginUserDetails.fromPkModel(str));

class LoginUserDetails {
  late final String? sId;
  late final String sTypename;

  LoginUserDetails({required this.sId, required this.sTypename});

  LoginUserDetails.fromPkModel(dynamic json) {
    sTypename = json.sTypename;
    sId = json.sId;
  }
}

class UserBankDetailVMModel {
  late final String accountHolderName;
  late final String accountNumber;
  late final String ifscCode;

  UserBankDetailVMModel(
      {required this.accountHolderName,
      required this.accountNumber,
      required this.ifscCode});

  UserBankDetailVMModel.fromPkModel(dynamic json) {
    if (json != null) {
      accountHolderName = json.accountHolderName;
      accountNumber = json.accountNumber;
      ifscCode = json.ifscCode;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountHolderName'] = this.accountHolderName;
    data['accountNumber'] = this.accountNumber;
    data['ifscCode'] = this.ifscCode;
    return data;
  }
}

CheckMobileAndEmailVM checkMobileEmailVMFromJson(dynamic str) =>
    (CheckMobileAndEmailVM.fromJson(str));

class CheckMobileAndEmailVM {
  late final bool? isMobile;
  late final bool? isEmail;

  CheckMobileAndEmailVM({required this.isMobile, required this.isEmail});

  CheckMobileAndEmailVM.fromJson(dynamic json) {
    isMobile = json.isMobile;
    isEmail = json.isEmail;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isMobile'] = this.isMobile;
    data['isEmail'] = this.isEmail;
    return data;
  }
}

UserRegisterModelVM userRegisterVMFromJson(dynamic str) =>
    (UserRegisterModelVM.fromJson(str));

class UserRegisterModelVM {
  late final String? userId;
  late final bool error;
  late final String message;
  late final String sTypename;

  UserRegisterModelVM(
      {required this.userId,
      required this.error,
      required this.message,
      required this.sTypename});

  UserRegisterModelVM.fromJson(dynamic json) {
    userId = json.userId;
    error = json.error;
    message = json.message;
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['error'] = this.error;
    data['message'] = this.message;
    data['__typename'] = this.sTypename;
    return data;
  }
}
