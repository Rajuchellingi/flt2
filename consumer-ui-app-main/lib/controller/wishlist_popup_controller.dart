// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/wishlist/wishlist_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/helper/keyboard.dart';
import 'package:black_locust/model/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WishlistPopupController extends GetxController with BaseController {
  WishListRepo? wishlistRepo;
  TextEditingController? collectionNameController;
  var wishlistCollection = [].obs;
  var limit = 10;
  var searchText = "";
  var isLoading = false.obs;
  var isCreate = false.obs;
  var selectedCollections = [].obs;
  @override
  void onInit() {
    wishlistRepo = WishListRepo();
    var isLoggedIn = GetStorage().read('utoken');
    if (isLoggedIn != null) getWishlistCollection();
    super.onInit();
  }

  Future getWishlistCollection() async {
    isLoading.value = true;
    collectionNameController = new TextEditingController();
    var result =
        await wishlistRepo!.wishlistPageCollectionList(searchText, limit);
    if (result != null) {
      var productColectionListDetails = wishlistCollectionVMFromJson(result);
      wishlistCollection.value = productColectionListDetails;
    }
    isLoading.value = false;
  }

  openCreateNewCollection() {
    isCreate.value = !isCreate.value;
  }

  Future createWishlistCollection() async {
    var collectionName = collectionNameController!.text;
    if (collectionName != null && collectionName.isNotEmpty) {
      KeyboardUtil.hideKeyboard(Get.context!);
      showLoading('Loading...');
      var result = await wishlistRepo!.createWishListName(collectionName);
      hideLoading();
      if (result == true) {
        isCreate.value = false;
        collectionNameController = new TextEditingController();
        getWishlistCollection();
      }
    }
  }

  assignSelectedCollections(collections) {
    isCreate.value = false;
    collectionNameController = new TextEditingController();
    if (collections != null && collections.length > 0) {
      selectedCollections.value = collections;
    } else {
      var defaultCollection = wishlistCollection.value
          .firstWhereOrNull((element) => element.isDefault == true);
      if (defaultCollection != null)
        selectedCollections.value = [defaultCollection.sId];
    }
  }

  onChangeCollection(collectionId) {
    var isExists = selectedCollections.value.contains(collectionId);
    if (isExists) {
      selectedCollections.value.remove(collectionId);
      selectedCollections.refresh();
    } else {
      selectedCollections.value.add(collectionId);
      selectedCollections.refresh();
    }
  }

  Future addProductToWishlist(productId) async {
    showLoading("Loading...");
    var result = await wishlistRepo!
        .createListoverall(selectedCollections.value, productId);
    hideLoading();
    if (result != null)
      Get.back(result: {'wishlistCollection': selectedCollections.value});
    selectedCollections.value = [];
  }

  @override
  void onClose() {
    super.onClose();
  }
}
