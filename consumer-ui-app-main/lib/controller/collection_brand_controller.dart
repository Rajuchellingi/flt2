// ignore_for_file: unnecessary_null_comparison, unused_local_variable, non_constant_identifier_names, invalid_use_of_protected_member, deprecated_member_use

import 'package:b2b_graphql_package/modules/cart/cart_repo.dart';
import 'package:b2b_graphql_package/modules/collection/collection_repo.dart';
import 'package:b2b_graphql_package/modules/wishlist/wishlist_repo.dart';
import 'package:black_locust/common_component/wishlist_popup.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/controller/collection_filter_v1_controller.dart';
import 'package:black_locust/controller/dynamic_form_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/collection_V2_model.dart';
import 'package:black_locust/model/filter_model.dart';
import 'package:black_locust/model/product_list_model.dart';
import 'package:black_locust/model/wishlist_model.dart';
import 'package:black_locust/view/collection/components/collection_filter_popup.dart';
import 'package:black_locust/view/collection/components/collection_filter_popup_v1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../const/constant.dart';
import '../const/size_config.dart';
import 'base_controller.dart';

class CollectionBrandController extends GetxController with BaseController {
  CollectionRepo? collectionRepo;
  CartRepo? cartRepo;
  WishListRepo? wishListRepo;
  WishListRepo? wishlistRepo;
  var pagelimit = 20;
  var productList = [].obs;
  var newData = [];
  var collectionMenu = [].obs;
  var filterAttributeValue = [].obs;
  var categoryAttribute =
      CollectionAttributeVM(attribute: [], sTypename: "").obs;
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
  var productCollections = [].obs;
  var wishlistFlag = false.obs;
  var sortSetting = [].obs;
  var isRelatedProduct = false.obs;
  var collectionData = new BrandProductCollection(
          error: null,
          message: null,
          collection: new BrandProductCollectionList(
            banners: [],
            product: [],
            collectionCatalog: null,
            collectionId: null,
            collectionName: null,
            count: null,
            downloadCatalogButtonName: null,
            paginationType: null,
            seo: [],
            showDownloadCatalog: null,
            showVariantInList: null,
            sortSetting: [],
            totalPages: null,
          ),
          brand: null,
          sTypename: null)
      .obs;
  var brandProductCollectionList = new BrandProductCollectionList(
    banners: [],
    product: [],
    collectionCatalog: null,
    collectionId: null,
    collectionName: null,
    count: null,
    downloadCatalogButtonName: null,
    paginationType: null,
    seo: [],
    showDownloadCatalog: null,
    showVariantInList: null,
    sortSetting: [],
    totalPages: null,
  ).obs;
  var collectionFilterValues = new GetProductFiltersVM(
    filters: [],
  ).obs;
  var viewType = 'default'.obs;
  var selectedSort = SortSetting(
          sId: 1, sortKey: "RELEVANCE", name: "Relevance", reverse: false)
      .obs;
  var sortList = [
    {"item": "Featured", "value": "default"},
    {"item": "Price Low to High", "value": "lowtohigh"},
    {"item": "Price High to Low", "value": "hightolow"},
    {"item": "New", "value": "new"}
  ];
  var selectedProducts = [].obs;
  var loading = false.obs;
  bool allLoaded = false;
  var selectedCatalog = ''.obs;
  final ScrollController scrollController = new ScrollController();
  var selectedFilters = [].obs;
  var wishlistValue = [].obs;
  final _controller = Get.find<CollectionFilterV1Controller>();
  final dynamicFormController = Get.find<DynamicFormController>();

  //wishList Page

  RxList<String> collections = [
    'Collection 1',
    'Collection 2',
    'Collection 3',
  ].obs;
  var selectedWishList = [];
  var colloctionListPopup = [].obs;
  var attributeFieldValues = [].obs;
  var selectedFilterAttr = [].obs;
  var filterAttribute = [].obs;
  var productListPopup = [].obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  // RxList<dynamic> sortSetting = <dynamic>[].obs;
  var selectedSortValue = Rx<BrandSortSetting?>(null);
  var selectedCollectionMenu = ''.obs;
  var selectedCollectionId = ''.obs;
  var selectedCollectionName = ''.obs;

