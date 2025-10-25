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

UserRegisterModel userRegisterFromJson(dynamic str) =>
    (UserRegisterModel.fromJson(str));

class UserRegisterModel {
  late final String? userId;
  late final bool error;
  late final String message;
  late final String sTypename;

  UserRegisterModel(
      {required this.userId,
      required this.error,
      required this.message,
      required this.sTypename});

  UserRegisterModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    error = json['error'];
    message = json['message'];
    sTypename = json['__typename'];
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
