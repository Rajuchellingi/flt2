// ignore_for_file: unnecessary_null_comparison

PostalCodeVMModel postalCodeVMFromJson(dynamic str) =>
    (PostalCodeVMModel.fromJson(str[0]));

class PostalCodeVMModel {
  late final String message;
  late final String status;
  late final List<PostOfficeVMModel> postOffice;

  PostalCodeVMModel(
      {required this.message, required this.status, required this.postOffice});

  PostalCodeVMModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    status = json['Status'];
    if (json['PostOffice'] != null) {
      postOffice = [];
      json['PostOffice'].forEach((v) {
        postOffice.add(new PostOfficeVMModel.fromJson(v));
      });
    } else {
      postOffice = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['Status'] = this.status;
    if (this.postOffice != null) {
      data['PostOffice'] = this.postOffice.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PostOfficeVMModel {
  late final String? name;
  late final String? description;
  late final String? branchType;
  late final String? deliveryStatus;
  late final String? circle;
  late final String? district;
  late final String? division;
  late final String? region;
  late final String? block;
  late final String? state;
  late final String? country;
  late final String? pincode;

  PostOfficeVMModel(
      {required this.name,
      required this.description,
      required this.branchType,
      required this.deliveryStatus,
      required this.circle,
      required this.district,
      required this.division,
      required this.region,
      required this.block,
      required this.state,
      required this.country,
      required this.pincode});

  PostOfficeVMModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    description = json['Description'];
    branchType = json['BranchType'];
    deliveryStatus = json['DeliveryStatus'];
    circle = json['Circle'];
    district = json['District'];
    division = json['Division'];
    region = json['Region'];
    block = json['Block'];
    state = json['State'];
    country = json['Country'];
    pincode = json['Pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['BranchType'] = this.branchType;
    data['DeliveryStatus'] = this.deliveryStatus;
    data['Circle'] = this.circle;
    data['District'] = this.district;
    data['Division'] = this.division;
    data['Region'] = this.region;
    data['Block'] = this.block;
    data['State'] = this.state;
    data['Country'] = this.country;
    data['Pincode'] = this.pincode;
    return data;
  }
}
