// ignore_for_file: invalid_use_of_protected_member, sdk_version_since

import 'dart:async';

// import 'package:b2b_graphql_package/modules/order/order_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/order_model.dart';
import 'package:get/get.dart';
import 'package:b2b_graphql_package/modules/enquiry/enquiry_repo.dart';

class EnquiryConfirmationController extends GetxController with BaseController {
  // OrderRepo? orderRepo;
  EnquiryRepo? enquiryRepo;
  bool allLoaded = false;
  var isLoading = false.obs;
  var orderId = '';
  var isOrder = false.obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  @override
  void onInit() {
    // orderRepo = OrderRepo();
    enquiryRepo = EnquiryRepo();
    var arguments = Get.arguments;
    if (arguments != null) {
      orderId = arguments['id'];
      getSingleOrder();
    }
    getTemplate();
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates
        .firstWhereOrNull((value) => value['id'] == 'enquiry-confirmed');
    isTemplateLoading.value = false;
  }

  Future getSingleOrder() async {
    isLoading.value = true;
    var result = await enquiryRepo!.getSingleOrderDetail(orderId);
    isLoading.value = false;
    if (result != null) {
      var response = myOrderDetailVMFromJson(result);
      if (response.sId != null) isOrder.value = true;
    }
  }
}
