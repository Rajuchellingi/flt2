// ignore_for_file: unnecessary_null_comparison, unused_local_variable, avoid_init_to_null, invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';

import 'package:b2b_graphql_package/modules/cart/cart_repo.dart';
import 'package:b2b_graphql_package/modules/collection/collection_repo.dart';
import 'package:b2b_graphql_package/modules/related_product/related_product_repo.dart';
import 'package:black_locust/controller/collection_filter_v1_controller.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/common_wishlist_controller.dart';
import 'package:black_locust/controller/plugins_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/collection_model.dart';
import 'package:black_locust/model/related_product_model.dart';
import 'package:black_locust/view/collection/components/collection_filter_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../const/constant.dart';
import '../const/size_config.dart';
import '../model/product_list_model.dart';
import 'base_controller.dart';

class CollectionController extends GetxController with BaseController {
  CollectionRepo? collectionRepo;
  CartRepo? cartRepo;
  var pagelimit = 10.obs;
  var categoryPackWithSet = Object().obs;
  var productList = [].obs;
  var newData = [];
  var nectarReviews = [];
  final pluginController = Get.find<PluginsController>();
  var categoryAttribute =
      CollectionAttributeVM(attribute: [], sTypename: "").obs;
  var pageInfo = PageInfoVM(
          hasNextPage: null,
          hasPreviousPage: null,
          endCursor: null,
          sTypename: "")
      .obs;
  var collectionData = new ProductCollectionVM(
          currentPage: null,
          totalPages: null,
          metafields: [],
          count: null,
          collection: null,
          pageInfo: null,
          showDownloadCatalog: null,
          downloadCatalogForm: null,
          downloadCatalogButtonName: null,
          catalogUrl: null,
          collectionCatalog: null,
          product: [],
          banners: [],
          collectionName: null,
          sTypename: null)
      .obs;
  var attributeList = [];
  var selectedFilter = [].obs;
  var allWishList = [];
  var isLoading = false.obs;
  var selectedCategoryName = ''.obs;
  var selectedCategoryLink;
  var pageIndex = 1;
  var cartBagCount = 0.obs;
  var userId;
  var argument;
  var wishlistFlag = false.obs;
  var sortSetting = [].obs;
  RelatedProductRepo? relatedProductRepo;
  var collectionMenu = [].obs;
  var selectedCollectionMenu = ''.obs;
  var collectionRelatedMeta = {
    "namespace": "custom",
    "key": "collection_related_products"
  };
  var selectedSort = SortSetting(
          sId: 1, sortKey: "RELEVANCE", name: "Relevance", reverse: false)
      .obs;
  var sortList = [
    {"item": "Featured", "value": "default"},
    {"item": "Price Low to High", "value": "lowtohigh"},
    {"item": "Price High to Low", "value": "hightolow"},
    {"item": "New", "value": "new"}
  ];
  var loading = false.obs;
  var selectedProductVariants = [].obs;
  var allLoaded = false.obs;
  late ScrollController scrollController;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  final _controller = Get.find<CollectionFilterV1Controller>();
  var collectionFilterValues =
      new CollectionAttributeVM(attribute: null, sTypename: null).obs;
  var viewType = 'default'.obs;
  final commonWishlistController = Get.find<CommonWishlistController>();
  final commonReviewController = Get.find<CommonReviewController>();
  var metafields = [].obs;
  var relatedProducts = [].obs;
  var productCollections = [].obs;
  var isRelatedProduct = false.obs;
  Timer? _scrollDebounce;
  static const _scrollDebounceDelay = Duration(milliseconds: 300);

  var productInstance;
  @override
  void onInit() {
    cartRepo = CartRepo();
    collectionRepo = CollectionRepo();
    relatedProductRepo = RelatedProductRepo();
    userId = GetStorage().read('utoken');
    argument = Get.arguments;
    scrollController = new ScrollController();
    // GetStorage().remove('collectionfilter');
    if (argument != null) {
      // selectedCategoryName = argument["id"];
      selectedCategoryLink = argument["id"];
      // selectedCategoryLink = "Shirts";
      pageIndex = argument["page"] != null ? argument["page"] : 1;
      getTemplate();
      initialLoad();
      getCollectionMenu();
      scrollController.addListener(_onScroll);
    }
    updateCartBag();
    super.onInit();
  }

