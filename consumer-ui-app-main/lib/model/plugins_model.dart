List<PluginsVM> pluginsVMFromJson(dynamic str) =>
    List<PluginsVM>.from(str.map((x) => PluginsVM.fromJson(x)));

class PluginsVM {
  late final String? sId;
  late final String? name;
  late final bool? status;
  late final bool? isReview;
  late final String? title;
  late final String? code;
  late final String? mobileNumber;
  late final String? secretKey;
  late final String? workspace;

  PluginsVM({
    required this.name,
    required this.sId,
    required this.status,
    required this.isReview,
    required this.mobileNumber,
    required this.title,
    required this.code,
    required this.secretKey,
    required this.workspace,
  });

  PluginsVM.fromJson(dynamic json) {
    sId = json.sId;
    name = json.name;
    mobileNumber = json.mobileNumber;
    status = json.status;
    isReview = json.isReview;
    title = json.title;
    code = json.code;
    secretKey = json.secretKey;
    workspace = json.workspace;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['title'] = this.title;
    data['isReview'] = this.isReview;
    data['mobileNumber'] = this.mobileNumber;
    data['code'] = this.code;
    data['secretKey'] = this.secretKey;
    data['workspace'] = this.workspace;
    return data;
  }
}
