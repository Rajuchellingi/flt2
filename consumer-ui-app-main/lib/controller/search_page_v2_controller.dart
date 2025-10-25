// ignore_for_file: unused_local_variable, invalid_use_of_protected_member, unnecessary_null_comparison, avoid_init_to_null

import 'package:b2b_graphql_package/modules/cart/cart_repo.dart';
import 'package:black_locust/common_component/wishlist_popup.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/related_product_model.dart';
import 'package:black_locust/model/search_v1_model.dart';
// import 'package:b2b_graphql_package/modules/wishlist/wishlist_model.dart';
import '../model/product_list_model.dart';
import '../model/search_model.dart';

import 'package:b2b_graphql_package/modules/search/search_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../const/constant.dart';
import '../const/size_config.dart';
import 'base_controller.dart';

class SearchPageV2Controller extends GetxController with BaseController {
  SearchRepo? searchRepo;
  CartRepo? cartRepo;
  var pagelimit = 20;
  var categoryPackWithSet = Object().obs;
  var productList = [].obs;
  var newData = [];

  var attributeList = [];
  var selectedFilter = [];
  var allWishList = [].obs;
  var isLoading = false.obs;
  var selectedCategoryName = ''.obs;
  var selectedCategoryLink;
  var searchText;
  var pageIndex = 1;
  var cartBagCount = 0.obs;
  var userId;
  var argument;
  var wishlistFlag = false.obs;
  var sortSetting = [].obs;

  var sortList = [
    {"item": "Featured", "value": "default"},
    {"item": "Price Low to High", "value": "lowtohigh"},
    {"item": "Price High to Low", "value": "hightolow"},
    {"item": "New", "value": "new"}
  ];
  var selectedSort = SortSetting(
          sId: 1, sortKey: "RELEVANCE", name: "Relevance", reverse: false)
      .obs;
  var loading = false.obs;
  bool allLoaded = false;
  final ScrollController scrollController = new ScrollController();
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();

