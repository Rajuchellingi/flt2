// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:b2b_graphql_package/modules/wishlist/wishlist_repo.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/wishlist_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class WishlistCollectionController extends GetxController {
  WishListRepo? wishListRepo;
  final ScrollController scrollController = new ScrollController();

  var collectionAllList = [].obs;
  var productList = [].obs;
  var pagelimit = 20;
  var limit = 20;
  var isLoading = false.obs;
  var newData = [];
  bool allLoaded = false;
  var pageIndex = 1;
  var loading = false.obs;
  var wishlistFlag = false.obs;
  var filterId;
  var collectionName = ''.obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  @override
  void onInit() {
    wishListRepo = WishListRepo();
    filterId = Get.arguments;
    // print("Hello--->>>1111 ${filterId}");
    selectedCollection(filterId);
    initialLoad();
    getTemplate();
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
    // ignore: invalid_use_of_protected_member
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'my-wishlist');
    isTemplateLoading.value = false;
  }

  Future initialLoad() async {
    this.isLoading.value = true;
    await Future.wait([selectedCollection(filterId)]);
    if (newData.isNotEmpty) {
      productList.addAll(newData);
      productList.refresh();
      pageIndex += 1;
    }
    this.isLoading.value = false;
  }

  Future<Null> refreshPage() async {
    isLoading.value = true;
    allLoaded = false;
    productList.value = [];
    pageIndex = 1;
    await Future.wait([
      // getProductList(selectedCategoryLink, pageIndex, selectedFilter),
      selectedCollection(filterId)
    ]);
    if (newData.isNotEmpty) {
      productList.addAll(newData);
      productList.refresh();
      pageIndex += 1;
    }
    isLoading.value = false;
  }

  paginationFetch() async {
    // print("allLoaded -->>> ${allLoaded}");
    if (allLoaded == false) {
      return;
    }
    loading.value = true;
    await Future.wait([selectedCollection(filterId)]);

    if (newData.isNotEmpty) {
      productList.addAll(newData);
      productList.refresh();
      pageIndex += 1;
    }
    loading.value = false;
    allLoaded = newData.isEmpty;

    // if (allLoaded) {
    //   snackMessage('No data found');
    // }
  }

  Future navigateToProductDetails(product) async {
    // print("Product-->>> ${product[0].toJson()}");
    var result = await Get.toNamed('/productDetail',
        preventDuplicates: false, arguments: product);
    // getAllWishListValidation();
  }

  Future selectedCollection(filterId) async {
    // print("id--->>>>filterId ${filterId}");
    var userIds = "";
    var result = await wishListRepo!
        .getProductsByWishlistCollection(userIds, filterId, limit, pageIndex);
    //  if(result == true){
    var productListCollectonDetails =
        productCollectionWishlistVMFromJson(result);
    //  print("productListCollectonDetails ${productListCollectonDetails}");
    newData = productListCollectonDetails.product;
    collectionName.value = productListCollectonDetails.collectionName!;
    //  print("wishlistCollection--->>>>: ${newData.map((e) => e.toJson()).toList()}");
    //  print("wishlistCollection.value ${wishlistCollection.value}");
    //  }
    // wc_controller.allWishlistPageCollectionList();
  }

  Future deleteCollection(selectedProduct) async {
    var collectionId = filterId;
    var wishlistIds = selectedProduct.wishlistId;
    var result =
        await wishListRepo!.removeColectionWishlist(wishlistIds, collectionId);
    // print("result deleteCollection ${result}");
    if (result == true) {
      // selectedCollection(filterId);
      // wc_controller.allWishlistPageCollectionList();
      // productList.refresh();
      refreshPage();
    }
    // hideLoading();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
