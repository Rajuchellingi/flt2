// ignore_for_file: unused_local_variable, unnecessary_null_comparison, invalid_use_of_protected_member, deprecated_member_use, unused_element

import 'package:b2b_graphql_package/modules/cart/cart_repo.dart';
import 'package:b2b_graphql_package/modules/collection/collection_repo.dart';
import 'package:b2b_graphql_package/modules/dynamic_form/dynamic_form_repo.dart';
import 'package:b2b_graphql_package/modules/user/user_repo.dart';
import 'package:black_locust/common_component/wishlist_popup.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/common_controller.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/common_wishlist_controller.dart';
import 'package:black_locust/controller/plugins_controller.dart';

import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/dynamic_form_model.dart';
import 'package:black_locust/model/user_model.dart';
import 'package:black_locust/services/common_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';
import '../common_component/search_delegate.dart';
import '../helper/common_helper.dart';
import '../model/landing_page_model.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_controller.dart';
import 'cart_count_controller.dart';
import 'notification_controller.dart';

class HomeController extends GetxController
    with BaseController, SingleGetTickerProviderMixin {
  var settingList = [].obs;
  var mainMenuList = [].obs;
  var categoryList = [].obs;
  var isAllLoaded = false.obs;
  var bannerRepo, propmotionRepo, mainMenuRepo;
  var pageIndex = 0.obs;
  var previousPage = 0.obs;
  var cartBagCount = 0.obs;
  var allWishlist = [];
  var wishlistFlag = false.obs;
  UserRepo? userRepo;
  var currentTabIndex = 0.obs;
  DynamicFormRepo? dynamicFormRepo;
  late TabController tabController;
  final _countController = Get.find<CartCountController>();
  final _notificationController = Get.find<NotificationController>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late ScrollController scrollController = new ScrollController();
  late CarouselSliderController carouselController;
  final commonReviewController = Get.find<CommonReviewController>();
  var index = 0.obs;
  var previousIndex = 0.obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  String? userId;
  var isLoggedIn = false.obs;
  var isLoading = true.obs;
  var isLoadData = false.obs;
  // PageController? pageController;
  CartRepo? cartRepo;
  var homePageLoaded = false.obs;
  var loading = false.obs;
  var collectionProducts = [].obs;
  var formComponents = [].obs;
  final themeController = Get.find<ThemeController>();
  CollectionRepo? collectionRepo;
  final commonController = Get.find<CommonController>();
  final pluginController = Get.find<PluginsController>();
  final commonWishlistController = Get.find<CommonWishlistController>();
  var isReward = false.obs;
  //media tab scroller
  var isScroll = false.obs;
  var isScrollFirst = false.obs;
  var isNavbar = true.obs;
  var isReachTop = true.obs;
  var homeBlocks = [].obs;
  var enabledHomeBlocks = [].obs;
  var limit = 5;
  var pageNo = 1.obs;
  var nectarReviews = [];
  Timer? _paginationDebounceTimer;
  var userProfile = new UserDetailsVM(
    sId: "",
    altIsdCode: 0,
    altMobileNumber: "",
    companyName: "",
    contactName: "",
    userTypeName: "",
    numberOfAddresses: 0,
    numberOfOrders: 0,
    emailId: "",
    firstName: "",
    gstNumber: "",
    metafields: null,
    isdCode: 0,
    lastName: "",
    mobileNumber: "",
  ).obs;

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    collectionRepo = CollectionRepo();
    dynamicFormRepo = DynamicFormRepo();
    // scrollController = new ScrollController();
    userRepo = new UserRepo();
    carouselController = new CarouselSliderController();
    // tabController = TabController(length: 3, vsync: this);
    loggedInId();
    getTemplate();
    assignTabCount();
    getUserDetails();
    onLoadCheckAuthAvailable();
    requestNotificationPermissions();
    getWishlist();
    if (tabController != null) {
      tabController.addListener(() {
        currentTabIndex.value = tabController.index;
        isScroll.value = true;
        commonController.imageSliderPageChanges(0);
      });
    }
    super.onInit();
  }

  Future getWishlist() async {
    if (platform == 'shopify') {
      await commonWishlistController.getAllWishilst();
      Future.delayed(Duration(seconds: 3), () {
        checkIsReward();
      });
    }
  }

  Future loadInitialImages() async {
    var images = [];
    var imageBlocks = [
      'sliding-banner-component',
      'carousel-banner-component',
      'fixed-banner-component',
      'card-banner-component'
    ];
    var header = template.value['layout']['header'];
    if (header != null &&
        header['layout'] != null &&
        header['layout']['children'] != null &&
        header['layout']['children'].length > 0) {
      for (var block in header['layout']['children']) {
        if (block['kind'] == 'image') {
          var logo = header['options'][block['key']];
          if (logo['image'] != null && logo['image'] != '') {
            images.add(logo['image']);
          }
        }
      }
    }
    for (var design in homeBlocks) {
      if (imageBlocks.contains(design['componentId'])) {
        design['source']['lists'].forEach((element) {
          if (element['visibility']['hide'] == false) {
            if (element['image'] != null)
              images
                  .add(changeImageUrl(element['image'], design['componentId']));
          }
        });
      } else if (design['componentId'] == 'media-tab-scroller-component') {
        if (design['source']['lists'] != null &&
            design['source']['lists'].length > 0) {
          design['source']['lists'].forEach((element) {
            if (element['visibility']['hide'] == false) {
              if (element['image'] != null)
                images.add(
                    changeImageUrl(element['image'], design['componentId']));
            }
          });
        }
      } else if (design['componentId'] == 'custom-banner-component') {
        if (design['source']['rowContent'] != null &&
            design['source']['rowContent'].length > 0) {
          design['source']['rowContent'].forEach((element) {
            if (element['visibility']['hide'] == false) {
              if (element['image'] != null)
                images.add(
                    changeImageUrl(element['image'], design['componentId']));
            }
          });
        }
      }
    }
    if (images.isNotEmpty) {
      await _preloadImages(images);
    }
  }

  Future getUserDetails() async {
    var id = GetStorage().read('utoken');
    if (id == null) return;
    var result = await userRepo!.getUserById(id, []);
    if (result != null) {
      userProfile.value = userDetailsVMFromJson(result);
    }
  }

  Future<void> _preloadImages(images) async {
    for (String url in images) {
      await precacheImage(
          CachedNetworkImageProvider(url, cacheKey: url), Get.context!);
    }
  }

  checkIsReward() {
    var nectar = pluginController.getPluginValue('nectar');
    if (nectar != null) isReward.value = true;
  }

  void _scrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !loading.value) {
        // Debounce pagination calls to prevent rapid triggering
        _paginationDebounceTimer?.cancel();
        _paginationDebounceTimer = Timer(Duration(milliseconds: 300), () {
          getBlockByPagination();
        });
      }
    });
    // scrollController.addListener(() {
    //   if (scrollController.offset <= 0 &&
    //       !scrollController.position.outOfRange) {
    //     isReachTop.value = true;
    //     if (commonController.imageSliderCurrentPageIndex.value == 0)
    //       isScroll.value = true;
    //   } else {
    //     isReachTop.value = false;
    //   }
    //   if (scrollController.position.userScrollDirection ==
    //       ScrollDirection.reverse) {
    //   } else if (scrollController.position.userScrollDirection ==
    //       ScrollDirection.forward) {}
    // });
  }

  changeScroll(bool value) {
    isScroll.value = value;
  }

  changeScrollByFirstBanner(value) {
    isScrollFirst.value = value;
  }

  updateByReachTop(value) {
    if (value == true) {
      isReachTop.value = true;
      // if (commonController.imageSliderCurrentPageIndex.value == 0)
      //   isScroll.value = true;
    } else {
      isReachTop.value = false;
    }
  }

  changeByBottomToTopDrag() {
    if (isScrollFirst.value == false) {
      double scrollOffset = SizeConfig.screenHeight - 100.0;
      final double currentOffset = scrollController.offset;
      final double targetOffset = currentOffset - scrollOffset;
      scrollController.animateTo(targetOffset,
          duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
      changeScroll(false);
    } else {
      carouselController.animateToPage(
          commonController.imageSliderCurrentPageIndex.value - 1);
      changeScroll(true);
    }
  }

  changeByTopToBottomDrag() {
    if (isScrollFirst.value == false) {
      carouselController.animateToPage(
          commonController.imageSliderCurrentPageIndex.value + 1);
    } else {
      double scrollOffset = SizeConfig.screenHeight - 50.0;
      final double currentOffset = scrollController.offset;
      final double targetOffset = currentOffset + scrollOffset;
      scrollController.animateTo(targetOffset,
          duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    themeController.isInitialDataLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'home');
    assignBlockByPagination();
    await Future.wait(
        [getCollectionProducts(), getDynamicForms(), loadInitialImages()]);
    themeController.pageIndex.value = 0;
    isTemplateLoading.value = false;
    themeController.isInitialDataLoading.value = false;
    if (themeController.isTimeReached.value == true) {
      themeController.isWelcomeImageLoading.value = false;
    }
    themeController.pageIndex.value = 0;
    themeController.showOfferPopup();
    _scrollListener();
  }

  assignTabCount() {
    var blocks = template.value['layout']['blocks'];
    if (blocks != null && blocks.length > 0) {
      var content = blocks.firstWhere(
          (element) => element['componentId'] == 'media-tab-scroller-component',
          orElse: () => null);
      if (content != null) {
        var lists = content['source']['lists'];
        if (lists != null && lists.length > 0) {
          var tabs =
              lists.where((element) => element['visibility']['hide'] == false);
          // Dispose old controller before creating new one to prevent memory leak
          tabController.dispose();
          tabController = TabController(length: tabs.length, vsync: this);
        } else {
          tabController.dispose();
          tabController = TabController(length: 3, vsync: this);
        }
      } else {
        tabController.dispose();
        tabController = TabController(length: 3, vsync: this);
      }
    }
  }

  assignBlockByPagination() {
    var blocks = template.value['layout']['blocks'];
    if (blocks != null && blocks.length > 0) {
      enabledHomeBlocks.value = blocks
          .where((element) => element['visibility']['hide'] == false)
          .toList();
      if (enabledHomeBlocks.value.isNotEmpty) {
        var currentLimit = pageNo.value * limit < enabledHomeBlocks.value.length
            ? pageNo.value * limit
            : enabledHomeBlocks.value.length;
        homeBlocks.value = enabledHomeBlocks.value.sublist(0, currentLimit);
      }
    }
  }

  getBlockByPagination() {
    if (homeBlocks.value.length == enabledHomeBlocks.value.length) return;
    isLoadData.value = true;
    pageNo.value++;
    if (enabledHomeBlocks.value.isNotEmpty) {
      var currentLimit = pageNo.value * limit < enabledHomeBlocks.value.length
          ? pageNo.value * limit
          : enabledHomeBlocks.value.length;
      var newData = enabledHomeBlocks.value
          .sublist(pageNo.value * limit - limit, currentLimit);
      if (newData.isNotEmpty) {
        homeBlocks.value.addAll(newData);
        homeBlocks.refresh();
      }
    }
    isLoadData.value = false;
  }

  changeNavbarVisibility(value) {
    isNavbar.value = value;
  }

  Future loggedInId() async {
    var userId = GetStorage().read("utoken");
    if (userId != null) {
      isLoggedIn.value = true;
    }
  }

  // Future getDynamicForms() async {
  //   var blocks = template.value['layout']['blocks'];
  //   if (blocks != null && blocks.length > 0) {
  //     var formComponent = ['form-component'];
  //     var collections = blocks
  //         .where((value) =>
  //             formComponent.contains(value['componentId']) &&
  //             value['visibility']['hide'] == false)
  //         .toList();
  //     if (collections != null && collections.length > 0) {
  //       await Future.forEach(collections, (dynamic element) async {
  //         if (element['source'] != null &&
  //             element['source']['formId'] != null) {
  //           var result = await dynamicFormRepo!
  //               .getFormByLink(element['source']['formId']);
  //           if (result != null) {
  //             var response = dynamicFormVMFromJson(result);
  //             var data = {"id": element['id'], "form": response};
  //             formComponents.add(data);
  //           }
  //         }
  //       });
  //     }
  //   }
  // }

  Future getDynamicForms() async {
    var blocks = template.value['layout']['blocks'];
    if (blocks != null && blocks.isNotEmpty) {
      var formComponent = ['form-component'];
      var collections = blocks
          .where((value) =>
              formComponent.contains(value['componentId']) &&
              value['visibility']['hide'] == false)
          .toList();

      if (collections.isNotEmpty) {
        await Future.forEach(collections, (dynamic element) async {
          if (element['source'] != null &&
              element['source']['formId'] != null) {
            var result = await dynamicFormRepo!
                .getFormByLink(element['source']['formId']);

            if (result != null) {
              var response = DynamicFormVM.fromJson(
                result is Map<String, dynamic> ? result : result.toJson(),
              );

              formComponents.add({
                "id": element['id'],
                "form": response,
              });
            }
          }
        });
      }
    }
  }

  // Handle dynamic form submission
  Future<void> submitDynamicForm(
    DynamicFormVM formVM,
    Map<String, TextEditingController> controllers,
    Map<String, String?> dropdownValues,
  ) async {
    final List details = formVM.formField?.map((field) {
          final String name = field.name ?? '';
          final String label = field.label ?? '';
          String? value;

          if (field.type == 'select') {
            value = dropdownValues[name];
          } else {
            value = controllers[name]?.text;
          }

          return {
            'labelName': label,
            'name': name,
            'value': value ?? '',
          };
        }).toList() ??
        [];

    final Map<String, dynamic> payload = {
      'input': {
        'formId': formVM.form?.sId ?? '',
        'details': details,
      }
    };

    print('Submitting dynamic form payload:');
    print(payload);

    var result = await dynamicFormRepo!.createCustomFormDetail(payload);
    print("Result of dynamic form: $result");

    if (result != null && result['error'] == false) {
      // Clear all text controllers
      controllers.forEach((key, controller) {
        controller.clear();
      });

      // Reset all dropdown values to default (first option)
      formVM.formField?.forEach((field) {
        if (field.type == 'select') {
          final List options = field.settings?.options ?? [];
          dropdownValues[field.name ?? ''] =
              options.isNotEmpty ? options.first.value : null;
        }
      });

      Get.back();
      Get.snackbar("Success", result['message']);
    } else {
      // Show error message if submission failed
      Get.snackbar("Error", result?['message'] ?? 'Something went wrong');
    }
  }

  Future getCollectionProducts() async {
    isLoading.value = true;
    var blocks = template.value['layout']['blocks'];
    if (blocks != null && blocks.length > 0) {
      var promotionComponent = [
        'fixed-promotion-component',
        'grid-carousel-promotion-component',
        'carousel-promotion-component'
      ];
      var collections = blocks
          .where((value) =>
              promotionComponent.contains(value['componentId']) &&
              value['visibility']['hide'] == false)
          .toList();
      if (collections != null && collections.length > 0) {
        await Future.forEach(collections, (dynamic element) async {
          if (element['source'] != null &&
              element['source']['collection'] != null) {
            var splittedLink = element['source']['collection'].split('/');
            var collectionId = splittedLink[splittedLink.length - 1];
            var productIdentifiers = themeController.productBadge != null
                ? [themeController.productBadge]
                : [];
            var result = await collectionRepo!.getPromotionProductsByCollection(
                collectionId, element['source']['count'], productIdentifiers);
            if (result != null) {
              var products = productPromotionFromJson(result);
              await assignNectorReviews(products);
              var data = {
                "count": element['source']['count'],
                "collection": element['source']['collection'],
                "products": products
              };
              collectionProducts.add(data);
            }
          }
        });
      }
    }
    isLoading.value = false;
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

  checkDataLoaded() {
    if (isLoading.value == false && isAllLoaded.value == false) {
      onInit();
    }
  }

  Future addProductToWishList(String productId) async {
    commonWishlistController.checkProductAndAdd(productId);
    wishlistFlag.value = !wishlistFlag.value;
  }

  Future removeProductFromWishList(String productId) async {}

  Future openWishlistPopup(productId, product) async {
    userId = GetStorage().read('utoken');
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
    if (collectionProducts.value != null &&
        collectionProducts.value.isNotEmpty) {
      var element;
      var product;
      for (var i = 0; i < collectionProducts.value.length; i++) {
        element = collectionProducts.value[i];
        if (element['products'] != null && element['products'].isNotEmpty) {
          for (var j = 0; j < element['products'].length; j++) {
            product = element['products'][j];
            if (product.sId == productId) {
              collectionProducts.value[i]['products'][j].wishlistCollection =
                  wishlistCollections;
              collectionProducts.value[i]['products'][j].isWishlist =
                  (wishlistCollections != null &&
                      wishlistCollections.isNotEmpty);
            }
          }
        }
      }
      wishlistFlag.value = !wishlistFlag.value;
    }
  }

  getWishListonClick(product) {
    if (platform == 'shopify') {
      return commonWishlistController.checkProductIsInWishlist(product.sId);
    } else {
      return product.wishlistCollection.isNotEmpty;
    }
  }

  navigateByUrlType(link) async {
    if (link != null && link['value'] != null) {
      if (link['kind'] == 'collection') {
        var splittedLink = link['value'].split('/');
        var collectionId = splittedLink[splittedLink.length - 1];
        // var collectionId = 'gid://shopify/Collection/$id';
        var result =
            await Get.toNamed('/collection', arguments: {'id': collectionId});
        // categoryList.refresh();
      } else if (link['kind'] == 'landingPage') {
        var splittedLink = link['value'].split('/');
        var landingPageId = splittedLink[splittedLink.length - 1];
        var result =
            await Get.toNamed('/landingPage', arguments: {'id': landingPageId});
        // categoryList.refresh();
      } else if (link['kind'] == 'brand') {
        var splittedLink = link['value'].split('/');
        var collectionId = splittedLink[splittedLink.length - 1];
        var result = await Get.toNamed('/brandCollection',
            arguments: {'id': collectionId});
      } else {
        print('URL does not contain the word "collections"');
      }
    }
  }

  downloadCatelog(Map<String, dynamic> link) async {
    String linkValue = "";
    if (link["value"] != null && link["value"].toString().isNotEmpty) {
      List<String> parts = link["value"].toString().split("/");
      linkValue = parts.isNotEmpty ? parts.last : "";
    }

    final formatted = {
      "input": {
        "metaId": link["metaId"] ?? "",
        "kind": link["kind"] ?? "",
        "link": linkValue,
      }
    };
    var result = await collectionRepo!.getMetaValueForDownload(formatted);
    if (result != null) {
      var products = getMetaValueForDownloadVMFromJson(result);
      print(
          "result downloadCatelog ------>>>>>>>>>>>>>>>.... ${products.toJson()}");
      for (var downloadCatalog in products.data) {
        final fileUrl = downloadCatalog.fileUrl;
        final fileName = downloadCatalog.fileName;

        if (fileUrl != null && fileUrl.isNotEmpty) {
          // Extract the last part of the URL (filename)
          await CommonService().downloadFile(fileName, fileUrl);
        }
      }
      // return formatted;
    }
  }

  @override
  void onClose() {
    super.onClose();
    GetStorage().remove('filter');
  }

  Future navigateToProductDetails(product) async {
    var result = await Get.toNamed('/productDetail',
        preventDuplicates: false, arguments: product);
  }

  Future navigateToPromotionPage(promotion) async {
    var result = await Get.toNamed('/productPromotion',
        preventDuplicates: false, arguments: promotion);
  }

  onPageChanged(page) {
    this.pageIndex.value = page;
  }

  navigateByType(type, index) async {
    this.previousPage.value = this.pageIndex.value;
    this.pageIndex.value = index;
    var userId = GetStorage().read('utoken');
    switch (type) {
      case 'home':
        await Get.toNamed('/home');
        this.pageIndex.value = this.previousPage.value;
        break;
      case 'account':
        await Get.toNamed('/myAccount');
        this.pageIndex.value = this.previousPage.value;
        break;
      case 'search':
        showSearch(
                context: Get.context!,
                delegate: SearchDelegateWidget('collectionPage'))
            .then((value) => {this.pageIndex.value = this.previousPage.value});
        break;
      case 'cart':
        await Get.toNamed('/cart');
        this.pageIndex.value = this.previousPage.value;
        break;
      case 'wishlist':
        if (userId != null)
          await Get.toNamed('/wishlist');
        else
          await Get.toNamed('/login', arguments: {"path": "/wishlist"});
        this.pageIndex.value = this.previousPage.value;
        break;
      case 'menu':
        await Get.toNamed('/category');
        this.pageIndex.value = this.previousPage.value;
        break;
      case 'notification':
        await Get.toNamed('/notification', preventDuplicates: false);
        this.pageIndex.value = this.previousPage.value;
        break;
      default:
        await Get.toNamed('/home');
        this.pageIndex.value = this.previousPage.value;
        break;
    }
  }

  Future changePage(context, newIndex) async {
    var _isLoggedIn = GetStorage().read('utoken');
    index.value = newIndex;
    if (newIndex == 0) {
      await Get.offAllNamed('/home');
      index.value = previousIndex.value;
    } else if (newIndex == 1) {
      await Get.toNamed(
        '/category',
      );
      index.value = previousIndex.value;
    } else if (newIndex == 2) {
      showSearch(context: context, delegate: SearchDelegateWidget('homePage'))
          .then((value) => {this.pageIndex.value = this.previousPage.value});
    } else if (newIndex == 3) {
      await Get.toNamed('/notification', preventDuplicates: false);
      index.value = previousIndex.value;
    } else if (newIndex == 4) {
      await Get.toNamed('/myAccount', preventDuplicates: false);
      index.value = previousIndex.value;
    }

    previousIndex.value = index.value;
  }

  onLoadCheckAuthAvailable() {
    userId = GetStorage().read('utoken');
    if (userId != null) {
      reloadOnLoggedIn(userId);
      isLoggedIn.value = true;
    }
  }

  reloadOnLoggedIn(userId) {}

  Future logOut() async {
    GetStorage().remove('utoken');
    GetStorage().remove('wishlist');
    CommonHelper.showSnackBarAddToBag("Logged out successfully. ");
    _countController.onLogout();
    _notificationController.onLogout();
    Get.offAndToNamed('/home');
  }

  Future signIn() async {
    Get.back();
    var loggedInUserId =
        await Get.toNamed('/login', arguments: {"path": "/home"});
    if (loggedInUserId != null) {
      isLoggedIn.value = true;
      reloadOnLoggedIn(loggedInUserId);
    }
  }

  Future<void> requestNotificationPermissions() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
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

  openNectorReward() {
    var nector = pluginController.getPluginValue('nectar');
    if (nector != null) {
      var customerId = getCustomerId();
      Get.toNamed('/webView', arguments: {
        'url':
            "https://websdk.nector.io/nector?murl=https%3A%2F%2Fplatform.nector.io&mkey=${nector.code}&mi=shopify&customer_id=$customerId"
      });
    }
  }

  getCustomerId() {
    var customerId = GetStorage().read('customerId');
    if (customerId != null) {
      var splittedData = customerId.split('/');
      return splittedData.last;
    } else {
      return null;
    }
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

  @override
  void dispose() {
    // Cancel debounce timer
    _paginationDebounceTimer?.cancel();

    // pageController!.dispose();
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
