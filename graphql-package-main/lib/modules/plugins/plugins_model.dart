List<Plugins> pluginsFromJson(dynamic str) =>
    List<Plugins>.from(str.map((x) => Plugins.fromJson(x)));

class Plugins {
  late final String? sId;
  late final String? name;
  late final bool? status;
  late final bool? isReview;
  late final String? title;
  late final String? mobileNumber;
  late final String? code;
  late final String? secretKey;
  late final String? workspace;

  Plugins({
    required this.name,
    required this.sId,
    required this.status,
    required this.isReview,
    required this.code,
    required this.title,
    required this.mobileNumber,
    required this.secretKey,
    required this.workspace,
  });

  Plugins.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    status = json['status'];
    isReview = json['isReview'];
    mobileNumber = json['mobileNumber'];
    title = json['title'];
    code = json['code'];
    secretKey = json['secretKey'];
    workspace = json['workspace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['isReview'] = this.isReview;
    data['mobileNumber'] = this.mobileNumber;
    data['title'] = this.title;
    data['code'] = this.code;
    data['secretKey'] = this.secretKey;
    data['workspace'] = this.workspace;
    return data;
  }
}
