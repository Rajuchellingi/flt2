OrderSetting orderSettingFromJson(dynamic str) => (OrderSetting.fromJson(str));

class OrderSetting {
  late final String? orderType;

  OrderSetting({
    required this.orderType,
  });

  OrderSetting.fromJson(Map<String, dynamic> json) {
    orderType = json['orderType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderType'] = this.orderType;
    return data;
  }
}
