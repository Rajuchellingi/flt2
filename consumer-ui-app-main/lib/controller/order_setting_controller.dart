// ignore_for_file: invalid_use_of_protected_member, sdk_version_since

import 'dart:async';

import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/model/order_setting.model.dart';
import 'package:get/get.dart';
import 'package:b2b_graphql_package/modules/order_setting/order_setting_repo.dart';

class OrderSettingController extends GetxController with BaseController {
  OrderSettingRepo? orderSettingRepo;
  var orderSetting = new OrderSettingVM(orderType: null).obs;
  var accountButtons = [
    {'label': 'Your Booking', 'action': '/bookingList'},
    {'label': 'Your Orders', 'action': '/orderList'},
    {'label': 'Your Address', 'action': '/myAddress'},
    {'label': 'Your Profile', 'action': '/myProfile'},
    {'label': 'Your Wish List', 'action': '/myWishlist'},
  ].obs;
  @override
  void onInit() {
    orderSettingRepo = OrderSettingRepo();
    getSingleOrderDetail();
    super.onInit();
  }

  Future getSingleOrderDetail() async {
    var result = await orderSettingRepo!.getOrderSetting();
    if (result != null) {
      orderSetting.value = orderSettingVMFromJson(result);
      if (orderSetting.value.orderType == 'booking') {
        accountButtons.value = [
          {'label': 'Your Booking', 'action': '/bookingList'},
          {'label': 'Your Address', 'action': '/myAddress'},
          {'label': 'Your Profile', 'action': '/myProfile'},
          {'label': 'Your Wish List', 'action': '/myWishlist'},
        ];
      } else if (orderSetting.value.orderType == 'booking-and-order') {
        accountButtons.value = [
          {'label': 'Your Booking', 'action': '/bookingList'},
          {'label': 'Your Orders', 'action': '/orderList'},
          {'label': 'Your Address', 'action': '/myAddress'},
          {'label': 'Your Profile', 'action': '/myProfile'},
          {'label': 'Your Wish List', 'action': '/myWishlist'},
        ];
      } else if (orderSetting.value.orderType == 'order') {
        accountButtons.value = [
          {'label': 'Your Orders', 'action': '/orderList'},
          {'label': 'Your Address', 'action': '/myAddress'},
          {'label': 'Your Profile', 'action': '/myProfile'},
          {'label': 'Your Wish List', 'action': '/myWishlist'},
        ];
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
