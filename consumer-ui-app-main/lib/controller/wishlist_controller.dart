// ignore_for_file: override_on_non_overriding_member, invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/wishlist/wishlist_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/common_wishlist_controller.dart';
import 'package:black_locust/controller/plugins_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/wishlist_model.dart';
import 'package:flutter/material.dart';
// import 'package:black_locust/model/wishlist_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WishlistController extends GetxController with BaseController {
  @override
  var textName;
  var isLoading = false.obs;
  WishListRepo? wishListRepo;
  var wishlist = <dynamic>[].obs;
  var userId;
  var pageIndex = 1;
  var pageLimit = 10;
  var newData = <dynamic>[];
  bool allLoaded = false;
  var loading = false.obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  final commonWishlistController = Get.find<CommonWishlistController>();
  final ScrollController scrollController = ScrollController();
  final commonReviewController = Get.find<CommonReviewController>();
  var nectarReviews = <dynamic>[];
  final _pluginController = Get.find<PluginsController>();

  @override
  void onInit() {
    this.textName = 'No Record Found!';
    wishListRepo = WishListRepo();
    userId = GetStorage().read('utoken');
    if (userId != null) {
      initialLoad();
      _setupScrollListener();
    }
    getTemplate();
    super.onInit();
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !loading.value &&
          !allLoaded) {
        paginationFetch();
      }
    });
  }

  Future refreshPage() async {
    isLoading.value = true;
    allLoaded = false;
    wishlist.clear();
    pageIndex = 1;
    await getWishilstProduct();
    if (newData.isNotEmpty) {
      wishlist.addAll(newData);
      pageIndex += 1;
    }
    isLoading.value = false;
  }

  Future initialLoad() async {
    isLoading.value = true;
    await getWishilstProduct();
    if (newData.isNotEmpty) {
      wishlist.addAll(newData);
      pageIndex += 1;
    }
    isLoading.value = false;
  }

  Future paginationFetch() async {
    if (allLoaded) return;

    loading.value = true;
    await getWishilstProduct();

    if (newData.isNotEmpty) {
      wishlist.addAll(newData);
      pageIndex += 1;
    }
    loading.value = false;
    allLoaded = newData.isEmpty;
  }

  Future getWishilstProduct() async {
    userId = GetStorage().read('utoken');
    if (userId == null) {
      newData = [];
      return;
    }

    var result =
        await wishListRepo!.getAllWishlistWithPagination(pageIndex, pageLimit);
    if (result == null) {
      newData = [];
      return;
    }

    var response = wishilstDataVMFromJson(result);
    if (response.wishlistData?.isEmpty ?? true) {
      newData = [];
      return;
    }

    var productIds = response.wishlistData!
        .map((e) => e.productId)
        .where((id) => id != null)
        .map((id) => id!)
        .toList();
    newData = await getAllWishList(productIds);

    if (newData.isNotEmpty) {
      await assignNectorReviews(newData);
    }
  }

  Future assignNectorReviews(List<dynamic> products) async {
    var nectar = _pluginController.getPluginValue('nectar');
    if (nectar == null || products.isEmpty) return;

    var productIds = products.map((element) => element.sId).toList();
    await commonReviewController.getAllNectarReviews(productIds);
  }

  Future getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'my-wishlist');
    isTemplateLoading.value = false;
  }

  Future<List<WishlistProductDetailVM>> getAllWishList(
      List<String> productIds) async {
    if (productIds.isEmpty) return [];

    var result = await wishListRepo!.getAllWishListWithProduct(productIds);
    if (result == null) return [];

    return wishlistProductDetailVMFromJson(result);
  }

  Future removeWishList(String productId) async {
    await commonWishlistController.checkProductAndAdd(productId);
    refreshPage();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
