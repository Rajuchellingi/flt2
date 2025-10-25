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
