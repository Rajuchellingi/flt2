// api_model.dart
// ignore_for_file: non_constant_identifier_names

CustomerVM CustomerFromJson(dynamic str) => (CustomerVM.fromJson(str));

class CustomerVM {
  late final CustomerInput? customer;
  late final CustomerUserError? customerUserErrors;

  CustomerVM({
    required this.customer,
    required this.customerUserErrors,
  });

  CustomerVM.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? new CustomerInput.fromJson(json['customer'])
        : null;
    customerUserErrors = json['customerUserErrors'] != null
        ? new CustomerUserError.fromJson(json['customerUserErrors'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.customerUserErrors != null) {
      data['customerUserErrors'] = this.customerUserErrors!.toJson();
    }
    return data;
  }
}

class CustomerInput {
  late final String? firstName;
  late final String? lastName;
  late final String? email;
  late final String? phone;
  late final int? type;
  late final String? clientId;
  late final String? sTypename;

  CustomerInput(
      {required this.firstName,
      required this.lastName,
      required this.sTypename,
      required this.email,
      required this.phone,
      required this.type,
      required this.clientId});

  CustomerInput.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    sTypename = json['sTypename'];
    email = json['email'];
    phone = json['phone'];
    type = json['type'];
    clientId = json['clientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class CustomerUserError {
  late final String? field;
  late final String? message;
  late final String? code;

  CustomerUserError({
    required this.message,
    required this.code,
    required this.field,
  });

  CustomerUserError.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    field = json['field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    data['field'] = this.field;
    return data;
  }
}

LoginToken LoginTokenVMJson(dynamic str) => (LoginToken.fromJson(str));

class LoginToken {
  late final CustomerAccessToken? customerAccessToken;
  late final CustomerUserErrors? customerUserErrors;

  LoginToken({
    required this.customerAccessToken,
    required this.customerUserErrors,
  });

  LoginToken.fromJson(Map<String, dynamic> json) {
    customerAccessToken = json['customerAccessToken'] != null
        ? new CustomerAccessToken.fromJson(json['customerAccessToken'])
        : null;
    customerUserErrors = json['customerUserErrors'] != null
        ? new CustomerUserErrors.fromJson(json['customerUserErrors'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerAccessToken != null) {
      data['customerAccessToken'] = this.customerAccessToken!.toJson();
    }
    if (this.customerUserErrors != null) {
      data['customerUserErrors'] = this.customerUserErrors!.toJson();
    }
    return data;
  }
}

class CustomerAccessToken {
  late final String? accessToken;
  late final String? expiresAt;

  CustomerAccessToken({
    required this.accessToken,
    required this.expiresAt,
  });

  CustomerAccessToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    expiresAt = json['expiresAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['expiresAt'] = this.expiresAt;
    return data;
  }
}

class CustomerUserErrors {
  late final String? message;
  late final String? code;
  late final String? field;

  CustomerUserErrors({
    required this.message,
    required this.code,
    required this.field,
  });

  CustomerUserErrors.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    field = json['field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    data['field'] = this.field;
    return data;
  }
}

RegistrationModelVM registrationModelVMFromJson(dynamic str) =>
    (RegistrationModelVM.fromJson(str));

class RegistrationModelVM {
  late final RegisteredCustomerVM? customer;
  late final RegisteredCustomerErrorVM? error;
  late final String? sTypename;

  RegistrationModelVM(
      {required this.customer, required this.error, required this.sTypename});

  RegistrationModelVM.fromJson(dynamic json) {
    customer = json.customer != null
        ? new RegisteredCustomerVM.fromJson(json.customer)
        : null;
    error = json.error != null
        ? new RegisteredCustomerErrorVM.fromJson(json.error)
        : null;
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.error != null) {
      data['error'] = this.error!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class RegisteredCustomerVM {
  late final String? firstName;
  late final String? lastName;
  late final String? email;
  late final String? sTypename;

  RegisteredCustomerVM(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.sTypename});

  RegisteredCustomerVM.fromJson(dynamic json) {
    firstName = json.firstName;
    lastName = json.lastName;
    email = json.email;
    sTypename = json.sTypename;
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

class RegisteredCustomerErrorVM {
  late final String message;
  late final String sTypename;

  RegisteredCustomerErrorVM({required this.message, required this.sTypename});

  RegisteredCustomerErrorVM.fromJson(dynamic json) {
    message = json.message;
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['__typename'] = this.sTypename;
    return data;
  }
}

LoginSettingVM loginSettingVMFromJson(dynamic str) =>
    (LoginSettingVM.fromJson(str));

class LoginSettingVM {
  late final String? loginAuthentication;
  late final String? logoName;

  LoginSettingVM({
    required this.loginAuthentication,
    required this.logoName,
  });

  LoginSettingVM.fromJson(dynamic json) {
    loginAuthentication = json.loginAuthentication;
    logoName = json.logoName;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loginAuthentication'] = this.loginAuthentication;
    data['logoName'] = this.logoName;
    return data;
  }
}