  void _onScroll() {
    if (_scrollDebounce?.isActive ?? false) _scrollDebounce!.cancel();

    _scrollDebounce = Timer(_scrollDebounceDelay, () {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      final delta = maxScroll - currentScroll;

      // Trigger pagination earlier (200px before end)
      if (delta <= 200 && !loading.value && !allLoaded.value) {
        paginationFetch();
      }
    });
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    productInstance = themeController.instance('product');
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'product-list');
    if (template.value != null) {
      var header = template.value['layout']['header'];
      if (header != null && header.isNotEmpty) {
        viewType.value = header['source']['default-view'] ?? 'default';
      }
    }
    getProductCollection();
    isTemplateLoading.value = false;
  }

  checkIsRelatedProducts() {
    var blocks = template.value['layout']['blocks'];
    if (blocks != null && blocks.isNotEmpty) {
      isRelatedProduct.value = blocks.any((element) =>
          element['componentId'] == 'related-products' &&
          element['visibility']['hide'] == false);
    }
  }

  getProductCollection() {
    if (template.value != null) {
      var blocks = template.value['layout']['blocks'];
      var data;
      if (blocks != null && blocks.length > 0) {
        for (var i = 0; i < blocks.length; i++) {
          var block = blocks[i];
          if (block['componentId'] == 'product-collection' &&
              block['visibility']['hide'] == false) {
            var collection = block['source']['collection'];
            var count = block['source']['count'] ?? 10;
            if (collection != null && collection.isNotEmpty)
              getRelatedProductCollection(collection, count, block);
          }
        }
      }
    }
  }

  Future getRelatedProductCollection(collectionId, count, block) async {
    var result = await relatedProductRepo!
        .getProductsByCollectionForCart(collectionId, count);
    if (result != null) {
      var response = relatedProductFromJson(result);
      print('collection response ${response.length}');
      if (response.length > 0) {
        block['source']['products'] = response;
        productCollections.value.add(block);
        productCollections.refresh();
        if (response.isNotEmpty) await assignNectorReviews(response);
      }
    }
  }

  getCollectionMenu() {
    isLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    var category = allTemplates
        .firstWhere((value) => value['id'] == 'collections', orElse: () => {});
    if (category != null && category != {}) {
      var blocks = category['layout']['blocks'];
      if (blocks != null && blocks.isNotEmpty) {
        var collectionComponent = blocks
            .firstWhere((da) => da['componentId'] == 'collection-component');
        if (collectionComponent != null &&
            collectionComponent['source'] != null &&
            collectionComponent['source']['lists'] != null &&
            collectionComponent['source']['lists'].length > 0) {
          checkMenuLists(collectionComponent['source']['lists']);
        }
      }
    }
  }

  checkMenuLists(lists) {
    var attributes;
    for (var menu in lists) {
      if (menu['link'] != null &&
          menu['link']['value'] != null &&
          menu['link']['value'] == selectedCategoryLink) {
        attributes = menu['attributes'];
        if (attributes != null && attributes.length > 0) {
          collectionMenu.value = attributes;
          break;
        }
      }
      if (menu['lists'] != null && menu['lists'].length > 0) {
        checkMenuLists(menu['lists']);
      }
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

  paginationFetch() async {
    if (pageInfo.value.hasNextPage == false || loading.value) {
      allLoaded.value = true;
      checkIsRelatedProducts();
      return;
    }

    loading.value = true;

    try {
      await getProductList(selectedCategoryLink, pageIndex, selectedFilter.value);

      if (newData.isNotEmpty) {
        productList.value.addAll(newData);
        productList.refresh();
        pageIndex += 1;

        // Run non-critical tasks in background
        _fetchWishlistAndReviewsInBackground();
      }
    } catch (e) {
      print('Pagination error: $e');
    } finally {
      loading.value = false;
      allLoaded.value = newData.isEmpty;
    }
  }

  void _fetchWishlistAndReviewsInBackground() {
    Future.microtask(() async {
      await getAllWishListValidation();
      if (newData.isNotEmpty) {
        await assignNectorReviews(newData);
      }
      productList.refresh();
    });
  }

  Future initialLoad() async {
    this.isLoading.value = true;
    await Future.wait([
      getProductList(selectedCategoryLink, pageIndex, selectedFilter.value),
      getAllWishListValidation(),
      getSortSetting()
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
    allLoaded.value = false;
    productList.value = [];
    pageInfo.value.endCursor = null;
    pageInfo.refresh();
    pageIndex = 1;
    await Future.wait([
      getProductList(selectedCategoryLink, pageIndex, selectedFilter.value),
      getAllWishListValidation()
    ]);
    if (newData.isNotEmpty) {
      productList.addAll(newData);
      productList.refresh();
      pageIndex += 1;
    }
    isLoading.value = false;
  }

  Future<void> getProductList(
      categoryLink, int page, List selectedFilter) async {
    var endCursor = pageInfo.value.endCursor;
    var result;
    var filterData;
    var productBadge = themeController.productBadge;
    if (selectedFilter.isNotEmpty) {
      var input;
      var collectionInput = {
        "first": pagelimit.value,
        "id": categoryLink,
        "filters": selectedFilter,
        "sort": selectedSort.value,
        "endCursor": endCursor,
        "identifiers": [collectionRelatedMeta],
        "productIdentifiers": productBadge != null ? [productBadge] : []
      };
      result = await collectionRepo!.getProductsByCollection(collectionInput);
      filterData = await collectionRepo!.getAttributeByCollection(categoryLink);
    } else {
      var collectionInput = {
        "first": pagelimit.value,
        "id": categoryLink,
        "filters": selectedFilter,
        "sort": selectedSort.value,
        "endCursor": endCursor,
        "identifiers": [collectionRelatedMeta],
        "productIdentifiers": productBadge != null ? [productBadge] : []
      };
      var filters = null;
      filterData = await collectionRepo!.getAttributeByCollection(categoryLink);
      result = await collectionRepo!.getProductsByCollection(collectionInput);
    }
    if (result != null) {
      var productListDetails = productCollectionVMFromJson(result);
      if (filterData != null) {
        collectionFilterValues.value =
            collectionAttributeVMFromJson(filterData);
      }
      pageInfo.value = productListDetails.pageInfo!;
      metafields.value = productListDetails.metafields!;
      assignRelatedProducts();
      selectedCategoryName.value =
          productListDetails.collection!.name.toString();
      newData = productListDetails.product;
      if (newData.isNotEmpty) {
        await assignNectorReviews(newData);
      }
    }
  }

  Future assignNectorReviews(products) async {
    var nectar = pluginController.getPluginValue('nectar');
    if (nectar != null) {
      if (products != null && products.isNotEmpty) {
        var productIds = products.map((element) => element.sId).toList();
        await commonReviewController.getAllNectarReviews(productIds);
      }
    }
  }

  Future assignRelatedProducts() async {
    if (metafields.value.isNotEmpty) {
      var relatedProductsData = metafields.value.firstWhereOrNull((value) =>
          value.namespace == collectionRelatedMeta['namespace'] &&
          value.key == collectionRelatedMeta['key']);
      if (relatedProductsData != null) {
        relatedProducts.value = relatedProductsData.references.edges;
        if (relatedProducts.value.isNotEmpty) {
          await assignNectorReviews(relatedProducts.value);
        }
      }
    }
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

  Future navigateToProductDetails(product) async {
    var result = await Get.toNamed('/productDetail',
        preventDuplicates: false, arguments: product);
    getAllWishListValidation();
  }

  updateCartBag() {}

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
    userId = GetStorage().read('utoken');

    if (userId != null) {
      await Get.toNamed("/cart");
      updateCartBag();
    } else {
      Get.toNamed('/login', arguments: {"path": "/cart"});
    }
  }

  // Future openCart() async {
  //   await Get.toNamed("/cart");
  //   updateCartBag();
  // }

  Future openFilter(design) async {
    var filters = await Get.toNamed('/collectionFilter',
        arguments: {"design": design, "collection": selectedCategoryLink});
    if (filters != null && filters.length > 0) {
      // formateFilter(selectedFilter);
      assignFilterInput(filters);
      refreshPage();
      // getProductList(selectedCategoryLink, pageIndex, selectedFilter);
    } else {
      selectedFilter.value = [];
      refreshPage();
    }
  }

  assignFilterInput(filterList) {
    if (filterList != null && filterList.length > 0) {
      var newFilters = [];
      var inputData;
      for (var element in filterList) {
        if (element['input'] != null &&
            element['input'] != selectedCollectionMenu.value) {
          inputData = jsonDecode(element['input']);
          newFilters.add(inputData);
        }
      }
      selectedFilter.value = newFilters;
    }
    if (selectedCollectionMenu.value != null &&
        selectedCollectionMenu.value.isNotEmpty) {
      var data = jsonDecode(selectedCollectionMenu.value);
      selectedFilter.value.add(data);
    }
  }

  getCollectionMenuProducts(menu) {
    selectedCollectionMenu.value = menu['attribute_input'];
    if (selectedCollectionMenu.value != null &&
        selectedCollectionMenu.value.isNotEmpty) {
      var data = jsonDecode(selectedCollectionMenu.value);
      selectedFilter.value = [data];
      GetStorage().remove('collectionfilter');
      refreshPage();
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
    final brightness = Theme.of(Get.context!).brightness;
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
            const SizedBox(height: 10),
            Row(children: [
              Expanded(
                  child: Text(
                'Sort By',
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(15),
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold),
              )),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.close))
            ]),
            const SizedBox(height: 10),
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
                        activeColor: kPrimaryColor,
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

  openSortDesign2() {
    final brightness = Theme.of(Get.context!).brightness;
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
            color: brightness == Brightness.dark ? Colors.black : kBackground,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        constraints: BoxConstraints(
          minHeight: 0.0,
          maxHeight: getSortHeight() - 20,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
                child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey))),
            SizedBox(height: 15),
            Center(
                child: Text(
              'Sort By',
              style: TextStyle(
                  fontSize: 17,
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.bold),
            )),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: sortSetting.length,
                itemBuilder: (context, index) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              filterSortItem(sortSetting[index]);
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 15),
                                width: SizeConfig.screenWidth,
                                color: selectedSort.value.sId ==
                                        sortSetting[index].sId
                                    ? kPrimaryColor
                                    : brightness == Brightness.dark
                                        ? Colors.black
                                        : kBackground,
                                child: Text(
                                  sortSetting[index].name,
                                  style: TextStyle(
                                      color: selectedSort.value.sId ==
                                              sortSetting[index].sId
                                          ? Colors.white
                                          : brightness == Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize:
                                          getProportionateScreenHeight(15)),
                                )))
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
    var height = (padding + fontSize) * (sortSetting.length + 1.5);
    return height;
  }

  assignSelectedSort(sortItem) {
    selectedSort.value = sortItem;
    refreshPage();
  }

  filterSortItem(item) {
    Get.back();
    selectedSort.value = item;
    refreshPage();
    // sort.add(sortItem);
    // this.getProductList(selectedCategoryLink, pageIndex, sort);
  }

  Future<void> openTopFilter(BuildContext context, controller) async {
    var collectionFilter = collectionFilterValues.value.toJson();
    var filterData = {"filter": collectionFilter['attribute']};
    await _controller.getCategoryAttributeWithSet(
      filterData,
      collectionFilterValues.value.attribute,
      [],
    );

    var selectedFilter = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.8,
          minChildSize: 0.5,
          snap: true,
          snapSizes: [0.5, 0.6, 0.8],
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                child: CollectionFilterPopup(controller: controller),
              ),
            );
          },
        );
      },
    );

    if (selectedFilter != null) {
      // formateFilter(selectedFilter);
      // refreshPage();
      // getProductList(selectedCategoryLink, pageIndex, selectedFilter);
    }
  }

  getProductByFilter(filterList) {
    if (filterList != null && filterList.length > 0) {
      var filterListData = [];
      filterList.forEach((element) {
        var existingFilter = collectionFilterValues.value.attribute!
            .firstWhereOrNull((da) => da.fieldName == element.fieldName);
        if (existingFilter != null) {
          var fieldValueData = existingFilter.fieldValue!.firstWhereOrNull(
              (da) => da.attributeFieldValue == element.fieldValue);
          if (fieldValueData != null) {
            var filter = {
              'fieldName': existingFilter.fieldName.toString(),
              'fieldValue': element.fieldValue.toString(),
              'input': fieldValueData.input,
            };
            filterListData.add(filter);
          }
        }
      });
      assignFilterInput(filterListData);
      refreshPage();
    } else {
      selectedFilter.value = [];
      refreshPage();
    }
  }

  Future getAllWishListValidation() async {}

  Future addProductToWishList(String productId) async {
    commonWishlistController.checkProductAndAdd(productId);
  }

  getWishListonClick(product) {
    return commonWishlistController.checkProductIsInWishlist(product.sId);
  }

  Future addToWishList(productId) async {
    commonWishlistController.checkProductAndAdd(productId);
  }

  onSearchProduct(value) async {
    var results =
        await Get.toNamed('/searchPage', arguments: {"search": value});
    getAllWishListValidation();
  }

  getAvailableVariantOptions(product, type) {
    var sizeOptions = [];
    var options = product.options;
    if (options != null && options.length > 0) {
      dynamic fieldValue =
          options.firstWhere((element) => element.name == type);
      if (fieldValue != null &&
          fieldValue.values != null &&
          fieldValue.values!.length > 0) {
        product.variants!.forEach((e) {
          var variantOptions = e.title!.split(' / ');
          fieldValue.values!.forEach((da) {
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

  List<ProductSizeOptions> getAvailableOptions(
      ProductCollectionListVM product) {
    List<ProductSizeOptions> sizeOptions = [];

    var options = product.options;
    if (options != null && options.length > 0) {
      CollectionProductOptions size = options.firstWhere(
          (element) => element.name == "Size",
          orElse: () => CollectionProductOptions(
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

  openWishListPopup(product, productId) {}
  @override
  void onClose() {
    super.onClose();
    GetStorage().remove('collectionfilter');
  }

  changeViewType(type) {
    viewType.value = type;
    if (type == 'small') {
      pagelimit.value = 40;
    } else {
      pagelimit.value = 10;
    }
    refreshPage();
  }

  productWidth(type, index, decrementWidth) {
    if (type == 'default') {
      return ((SizeConfig.screenWidth / 2) - decrementWidth);
    } else if (type == 'large') {
      return ((SizeConfig.screenWidth / 1) - decrementWidth);
    } else if (type == 'medium') {
      bool isChange = (index % 5 == 0);
      if (isChange)
        return ((SizeConfig.screenWidth / 1) - decrementWidth);
      else
        return ((SizeConfig.screenWidth / 2) - decrementWidth);
    } else if (type == 'small') {
      return ((SizeConfig.screenWidth / 4) - decrementWidth);
    } else {
      return ((SizeConfig.screenWidth / 2) - decrementWidth);
    }
  }

  productHeight(type, index) {
    if (type == 'default') {
      return SizeConfig.screenWidth / 1.8;
    } else if (type == 'large') {
      return SizeConfig.screenWidth / 1;
    } else if (type == 'medium') {
      bool isChange = (index % 5 == 0);
      if (isChange)
        return SizeConfig.screenWidth / 1;
      else
        return SizeConfig.screenWidth / 1.8;
    } else if (type == 'small') {
      return SizeConfig.screenWidth / 4;
    } else {
      return SizeConfig.screenWidth / 1.8;
    }
  }

  assignProductImage(imageUrl, type, index) {
    if (type == 'medium') {
      bool isChange = (index % 5 == 0);
      if (isChange) {
        return '${imageUrl}&width=500';
      } else {
        return '${imageUrl}&width=200';
      }
    } else if (type == 'small') {
      return '${imageUrl}&width=100';
    } else if (type == 'large') {
      return '${imageUrl}&width=500';
    } else {
      return '${imageUrl}&width=200';
    }
  }

  List<RelatedProductSizeOptions> getRelatedAvailableOptions(
      RelatedProduct product) {
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

  @override
  void dispose() {
    _scrollDebounce?.cancel();
    pagelimit.close();
    categoryPackWithSet.close();
    productList.close();
    categoryAttribute.close();
    pageInfo.close();
    collectionData.close();
    selectedFilter.close();
    isLoading.close();
    selectedCategoryName.close();
    cartBagCount.close();
    wishlistFlag.close();
    sortSetting.close();
    collectionMenu.close();
    selectedCollectionMenu.close();
    selectedSort.close();
    loading.close();
    selectedProductVariants.close();
    template.close();
    isTemplateLoading.close();
    collectionFilterValues.close();
    viewType.close();
    metafields.close();
    relatedProducts.close();
    isRelatedProduct.close();
    scrollController.dispose();
    GetStorage().remove('collectionfilter');
    super.dispose();
  }
}
