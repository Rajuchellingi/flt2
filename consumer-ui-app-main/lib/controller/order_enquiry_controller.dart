// ignore_for_file: invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/enquiry/enquiry_repo.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/enquiry_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderEnquiryController extends GetxController with BaseController {
  EnquiryRepo? enquiryRepo;
  var orderList = [].obs;
  var pageIndex = 1;
  var pageLimit = 20;
  var isLoading = false.obs;
  bool allLoaded = false;
  var newData = [];
  var loading = false.obs;
  var order = new MyEnquiryVM(orderData: [], count: 0, totalPages: 0).obs;
  final ScrollController scrollController = new ScrollController();
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  @override
  void onInit() {
    enquiryRepo = EnquiryRepo();
    getTemplate();
    initialLoad();
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
        .firstWhereOrNull((value) => value['id'] == 'enquiry-history');
    isTemplateLoading.value = false;
  }

  paginationFetch() async {
    if (allLoaded) {
      return;
    }

    loading.value = true;

    await Future.wait([getOrderList(pageIndex, pageLimit)]);

    if (newData.isNotEmpty) {
      orderList.addAll(newData);
      orderList.refresh();
      pageIndex += 1;
    }
    loading.value = false;
    allLoaded = newData.isEmpty;
  }

  Future initialLoad() async {
    this.isLoading.value = true;
    await Future.wait([getOrderList(pageIndex, pageLimit)]);
    if (newData.isNotEmpty) {
      orderList.addAll(newData);
      orderList.refresh();
      pageIndex += 1;
    }
    this.isLoading.value = false;
  }

  Future<Null> refreshPage() async {
    isLoading.value = true;
    allLoaded = false;
    orderList.value = [];
    pageIndex = 1;
    await Future.wait([getOrderList(pageIndex, pageLimit)]);
    if (newData.isNotEmpty) {
      orderList.addAll(newData);
      orderList.refresh();
      pageIndex += 1;
    }
    isLoading.value = false;
  }

  snackMessage(String message) {
    Get.snackbar(
      "", message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kTextColor,
      colorText: Colors.white,
      maxWidth: SizeConfig.screenWidth,
      borderRadius: 0,
      titleText: Container(),
      snackStyle: SnackStyle.FLOATING,
      // padding: EdgeInsets.all(kDefaultPadding / 2),
      // margin: EdgeInsets.all(0)
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }

  Future<Null> refreshOrderList() async {}

  Future getOrderList(pageNo, limit) async {
    var result = await enquiryRepo!.getEnquiryListByUser(pageNo, limit);
    if (result != null) {
      var orderData = myEnquiryVMFromJson(result);
      newData = orderData.orderData;
    } else {
      newData = [];
    }
    // refreshPage();
  }

  Future navigateToOrderDetails(orderItem) async {
    await Get.toNamed('/enquiryDetail', arguments: {"id": orderItem.sId});
  }

  getOrderStatus(String orderStatus) {
    return orderStatus.toUpperCase();
  }
}
