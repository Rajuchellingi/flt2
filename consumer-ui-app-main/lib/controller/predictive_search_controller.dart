// ignore_for_file: unused_local_variable, unnecessary_null_comparison, invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/collection/collection_repo.dart';
import 'package:b2b_graphql_package/modules/search/search_repo.dart';
import 'package:black_locust/common_component/wishlist_popup.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/common_wishlist_controller.dart';
import 'package:black_locust/controller/plugins_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/keyboard.dart';
import 'package:black_locust/model/landing_page_model.dart';
import 'package:black_locust/model/search_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import '../common_component/speech_to_text.dart';

class PredictiveSearchController extends GetxController with BaseController {
  SearchRepo? searchRepo;
  CollectionRepo? collectionRepo;
  var suggestions = [].obs;
  var searchQuery = [].obs;
  var searchSetting = new SearchSettingVM(
          sId: null, popularSearches: [], recommendedProducts: null)
      .obs;
  var isLoading = false.obs;
  var isNoData = false.obs;
  var collectionProduct = [].obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  var wishlistFlag = false.obs;
  final themeController = Get.find<ThemeController>();
  final commonWishlistController = Get.find<CommonWishlistController>();
  final commonReviewController = Get.find<CommonReviewController>();
  final _pluginController = Get.find<PluginsController>();
  var nectarReviews = [];

  @override
  void onInit() {
    searchRepo = SearchRepo();
    collectionRepo = CollectionRepo();
    getSearchSetting();
    getTemplate();
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'search');
    isTemplateLoading.value = false;
  }

  Future getSearchSetting() async {
    var result = await searchRepo!.getSearchSetting();
    if (result != null) {
      var response = searchSettingVMFromJson(result);
      print("result ${response.popularSearches}");
      searchSetting.value = response;
      if (response.recommendedProducts != null &&
          response.recommendedProducts!.collectionUrl != null) {
        var link = response.recommendedProducts!.collectionUrl;
        var splittedLink = link!.split('/');
        var handle = splittedLink[splittedLink.length - 1];
        var limit = response.recommendedProducts!.count;
        var productIdentifiers = themeController.productBadge != null
            ? [themeController.productBadge]
            : [];
        var productResult = await collectionRepo!
            .getPromotionProductsByCollection(
                handle, limit, productIdentifiers);
        if (productResult != null) {
          var productResponse = productPromotionFromJson(productResult);
          collectionProduct.value = productResponse;
          if (collectionProduct.value.isNotEmpty)
            await assignNectorReviews(collectionProduct.value);
        }
      }
    }
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

  Future openVoiceSearch(context, pageType) async {
    KeyboardUtil.hideKeyboard(context);
    var permission = await Permission.microphone.status;
    if (permission.isDenied || permission.isPermanentlyDenied) {
      permission = await Permission.microphone.request();
      if (permission.isDenied) {
        return;
      }
    }

    if (permission.isPermanentlyDenied) {
      openAppSettings();
      return;
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SpeechToTextPopup();
        }).then((value) {
      if (value != null) {
        var recentSearch = GetStorage().read("recentSearch") ?? [];
        if (!recentSearch.contains(value.trim())) {
          searchQuery.value.add(value.trim());
          GetStorage().write("recentSearch", searchQuery.value);
        }
        checkTypeAndNavigate(context, pageType, value.trim());
      }
    });
  }

  Future checkTypeAndNavigate(context, type, searchInput) async {
    if (type == 'searchPage') {
      await Get.toNamed('/searchPage',
          preventDuplicates: false, arguments: {"search": searchInput});
    } else {
      var results = await Get.toNamed('/searchPage',
          preventDuplicates: false, arguments: {"search": searchInput});
    }
  }

  Future getSearchSuggestions(searchText) async {
    if (searchText != null && searchText.isNotEmpty) {
      isLoading.value = true;
      var result = await searchRepo!.getPredictiveSearch(searchText);
      isLoading.value = false;
      if (result != null) {
        var response = predictiveSearchVMFromJson(result);
        suggestions.value = response.products!;
        isNoData.value = false;
        if (response.products == null || response.products!.length == 0)
          isNoData.value = true;
      } else {
        isNoData.value = true;
        suggestions.value = [];
      }
    } else {
      isNoData.value = false;
      suggestions.value = [];
    }
    var searchList = GetStorage().read("recentSearch");
    searchQuery.value = searchList != null ? searchList.reversed.toList() : [];
  }

  Future submitSearch(context, value, pageName) async {
    RegExp regex = RegExp(r'^.{1,100}$');
    if (value.trim().isNotEmpty) {
      if (regex.hasMatch(value)) {
        var recentSearch = GetStorage().read("recentSearch") ?? [];

        if (!recentSearch.contains(value.trim())) {
          searchQuery.value.add(value.trim());
          GetStorage().write("recentSearch", searchQuery.value);
        }

        suggestions.value = [];
        Navigator.of(context).pop();

        if (pageName == 'searchPage') {
          await Get.toNamed('/searchPage',
              preventDuplicates: false, arguments: {"search": value.trim()});
        } else {
          onSearchProduct(value.trim());
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid search query.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a non-empty search query.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // Future submitSearch(context, value, pageName) async {
  //   RegExp regex = RegExp(r'^.{1,50}$');
  //   if (value.trim().isNotEmpty) {
  //     if (regex.hasMatch(value)) {
  //       var recentSearch = GetStorage().read("recentSearch");
  //       if (recentSearch != null && recentSearch.length > 0)
  //         searchQuery.value.add(value);
  //       else
  //         searchQuery.value.add(value);
  //       GetStorage().write("recentSearch", searchQuery.value);
  //       suggestions.value = [];
  //       Navigator.of(context).pop();
  //       if (pageName == 'searchPage') {
  //         Navigator.pushReplacementNamed(context, '/searchPage',
  //             arguments: {"search": value.trim()});
  //       } else {
  //         onSearchProduct(value.trim());
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Please enter a valid search query.'),
  //           behavior: SnackBarBehavior.floating,
  //         ),
  //       );
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Please enter a non-empty search query.'),
  //         behavior: SnackBarBehavior.floating,
  //       ),
  //     );
  //   }
  // }

  onSearchProduct(value) async {
    var results = await Get.toNamed('/searchPage',
        preventDuplicates: false, arguments: {"search": value});
  }

  Future navigateToProductDetails(product) async {
    var result = await Get.toNamed('/productDetail', arguments: product);
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
    suggestions.clear();
    super.dispose();
  }
}
