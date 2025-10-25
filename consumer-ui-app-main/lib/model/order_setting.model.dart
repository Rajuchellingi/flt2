OrderSettingVM orderSettingVMFromJson(dynamic str) =>
    (OrderSettingVM.fromJson(str));

class OrderSettingVM {
  late final String? orderType;

  OrderSettingVM({
    required this.orderType,
  });

  OrderSettingVM.fromJson(dynamic json) {
    orderType = json.orderType;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderType'] = this.orderType;
    return data;
  }
}