  @override
  void onInit() {
    cartRepo = CartRepo();
    searchRepo = SearchRepo();
    userId = GetStorage().read('utoken');
    argument = Get.arguments;
    if (argument != null) {
      selectedCategoryName.value = argument["search"];
      searchText = argument["search"];
      // value = argument["id"];
      initialLoad();
      getTemplate();
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
                scrollController.position.maxScrollExtent &&
            !loading.value) {
          paginationFetch();
        }
      });
    }
    GetStorage().remove('searchfilter');
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates
        .firstWhereOrNull((value) => value['id'] == 'search-product-list');
    isTemplateLoading.value = false;
  }

  @override
  void dispose() {
    GetStorage().remove('searchfilter');
    super.dispose();
  }

  paginationFetch() async {
    if (allLoaded) {
      return;
    }

    loading.value = true;

    await Future.wait([getSearchProducts(), getAllWishListValidation()]);

    if (newData.isNotEmpty) {
      productList.addAll(newData);
      productList.refresh();
      pageIndex += 1;
    }
    loading.value = false;
    allLoaded = newData.isEmpty;
  }

  Future initialLoad() async {
    this.isLoading.value = true;
    await Future.wait([
      getSearchProducts(),
      getSortSetting(),
      getAllWishListValidation(),
    ]);
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
      getSearchProducts(),
      getAllWishListValidation(),
    ]);
    if (newData.isNotEmpty) {
      productList.addAll(newData);
      productList.refresh();
      pageIndex += 1;
    }
    isLoading.value = false;
  }

  Future getSearchProducts() async {
    var result =
        await searchRepo!.getProductsBySearchForUIV1(searchText, pageIndex, []);
    print(
        'result-------------------------------------======================= ${result.toJson()}');
    if (result != null) {
      var productListDetails = searchProductV1VMFromJson(result);
      newData = productListDetails.products;
    }
  }

  Future navigateToProductDetails(product) async {
    var result = await Get.toNamed('/productDetail', arguments: product);
    getAllWishListValidation();
  }

  Future getSortSetting() async {
    var sortOptions = [
      {"name": "Relevance", "_id": 1, "sortKey": "RELEVANCE", "reverse": false},
      {"name": "Latest", "_id": 2, "sortKey": "CREATED_AT", "reverse": false},
      {"name": "Title: A-Z", "_id": 3, "sortKey": "TITLE", "reverse": false},
      {"name": "Title: Z-A", "_id": 4, "sortKey": "TITLE", "reverse": true},
      {
        "name": "Price - Low to High",
        "_id": 5,
        "sortKey": "PRICE",
        "reverse": false
      },
      {
        "name": "Price - High to Low",
        "_id": 6,
        "sortKey": "PRICE",
        "reverse": true
      },
    ];
    var sort = sortSettingFromJson(sortOptions);
    sortSetting.value = sort;
    // }
  }

  snackMessage(String message) {
    Get.snackbar("", message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kTextColor,
        colorText: Colors.white,
        // duration: Duration(milliseconds: 10000),
        maxWidth: SizeConfig.screenWidth,
        borderRadius: 0,
        titleText: Container(),
        snackStyle: SnackStyle.FLOATING,
        // padding: EdgeInsets.all(kDefaultPadding / 2),
        // margin: EdgeInsets.all(0)
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10));
  }

  Future openCart() async {
    await Get.toNamed("/cart");
  }

  Future openFilter() async {
    final dynamic result =
        await Get.toNamed('/searchFilter', arguments: selectedCategoryLink);
    if (result != null && result is List<dynamic>) {
      selectedFilter = result;
      formateFilter(selectedFilter);
      refreshPage();
    } else {
      // Handle the case where the result is null or not of the expected type.
      // You can log an error, display an error message, or take appropriate action.
    }
  }

  formateFilter(List selectedFilter) {
    if (selectedFilter.length > 0) {
      var index;
      for (var i = 0; i < attributeList.length; i++) {
        index = -1;
        for (var j = 0; j < selectedFilter.length; j++) {
          if (selectedFilter[j].fieldName == attributeList[i].fieldName) {
            if (index == -1) {
              index = j;
            } else {
              selectedFilter[index].fieldValue =
                  selectedFilter[index].fieldValue +
                      "," +
                      selectedFilter[j].fieldValue;
              selectedFilter.removeAt(j);
            }
          }
        }
      }
    }
  }

  openSort() {
    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(
          minHeight: 0.0,
          maxHeight: getSortHeight(),
        ),
        // height: SizeConfig.screenHeight * 0.35,
        // height: double.maxFinite,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Sort By',
              style: TextStyle(
                  fontSize: getProportionateScreenHeight(15),
                  color: kSecondaryColor,
                  fontWeight: FontWeight.bold),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: sortSetting.length,
                itemBuilder: (context, index) {
                  return Column(children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      onTap: () {
                        filterSortItem(sortSetting[index]);
                      },
                      dense: true,
                      title: Text(
                        sortSetting[index].name,
                        style: TextStyle(
                            fontWeight:
                                selectedSort.value.sId == sortSetting[index].sId
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            fontSize: getProportionateScreenHeight(15)),
                      ),
                      trailing: Radio<dynamic>(
                        value: sortSetting[index].sId,
                        groupValue: selectedSort.value.sId,
                        onChanged: (value) {
                          filterSortItem(sortSetting[index]);
                        },
                      ),
                    )
                  ]);
                },
              ),
            )
          ]),
        ),
      ),
    );
  }

  getSortHeight() {
    var padding = (kDefaultPadding / 2) * 2;
    var fontSize = getProportionateScreenHeight(15) * 2;
    var height = (padding + fontSize) * (sortSetting.length + 2);
    return height;
  }

  filterSortItem(item) {
    Get.back();
    selectedSort.value = item;
    refreshPage();
    // sort.add(sortItem);
    // this.getProductList(selectedCategoryLink, pageIndex, sort);
  }

  Future getAllWishListValidation() async {
    // if (userId != null) {
    //   var result =
    //       await wishListRepo!.getAllProductWishlistForVerification(userId);
    //   if (result != null) {
    //     allWishList.value = result;
    //     wishlistFlag.value = !wishlistFlag.value;
    //   }
    // }
  }
  Future<void> openWishListPopup(productId, product) async {
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
    if (result != null) refreshPage();
  }

  Future addProductToWishList(String productId) async {
    await GetStorage.init();
    // await GetStorage().erase();
    if (userId != null) {
      showLoading('Loading...');
      // await GetStorage().remove('wishlist');
      var existingProductIds = GetStorage().read("wishlist") ?? [];
      if (!existingProductIds.contains(productId)) {
        existingProductIds.add(productId);
        GetStorage().write("wishlist", existingProductIds);
        wishlistFlag.value = !wishlistFlag.value;
      } else {
        var existingProductIds = GetStorage().read("wishlist") ?? [];
        existingProductIds.removeWhere((item) => item == productId);
        // existingProductIds.add(productId);
        GetStorage().write("wishlist", existingProductIds);
        wishlistFlag.value = !wishlistFlag.value;
      }
      hideLoading();
    } else {
      var result = await Get.toNamed('/login',
          arguments: {"path": "/searchPage", "arguments": argument});
      if (result != null) {
        userId = result;
        initialLoad();
      }
    }
  }

  getWishListonClick(product) {
    return product.wishlistCollection.isNotEmpty;
  }

  List<RelatedProductSizeOptions> getAvailableOptions(RelatedProduct product) {
    List<RelatedProductSizeOptions> sizeOptions = [];

    var options = product.options;
    if (options != null && options.length > 0) {
      RelatedProductOptionsVM size = options.firstWhere(
          (element) => element.name == "Size",
          orElse: () => RelatedProductOptionsVM(
              name: null, sId: null, values: [], sTypename: null));
      if (size != null && size.values != null && size.values.length > 0) {
        product.variants!.forEach((e) {
          var variantOptions = e.title!.split(' / ');
          size.values.forEach((da) {
            var haveSizeOption = variantOptions.contains(da.name);
            bool containSize = sizeOptions.any((obj) => obj.name == da.name);
            if (haveSizeOption && !containSize) {
              var sizeList = new RelatedProductSizeOptions(
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

  List<SearchProductSizeOptions> getProductAvailableOptions(
      ProductCollectionListVM product) {
    List<SearchProductSizeOptions> sizeOptions = [];

    var options = product.options;
    if (options != null && options.length > 0) {
      ProductOptionsVM size = options.firstWhere(
          (element) => element.name == "Size",
          orElse: () => ProductOptionsVM(
              name: null, sId: null, values: [], sTypename: null));
      if (size != null && size.values != null && size.values.length > 0) {
        product.variants!.forEach((e) {
          var variantOptions = e.title!.split(' / ');
          size.values.forEach((da) {
            var haveSizeOption = variantOptions.contains(da.name);
            bool containSize = sizeOptions.any((obj) => obj.name == da.name);
            if (haveSizeOption && !containSize) {
              var sizeList = new SearchProductSizeOptions(
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

  Future<void> openProfilePage() async {
    userId = GetStorage().read('utoken');

    if (userId != null) {
      await Get.toNamed('/profile');
      productList.refresh();
    } else {
      Get.toNamed('/login', arguments: {"path": "/profile"});
    }
  }

  Future<void> userAnalysis() async {
    userId = GetStorage().read('utoken');

    if (userId != null) {
      await Get.toNamed('/wishlist');
      productList.refresh();
    } else {
      Get.toNamed('/login', arguments: {"path": "/wishlist"});
    }
  }

  @override
  void onClose() {
    super.onClose();
    GetStorage().remove('searchfilter');
  }
}
