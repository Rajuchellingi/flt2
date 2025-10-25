// ignore_for_file: unused_local_variable, invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/wishlist/wishlist_repo.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/controller/wishlist_popup_controller.dart';
import 'package:black_locust/model/wishlist_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class WishlistV1Controller extends GetxController {
  WishListRepo? wishlistRepo;
  final ScrollController scrollController = new ScrollController();

  // var wishlists = [
  //   Wishlist('My Wishlist', ['assets/image1.png', 'assets/image2.png', 'assets/image3.png', 'assets/image4.png', 'assets/image5.png']),
  //   Wishlist('Wedding Gift List', ['assets/image1.png', 'assets/image2.png', 'assets/image3.png']),
  //   Wishlist('Travel Wear', ['assets/image1.png', 'assets/image2.png']),
  //   Wishlist('Books Heeding', ['assets/image1.png', 'assets/image2.png', 'assets/image3.png', 'assets/image4.png', 'assets/image5.png', 'assets/image6.png']),
  // ].obs;
  var collectionAllList = [].obs;
  var productList = [].obs;
  var pagelimit = 20;
  var limit = 20;
  var isLoading = false.obs;
  var newData = [].obs;
  bool allLoaded = false;
  var pageIndex = 1;
  var loading = false.obs;
  var wishlistFlag = false.obs;
  final _controller = Get.find<WishlistPopupController>();
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  @override
  void onInit() {
    wishlistRepo = WishListRepo();
    allWishlistPageCollectionList();
    getTemplate();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !loading.value) {}
    });
    super.onInit();
  }

  Future allWishlistPageCollectionList() async {
    // print("Hello--->>>222");
    // print('Creating new wishlist collection: $collectionId');
    isLoading.value = true;

    var userIds = "";
    // showLoading('Loading...');
    var result = await wishlistRepo!.allWishlistPageCollectionList(userIds);
    if (result != null) {
      var productColectionListDetails =
          wishListCollectionListVMFromJson(result);
      // print("getProductList productColectionListDetails--->>>>: ${productColectionListDetails.toJson()}");
      collectionAllList.value = productColectionListDetails.product;
    }
    // }
    // hideLoading();
    isLoading.value = false;
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'my-wishlist');
    isTemplateLoading.value = false;
  }

  Future deleteOverallCollection(context, collectionId) async {
    // print("id--->>>>filterId $collectionId");
    var collectionIds = collectionId;
    var result =
        await wishlistRepo!.removeOverallColectionWishlist(collectionIds);
    if (result == true) {
      _controller.getWishlistCollection();
      allWishlistPageCollectionList();
      // Navigator.of(context).pop();
      // Get.back();
    }
  }

  Future updateCollectionName(newName, filterId) async {
    // print("id--->>>>filterId ${filterId}");
    var collectionId = filterId;
    var name = newName;
    var userIdsss = '';
    var result =
        await wishlistRepo!.changeCollectionName(collectionId, name, userIdsss);
    if (result == true) {
      _controller.getWishlistCollection();
      allWishlistPageCollectionList();
      // selectedCollection(filterId);
    }
    refresh();
  }

  Future navigateToWishlistCollection(filterId) async {
    // print("filterId---/// ${filterId}");
    // print("Product-->>> ${product[0].toJson()}");
    var result = await Get.toNamed('/wishlistCollection',
        preventDuplicates: false, arguments: filterId);
    // getAllWishListValidation();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
