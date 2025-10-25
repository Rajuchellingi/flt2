// ignore_for_file: unused_local_variable, unnecessary_null_comparison, invalid_use_of_protected_member, unused_field

import 'dart:async';

import 'package:b2b_graphql_package/modules/checkout/checkout_repo.dart';
import 'package:b2b_graphql_package/modules/coupen_codes/coupen_code_repo.dart';
import 'package:b2b_graphql_package/modules/trigger/trigger_repo.dart';
import 'package:b2b_graphql_package/modules/user/user_repo.dart';
import 'package:b2b_graphql_package/modules/order/order_repo.dart';
import 'package:b2b_graphql_package/modules/cart/cart_repo.dart';
import 'package:b2b_graphql_package/modules/cart_setting/cart_setting_repo.dart';
import 'package:b2b_graphql_package/modules/related_product/related_product_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/common_wishlist_controller.dart';
import 'package:black_locust/controller/plugins_controller.dart';
import 'package:black_locust/controller/shop_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/cart_product_model.dart';
import 'package:black_locust/model/cart_setting_model.dart';
import 'package:black_locust/model/common_model.dart';
import 'package:black_locust/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../model/related_product_model.dart';
import 'cart_count_controller.dart';

class CartController extends GetxController with BaseController {
  ScrollController? scrollController;
  RelatedProductRepo? relatedProductRepo;
  CartRepo? cartRepo;
  CartSettingRepo? cartSettingRepo;
  UserRepo? userRepo;
  OrderRepo? orderRepo;
  CheckoutRepo? checkoutRepo;
  CoupenCodeRepo? coupenCodeRepo;
  TriggerRepo? triggerRepo;
  var productCart = [].obs;
  var relatedProduct = [].obs;
  var cartCollectionProduct = [].obs;
  var productId;
  var totalCartPrice = new ProductSummary(
          summary: null,
          totalQuantity: null,
          discountAllocations: null,
          checkoutUrl: null,
          discountCodes: null,
          sTypename: "")
      .obs;
  final commonReviewController = Get.find<CommonReviewController>();
  Rx<DiscountCodesVM?> discountCode = Rx<DiscountCodesVM?>(null);
  Rx<DiscountAllocationsVM?> discountAllocation =
      Rx<DiscountAllocationsVM?>(null);
  var userId;
  var cartSetting = new CartSettingVM(
          sId: null,
          recommendedProducts: null,
          sTypename: null,
          discountProgressBar: null,
          showDiscountProgressBar: null)
      .obs;
  var userProfile;
  var paymentToken;
  var cartId = GetStorage().read("cartId");
  var cartExpiry = GetStorage().read("cartExpiry");
  var isLoading = false.obs;
  var outOfStock = false.obs;
  final _countController = Get.find<CartCountController>();
  var wishlistFlag = false.obs;
  var selectedDiscount = new DiscountProgressBarVM(
          sId: null,
          title: null,
          discountValue: null,
          discountType: null,
          requirementType: null,
          requirementValue: null,
          sTypename: null)
      .obs;
  var selectedDiscountIndex = 0.obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  final commonWishlistController = Get.find<CommonWishlistController>();
  final shopifyShopController = Get.find<ShopController>();
  final pluginController = Get.find<PluginsController>();
  late Razorpay _razorpay;
  var nectarReviews = [];
  var duration = 60.obs;
  Timer? _timer;
  var isReload = false.obs;

