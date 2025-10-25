// ignore_for_file: unused_local_variable, invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/order/order_repo.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/order_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OrderHistoryController extends GetxController with BaseController {
  OrderRepo? orderRepo;
  var userId;
  var orderList = [].obs;
  var pageIndex = 1;
  var pageLimit = 10;
  var isLoading = false.obs;
  bool allLoaded = false;
  bool isOrderDetail = false;
  var orderDetailId;
  var newData = [];
  var loading = false.obs;
  var endCursorValue;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  var order = new OrderVMModel(
          order: [], count: 0, currentPage: 0, totalPages: 0, sTypename: '')
      .obs;
  final ScrollController scrollController = new ScrollController();
  var pageInfo = PageVM(hasNextPage: null, endCursor: null, sTypename: "").obs;
  final themeController = Get.find<ThemeController>();

  @override
  void onInit() {
    userId = GetStorage().read('utoken');
    orderRepo = OrderRepo();
    var args = Get.arguments;
    if (args != null) {
      isOrderDetail = args['isOrderDetail'] == true;
      orderDetailId = args['id'];
    }
    initialLoad();
    getTemplate();
    // getOrderList(userId, pageNo, pageLimit);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !loading.value) {
        paginationFetch();
      }
    });
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates
        .firstWhereOrNull((value) => value['id'] == 'order-history');
    isTemplateLoading.value = false;
  }

  paginationFetch() async {
    if (pageInfo.value.hasNextPage == false) {
      return;
    }

    loading.value = true;

    await Future.wait(
        [getOrderList(userId, pageIndex, pageLimit, endCursorValue)]);

    if (newData.isNotEmpty) {
      orderList.addAll(newData);
      orderList.refresh();
      pageIndex += 1;
    }
    loading.value = false;
    allLoaded = newData.isEmpty;

    if (allLoaded) {
      snackMessage('No data found');
    }
  }

  Future initialLoad() async {
    this.isLoading.value = true;
    await Future.wait(
        [getOrderList(userId, pageIndex, pageLimit, endCursorValue)]);
    if (newData.isNotEmpty) {
      orderList.addAll(newData);
      openDetailPage();
      orderList.refresh();
      pageIndex += 1;
    }
    this.isLoading.value = false;
  }

  openDetailPage() {
    if (isOrderDetail == true) {
      var order = orderList.value.first;
      navigateToOrderDetails(order);
    }
  }

  Future<Null> refreshPage() async {
    isLoading.value = true;
    await Future.wait(
        [getOrderList(userId, pageIndex, pageLimit, endCursorValue)]);
    isLoading.value = false;
  }

  snackMessage(String message) {
    Get.snackbar("", message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kTextColor,
        colorText: Colors.white,
        // duration: Duration(milliseconds: 10000),
        maxWidth: SizeConfig.screenWidth,
        borderRadius: 0,
        titleText: Container(),
        snackStyle: SnackStyle.FLOATING,
        // padding: EdgeInsets.all(kDefaultPadding / 2),
        // margin: EdgeInsets.all(0)
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10));
  }

  Future<Null> refreshOrderList() async {
    // getOrderList(userId, pageNo, pageLimit);
  }

  Future getOrderList(userId, pageNo, limit, endCursorValue) async {
    var endCursor = pageInfo.value.endCursor;
    var result =
        await orderRepo!.getUserOrderList(userId, pageNo, limit, endCursor);
    if (result != null) {
      var orderData = orderListModelVMFromJson(result);
      pageInfo.value = orderData.pageInfo!;
      newData = orderData.order;
    } else {
      newData = [];
    }
    // }
    // isLoading.value = false;
  }

  Future navigateToOrderDetails(orderItem) async {
    var result = await Get.toNamed('/orderDetail', arguments: orderItem);
    if (result == true) {
      getOrderList(userId, pageIndex, pageLimit, endCursorValue);
    }
  }

  getOrderStatus(orderStatus) {
    switch (orderStatus) {
      case 1:
        return 'Order Placed';
      case 2:
        return 'Order Confirmed';
      case 3:
        return 'Processing';
      case 4:
        return 'Ready To Ship';
      case 5:
        return 'Shipped';
      case 11:
        return 'Out For Delivery';
      case 12:
        return 'Delivered';
      case 13:
        return 'Order Cancelled';
      case 14:
        return 'Return Requested';
      case 15:
        return 'Return Approved';
      case 16:
        return 'Return Rejected';
      case 17:
        return 'Returned';
      default:
        return 'In Process';
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
