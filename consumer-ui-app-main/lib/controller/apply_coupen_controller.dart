// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison

import 'package:b2b_graphql_package/modules/coupen_codes/coupen_code_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/dailog_helper.dart';
import 'package:black_locust/model/coupen_code_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ApplyCoupenController extends GetxController with BaseController {
  CoupenCodeRepo? coupenCodeRepo;
  TextEditingController? couponTextController;
  var coupenCodes = [].obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  var isLoading = false.obs;
  final themeController = Get.find<ThemeController>();

  @override
  void onInit() {
    coupenCodeRepo = CoupenCodeRepo();
    couponTextController = TextEditingController(text: '');
    getCoupenCodes();
    getTemplate();
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'apply-coupen');
    isTemplateLoading.value = false;
  }

  Future getCoupenCodes() async {
    isLoading.value = true;
    var result = await coupenCodeRepo!.getAllCoupenCodeForUI();
    if (result != null) {
      var response = coupenCodesVMFromJson(result);
      coupenCodes.value = response;
    }
    isLoading.value = false;
  }

  Future applyCoupon() async {
    if (couponTextController!.text != null &&
        couponTextController!.text.isNotEmpty) {
      showLoading("Loading...");
      var cartId = GetStorage().read("cartId");
      var coupenCodes = [couponTextController!.text];
      var result =
          await coupenCodeRepo!.applyDiscountCoupen(cartId, coupenCodes);
      hideLoading();
      if (result != null) {
        if (result['cart'] != null) {
          var discountCodes = result['cart']['discountCodes'];
          var isValid = discountCodes.firstWhere(
              (element) =>
                  element['applicable'] == true &&
                  element['code'] == couponTextController!.text,
              orElse: () => null);
          if (isValid != null) {
            Get.back(result: true);
          } else {
            DailogHelper.showInfoDailog(
                title: couponTextController!.text,
                description:
                    "This code is not applicable to the items in your cart.",
                onPressed: () {
                  Get.back();
                });
          }
        }
      }
    }
  }

  Future applyDiscountCoupen(coupen) async {
    showLoading("Loading...");
    var cartId = GetStorage().read("cartId");
    print("cart id $cartId");
    var coupenCodes = [coupen.couponCode];
    var result = await coupenCodeRepo!.applyDiscountCoupen(cartId, coupenCodes);
    hideLoading();
    if (result != null) {
      if (result['cart'] != null) {
        var discountCodes = result['cart']['discountCodes'];
        var isValid = discountCodes.firstWhere(
            (element) =>
                element['applicable'] == true &&
                element['code'] == coupen.couponCode,
            orElse: () => null);
        if (isValid != null) {
          Get.back(result: true);
        } else {
          DailogHelper.showInfoDailog(
              title: coupen.couponCode,
              description:
                  "This code is not applicable to the items in your cart.",
              onPressed: () {
                Get.back();
              });
        }
      }
    }
  }

  @override
  void onClose() {
    couponTextController!.dispose();
    coupenCodes.close();
    template.close();
    isTemplateLoading.close();
    isLoading.close();
    super.onClose();
  }
}