  @override
  void onInit() {
    // cartProductRepo = CartProductRepo();
    cartRepo = CartRepo();
    userRepo = UserRepo();
    checkoutRepo = CheckoutRepo();
    coupenCodeRepo = CoupenCodeRepo();
    triggerRepo = TriggerRepo();
    cartSettingRepo = CartSettingRepo();
    orderRepo = OrderRepo();
    relatedProductRepo = RelatedProductRepo();
    getTemplate();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    userId = GetStorage().read('utoken');
    var isAllowCart = themeController.isAllowCartBeforLogin();
    if (userId != null || isAllowCart == true) {
      getCartSetting();
      getInitalCartProduct();
      if (userId != null) getProfile();
    }
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'cart');
    isTemplateLoading.value = false;
  }

  Future getCartSetting() async {
    var result = await cartSettingRepo!.getCartSetting();
    if (result != null) {
      var response = cartSettingVMFromJson(result);
      cartSetting.value = response;
      if (response.recommendedProducts != null &&
          response.recommendedProducts!.type == 'single-collection' &&
          response.recommendedProducts!.singleCollectionUrl != null) {
        var link = response.recommendedProducts!.singleCollectionUrl;
        var splittedLink = link!.split('/');
        var handle = splittedLink[splittedLink.length - 1];
        var limit = 10;
        var productResult = await relatedProductRepo!
            .getProductsByCollectionForCart(handle, limit);
        if (productResult != null) {
          var productResponse = cartCollectionProductVMFromJson(productResult);
          cartCollectionProduct.value = productResponse;
          if (cartCollectionProduct.value.isNotEmpty)
            await assignNectorReviews(cartCollectionProduct.value);
        }
      }
    }
  }

  Future getInitalCartProduct() async {
    isLoading.value = true;
    cartId = await getCartId();
    var result = await cartRepo!.getCartProductByUser(cartId);
    var summary = await cartRepo!.getCartProducPricetSummaryByUser(cartId);
    if (result != null && summary != null) {
      var response = cartProductFromJson(result);
      productCart.value = response;
      if (response != null && response.length > 0) {
        productId = response.first.productId;
        getRelatedProduct(productId);
      }
      var summaryResponse = cartSummaryFromJson(summary);
      totalCartPrice.value = summaryResponse;
      getAppliedCoupen();
      getSelectedDiscount();
      outOfStockOrder();
    } else {
      productCart.value = [];
    }
    isLoading.value = false;
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

  Future getCartProduct() async {
    showLoading("Loading...");
    var result = await cartRepo!.getCartProductByUser(cartId);
    var summary = await cartRepo!.getCartProducPricetSummaryByUser(cartId);
    if (result != null && summary != null) {
      var response = cartProductFromJson(result);
      productCart.value = response;
      if (response != null && response.length > 0) {
        productId = response.first.productId;
        getRelatedProduct(productId);
      }
      var summaryResponse = cartSummaryFromJson(summary);
      totalCartPrice.value = summaryResponse;
      getAppliedCoupen();
      getSelectedDiscount();
      outOfStockOrder();
    } else {
      productCart.value = [];
    }
    hideLoading();
  }

  getSelectedDiscount() {
    if (cartSetting.value.showDiscountProgressBar == 'enabled' &&
        cartSetting.value.discountProgressBar != null &&
        cartSetting.value.discountProgressBar!.length > 0) {
      selectedDiscountIndex.value = 0;
      var progressBar = cartSetting.value.discountProgressBar;
      var price = totalCartPrice.value.summary!.totalSellingPrice;
      var count = totalCartPrice.value.totalQuantity;
      for (var i = 0; i < progressBar!.length; i++) {
        if (progressBar[i].requirementType == 'amount') {
          if (price! >= progressBar[i].requirementValue) {
            selectedDiscount.value = progressBar[i];
            selectedDiscountIndex.value++;
          }
        } else if (progressBar[i].requirementType == 'quantity') {
          if (count! >= progressBar[i].requirementValue) {
            selectedDiscount.value = progressBar[i];
            selectedDiscountIndex.value++;
          }
        }
      }
    }
  }

  Future getProfile() async {
    var result = await userRepo!.getUserById(userId, []);
    if (result != null) {
      userProfile = userByIdVMFromJson(result);
    }
  }

  Future addCartProduct(sku, product, category) async {
    this.showLoading('Loading...');
    var line = {
      "id": product?.sId,
      "merchandiseId": product?.skuId,
      "quantity": product?.qty + 1,
      // 'sellingPlanId': sku.sid
    };
    var result = await cartRepo!.updateCartProductQtyById(line, cartId);
    if (result != null) {
      this.getCartProduct();
      _countController.getCartCount();
    }
    hideLoading();
  }

  Future minusCartProduct(sku, product) async {
    this.showLoading('Loading...');
    var line = {
      "id": product?.sId,
      "merchandiseId": product?.skuId,
      "quantity": product?.qty - 1,
      // 'sellingPlanId': sku.sid
    };
    var result = await cartRepo!.updateCartProductQtyById(line, cartId);
    if (result != null) {
      this.getCartProduct();
      _countController.getCartCount();
    }
    hideLoading();
  }

  addCustomizableProduct(sku, product) async {
    this.showLoading('Loading...');
    var line = {
      "id": product?.sId,
      "merchandiseId": "gid://shopify/ProductVariant/47183985410348",
      "quantity": product?.qty,
      // 'sellingPlanId': sku.sid
    };
    var result = await cartRepo!.updateCartProductQtyById(line, cartId);
    if (result != null) {
      this.getCartProduct();
    }
    hideLoading();
  }

  addNonCustomizableProduct(sku, product) async {
    this.showLoading('Loading...');
    var line = {
      "id": product?.sId,
      "merchandiseId": "gid://shopify/ProductVariant/47183985410348",
      "quantity": product?.qty,
      // 'sellingPlanId': sku.sid
    };
    var result = await cartRepo!.updateCartProductQtyById(line, cartId);
    if (result != null) {
      this.getCartProduct();
    }
    hideLoading();
  }

  minusCustomizableProduct(sku, product) async {
    if (sku.qty > 1) {
      this.showLoading('Loading...');
      var line = {
        "id": product?.sId,
        "merchandiseId": "gid://shopify/ProductVariant/47183985410348",
        "quantity": 5,
        // 'sellingPlanId': sku.sid
      };
      var result = await cartRepo!.updateCartProductQtyById(line, cartId);
      if (result != null) {
        this.getCartProduct();
      }
      hideLoading();
    }
  }

  minusNonCustomizableProduct(sku, product) async {
    if (sku.qty > 1) {
      this.showLoading('Loading...');
      var line = {
        "id": product?.sId,
        "merchandiseId": "gid://shopify/ProductVariant/47183985410348",
        "quantity": product?.qty - 1,
        // 'sellingPlanId': sku.sid
      };
      var result = await cartRepo!.updateCartProductQtyById(line, cartId);
      if (result != null) {
        this.getCartProduct();
      }
      hideLoading();
    }
  }

  Future removeCartProduct(sku, product) async {
    this.showLoading('Loading...');
    var result = await cartRepo!.removeCartById(
        cartId: cartId,
        type: product.type,
        sid: sku.sid,
        productId: product.sId);
    if (result != null) {
      this.getCartProduct();
      if (productCart.value.isEmpty) {
        await triggerRepo!.cancelTriggerNotification('abandoned-cart');
      }
    }
    hideLoading();
  }

  openDetailPage(product) async {
    await Get.toNamed('/productDetail', arguments: product);
    getCartProduct();
  }

  Future removeNonCustomProuduct(sku, product) async {
    this.showLoading('Loading...');
    var result = await cartRepo!.removeCartById(
        cartId: cartId, type: product.type, productId: product.sId);
    if (result != null) {
      await this.getCartProduct();
      if (productCart.value.isEmpty) {
        await triggerRepo!.cancelTriggerNotification('abandoned-cart');
      }
      _countController.getCartCount();
    }
    hideLoading();
  }

  outOfStockOrder() {
    if (productCart.length > 0) {
      outOfStock.value =
          productCart.any((element) => element.outOfStock == false);
      // productCart.forEach((element) {
      //   print('outof stock condition ${element.outOfStock}');
      //   if (!element.outOfStock) {
      //     outOfStock.value = true;
      //     outOfStock.refresh();
      //   }
      // });
    }
  }

  navigateToPlaceOrder(prefernce) {
    if (prefernce.order.enableDirectPayment) {
      Get.toNamed('/placeOrder');
    } else {
      Get.toNamed('/booking');
    }
  }

  Future navigateToProductDetails(product) async {
    var result = await Get.toNamed('/productDetail',
        preventDuplicates: false, arguments: product);
  }

  Future navigateToCheckout() async {
    var magicCheckout = pluginController.getPluginValue('magic-checkout');
    if (magicCheckout != null) {
      await initiateMagicCheckout(magicCheckout);
    } else {
      // showLoading('Loading...');
      // var cartInput = cartCheckoutInput();
      // var result = await orderRepo!.createOrder(cartInput);
      // if (result != null) {
      //   var checkout = createCheckoutVMFromJson(result);
      //   var checkoutUrl = result.webUrl;
      var checkoutUrl = totalCartPrice.value.checkoutUrl;
      if (checkoutUrl != null) {
        var result = await Get.toNamed('/checkout',
            preventDuplicates: false, arguments: {"url": checkoutUrl});
      }
      // hideLoading();
    }
  }

  Future initiateMagicCheckout(credentatials) async {
    showLoading('Processing...');
    var result = await cartRepo!.initiateRazorPayPayment(cartId);
    hideLoading();
    if (result != null) {
      if (result['error'] == false) {
        paymentToken = result['token'];
        var prefill = {};
        var options = {
          "key": credentatials.code,
          'order_id': result['orderId'],
          "amount": "50000",
          "currency": "INR",
          "name": shopifyShopController.shopDetail.value.name,
          "description": "Transaction",
          "one_click_checkout": true,
          "show_coupons": true,
          "notes": {"address": "Razorpay Corporate Office"},
          // "theme": {"color": "#3399cc"}
        };

        try {
          _razorpay.open(options);
        } catch (e) {
          debugPrint('Error: e');
        }
      } else {
        showMessage(result['message']);
      }
    } else {
      showMessage("Failed to initiate payment");
    }
  }

  showMessage(message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    fetchPaymentStatus();
  }

  void fetchPaymentStatus() async {
    showLoading("Loading...");
    var result = await checkoutRepo!.checkPaymentAndCreateOrder(paymentToken);
    if (result['error'] == false) {
      duration.value = 60;
      _timer = Timer.periodic(
          Duration(seconds: 1), (Timer t) => checkPaymentIsCompleted());
    } else {
      hideLoading();
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void checkPaymentIsCompleted() async {
    if (duration.value > 0) {
      duration.value--;
      if (isReload.value == false) {
        isReload.value = true;
        var result = await checkoutRepo!.checkBookingIsConfirmed(paymentToken);
        if (result != null) {
          if (result['error'] == false) {
            _timer?.cancel();
            hideLoading();
            _countController.cartCount.value = 0;
            Get.offAndToNamed('/orderConfirmation', arguments: {
              "token": paymentToken,
              "orderId": result['orderId']
            });
            isReload.value = false;
          } else {
            isReload.value = false;
          }
        }
      }
    } else {
      hideLoading();
      _timer?.cancel();
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // updatePaymentByResponse();
    // ScaffoldMessenger.of(Get.context!).showSnackBar(
    //   SnackBar(
    //     duration: Duration(seconds: 10),
    //     content: Text(
    //         'Code: ${response.code}, Message: ${response.message}, error:${response.error}'),
    //     behavior: SnackBarBehavior.floating,
    //   ),
    // );
  }

  cartCheckoutInput() {
    List<Map<String, dynamic>> lineItems = productCart.map((product) {
      String variantId = product.skuId;
      int quantity = product.qty;
      return {
        'quantity': quantity,
        'variantId': variantId,
      };
    }).toList();
    var input = {
      "allowPartialAddresses": true,
      "buyerIdentity": {"countryCode": "IN"},
      "email": userProfile.emailId,
      "lineItems": lineItems,
      // "shippingAddress": {
      //   "address1": userProfile.defaultAddress.address,
      //   "address2": userProfile.defaultAddress.address2,
      //   "city": userProfile.defaultAddress.city,
      //   "company": userProfile.defaultAddress.company,
      //   "country": userProfile.defaultAddress.country,
      //   "firstName": userProfile.defaultAddress.firstName,
      //   "lastName": userProfile.defaultAddress.lastName,
      //   "phone": userProfile.defaultAddress.phone,
      //   "province": userProfile.defaultAddress.province,
      //   "zip": userProfile.defaultAddress.zip,
      // }
    };
    if (userProfile.defaultAddress != null) {
      var shippingAddress = {};
      if (userProfile.defaultAddress.address != null)
        shippingAddress["address1"] = userProfile.defaultAddress.address;
      if (userProfile.defaultAddress.address2 != null)
        shippingAddress["address2"] = userProfile.defaultAddress.address2;
      if (userProfile.defaultAddress.city != null)
        shippingAddress["city"] = userProfile.defaultAddress.city;
      if (userProfile.defaultAddress.company != null)
        shippingAddress["company"] = userProfile.defaultAddress.company;
      if (userProfile.defaultAddress.country != null)
        shippingAddress["country"] = userProfile.defaultAddress.country;
      if (userProfile.defaultAddress.firstName != null)
        shippingAddress["firstName"] = userProfile.defaultAddress.firstName;
      if (userProfile.defaultAddress.lastName != null)
        shippingAddress["lastName"] = userProfile.defaultAddress.lastName;
      if (userProfile.defaultAddress.phone != null)
        shippingAddress["phone"] = userProfile.defaultAddress.phone;
      if (userProfile.defaultAddress.province != null)
        shippingAddress["province"] = userProfile.defaultAddress.province;
      if (userProfile.defaultAddress.zip != null)
        shippingAddress["zip"] = userProfile.defaultAddress.zip;
      input["shippingAddress"] = shippingAddress;
    }
    return input;
  }

  onSearchProduct(value) async {
    var results =
        await Get.toNamed('/searchPage', arguments: {"search": value});
  }

  Future getRelatedProduct(productId) async {
    // isLoading.value = true;
    var productIdentifiers = themeController.productBadge != null
        ? [themeController.productBadge]
        : [];
    var result = await relatedProductRepo!
        .getRelatedProducts(productId, productIdentifiers);
    // print("relatedProduct result ------>>>>>>>>>>>>${result.toJson()}");
    var response = relatedProductFromJson(result);
    if (response != null && response.length > 4) {
      relatedProduct.value = response.sublist(0, 4);
    } else {
      relatedProduct.value = response;
    }
    if (relatedProduct.value.isNotEmpty)
      await assignNectorReviews(relatedProduct.value);
    // isLoading.value = false;
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

  Future<void> userAnalysis() async {
    userId = GetStorage().read('utoken');

    if (userId != null) {
      await Get.toNamed('/wishlist');
      // getAllWishListValidation();
    } else {
      Get.toNamed('/login', arguments: {"path": "/wishlist"});
    }
  }

  getWishListonClick(productId) {
    return commonWishlistController.checkProductIsInWishlist(productId);
  }

  Future openApplyCoupen() async {
    var result = await Get.toNamed('/applyCoupon');
    if (result == true) getCartPriceDetails();
  }

  Future getCartPriceDetails() async {
    showLoading("Loading...");
    var summary = await cartRepo!.getCartProducPricetSummaryByUser(cartId);
    if (summary != null) {
      var summaryResponse = cartSummaryFromJson(summary);
      totalCartPrice.value = summaryResponse;
      getAppliedCoupen();
    }
    hideLoading();
  }

  getAppliedCoupen() {
    var discountCodes = totalCartPrice.value.discountCodes;
    if (discountCodes != null && discountCodes.length > 0) {
      discountCode.value = discountCodes
          .firstWhereOrNull((element) => element.applicable == true);
      var discount = totalCartPrice.value.discountAllocations;
      if (discount != null && discount.length > 0) {
        discountAllocation.value = discount.first;
        double discountAmount = 0;
        for (var data in discount) {
          var amount = double.parse(data.amount ?? '0.0');
          discountAmount += amount;
        }
        discountAllocation.value!.amount = discountAmount.toString();
      }
    } else {
      discountAllocation.value = null;
      discountCode.value = null;
    }
  }

  Future removeDiscount() async {
    var cartId = GetStorage().read("cartId");
    showLoading("Loading...");

    var result = await coupenCodeRepo!.applyDiscountCoupen(cartId, []);
    if (result != null) {
      var cartResult = await cartRepo!.getCartProductByUser(cartId);
      var summary = await cartRepo!.getCartProducPricetSummaryByUser(cartId);
      if (cartResult != null && summary != null) {
        var response = cartProductFromJson(cartResult);
        productCart.value = response;
        var summary = await cartRepo!.getCartProducPricetSummaryByUser(cartId);
        var summaryResponse = cartSummaryFromJson(summary);
        totalCartPrice.value = summaryResponse;
        getAppliedCoupen();
      }
    }
    hideLoading();
  }

  Future addCartToWishList(productId, isExists) async {
    commonWishlistController.checkProductAndAdd(productId);
    if (isExists) {
      showMessage("Product removed from wishlist");
    } else {
      showMessage("Product added to wishlist");
    }
  }

  Future addToWishList(productId) async {
    commonWishlistController.checkProductAndAdd(productId);
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

  toProductDetailPage(productId) async {
    CommonModel product = CommonModel(sId: productId);
    var result = await Get.offAndToNamed('/productDetail', arguments: product);
    getCartProduct();
  }

  openCollectionPage(link) async {
    var splittedLink = link.split('/');
    var collectionId = splittedLink[splittedLink.length - 1];
    var result =
        await Get.toNamed('/collection', arguments: {'id': collectionId});
  }

  @override
  void dispose() {
    // Cancel timer to prevent memory leak
    _timer?.cancel();

    // Dispose Razorpay to release native listeners
    _razorpay.clear();

    // Dispose ScrollController if initialized
    scrollController?.dispose();

    // Clear and close observables
    productCart.clear();
    productCart.close();
    relatedProduct.close();
    cartCollectionProduct.close();
    totalCartPrice.close();
    discountCode.close();
    discountAllocation.close();
    cartSetting.close();
    isLoading.close();
    outOfStock.close();
    wishlistFlag.close();
    selectedDiscount.close();
    selectedDiscountIndex.close();
    template.close();
    isTemplateLoading.close();
    duration.close();
    isReload.close();

    super.dispose();
  }
}
