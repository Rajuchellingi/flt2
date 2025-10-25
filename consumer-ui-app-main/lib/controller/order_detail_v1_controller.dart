// ignore_for_file: invalid_use_of_protected_member, sdk_version_since, unnecessary_null_comparison

import 'dart:async';

import 'package:b2b_graphql_package/modules/order/order_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailV1Controller extends GetxController with BaseController {
  OrderRepo? orderRepo;
  bool allLoaded = false;
  var isLoading = false.obs;
  var isProgress = false.obs;
  var orderId = '';
  var orderDetail = new MyOrderDetailVM(
      sId: null,
      billingAddress: null,
      shippingAddress: null,
      user: null,
      price: null,
      status: null,
      statusUrl: null,
      orderNumber: null,
      orderNo: null,
      creationDate: null,
      products: []).obs;
  var pageLimit = 20;
  var pageIndex = 1;
  var template = {}.obs;
  TextEditingController? reasonController;

  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  @override
  void onInit() {
    orderRepo = OrderRepo();
    reasonController = TextEditingController(text: '');
    getTemplate();
    var arguments = Get.arguments;
    if (arguments != null) {
      orderId = arguments['id'];
      getSingleOrderDetail();
    }
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'order-detail');
    isTemplateLoading.value = false;
  }

  Future getSingleOrderDetail() async {
    isLoading.value = true;
    var result = await orderRepo!.getSingleOrderDetail(orderId);
    isLoading.value = false;
    if (result != null) {
      orderDetail.value = myOrderDetailVMFromJson(result);
    }
  }

  Future<Null> refreshPage() async {
    isLoading.value = true;
    allLoaded = false;
    // orderDetail.value = '';
    pageIndex = 1;
    await Future.wait([getSingleOrderDetail()]);
    if (orderDetail != null) {
      // orderDetail.addAll(newData);
      orderDetail.refresh();
      pageIndex += 1;
    }
    isLoading.value = false;
  }

  Future downloadInvoice() async {
    isProgress.value = true;
    var result = await orderRepo!.downloadInvoice(orderId);
    isProgress.value = false;
    if (result != null && result['error'] == false) {
      print('result $result');
      downloadPDF(result['invoiceUrl'], result['fileName']);
    }
  }

  Future downloadPDF(String url, String filename) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Future cancelOrder() async {
    showLoading("Loading...");
    var result = await orderRepo!.cancelOrder(orderId, reasonController!.text);
    if (result != null) {
      var message = result['message'];
      if (message != null) {
        getSingleOrderDetail();
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(message),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
    hideLoading();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
