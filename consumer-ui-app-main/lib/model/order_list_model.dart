// ignore_for_file: unnecessary_null_comparison

import 'package:black_locust/model/order_model.dart';

List<OrderVMModel> orderListVMFromJson(dynamic str) =>
    List<OrderVMModel>.from(str.map((x) => OrderVMModel.fromPkModel(x)));
RecentOrderAndBookingVM recentOrderAndBookingVMFromJson(dynamic str) =>
    (RecentOrderAndBookingVM.fromJson(str));
// OrderVMModel orderVMFromJson(dynamic str) => (OrderVMModel.fromPkModel(str));

class OrderVMModel {
  late final List<MyOrderDetailVM> order;
  late final int currentPage;
  late final int totalPages;
  late final int count;
  late final String sTypename;

  OrderVMModel(
      {required this.order,
      required this.currentPage,
      required this.totalPages,
      required this.count,
      required this.sTypename});

  OrderVMModel.fromPkModel(dynamic json) {
    if (json.order != null) {
      order = [];
      json.order.forEach((v) {
        order.add(new MyOrderDetailVM.fromJson(v));
      });
    }
    currentPage = json.currentPage;
    totalPages = json.totalPages;
    count = json.count;
    sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    data['count'] = this.count;
    data['sTypename'] = this.sTypename;
    return data;
  }
}

OrderListModelVM orderListModelVMFromJson(dynamic str) =>
    (OrderListModelVM.fromJson(str));

class OrderListModelVM {
  late final List<MyOrderDetailVM> order;
  late final PageVM? pageInfo;
  OrderListModelVM({
    required this.order,
    required this.pageInfo,
  });

  OrderListModelVM.fromJson(dynamic json) {
    if (json.order != null) {
      order = [];
      json.order.forEach((v) {
        order.add(new MyOrderDetailVM.fromJson(v));
      });
    }
    pageInfo =
        json.pageInfo != null ? new PageVM.fromJson(json.pageInfo) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order.map((v) => v.toJson()).toList();
    }
    if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo!.toJson();
    }
    return data;
  }
}

class RecentOrderAndBookingVM {
  late final RecentOrderVM? order;
  late final RecentOrderVM? booking;

  RecentOrderAndBookingVM({
    required this.order,
    required this.booking,
  });

  RecentOrderAndBookingVM.fromJson(dynamic json) {
    order = json.order != null ? new RecentOrderVM.fromJson(json.order) : null;
    booking =
        json.booking != null ? new RecentOrderVM.fromJson(json.booking) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    return data;
  }
}

class RecentOrderVM {
  late final String? sId;
  late final String? status;
  late final String? currencySymbol;
  late final String? creationDate;
  late final String? orderNo;
  late final String? bookingNo;
  late final List<String>? productNames;
  late final num? totalPrice;

  RecentOrderVM(
      {required this.sId,
      required this.status,
      required this.productNames,
      required this.creationDate,
      required this.currencySymbol,
      required this.bookingNo,
      required this.orderNo,
      required this.totalPrice});

  RecentOrderVM.fromJson(dynamic json) {
    sId = json.sId;
    status = json.status;
    creationDate = json.creationDate;
    bookingNo = json.bookingNo;
    currencySymbol = json.currencySymbol;
    orderNo = json.orderNo;
    productNames = json.productNames;
    totalPrice = json.totalPrice;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['productNames'] = this.productNames;
    data['bookingNo'] = this.bookingNo;
    data['creationDate'] = this.creationDate;
    data['currencySymbol'] = this.currencySymbol;
    data['orderNo'] = this.orderNo;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}

class PageVM {
  late final bool? hasNextPage;
  late final String? endCursor;
  late final String? sTypename;

  PageVM(
      {required this.hasNextPage,
      required this.endCursor,
      required this.sTypename});

  PageVM.fromJson(dynamic json) {
    hasNextPage = json.hasNextPage;
    endCursor = json.endCursor;
    sTypename = json.sTypename;
    // sTypename = json.sTypename;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasNextPage'] = this.hasNextPage;
    data['endCursor'] = this.endCursor;
    data['sTypename'] = this.sTypename;
    return data;
  }
}