  @override
  void onInit() {
    cartRepo = CartRepo();
    collectionRepo = CollectionRepo();
    wishlistRepo = WishListRepo();
    wishListRepo = WishListRepo();
    userId = GetStorage().read('utoken');
    argument = Get.arguments;
    if (argument != null) {
      selectedCategoryLink = argument["id"];
      getTemplate();
      initialLoad();
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
                scrollController.position.maxScrollExtent &&
            !loading.value) {
          paginationFetch();
        }
      });
    }
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates
        .firstWhereOrNull((value) => value['id'] == 'brand-product-list');
    // print(
    //     "template.value:---------------->>> brand collection ${template.value}");

    isTemplateLoading.value = false;
  }

  paginationFetch() async {
    if (allLoaded) {
      return;
    }
    loading.value = true;
    await Future.wait([
      getProductList(selectedCategoryLink, pageIndex, selectedFilter.value),
      openFilterV2(),
    ]);

    if (newData.isNotEmpty) {
      productList.addAll(newData);
      // productList.refresh();
      pageIndex += 1;
    }
    loading.value = false;
    allLoaded = newData.isEmpty;
  }

  Future initialLoad() async {
    this.isLoading.value = true;
    await Future.wait([
      getProductList(selectedCategoryLink, pageIndex, selectedFilter.value),
      openFilterV2(),
    ]);
    if (newData.isNotEmpty) {
      initializeSortSetting();
      productList.addAll(newData);
      productList.refresh();
      pageIndex += 1;
    }
    this.isLoading.value = false;
  }

  Future<Null> refreshPage() async {
    isLoading.value = true;
    allLoaded = false;
    // allLoaded = false;
    productList.value = [];
    pageIndex = 1;
    await Future.wait([
      getProductList(selectedCategoryLink, pageIndex, selectedFilter.value),
      openFilterV2(),
    ]);
    if (newData.isNotEmpty) {
      productList.addAll(newData);
      productList.refresh();
      pageIndex += 1;
    }
    isLoading.value = false;
  }

  Future<void> getProductList(
      String categoryLink, int page, List filter) async {
    // print("selectedCategoryLink --------------->>>>> ${selectedCategoryLink}");
    // print("categoryLink --------------->>>>> ${categoryLink}");

    String? oneFilterValue;

    for (var f in filter) {
      if (f is Map<String, dynamic>) {
        if (f['fieldValue'] != null) {
          oneFilterValue = f['fieldValue'].toString();
          break; // stop after first
        }
      } else {
        try {
          if (f.fieldValue != null) {
            oneFilterValue = f.fieldValue.toString();
            break; // stop after first
          }
        } catch (_) {}
      }
    }
    bool useV1 = false;

    if (template.value != null &&
        template.value['layout'] != null &&
        template.value['layout']['blocks'] != null) {
      final blocks = template.value['layout']['blocks'] as List;
      useV1 = blocks.any((block) =>
          block['componentId'] == 'product-filter-component' &&
          block['instanceId'] == 'design5');
    }
    var input = {
      "brandId": categoryLink,
      "collectionId": selectedCollectionId.value,
      "pageNo": page,
      "filter": useV1 == true ? filter : null,
      "oneFilter": oneFilterValue
    };
    var result = await collectionRepo!.getProductsByBrandForUIV1(input);
    // print("result=================------------------->>>> ${result.toJson()}");
    if (result != null) {
      var productListDetails = getProductsByBrandForUIV1VMFromJson(result);
      // print("productListDetails Data: ${productListDetails.toJson()}");
      // if (productListDetails.collection != null) {
      collectionData.value = productListDetails;
      // }
      // print("Collection Data: ${collectionData.value.toJson()}");
      collectionMenu.value = [collectionData.value.brand];
      // print("collectionMenu.value: ${collectionMenu.value.to}");
      selectedCollectionMenu.value = collectionData
          .value.brand!.collections!.first.collectionId
          .toString();
      selectedCategoryName.value =
          productListDetails.collection!.collectionName.toString();
      newData = productListDetails.collection!.product!;
      // filterAttributeValue.value = productListDetails.collection!.filters!;
      // collectionFilterValues.value = productListDetails.collection;
      sortSetting.value = productListDetails.collection!.sortSetting!;
      // if (selectedFilters.value != null && selectedFilters.value.length > 0) {
      //   filterAttributeValue.value = productListDetails.filters!;
      // }
      // downloadCatalog();
    }
  }

  void getCollectionMenuProducts(collection) {
    print("collection: ${collection.toJson()}");
    // selectedMenuCollection.value = collection;
    selectedCollectionId.value = collection.collectionId!;
    refreshPage();
    openFilterV2();
  }

  Future navigateToProductDetails(product) async {
    // print("Product-->>> ${product[0].toJson()}");
    var result = await Get.toNamed('/productDetail',
        preventDuplicates: false, arguments: product);
  }

  Future openCart() async {
    await Get.toNamed("/cart");
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

  getProductByFilter(selectedAttributes) {
    selectedFilter.value = selectedAttributes;

    formateFilter(selectedFilter.value);
    refreshPage();
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
                  fontWeight: FontWeight.w500),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: sortSetting.length,
                itemBuilder: (context, index) {
                  return Column(children: [
                    if (index == 0)
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        onTap: () {
                          filterSortItem('default');
                        },
                        dense: true,
                        title: Text(
                          'Relevance',
                          style: TextStyle(
                              fontSize: getProportionateScreenHeight(15)),
                        ),
                      ),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      onTap: () {
                        filterSortItem(sortSetting[index].name);
                      },
                      dense: true,
                      title: Text(
                        sortSetting[index].name,
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(15)),
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
    var sort = [];
    var index = selectedFilter.value
        .indexWhere((element) => element.fieldName == 'sortBy');
    if (index != -1) selectedFilter.value.removeAt(index);
    var sortItem =
        new SelectedFilter(fieldName: 'sortBy', fieldValue: item.name);
    selectedFilter.value.add(sortItem);
    selectedSortValue.value = item;
    Get.back();
    refreshPage();
  }

  getWishListonClick(product) {
    return product.wishlistCollection.isNotEmpty;
  }

  @override
  void onClose() {
    super.onClose();
    GetStorage().remove('filter');
  }

  getFilterInput() {
    var input = [];
    selectedFilters.value.forEach((element) {
      if (element['subFilter'].length > 0) {
        var fieldValue = element['subFilter'].join(',');
        var data = {"fieldName": element['filter'], "fieldValue": fieldValue};
        input.add(data);
      }
    });
    return input;
  }

  Future createWishListName(collectionName) async {
    var selectedCollectionID = collectionName;
    // print('Creating new wishlist collection: $selectedCollectionID');
    var userIds = "111111";
    showLoading('Loading...');
    if (collectionName != null && collectionName.isNotEmpty) {
      var result = await wishlistRepo!.createWishListName(collectionName);
      if (result == true) {
        createWishListCollection('', '', '');
        // wc_controller.allWishlistPageCollectionList();
        //  allCollectionListPopup(selectedCollectionID);
      }
    }
    hideLoading();
  }

  Future<void> createWishListCollection(collectionId, page, collection) async {
    var userIds = "";
    var search = "";
    var pagelimit = 10;
    var result =
        await wishlistRepo!.wishlistPageCollectionList(search, pagelimit);
    var productColectionListDetails = wishListCollectionListVMFromJson(result);
    colloctionListPopup.value = productColectionListDetails.product;
    if (collectionId.isEmpty) {
      var firstDefaultCollection = colloctionListPopup.value
          .where((collection) => collection.isDefault)
          .toList();
      if (firstDefaultCollection.isNotEmpty) {
        var collectionIds =
            firstDefaultCollection.map((collection) => collection.sId).toList();
        selectedColor(collectionIds);
      }
    } else if (collectionId.isNotEmpty) {
      var firstDefaultCollection = collectionId;
      if (firstDefaultCollection.isNotEmpty) {
        selectedColor(firstDefaultCollection);
      }
    }
  }

  void selectedColor(fieldValue) {
    selectedFilterAttr.clear();
    var field;
    if (fieldValue.isNotEmpty) {
      for (var value in fieldValue) {
        field = {"id": value};
        selectedFilterAttr.add(field);
      }
    } else {}
  }

  void selectedCollectionList(String fieldName, String fieldValue, value) {
    var existingFilter = selectedFilterAttr.firstWhere(
      (element) => element['id'] == fieldValue,
      orElse: () => null,
    );

    if (existingFilter != null) {
      selectedFilterAttr.remove(existingFilter);
    } else {
      var filter = {"id": fieldValue, "name": fieldName, "value": value};
      selectedFilterAttr.add(filter);
    }
    selectedFilterAttr.refresh();
  }

  snackMessage(String message) {
    Get.snackbar(
      "", message,
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
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }

  Future<void> allCollectionListPopup(selectedCollectionID) async {
    var collectionIds = selectedFilterAttr.map((e) => e['id']).toList();
    var result = await wishlistRepo!
        .createListoverall(collectionIds, selectedCollectionID);
    if (result['error'] == false) {
      snackMessage(result['message']);
      getProductList(selectedCategoryLink, pageIndex, selectedFilter.value);
      openFilterV2();
      refreshPage();
    } else if (result['error'] == true) {
      snackMessage(result['message']);
    }
    hideLoading();
  }

  changeSelectedProducts(productId) {
    if (selectedProducts.contains(productId)) {
      selectedProducts.remove(productId);
    } else {
      selectedProducts.add(productId);
    }
  }

  openCreateMultiBooking() {
    userId = GetStorage().read('utoken');
    if (userId != null) {
      Get.toNamed('/multiBooking', arguments: {
        'productIds': selectedProducts.value,
        'pageId': 'multi-booking'
      });
    } else {
      Get.toNamed('/login', arguments: {
        "path": "/multiBooking",
        "arguments": {
          'productIds': selectedProducts.value,
          'pageId': 'multi-booking'
        },
      });
    }
  }

  addProductToWishList(productId) {}
  getAvailableOptions(product) {}

  Future<void> openFilterV2() async {
    var input = {
      "brandId": selectedCategoryLink,
      "collectionUrl": selectedCollectionId.value,
    };
    var result = await collectionRepo!.getProductFilters(input);
    // print("result openFilterV2-------------------->>>> ${result.toJson()}");
    // if (result != null) {
    var productListDetails = getProductFiltersVMFromJson(result);
    // print(
    //     "productListDetails=========================---------->>>> ${productListDetails.toJson()}");
    // collectionData.value = productListDetails;
    //   print("Collection Data: ${collectionData.value.toJson()}");
    //   selectedCategoryName.value =
    //       productListDetails.collection!.name.toString();
    //   newData = productListDetails.product;
    filterAttributeValue.value = productListDetails.filters!;
    collectionFilterValues.value = productListDetails;
    //   sortSetting.value = productListDetails.sortSetting;
    // if (selectedFilters.value != null && selectedFilters.value.length > 0) {
    //   filterAttributeValue.value = productListDetails.filters!;
    // }
    // initializeSortSetting();
    // }
  }

  Future<void> openTopFilter(BuildContext context, controller) async {
    var collectionFilter = collectionFilterValues.value.toJson();
    // print(
    //     "productListDetails.filters: ${filterAttributeValue.value?.map((e) => e.toJson()).toList()}");
    await _controller.getCategoryAttributeWithSet(
      collectionFilter,
      filterAttributeValue.value,
      [],
    );
    bool useV1 = false;

    if (template.value != null &&
        template.value['layout'] != null &&
        template.value['layout']['blocks'] != null) {
      final blocks = template.value['layout']['blocks'] as List;
      useV1 = blocks.any((block) =>
          block['componentId'] == 'product-filter-component' &&
          block['instanceId'] == 'design5');
    }

    selectedFilter = await showModalBottomSheet(
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
                child: useV1
                    ? CollectionFilterPopupV1(controller: controller)
                    : CollectionFilterPopup(controller: controller),
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

  void showSortBottomSheet(BuildContext context) {
    final sortList = sortSetting.value;
    final selectedSort = selectedSortValue.value;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 12),
          children: sortList.map<Widget>((element) {
            final isSelected = selectedSort?.sId == element.sId;
            final isDefault = element.isDefault == true;

            return InkWell(
              onTap: () {
                filterSortItem(element);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? kPrimaryColor.withOpacity(0.1)
                      : Colors.white,
                ),
                child: Row(
                  children: [
                    Icon(
                      iconByType(element.type),
                      color: isSelected ? kPrimaryColor : Colors.black,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        element.name,
                        style: TextStyle(
                          color: isSelected ? kPrimaryColor : Colors.black,
                          fontWeight: isSelected || isDefault
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check, color: kPrimaryColor, size: 18),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  IconData iconByType(dynamic type) {
    switch (type) {
      case 1:
        return Icons.trending_up;
      case 2:
        return Icons.access_time;
      case 3:
        return CupertinoIcons.sort_down;
      case 4:
        return CupertinoIcons.sort_up;
      case 5:
        return CupertinoIcons.sort_down_circle;
      case 6:
        return CupertinoIcons.sort_up_circle;
      default:
        return CupertinoIcons.sort_down;
    }
  }

  changeViewType(type) {
    viewType.value = type;
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

  // Future downloadCatalog(fileName, fileUrl) async {
  //   // print("heloooooooo");
  //   print("fileName ${fileName} fileUrl ${fileUrl}");
  //   var userId = GetStorage().read('utoken');

  //   if (userId != null) {
  //     for (var downloadCatalog in collectionData.value.collectionCatalog) {
  //       if (downloadCatalog != null && fileUrl != null) {
  //         await CommonService().downloadFile(fileName, fileUrl);
  //       }
  //     }
  //   } else {
  //     if (collectionData.value.downloadCatalogForm != null) {
  //       dynamicFormController
  //           .initialLoad(collectionData.value.downloadCatalogForm);
  //       Get.bottomSheet(
  //         Container(child: DynamicFormBottomSheet()),
  //         enterBottomSheetDuration: Duration(milliseconds: 200),
  //         isScrollControlled: true,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(20),
  //             topRight: Radius.circular(20),
  //           ),
  //         ),
  //       ).then((value) async {
  //         if (value == true) {
  //           if (collectionData.value.catalogUrl != null) {
  //             var fileName = collectionData.value.catalogUrl!.split('/').last;
  //             await CommonService()
  //                 .downloadFile(fileName, collectionData.value.catalogUrl);
  //           }
  //         }
  //       });
  //     } else if (collectionData.value.catalogUrl != null) {
  //       var fileName = collectionData.value.catalogUrl!.split('/').last;
  //       await CommonService()
  //           .downloadFile(fileName, collectionData.value.catalogUrl);
  //     }
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    productList.close();
    collectionMenu.close();
    filterAttributeValue.close();
    categoryAttribute.close();
    selectedFilter.close();
    isLoading.close();
    selectedCategoryName.close();
    cartBagCount.close();
    wishlistFlag.close();
    sortSetting.close();
    isRelatedProduct.close();
    collectionData.close();
    collectionFilterValues.close();
    viewType.close();
    selectedSort.close();
    loading.close();
    selectedCatalog.close();
    selectedFilters.close();
    wishlistValue.close();
    collections.close();
    colloctionListPopup.close();
    attributeFieldValues.close();
    selectedFilterAttr.close();
    filterAttribute.close();
    productListPopup.close();
    template.close();
    isTemplateLoading.close();
    scrollController.dispose();
  }

  changeImageUrl(image, type) {
    var newUrl = image ?? '';
    if (image != null && image.isNotEmpty) {
      if (platform == 'shopify') {
        if (image.contains('ri-shopify-mobile-app-file') &&
            image.contains('homepageSetting') &&
            !image.contains('/webp/')) {
          newUrl = image.replaceAll(
              'ri-shopify-mobile-app-file.s3.ap-south-1.amazonaws.com/homepageSetting',
              'd1p1ymt3bt37nv.cloudfront.net/homepageSetting/webp');
        } else if (image.contains('cdn.shopify.com') &&
            !image.contains('width=')) {
          var width = SizeConfig.screenWidth;
          var responsiveTypes = [
            'fixed-banner-component',
            'sliding-banner-component',
            'media-tab-scroller-component'
          ];
          if (responsiveTypes.contains(type)) {
            if (width < 600) {
              newUrl = '$image?width=350';
            } else {
              newUrl = '$image?width=600';
            }
          } else {
            newUrl = '$image?width=350';
          }
        }
      }
    }
    return newUrl;
  }

  void assignSelectedSort(sortItem) {
    selectedSortValue.value = sortItem;
  }

  void initializeSortSetting() {
    final defaultSort =
        sortSetting.value.firstWhereOrNull((e) => e.isDefault == true);
    if (defaultSort != null) {
      selectedSortValue.value = defaultSort;
    }
  }
}
