// ignore_for_file: unused_local_variable, unnecessary_null_comparison, invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/collection/collection_repo.dart';
import 'package:black_locust/common_component/wishlist_popup.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/common_wishlist_controller.dart';
import 'package:black_locust/controller/plugins_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/landing_page_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartLoginMessageController extends GetxController with BaseController {
  CollectionRepo? collectionRepo;
  var isLoading = false.obs;
  var isNoData = false.obs;
  var collectionProduct = [].obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  var wishlistFlag = false.obs;
  var arguments;
  final themeController = Get.find<ThemeController>();
  final commonWishlistController = Get.find<CommonWishlistController>();
  final commonReviewController = Get.find<CommonReviewController>();
  final _pluginController = Get.find<PluginsController>();
  var nectarReviews = [];

  @override
  void onInit() {
    collectionRepo = CollectionRepo();
    arguments = Get.arguments;
    getTemplate();
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates
        .firstWhereOrNull((value) => value['id'] == 'cart-login-message');
    isTemplateLoading.value = false;
    if (template.value != null && template.value.isNotEmpty) {
      var blocks = template['layout']['blocks'];
      if (blocks != null && blocks.isNotEmpty) {
        for (var block in blocks) {
          if (block['componentId'] == 'related-products') {
            var source = block['source'];
            getProducts(source['collection'], source['limit'] ?? 10);
          }
        }
      }
    }
  }

  Future getProducts(handle, limit) async {
    isLoading.value = true;
    var productIdentifiers = themeController.productBadge != null
        ? [themeController.productBadge]
        : [];
    var productResult = await collectionRepo!
        .getPromotionProductsByCollection(handle, limit, productIdentifiers);
    if (productResult != null) {
      var productResponse = productPromotionFromJson(productResult);
      collectionProduct.value = productResponse;
      if (collectionProduct.value.isNotEmpty)
        await assignNectorReviews(collectionProduct.value);
    }
    isLoading.value = false;
  }

  Future assignNectorReviews(products) async {
    var nectar = _pluginController.getPluginValue('nectar');
    if (nectar != null) {
      if (products != null && products.isNotEmpty) {
        var productIds = products.map((element) => element.sId).toList();
        await commonReviewController.getAllNectarReviews(productIds);
      }
    }
  }

  Future navigateToProductDetails(product) async {
    var result = await Get.toNamed('/productDetail', arguments: product);
  }

  Future openLoginPage() async {
    var result = await Get.toNamed('/login', arguments: arguments);
  }

  getWishListonClick(product) {
    return commonWishlistController.checkProductIsInWishlist(product.sId);
  }

  Future openWishlistPopup(productId, product) async {
    var userId = GetStorage().read('utoken');
    if (userId != null) {
      var result = await Get.bottomSheet(
        Container(
          height: MediaQuery.of(Get.context!).size.height / 0.1,
          child: WishlistPopup(
            product: product,
            productId: product.sId,
          ),
        ),
        enterBottomSheetDuration: Duration(milliseconds: 200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      );
      if (result != null)
        changeWishlist(result['wishlistCollection'], productId);
    } else {
      var result = await Get.toNamed('/login', arguments: {"path": "/home"});
      if (result != null) {
        userId = result;
      }
    }
  }

  changeWishlist(wishlistCollections, productId) {
    if (collectionProduct.value != null && collectionProduct.value.isNotEmpty) {
      var element;
      var product;
      for (var i = 0; i < collectionProduct.value.length; i++) {
        element = collectionProduct.value[i];
        if (element['products'] != null && element['products'].isNotEmpty) {
          for (var j = 0; j < element['products'].length; j++) {
            product = element['products'][j];
            if (product.sId == productId) {
              collectionProduct.value[i]['products'][j].wishlistCollection =
                  wishlistCollections;
              collectionProduct.value[i]['products'][j].isWishlist =
                  (wishlistCollections != null &&
                      wishlistCollections.isNotEmpty);
            }
          }
        }
      }
      wishlistFlag.value = !wishlistFlag.value;
    }
  }

  Future addProductToWishList(String productId) async {
    commonWishlistController.checkProductAndAdd(productId);
  }

  List<ProductSizeOptions> getAvailableOptions(PromotionProductsVM product) {
    List<ProductSizeOptions> sizeOptions = [];

    var options = product.options;
    if (options != null && options.length > 0) {
      PromotionProductOptionsVM size = options.firstWhere(
          (element) => element.name == "Size",
          orElse: () => PromotionProductOptionsVM(
              name: null, sId: null, values: [], sTypename: null));
      if (size != null && size.values != null && size.values.length > 0) {
        product.variants!.forEach((e) {
          var variantOptions = e.title!.split(' / ');
          size.values.forEach((da) {
            var haveSizeOption = variantOptions.contains(da.name);
            bool containSize = sizeOptions.any((obj) => obj.name == da.name);
            if (haveSizeOption && !containSize) {
              var sizeList = new ProductSizeOptions(
                  name: da.name, isAvailable: e.availableForSale);
              sizeOptions.add(sizeList);
            }
          });
        });
        return sizeOptions;
      } else {
        return sizeOptions;
      }
    } else {
      return sizeOptions;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
