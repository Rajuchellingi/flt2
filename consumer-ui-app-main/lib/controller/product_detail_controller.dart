// ignore_for_file: unnecessary_null_comparison, unused_local_variable, invalid_use_of_protected_member, deprecated_member_use, avoid_init_to_null

import 'dart:io';
import 'package:b2b_graphql_package/modules/cart/cart_repo.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/common_wishlist_controller.dart';
import 'package:black_locust/controller/plugins_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/model/banner_model.dart';
import 'package:black_locust/model/review_model.dart';
import 'package:black_locust/model/product_detail_model.dart';
import 'package:black_locust/model/related_product_model.dart';
import 'package:b2b_graphql_package/modules/product_detail/product_detail_repo.dart';
import 'package:b2b_graphql_package/modules/trigger/trigger_repo.dart';
import 'package:integration_package/modules/size_chart/size_chart_repo.dart';
import 'package:b2b_graphql_package/modules/related_product/related_product_repo.dart';
import 'package:cached_network_image/cached_network_image.dart';

// import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:integration_package/modules/review/review_repo.dart';

// import 'package:social_share/social_share.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'package:get_storage/get_storage.dart';
import '../config/configConstant.dart';
import 'cart_count_controller.dart';

class ProductDetailController extends GetxController
    with BaseController, SingleGetTickerProviderMixin {
  TextEditingController? pinCodeController;
  CartRepo? cartRepo;
  TriggerRepo? triggerRepo;
  ProductDetailRepo? productDetailRepo;
  RelatedProductRepo? relatedProductRepo;
  SizeChartRepo? sizeChartRepo;
  ReviewRepo? reviewRepo;
  final commonReviewController = Get.find<CommonReviewController>();

  var appbarOpacity = 0.obs;
  var packId;
  var productId;
  var packVariant;
  var similarPack = [].obs;
  var localRecentPack = [].obs;
  var productDetails = Object().obs;
  var relatedProduct = [].obs;
  var allWishlist = [];
  var wishlist = [].obs;
  var recentlyView = [].obs;
  var wishlistFlag = false.obs;
  var quantity = 1.obs;
  var relatedProducts = [].obs;
  var productCollection = {}.obs;
  List<dynamic> variants = [].obs;
  List<dynamic> combinedArray = [].obs;
  List<XFile> imageSharePath = [];
  var selectedTitle = "".obs;
  var productVariants = [].obs;
  var productVariantsValues = [].obs;
  List<VariantTypesNew> allVariants = [];
  final _pluginController = Get.find<PluginsController>();
  var selectedProductVariants = [].obs;
  var nectarReviews = [];
  var isSizeChart = false.obs;
  var displayMode = ''.obs;
  var isReview = false.obs;
  var selectedVariant = new ImageVariantFieldValue(
          id: "",
          attributeFieldValueId: '',
          attributeFieldId: '',
          labelName: '',
          colorCode: '',
          enable: false,
          disabled: false,
          imageName: '',
          sTypename: '')
      .obs;
  String? externalMatchingProductId;
  //var quantity = 0.obs;
  // var size = "".obs;
  var product = new ProductDetailVM(
          sId: '',
          isMultiple: false,
          categoryIds: [],
          imageId: '',
          vendor: '',
          handle: '',
          bulletPoints: '',
          productId: '',
          name: '',
          description: '',
          details: null,
          packVariant: null,
          metafields: null,
          moq: 0,
          isOutofstock: false,
          type: '',
          skuId: '',
          skuIds: [],
          children: [],
          price: null,
          imageVariant: [],
          variantTypes: [],
          variantTypesNew: [],
          images: [],
          mergeAttribute: [],
          priceType: '',
          filterAttribute: null,
          isCustomizable: false,
          preferenceVariant: null,
          quantity: 1,
          sTypename: '',
          collections: null,
          productType: null,
          tags: null)
      .obs;

  var addedToWishList = false.obs;
  var productPackImage = [].obs;
  var productSize = [];
  var productSizeOption = [];
  var cartBagCount = 0.obs;
  var isLoading = false.obs;
  var loadingDonwload = false.obs;
  var toBagButtonText = 'Add To Bag'.obs;
  var selectedPackSizes = [];
  var userId;
  var packDetail;
  var isDefault = false;
  var isReturnable = false.obs;
  var isCODByCategory = false.obs;
  var deliverdByDate = "".obs;
  var pinCodeCheckBtnText = 'CHECK'.obs;
  var cashOnDeliveryText = "Cash on delivery might be available".obs;
  var varientCircleSize = 40.0.obs;
  final _countController = Get.find<CartCountController>();
  late TabController tabController;
  var selectedSize = ''.obs;
  var selectedValue = 1.0.obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  var metafields = [].obs;
  var reviewProduct = new ReviewProductVM(
          sId: null, handle: null, externalId: null, title: null)
      .obs;
  final commonWishlistController = Get.find<CommonWishlistController>();
  var arguments;
  @override
  void onInit() {
    arguments = Get.arguments;
    getTemplate();
    pinCodeController = TextEditingController();
    reviewRepo = ReviewRepo();
    // scrollController = ScrollController();
    productDetailRepo = ProductDetailRepo();
    sizeChartRepo = SizeChartRepo();
    relatedProductRepo = RelatedProductRepo();
    cartRepo = CartRepo();
    triggerRepo = TriggerRepo();
    userId = GetStorage().read('utoken');
    packDetail = Get.arguments;
    productId = packDetail.sId;
    getProductDetails(packDetail.sId, true, []);
    updateCartBag();
    checkIsReview();
    super.onInit();
  }

  getSizeChart() async {
    var sizeChart = _pluginController.getPluginValue('ri-size-chart-10');
    if (sizeChart != null) {
      var collectionId = (product.value.collections != null &&
              product.value.collections!.isNotEmpty)
          ? product.value.collections!.first.id!.split('/').last
          : null;
      var tags = (product.value.tags != null && product.value.tags!.isNotEmpty)
          ? product.value.tags!.join(',')
          : null;
      var productType = product.value.productType;
      var shop = GetStorage().read("shop");
      var params = {
        "productId": product.value.sId!.split('/').last,
        "collectionId": collectionId,
        "productType": productType,
        "productTag": tags
      };
      var data = await sizeChartRepo!.getSizeChart(params);
      print('size chart data ${data}');
      isSizeChart.value = data['status'] == true;
    }
  }

  checkIsReview() {
    var review = _pluginController.getPluginValue('judgeme');
    var nectar = _pluginController.getPluginValue('nectar');

    if (review != null) {
      // print('review ${review.toJson()}');
      // reviewProduct.value = new ReviewProductVM(
      //     sId: review.code,
      //     handle: review.handle,
      //     externalId: null,
      //     title: null);
      isReview.value = true;
    } else if (nectar != null && nectar.isReview == true) {
      isReview.value = true;
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

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'products');
    assignMetaFields();
    isTemplateLoading.value = false;
  }

  assignMetaFields() {
    if (template.value != null) {
      var blocks = template.value['layout']['blocks'];
      var data;
      if (blocks != null && blocks.length > 0) {
        for (var block in blocks) {
          if (block['componentId'] == 'meta-field-block') {
            data = {
              "key": block['source']['key'],
              "namespace": block['source']['namespace']
            };
            metafields.value.add(data);
          } else if (block['componentId'] == 'custom-variant') {
            if (block['value'] != null && block['value']['key'] != null) {
              data = {
                "key": block['value']['key'],
                "namespace": block['value']['namespace']
              };
              metafields.value.add(data);
            }
            if (block['variant'] != null && block['variant']['key'] != null) {
              data = {
                "key": block['variant']['key'],
                "namespace": block['variant']['namespace']
              };
              metafields.value.add(data);
            }
          }
        }
      }
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
              getProductsByCollection(collection, count, i);
          }
        }
      }
    }
  }

  Future getProductsByCollection(collectionId, count, index) async {
    var result = await relatedProductRepo!
        .getProductsByCollectionForCart(collectionId, count);
    if (result != null) {
      var response = relatedProductFromJson(result);
      productCollection.value[index] = response;
      if (response.isNotEmpty) await assignNectorReviews(response);
    }
  }

  Future<Null> refreshLocalGallery() async {
    getProductDetails(packDetail.sId, isDefault, []);
    updateCartBag();
  }

  Future getProductDetails(String id, bool isDefault, List variants) async {
    isLoading.value = true;
    var result;
    RegExp gidRegex = RegExp(r'^gid://shopify/Product/\d+$');
    if (gidRegex.hasMatch(id)) {
      result = await productDetailRepo!
          .getShopifyProductDetail(id, isDefault, variants, metafields.value);
      // result = await productDetailRepo!.getShopifyProductDetail(input);
    } else if (int.tryParse(id) != null) {
      var prodId = 'gid://shopify/Product/$id';
      result = await productDetailRepo!.getShopifyProductDetail(
          prodId, isDefault, variants, metafields.value);
      // result = await productDetailRepo!.getProductDetail(input);
    } else {
      result =
          await productDetailRepo!.getProductByHandle(id, metafields.value);
    }
    // await categoryPackWithSetRepo!.getProduct(id, isDefault, variants);
    var response = productDetailVMFromJson(result);
    // if (userId != null) {
    //   checkProductWishlist(userId, response.sId);
    // }
    await getImageByVariant(response.images, response.imageId);
    product.value = response;
    getReviewProduct();
    product.refresh();
    productVariants.value =
        product.value.variantTypes != null ? product.value.variantTypes! : [];
    productVariantsValues.value =
        product.value.skuIds != null ? product.value.skuIds! : [];
    allVariants = product.value.variantTypesNew != null
        ? product.value.variantTypesNew!
        : [];
    getRecentlyViewedProductList();
    getProductCollection();
    getRelatedProduct(response.sId!);
    getSizeChart();
    getProductVaraiants();
    isLoading.value = false;
  }

  Future getReviewProduct() async {
    var splittedData = product.value.sId!.split('/');
    var review = _pluginController.getPluginValue('judgeme');
    var shopDomain = GetStorage().read('shop');
    if (review != null) {
      var params = {
        "api_token": review.code,
        "shop_domain": shopDomain,
        "external_id": splittedData.last
      };
      var result = await reviewRepo!.getProduct(params);
      if (result != null) {
        var response = reviewProductVMFromJson(result);
        reviewProduct.value = response;
      }
    }
  }

  navigateToReview() async {
    var review = _pluginController.getPluginValue('judgeme');
    var nectar = _pluginController.getPluginValue('nectar');
    if (nectar != null && nectar.isReview == true) {
      openReviewPage();
    } else if (review != null) {
      await Get.toNamed('/review', arguments: {
        "id": reviewProduct.value.sId,
        "externalId": reviewProduct.value.externalId
      });
    }
  }

  Future openReviewPage() async {
    var splittedData = product.value.sId!.split('/');

    var referralPlugin = _pluginController.getPluginValue('nectar');
    String htmlString = """
      <!DOCTYPE html>
        <html lang="en">
          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Nector Rewards</title>
          </head>
          <body>
            <script async src="https://cdn.nector.io/nector-static/no-cache/reward-widget/mainloader.min.js"
              data-op="review_list" data-api_key=${referralPlugin.code}
              data-product_id=${splittedData.last} data-platform="shopify"></script>
          </body>
        </html>
      """;
    await Get.toNamed('/webView',
        arguments: {'htmlData': htmlString, "pageTitle": "Reviews"});
  }

  Future getReview(internalId) async {
    var review = _pluginController.getPluginValue('judgeme');
    var shopDomain = GetStorage().read('shop');
    if (review != null) {
      var params = {
        "api_token": review.code,
        "shop_domain": shopDomain,
        "per_page": "10",
        "page": "1",
        "product_id": internalId.toString()
      };
      var result = await reviewRepo!.getReviews(params);
    }
  }

  getRecentlyViewedProductList() {
    var productIds = [];
    var localData = GetStorage().read("recentlyView");
    List<dynamic> recentProduct =
        (localData != null && localData.length > 0) ? localData : [];
    if (recentProduct != null && recentProduct.length > 0) {
      if (recentProduct.contains(product.value.sId)) {
        recentProduct.remove(product.value.sId);
        productIds = recentProduct.reversed.toList();
        recentProduct.add(product.value.sId);
      } else {
        if (recentProduct.length > 10) {
          recentProduct.removeAt(0);
          productIds = recentProduct.reversed.toList();
          recentProduct.add(product.value.sId);
        } else {
          productIds = recentProduct.reversed.toList();
          recentProduct.add(product.value.sId);
        }
      }
      if (productIds != null && productIds.length > 0)
        getRecentlyViewProduct(productIds);
    } else {
      recentProduct.add(product.value.sId);
    }
    GetStorage().write('recentlyView', recentProduct);
  }

  getProductVaraiants() {
    productVariants.value.forEach((element) {
      var variant;
      var values = element.fieldValue;
      if (values != null && values.length == 1) {
        variant = {"type": element.type, "value": values.first.labelName};
      } else {
        variant = {"type": element.type, "value": null};
      }
      selectedProductVariants.add(variant);
    });
  }

  Future getRelatedProduct(String productId) async {
    isLoading.value = true;
    var productIdentifiers = themeController.productBadge != null
        ? [themeController.productBadge]
        : [];
    var result = await relatedProductRepo!
        .getRelatedProducts(productId, productIdentifiers);
    if (result != null) {
      var response = relatedProductFromJson(result);
      if (response != null && response.length > 10) {
        relatedProduct.value = response.sublist(0, 10);
      } else {
        relatedProduct.value = response;
      }
      if (relatedProduct.value.isNotEmpty)
        await assignNectorReviews(relatedProduct.value);
      relatedProduct.refresh();
    }
    isLoading.value = false;
  }

  Future getRecentlyViewProduct(productIds) async {
    // isLoading.value = true;
    var result = await relatedProductRepo!.getProductsbyId(productIds);
    var response = relatedProductFromJson(result);
    recentlyView.value = response;
    if (recentlyView.value.isNotEmpty)
      await assignNectorReviews(recentlyView.value);
    recentlyView.refresh();
  }

  Future mapPackImage(packImages, imageId) async {
    List<ImageSliderVWModel> bannerSliderList = [];
    packImages.forEach((element) {
      var imageList = new ImageSliderVWModel(
          imageId, element.imageName, element.link, '', '');
      bannerSliderList.add(imageList);
    });
    if (bannerSliderList.length > 0) _preloadImages(bannerSliderList);
    productPackImage.value = bannerSliderList;
  }

  Future<void> _preloadImages(images) async {
    for (dynamic data in images) {
      await precacheImage(
          CachedNetworkImageProvider(data.imageName + "&width=500"),
          Get.context!);
    }
  }

  Future getImageByVariant(packImages, imageId) async {
    if (product.value.imageVariant != null &&
        product.value.imageVariant!.length > 0) {
      product.value.imageVariant!.forEach((element) {
        if (element.fieldValue != null && element.fieldValue!.length > 0) {
          var field = element.fieldValue!.first;
          selectedVariant.value = field;
          var images = packImages!
              .where((da) =>
                  da.attributeFieldValueId == field.attributeFieldValueId)
              .toList();
          mapPackImage(images, imageId);
        } else {
          mapPackImage(packImages, imageId);
        }
      });
    } else {
      await mapPackImage(packImages, imageId);
    }
  }

  selectedVarient(varient, fieldValue) {
    if (varient != null) {
      if (varient.toString().toLowerCase() == 'size') {
        var selectedSize = fieldValue;
        this
            .product
            .value
            .variantTypes!
            .where((element) =>
                element.type!.toLowerCase() == varient.toString().toLowerCase())
            .first
            .fieldValue!
            .forEach((element) {
          element.enable = false;
          if (element.labelName == selectedSize.labelName &&
              element.id == selectedSize.id) {
            element.enable = true;
          }
        });
        this.varientCircleSize.refresh();
      }
      if (varient.toString().toLowerCase() == 'color') {
        var selectedColor = fieldValue;
        this
            .product
            .value
            .variantTypes!
            .where((element) =>
                element.type!.toLowerCase() == varient.toString().toLowerCase())
            .first
            .fieldValue!
            .forEach((element) {
          element.enable = false;
          if (element.labelName == selectedColor.labelName &&
              element.id == selectedColor.id) {
            element.enable = true;
          }
        });
        this.varientCircleSize.refresh();
      }
    }
  }

  Future productAddToCart({isPopup = false}) async {
    userId = GetStorage().read('utoken');
    var isAllowCart = themeController.isAllowCartBeforLogin();
    if (userId != null || isAllowCart == true) {
      if (product.value.isOutofstock == true) {
        this.showLoading('Loading...');
        var selectedVariantId = getSelectedProductVariant();
        if (selectedVariantId != null) {
          var productInput = getSelectedProduct(selectedVariantId);
          var cartId = await getCartId();
          var cartExpiry = GetStorage().read("cartExpiry");
          var input = {"selectedProduct": productInput, "cartId": cartId};
          var result = await cartRepo!.addProductToCart(input);
          if (result != null) {
            hideLoading();
            await triggerRepo!.createTrigger('abandoned-cart');
            if (isPopup) Get.back();
            CommonHelper.showSnackBarAddToBag("Successfully moved to bag ");
            _countController.getCartCount();
          }
        } else {
          hideLoading();
          CommonHelper.showSnackBarAddToBag("Please select the variant");
        }
        hideLoading();
      } else {
        createNotifyMe();
        if (isPopup) Get.back();
        CommonHelper.showSnackBarAddToBag(
            'You’ll be notified when this product is back in stock!');
        // ScaffoldMessenger.of(Get.context!).showSnackBar(
        //   SnackBar(
        //     content:
        //         Text(),
        //     behavior: SnackBarBehavior.floating,
        //   ),
        // );
      }
    } else {
      var isMessage = themeController.isCartMessage();
      if (isMessage) {
        var result = await Get.toNamed('/cartLoginMessage',
            arguments: {"path": "/productDetail", "arguments": arguments});
        if (result != null) {
          userId = GetStorage().read('utoken');
        }
      } else {
        var result = await Get.toNamed('/login',
            arguments: {"path": "/productDetail", "arguments": arguments});
        if (result != null) {
          userId = GetStorage().read('utoken');
          // getProductDetails(packDetail.sId, true, []);
          // updateCartBag();
        }
      }
    }
  }

  getCartId() async {
    var cartId = GetStorage().read("cartId");
    if (cartId != null) {
      return cartId;
    } else {
      var cart = await cartRepo!.createCart({});
      var newCartId = cart['cart']['id'];
      GetStorage().write("cartId", newCartId);
      GetStorage().write("cartExpiry", cart['cart']['updatedAt']);
      return newCartId;
    }
  }

  Future createNotifyMe() async {
    var selectedVariantId = getSelectedProductVariant();

    var input = {
      "productId": product.value.sId,
      "variantId": selectedVariantId,
      "type": "manual"
    };
    await productDetailRepo!.createNotifyMe(input);
  }

  getSelectedProduct(selectedVariantId) {
    List<dynamic> skuInput = [];
    var productData = this.product.value;
    if (quantity.value > 0 && selectedVariantId != null) {
      var request = {
        "quantity": quantity.value,
        // "merchandiseId": externalMatchingProductId,
        "merchandiseId": selectedVariantId,
        // "merchandiseId": "gid://shopify/ProductVariant/47183985410348",
        //  externalMatchingProductId =
        //     "gid://shopify/ProductVariant/47183985410348";
      };
      return request;
    } else {
      return null;
    }
  }

  Future getServerCartCount(userId) async {
    // var result = await cartRepo!.getServerCartCount(userId);
    // if (result != null) {
    //   cartBagCount.value = result.noOfProducts;
    // }
  }

  quantityMinus() {
    quantity.value = quantity.value > 1 ? quantity.value - 1 : 1;
  }

  quantityAdd() {
    quantity.value = quantity.value + 1;
  }

  updateCartBag() {
    if (userId != null) {
      // getServerCartCount(userId);
    } else {
      var cacheBag = GetStorage().read('shoppingCart');
      if (cacheBag != null) {
        cartBagCount.value = cacheBag.length;
      }
    }
  }

  // Future openCart() async {
  //   await Get.toNamed("/cart");
  //   updateCartBag();
  // }

  Future openCart() async {
    userId = GetStorage().read('utoken');

    if (userId != null) {
      await Get.offAndToNamed("/cart");
    } else {
      Get.toNamed('/login', arguments: {"path": "/cart"});
    }
  }

  showSnackBar(String msg, SnackPosition position) {
    Get.snackbar("", msg,
        snackPosition: position,
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

  // Future addToWishList(productId) async {
  //   if (userId != null) {
  //     showLoading('Loading...');
  //     var result = await wishListRepo!.changeProductWishlist(userId, productId);
  //     if (result != null) {
  //       addedToWishList.value = !addedToWishList.value;
  //     }
  //     hideLoading();
  //   } else {
  //     var result = await Get.toNamed('/login');
  //     if (result != null) {
  //       userId = result;
  //     }
  //   }
  // }

  Future addToWishList(productId) async {
    commonWishlistController.checkProductAndAdd(productId);
  }

  getWishListonClick(product) {
    return commonWishlistController.checkProductIsInWishlist(product.sId);
  }

  updateColorOnTap(variant) {}

  //  getWishListonClick(productId) {
  //   var result = false;
  //   if (userId != null) {
  //     if (allWishlist != null) {
  //       for (var i = 0; i < allWishlist.length; i++) {
  //         if (allWishlist[i].productId == productId) {
  //           result = true;
  //         }
  //       }
  //       return result;
  //     }
  //   }
  //   return result;
  // }

  @override
  void onClose() {
    super.onClose();
    GetStorage().remove('filter');
  }

  onSearchProduct(value) async {
    var results =
        await Get.toNamed('/searchPage', arguments: {"search": value});
  }

  Future<void> userAnalysis() async {
    userId = GetStorage().read('utoken');

    if (userId != null) {
      await Get.toNamed('/wishlist');
    } else {
      Get.toNamed('/login', arguments: {"path": "/wishlist"});
    }
  }

  Future<void> shareImageFromUrl() async {
    showLoading('Loading..');
    int index = 0;
    this.imageSharePath = [];
    await asyncTwo(this.productPackImage.first, index);
    String content =
        '\n <p><strong>Take a look at this ${product.value.name.toString()}</strong></p>\n${websiteUrl + 'products/' + product.value.handle.toString()} ';
    hideLoading();
    ShareResult shareResult = await Share.shareXFiles(imageSharePath,
        subject: product.value.name,
        text: parse(content).documentElement!.text);
    if (shareResult.status == ShareResultStatus.success) {}
    // ShareResultStatus status = shareResult.status;
    // print(shareResult.status.su);
    // result.contains((needle) => print(needle));
  }

  asyncTwo(element, index) async {
    var imageurl = element.imageName;
    var imageName = 'image' + index.toString() + '.jpg';
    var uri = Uri.parse(imageurl);
    var response = await http.get(uri);
    var bytes = response.bodyBytes;
    var temp = await getTemporaryDirectory();
    var path = '${temp.path}/' + imageName;
    File(path).writeAsBytesSync(bytes);
    imageSharePath.add(XFile(path));
  }

  Future downloadProductImage(context) async {
    // showLoading('Downloading...');

    // // loadingDonwload.value = true;
    // for (final image in product.value.images!) {
    //   await GallerySaver.saveImage(
    //           promotionImageBaseUri +
    //               product.value.imageId! +
    //               '/' +
    //               image.imageName!,
    //           albumName: product.value.name,
    //           toDcim: true)
    //       .then((value) => {print('response'), print(value)});
    // }
    // // loadingDonwload.value = false;
    // hideLoading();
    // showSnackBar('Download successfully', SnackPosition.TOP);
  }

  getPackVariants() {
    var packVariants = [];
    this.product.value.children!.forEach((element) {
      var variant = element.preferenceVariant!.fieldValue![0];
      packVariants.add(variant);
    });
    return packVariants;
  }

  changeImageVariant(variant) {
    selectedVariant.value = variant;
    var images = product.value.images!
        .where(
            (da) => da.attributeFieldValueId == variant.attributeFieldValueId)
        .toList();
    mapPackImage(images, product.value.imageId);
  }

  navigateToRelatedProduct() async {
    await Get.offAndToNamed('/relatedProduct', arguments: {"id": productId});
    relatedProduct.refresh();
  }

  getProductAvailableVariantOptions(type) {
    var sizeOptions = [];
    var options = product.value.variantTypes;
    if (options != null && options.length > 0) {
      final fieldValue = options.firstWhere((element) => element.type == type);
      if (fieldValue != null &&
          fieldValue.fieldValue != null &&
          fieldValue.fieldValue!.length > 0) {
        product.value.skuIds!.forEach((e) {
          var variantOptions = e.title!.split(' / ');
          fieldValue.fieldValue!.forEach((da) {
            var haveSizeOption = variantOptions.contains(da.labelName);
            bool containSize =
                sizeOptions.any((obj) => obj.name == da.labelName);
            if (haveSizeOption && !containSize) {
              var isAvailable = product.value.skuIds!.any((el) =>
                  el.title!.split(' / ').contains(da.labelName) &&
                  el.availableForSale == true);
              var sizeList = new RelatedProductSizeOptions(
                  name: da.labelName, isAvailable: isAvailable);
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

  // getWishListonClick(productId) {
  //   var result = false;
  //   if (userId != null) {
  //     if (allWishlist != null) {
  //       for (var i = 0; i < allWishlist.length; i++) {
  //         if (allWishlist[i].productId == productId) {
  //           result = true;
  //         }
  //       }
  //       return result;
  //     }
  //   }
  //   return result;
  // }

  Future navigateToProductDetails(product) async {
    var result = await Get.toNamed('/productDetail',
        preventDuplicates: false, arguments: product);
  }

  getProductByVariant(type, value) {
    var variantIndex = selectedProductVariants
        .indexWhere((element) => element['type'] == type);
    selectedProductVariants[variantIndex]['value'] = value;
    selectedProductVariants.refresh();
    // selectedTitle.value = value!;
    // print("productTitle.value -->>> ${productTitle.value}");
    //  var matchingProductId = selectedProductVariants.skuId;
    getAvailabelVariants(type, value);
    // print(
    //     'selected variants------------- ${product.value.variantTypes![1].toJson()}');
  }

  Future getAvailabelVariants(type, value) async {
    var skuIds = product.value.skuIds;
    List<VariantTypes> newVariants = [
      // {"type": "size", "fieldValue": []}
    ];
    var variantFieldValue = [];
    skuIds!.forEach((element) {
      var variantOptions = element.title!.split(' / ');
      // print("availableVariant options ${element.skuId}");
      var isContainsVariant = variantOptions.contains(value);
      if (isContainsVariant) {
        if (variantOptions.length > 1) {
          variantOptions.forEach((variant) {
            // var matchingProductId = variant.skuId;
            if (variant != value) {
              // print("variant222 $variant");
              allVariants.forEach((options) {
                if (options.type != type) {
                  var isAvailableVariant =
                      options.fieldValue!.any((da) => da.labelName == variant);
                  if (isAvailableVariant) {
                    var availableVariant = options.fieldValue!
                        .firstWhere((da) => da.labelName == variant);
                    var isValueExists = variantFieldValue.length > 0
                        ? variantFieldValue
                            .any((da) => da['type'] == options.type)
                        : false;

                    // print("productTitle---111 ${productTitle}");
                    if (isValueExists) {
                      var isExists = variantFieldValue.length > 0
                          ? variantFieldValue
                              .firstWhere((da) => da['type'] == options.type)
                          : null;
                      int existingVariant = variantFieldValue
                          .indexWhere((da) => da['type'] == options.type);
                      // print("isExists ${isExists.fieldValue[0].toJson()}");
                      // var existFieldValue = isExists['fieldValue'].firstWhere(
                      //   (da) => da.labelName == availableVariant.labelName,
                      //   orElse: () => null,
                      // );
                      var existFieldValue = isExists['fieldValue'].any(
                          (da) => da.labelName == availableVariant.labelName);
                      if (existFieldValue == false) {
                        variantFieldValue[existingVariant]['fieldValue']
                            .add(availableVariant);
                      }
                      // if (existingVariant == null) {
                      //   variantFieldValue.add({
                      //     "type": options.type,
                      //     "fieldValue": [availableVariant]
                      //   });
                      //   print("variantFieldValue111 $variantFieldValue");
                      // }
                      // print("variantFieldValue222 $variantFieldValue");
                    } else {
                      variantFieldValue.add({
                        "type": options.type,
                        "fieldValue": [availableVariant]
                      });
                    }
                  }
                }
                // else {
                //   newVariants.add(options);
                // }
              });
            }
          });
        } else {
          variantOptions.forEach((variant) {
            allVariants.forEach((options) {
              var availableVariant = options.fieldValue!
                  .firstWhere((da) => da.labelName == variant);
              if (availableVariant != null) {
                var isExists = variantFieldValue.length > 0
                    ? variantFieldValue
                        .firstWhere((da) => da['type'] == options.type)
                    : null;

                // print("productTitle---111 ${productTitle}");
                if (isExists != null) {
                  int existingVariant = variantFieldValue
                      .indexWhere((da) => da['type'] == options.type);

                  var existFieldValue = isExists['fieldValue']
                      .any((da) => da.labelName == availableVariant.labelName);
                  if (existFieldValue == false) {
                    variantFieldValue[existingVariant]['fieldValue']
                        .add(availableVariant);
                  }
                } else {
                  variantFieldValue.add({
                    "type": options.type,
                    "fieldValue": [availableVariant]
                  });
                }
              }
            });
          });
        }
      }
    });
    variantFieldValue.forEach((element) {
      // print("element --->>${element.toJson()}");
      // var updateType = element.['type'];
      // var oldType = productVariants[0].type;
      // print("productVariants --->>${element.fieldValue}");
      // int existingVariants =
      //     productVariants.indexWhere((da) => da.type == element.type);
      int existingIndex = productVariants.indexWhere(
          (existingVariant) => existingVariant.type == element['type']);
      if (existingIndex != null) {
        var existFieldValues = productVariants.firstWhere(
            (da) => da?.type == element['type'],
            orElse: () => null);
        if (existFieldValues != null) {
          productVariants.value[existingIndex].fieldValue =
              element["fieldValue"];

          productVariants.refresh();
        }
      }
      var selectedSkuId = getSelectedProductVariant();
      if (selectedSkuId != null) {
        var skuIds = product.value.skuIds;
        var sku =
            skuIds!.firstWhere((element) => element.skuId == selectedSkuId);
        if (sku.availableForSale == false) {
          product.value.isOutofstock = false;
          CommonHelper.showSnackBarAddToBag(
              "Selected variant is currently unavilable");
          // ScaffoldMessenger.of(contextValue).showSnackBar(
          //   SnackBar(
          //     content: Text('Selected variant is currently unavilable'),
          //     behavior: SnackBarBehavior.floating,
          //   ),
          // );
        } else {
          product.value.isOutofstock = true;
        }
        product.refresh();
      }
    });
    // print(
    //     "productVariants productVariants1111 ${productVariants![0].toJson()}");
    // print("productVariants productVariants2 ${productVariants![1].toJson()}");
    // print(
    //     "variantFieldValue variantFieldValue11111 ${product.value.variantTypes![0].toJson()}");
    // print(
    //     "variantFieldValue variantFieldValue2 ${product.value.variantTypes![1].toJson()}");
    // print('new variants ${variantFieldValue}');
  }

  String? getSelectedProductVariant() {
    bool isVariantSelected =
        selectedProductVariants.every((element) => element['value'] != null);
    if (isVariantSelected) {
      var selectedValues =
          selectedProductVariants.map((element) => element['value']).toList();
      var skuIdss = product.value.skuIds;
      var selectedFieldValue;
      bool isVariant;
      for (var element in skuIdss!) {
        selectedFieldValue = element.title!.split(' / ');
        isVariant = selectedValues
            .every((element) => selectedFieldValue.contains(element));
        if (isVariant) return element.skuId;
      }
    } else {
      return null;
    }
    return null;
  }
  // Future<void> getProductByVariant(type, value) async {
  //   // List<dynamic> existVariant =
  //   //     variants.where((element) => element['type'] != type).toList();
  //   // existVariant.add({"type": type, "value": value});
  //   print("value --->>> $value");
  //   print("type --->>> $type");
  //   // variants = existVariant;
  //   // List types = variants.map((variant) => variant['value']).toList();
  //   print("variants $variants");
  //   var skuIds = product.value?.skuIds;
  //   if (skuIds != null && skuIds.isNotEmpty) {
  //     print("skuIds cart ${skuIds[0]}");
  //     var productWithMatchingTitle = skuIds.firstWhereOrNull(
  //       (product) => value.contains(product.title),
  //     );

  //     print("productWithMatchingTitle ---> $productWithMatchingTitle");

  //     if (productWithMatchingTitle != null) {
  //       var matchingProductId = productWithMatchingTitle.skuId;
  //       productTitle.value = productWithMatchingTitle.title!;
  //       print("productTitle ---> $productTitle");

  //       externalMatchingProductId = matchingProductId;
  //       // externalMatchingProductId =
  //       //     "gid://shopify/ProductVariant/47183985410348";
  //       print("Matching Product ID: $externalMatchingProductId");
  //     } else {
  //       print("No matching product found");
  //     }
  //   }
  // }
  // Future<void> getProductByVariant(type, value) async {
  //   // List<dynamic> existVariant =
  //   //     variants.where((element) => element['type'] != type).toList();
  //   // existVariant.add({"type": type, "value": value});
  //   // variants = existVariant;
  //   // List types = variants.map((variant) => variant['value']).toList();
  //   var skuIds = product.value?.skuIds;
  //   if (skuIds != null && skuIds.isNotEmpty) {
  //     List<dynamic> titles = skuIds.map((sku) => sku.title).toList();
  //     // List<String> color = [];
  //     // List<String> size = [];
  //     if (product.value.variantTypes!.length >= 2) {
  //       titles.forEach((title) {
  //         List<String> parts = title.split(" / ");
  //         if (parts.length == 2) {
  //           combinedArray.addAll(parts);
  //           // color.add(parts[0]);
  //           // size.add(parts[1]);
  //           // print("colorArray $color");
  //           // print("sizeArray $size");
  //         }
  //       });
  //     } else {
  //       var combinedArray = titles;
  //     }
  //     // print("skuIds cart ${skuIds[0].title}");
  //     var productWithMatchingTitle = combinedArray.firstWhereOrNull(
  //       (part) => combinedArray.contains(value),
  //     );

  //     if (productWithMatchingTitle != null) {
  //       var matchingProductId = productWithMatchingTitle.skuId;
  //       productTitle.value = productWithMatchingTitle.title!;

  //       externalMatchingProductId = matchingProductId;
  //       // externalMatchingProductId =
  //       //     "gid://shopify/ProductVariant/47183985410348";
  //     } else {
  //       print("No matching product found");
  //     }
  //   }
  // }
  // Future<void> getProductByVariant(type, value) async {
  //   List<dynamic> existVariant =
  //       variants.where((element) => element['type'] != type).toList();
  //   existVariant.add({"type": type, "value": value});
  //   print("value --->>>value $value");
  //   print("type --->>>value $type");
  //   variants = existVariant;

  //   var skuIds = product.value?.skuIds;

  //   if (skuIds != null) {
  //     var productWithMatchingTitle = skuIds.firstWhere(
  //       (product) => product.title == value,
  //     );
  //     print("productWithMatchingTitle ---> $productWithMatchingTitle");
  //     if (productWithMatchingTitle != null) {
  //       var matchingProductId = productWithMatchingTitle.skuId;
  //       productTitle.value = productWithMatchingTitle.title!;
  //       print("productTitle ---> $productTitle");
  //       if (productWithMatchingTitle != null) {
  //         var matchingProductId = productWithMatchingTitle.skuId;
  //         externalMatchingProductId = matchingProductId;
  //         print("Matching Product ID: $matchingProductId");
  //       }
  //     } else {
  //       print("no one is equal");
  //     }
  //   }
  // }
  List<RelatedProductSizeOptions> getAvailableVariantOptions(type) {
    List<RelatedProductSizeOptions> sizeOptions = [];

    var options = product.value.variantTypes;
    if (options != null && options.length > 0) {
      var fieldValue = options.firstWhere((element) => element.type == type,
          orElse: () => VariantTypes(
              type: null,
              attributeFieldId: null,
              fieldValue: null,
              sTypename: null));
      if (fieldValue != null &&
          fieldValue.fieldValue != null &&
          fieldValue.fieldValue!.length > 0) {
        product.value.skuIds!.forEach((e) {
          var variantOptions = e.title!.split(' / ');
          fieldValue.fieldValue!.forEach((da) {
            var haveSizeOption = variantOptions.contains(da.labelName);
            bool containSize =
                sizeOptions.any((obj) => obj.name == da.labelName);
            if (haveSizeOption && !containSize) {
              var sizeList = new RelatedProductSizeOptions(
                  name: da.labelName, isAvailable: e.availableForSale);
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

  getCollectionData() {
    if (product.value.collections != null &&
        product.value.collections!.length > 0) {
      var collections = [];
      product.value.collections!.forEach((element) {
        var newData = {
          'id': getId(element.id),
          'handle': element.handle,
          'title': element.title
        };
        collections.add(newData);
      });
      return collections;
    } else {
      return [];
    }
  }

  getId(id) {
    return id.split('/').last;
  }

  @override
  void dispose() {
    tabController.dispose();
    pinCodeController?.dispose();
    // scrollController!.removeListener(_scrollListener);
    // scrollController!.dispose();
    super.dispose();
  }
}
