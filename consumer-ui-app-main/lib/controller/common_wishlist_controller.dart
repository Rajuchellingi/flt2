// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/wishlist/wishlist_repo.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/wishlist_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CommonWishlistController extends GetxController {
  WishListRepo? wishlistRepo;
  var allWishlist = [].obs;
  var isLoading = true.obs;
  final themeController = Get.find<ThemeController>();
  var isLoginMessage = false;
  @override
  void onInit() {
    wishlistRepo = WishListRepo();
    checkWishlistMessageExists();
    super.onInit();
  }

  checkWishlistMessageExists() {
    List<dynamic> allTemplates = themeController.allTemplate.value;
    var messageComponent = allTemplates
        .firstWhereOrNull((value) => value['id'] == 'wishlist-login-message');
    isLoginMessage = messageComponent != null && messageComponent.isNotEmpty;
  }

  Future getAllWishilst() async {
    var userId = GetStorage().read('utoken');
    if (userId != null) {
      var result = await wishlistRepo!.getAllWishlistForUSer();
      if (result != null) {
        var response = wishlistProductDataVMFromJson(result);
        if (response != null && response.length > 0) {
          allWishlist.value = response;
        } else {
          allWishlist.value = [];
        }
      }
    } else {
      allWishlist.value = [];
    }
    allWishlist.refresh();
  }

  clearAllWishlist() {
    allWishlist.value = [];
    allWishlist.refresh();
  }

  Future removeProductToWishlist(productId) async {
    await wishlistRepo!.removeWishlist(productId);
    getAllWishilst();
  }

  Future checkProductAndAdd(productId) async {
    var arguments = Get.arguments;
    var path = Get.currentRoute;
    var userId = GetStorage().read('utoken');
    if (userId != null) {
      var isExists =
          allWishlist.value.any((element) => element.productId == productId);
      if (isExists) {
        var data = allWishlist.value
            .firstWhereOrNull((element) => element.productId == productId);
        if (data != null) {
          await wishlistRepo!.removeWishlist(data.sId);
        }
      } else {
        var input = {"productId": productId, "userId": ""};
        await wishlistRepo!.createWishlist(input);
      }
      getAllWishilst();
    } else {
      if (isLoginMessage == true) {
        await Get.toNamed('/wishlistLoginMessage',
            arguments: {"path": path, "arguments": arguments});
      } else {
        await Get.toNamed('/login',
            arguments: {"path": path, "arguments": arguments});
      }
    }
  }

  bool checkProductIsInWishlist(productId) {
    var userId = GetStorage().read('utoken');
    if (userId != null) {
      var isExists =
          allWishlist.value.any((element) => element.productId == productId);
      if (isExists) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  void onClose() {
    allWishlist.close();
    isLoading.close();
    super.onClose();
  }
}
