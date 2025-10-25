List<CoupenCodes> coupenCodesFromJson(dynamic str) =>
    List<CoupenCodes>.from(str.map((x) => CoupenCodes.fromJson(x)));

class CoupenCodes {
  late final String? sId;
  late final String? couponCode;
  late final String? heading;
  late final String? description;
  late final String? termsAndCondition;
  late final String? startDate;
  late final String? startTime;
  late final String? startStandardType;
  late final String? endDate;
  late final String? endTime;
  late final String? endStandardType;

  CoupenCodes({
    required this.sId,
    required this.couponCode,
    required this.heading,
    required this.description,
    required this.termsAndCondition,
    required this.startDate,
    required this.startTime,
    required this.startStandardType,
    required this.endDate,
    required this.endTime,
    required this.endStandardType,
  });

  CoupenCodes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    couponCode = json['couponCode'];
    heading = json['heading'];
    description = json['description'];
    termsAndCondition = json['termsAndCondition'];
    startDate = json['startDate'];
    startTime = json['startTime'];
    startStandardType = json['startStandardType'];
    endDate = json['endDate'];
    endTime = json['endTime'];
    endStandardType = json['endStandardType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['couponCode'] = this.couponCode;
    data['heading'] = this.heading;
    data['description'] = this.description;
    data['termsAndCondition'] = this.termsAndCondition;
    data['startDate'] = this.startDate;
    data['startTime'] = this.startTime;
    data['startStandardType'] = this.startStandardType;
    data['endDate'] = this.endDate;
    data['endTime'] = this.endTime;
    data['endStandardType'] = this.endStandardType;
    return data;
  }
}
