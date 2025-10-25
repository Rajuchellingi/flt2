// ignore_for_file: unused_local_variable, invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/cart/cart_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/cart_product_model.dart';

class CartCountController extends GetxController with BaseController {
  CartRepo? cartRepo;
  var userId;
  var cartId;
  var cartExpiry;
  var isLoading = false.obs;
  var cartCount = 0.obs;
  var wishlisCount = 0.obs;
  final themeController = Get.find<ThemeController>();

  @override
  void onInit() {
    Future.delayed(Duration(seconds: 3), () {
      cartRepo = CartRepo();
      userId = GetStorage().read('utoken');
      // print('car count controller initialized ${GetStorage().read('utoken')}');
      cartId = GetStorage().read("cartId");
      cartExpiry = GetStorage().read("cartExpiry");
      getCartCount();
      if (userId != null) {
        getWishlistCount();
      }
    });
    super.onInit();
  }

  Future getCartCount() async {
    userId = GetStorage().read('utoken');
    var cartId = GetStorage().read("cartId");
    var isAllowCart = themeController.isAllowCartBeforLogin();

    if (userId != null || isAllowCart == true) {
      var result = await cartRepo!.getCartCount(cartId);
      if (result != null) {
        var response = cartCountVMFromJson(result);
        cartCount.value = response.totalQuantity;
      }
    }
  }

  Future getWishlistCount() async {
    userId = GetStorage().read('utoken');
    if (userId != null) {
      // wishlisCount.value = commonWishlistController.allWishlist.value.length;
    }
  }

  onLogout() {
    wishlisCount.value = 0;
    cartCount.value = 0;
  }

  @override
  void dispose() {
    cartCount.close();
    wishlisCount.close();
    isLoading.close();
    super.dispose();
  }
}
