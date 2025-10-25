// ignore_for_file: invalid_use_of_protected_member, sdk_version_since, unnecessary_null_comparison

import 'dart:async';

import 'package:b2b_graphql_package/modules/enquiry/enquiry_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/enquiry_model.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EnquiryDetailController extends GetxController with BaseController {
  EnquiryRepo? enquiryRepo;
  bool allLoaded = false;
  var isLoading = false.obs;
  var isProgress = false.obs;
  var orderId = '';
  var orderDetail = new MyEnquiryDetailVM(
      sId: null,
      billingAddress: null,
      shippingAddress: null,
      user: null,
      price: null,
      status: null,
      priceDisplayType: null,
      totalQuantity: null,
      statusUrl: null,
      orderNumber: null,
      orderNo: null,
      creationDate: null,
      message: null,
      products: []).obs;
  var pageLimit = 20;
  var pageIndex = 1;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  @override
  void onInit() {
    enquiryRepo = EnquiryRepo();
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
    template.value = allTemplates
        .firstWhereOrNull((value) => value['id'] == 'enquiry-detail');
    isTemplateLoading.value = false;
  }

  Future getSingleOrderDetail() async {
    isLoading.value = true;
    var result = await enquiryRepo!.getSingleOrderDetail(orderId);
    isLoading.value = false;
    if (result != null) {
      orderDetail.value = myEnquiryDetailVMFromJson(result);
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
    var result = await enquiryRepo!.downloadInvoice(orderId);
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
}
