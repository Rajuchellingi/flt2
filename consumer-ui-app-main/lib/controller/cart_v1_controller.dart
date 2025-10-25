// ignore_for_file: invalid_use_of_protected_member, unused_local_variable, unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';

import 'package:b2b_graphql_package/modules/cart/cart_repo.dart';
import 'package:b2b_graphql_package/modules/checkout/checkout_repo.dart';
import 'package:b2b_graphql_package/modules/trigger/trigger_repo.dart';
import 'package:black_locust/common_component/enquiry_popup.dart';
import 'package:black_locust/common_component/wishlist_popup.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/cart_count_controller.dart';
import 'package:black_locust/controller/order_setting_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/cart_v1_model.dart';
import 'package:black_locust/model/checkout_v1_model.dart';
import 'package:black_locust/services/common_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartV1Controller extends GetxController with BaseController {
  final ScrollController scrollController = new ScrollController();
  final _orderSettingController = Get.find<OrderSettingController>();

  CheckoutRepo? checkoutRepo;
  CartRepo? cartRepo;
  TriggerRepo? triggerRepo;
  var newData = [];
  bool allLoaded = false;
  var loading = false.obs;
  var productListPopup = [].obs;
  var relatedProducts = [].obs;
  var productList = [].obs;
  var pageIndex = 1;
  var isLoading = false.obs;
  var isProgress = false.obs;
  var totlSummary = new CartProductPriceSummary(
          discount: null,
          subTotal: null,
          total: null,
          totalCartQuantity: null,
          currencySymbol: null)
      .obs;
  var newQuantityIncrease;
  Timer? _timer;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  var isDownloadQuotation = false.obs;
  var isInvoiceDownload = false.obs;
  var summary = "".obs;
  var quotationDownloadText = "".obs;
  var invoiceDownloadText = "".obs;
  TextEditingController? summaryController;
  var duration = 60.obs;
  var isReload = false.obs;
  final _cController = Get.find<CartCountController>();
  var address = [].obs;
  var selectedAddress = new CheckoutAddressVM(
          sId: null,
          city: null,
          country: null,
          contactName: null,
          emailId: null,
          mobileNumber: null,
          address: null,
          landmark: null,
          pinCode: null,
          state: null,
          shippingAddress: null,
          billingAddress: null)
      .obs;
  final themeController = Get.find<ThemeController>();
  @override
  void onInit() {
    summaryController = TextEditingController(text: '');
    cartRepo = CartRepo();
    checkoutRepo = CheckoutRepo();
    triggerRepo = TriggerRepo();
    // filterId = Get.arguments;
    // print("Hello--->>>1111 ${filterId}");
    // catProducts();
    initialLoad();
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels >=
    //           scrollController.position.maxScrollExtent &&
    //       !loading.value) {
    //     paginationFetch();
    //   }
    // });
    getTemplate();
    super.onInit();
  }

  Future initialLoad() async {
    this.isLoading.value = true;
    await Future.wait([catProducts()]);

    this.isLoading.value = false;
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'cart');
    checkQuotationIsExists();
    isTemplateLoading.value = false;
  }

  checkQuotationIsExists() {
    if (template.value != null && template.value.isNotEmpty) {
      if (template.value['layout'] != null &&
          template.value['layout']['blocks'] != null &&
          template.value['layout']['blocks'].isNotEmpty) {
        for (var item in template.value['layout']['blocks']) {
          if (item['componentId'] == "price-details") {
            if (item['source'] != null && item['source'] != null) {
              isDownloadQuotation.value =
                  item['source']['quotationDownload'] == true;
              quotationDownloadText.value = item['source']
                      ['quotationDownloadText'] ??
                  'Download Quotation';
              isInvoiceDownload.value =
                  item['source']['invoiceDownload'] == true;
              invoiceDownloadText.value =
                  item['source']['invoiceDownloadText'] ?? 'Download Invoice';
            }
          }
        }
      }
    }
  }

  Future<Null> refreshPage() async {
    isLoading.value = true;
    allLoaded = false;
    productList.value = [];
    pageIndex = 1;
    await Future.wait([catProducts()]);
    if (newData.isNotEmpty) {
      productList.addAll(newData);
      productList.refresh();
      pageIndex += 1;
    }
    isLoading.value = false;
  }

  Future reloadData() async {
    isProgress.value = true;
    await Future.wait([catProducts()]);
    isProgress.value = false;
  }

  paginationFetch() async {
    // print("allLoaded -->>> ${allLoaded}");
    if (allLoaded == false) {
      return;
    }
    loading.value = true;
    await Future.wait([catProducts()]);

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

  Future catProducts() async {
    var userId = "";
    var result = await cartRepo!.getCart(userId);
    if (result != null) {
      // await categoryPackWithSetRepo!.getProduct(id, isDefault, variants);
      var response = cartFromJson(result);
      productList.value = response.products;
      relatedProducts.value = response.relatedProducts;
      totlSummary.value = response.orderSummary!;
    } else {
      newData = [];
      totlSummary.value = new CartProductPriceSummary(
          discount: null,
          subTotal: null,
          total: null,
          totalCartQuantity: null,
          currencySymbol: null);
    }
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

  void updateProductQuantityReduce(productId, variantId, newQuantity, product) {
    // print("quantity quantityAdd $newQuantity");

    if (newQuantity != null) {
      newQuantityIncrease = newQuantity - 1;
      this.newQuantityIncrease = newQuantityIncrease;
      // this.newQuantityIncrease.refresh();
      // print("newQuantityIncrease newQuantityIncrease $newQuantityIncrease");
      var data = (product.sTypename == "pack" &&
              product.isCustomizable == true &&
              product.setIsCustomizable == false)
          ? {
              "cartId": productId,
              "setId": product.setId,
              "quantity": newQuantityIncrease,
            }
          : {
              "cartId": productId,
              "variantId": variantId,
              "quantity": newQuantityIncrease,
            };
      updateProductVariantQuantity(data);
      // reloadData();
    }
  }

  void updateProductQuantityAdd(productId, variantId, newQuantity, product) {
    if (newQuantity != null) {
      newQuantityIncrease = newQuantity + 1;
      this.newQuantityIncrease = newQuantityIncrease;
      // this.newQuantityIncrease.refresh();
      var data = (product.sTypename == "pack" &&
              product.isCustomizable == true &&
              product.setIsCustomizable == false)
          ? {
              "cartId": productId,
              "setId": product.setId,
              "quantity": newQuantityIncrease,
            }
          : {
              "cartId": productId,
              "variantId": variantId,
              "quantity": newQuantityIncrease,
            };
      updateProductVariantQuantity(data);
      // reloadData();
    }
  }

  quantityMinus(quantity, productId) {
    // if (quantity != null && quantity > this.productList.value.moq) {
    //   this.product.value.quantity = quantity - 1;
    //   this.product.refresh();
    // }
    // updateNewQuantity();
    // return this.product.value.quantity;
  }

  quantityAdd(quantity, productId) {
    // if (quantity != null) {
    //   this.product.value.quantity = quantity + 1;
    //   this.product.refresh();
    // }
    // updateNewQuantity();
    // return this.product.value.quantity;
  }

  void updateNewQuantity() {
    // newQuantity.value = {
    //   "quantityValue": product.value.quantity!,
    //   "id": product.value.sId,
    // };
    // print("New Quantity: $newQuantity");
  }
  void updateProductQuantityWithInput(productId, varientId, variantqty, setId) {
    var data = {
      "cartId": productId,
      "quantity": variantqty,
      "variantId": varientId,
      "setId": setId,
    };
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 500), () {
      // print('quantity $variantqty');
      updateProductVariantQuantity(data);
    });
  }

  Future updateProductVariantQuantity(data) async {
    // if (data['variantId'] != null) {
    // showLoading("Loading...");
    isProgress.value = true;
    var result = await cartRepo!.updateCartQuantity(data);
    if (result != null) {
      // var data = jsonDecode(result['response']);
      // print("result submitRegistration data $data");
      await reloadData();
      isProgress.value = false;
      // hideLoading();
      snackMessage(result['message']);
    }
    // refreshPage();
    // } else if (result['error'] == true) {
    //   // hideLoading();
    //   snackMessage(result['message']);
    // }
    // }
  }

  void moveToWishlist(productId, setId, product) async {
    var result = await Get.bottomSheet(
      Container(
        height: MediaQuery.of(Get.context!).size.height / 0.1,
        child: WishlistPopup(product: product, productId: product.productId),
      ),
      enterBottomSheetDuration: Duration(milliseconds: 200),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
    if (result != null) {
      removeProduct(product.sId, product.setId);
    }
    // _controller.openWishListPopup(productId, product);
    // catProducts();
    // refreshPage();
  }

  Future removeProduct(productId, setId) async {
    // void removeProduct(productId, setId) {
    var data;
    // if (setId != null) {
    //   data = {
    //     "productId": productId,
    //     "setId": setId,
    //   };
    // } else {
    //   data = {
    //     data = {
    //       "productId": productId,
    //       "setId": null,
    //     },
    //   };
    // }
    data = {
      "productId": productId,
      "setId": setId,
    };
    var result = await cartRepo!.deleteCartQuantity(data);
    if (result['error'] == false) {
      _cController.getCartCount();
      // var data = jsonDecode(result['response']);
      // print("result submitRegistration data $data");
      snackMessage(result['message']);
      await refreshPage();
      if (productList.value.isEmpty)
        await triggerRepo!.cancelTriggerNotification('abandoned-cart');
    } else if (result['error'] == true) {
      snackMessage(result['message']);
    }
  }

  Future addToWishList(productId, product) async {
    var isLoggedIn = GetStorage().read('utoken');
    if (isLoggedIn != null)
      openWishListPopup(productId, product);
    else
      Get.toNamed('/login', arguments: {"path": "/cart"});
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
    if (result != null) reloadData();
  }

  openCheckoutPage(_controller) {
    var orderType = _orderSettingController.orderSetting.value.orderType;
    print("orderType $orderType");
    // if (orderType == 'booking' || orderType == 'booking-and-order')
    if (orderType == 'enquiry') {
      // =================
      // Get.toNamed('/enquityNowPopup');
      Get.dialog(EnquiryNowPopup(type: "cartEnquiry", controller: _controller));
    } else {
      Get.toNamed('/checkout');
    }
  }

  // Future updateSummary() async {
  //   summary.value = summaryController!.text;
  //   print("Summary Updated: ${summary.value}");
  //   var result = await cartRepo!.initiateCartEnquiryByUser(summary.value);
  //   print("updateSummary result-------->>>>> $result");
  //   if (result != null) {
  //     await reloadData();
  //     isProgress.value = false;
  //     snackMessage(result['message']);
  //   }
  // }

  void updateSummary() async {
    showLoading("Loading...");
    var result =
        await cartRepo!.initiateCartEnquiryByUser(summaryController!.text);
    // print("updateSummary result-------->>>>> $result");
    if (result != null) {
      if (result['error'] == false) {
        summary.value = result['token'];
        fetchOrderStatus();
      } else {
        isReload.value = false;
        summary.value = result['message'];
        hideLoading();
      }
    }
  }

  void fetchOrderStatus() {
    _timer =
        Timer.periodic(Duration(seconds: 1), (Timer t) => addConfirmation());
  }

  void addConfirmation() async {
    if (duration.value > 0) {
      duration.value--;
      if (isReload.value == false) {
        isReload.value = true;
        var result = await cartRepo!.checkEnquiryIsConfirmed(summary.value);
        // print("updateSummary result-------->>>>> $result");
        if (result != null) {
          if (result['error'] == false) {
            _timer?.cancel();
            hideLoading();
            // snackMessage(result['message']);
            Get.offAndToNamed('/enquiryConfirmation',
                arguments: {"id": result['_id']});
            isReload.value = false;
          } else {
            isReload.value = false;
            // snackMessage(result['message']);
          }
        }
      }
    } else {
      hideLoading();
      _timer?.cancel();
    }
  }

  Future downloadQuotation() async {
    showLoading("Loading...");
    var result = await cartRepo!.quotationDownloadCart();
    if (result != null) {
      var template = result['template'];
      if (template != null && template.isNotEmpty) {
        var fileName = template.split('/').last;
        await CommonService().downloadFile(fileName, template);
      }
    }
    hideLoading();
  }

//   void openCheckoutPage() {
//   var orderType = Get.find<SummaryController>().summary.value;
//   print("orderType: $orderType");
//   if (orderType == 'enquiry' || orderType == 'booking' || orderType == 'booking-and-order') {
//     Get.dialog(EnquiryNowPopup());
//   }
// }
  Future getAddress() async {
    showLoading("Loading...");
    await getAddressDetails();
    hideLoading();
  }

  Future getAddressDetails() async {
    var result = await checkoutRepo!.getAllAddressByUser();
    if (result != null) {
      address.value = checkoutAddressVMFromJson(result);
      if (address.value.isNotEmpty) {
        selectedAddress.value = address.value
            .firstWhereOrNull((element) => element.shippingAddress == true);
      }
    }
  }

  Future openAddAddress() async {
    var result = await Get.toNamed('/addAddress', arguments: {'type': 'new'});
    if (result != null) {
      showLoading("Loading...");
      await getAddressDetails();
      hideLoading();
    }
  }

  Future changeShippingAddress(addressId) async {
    showLoading("Loading...");
    var result = await checkoutRepo!.changeShippingAddress(addressId);
    if (result != null) {
      await getAddressDetails();
    }
    hideLoading();
  }

  Future openEditAddress(address) async {
    var result = await Get.toNamed('/addAddress',
        arguments: {'type': 'edit', 'address': address});
    if (result != null) {
      showLoading("Loading...");
      await getAddress();
      hideLoading();
    }
  }

  Future changeBillingAddress(addressId) async {
    showLoading("Loading...");
    var result = await checkoutRepo!.changeBillingAddress(addressId);
    if (result != null) {
      await getAddress();
    }
    hideLoading();
  }

  Future invoiceDownloadCart() async {
    showLoading("Loading...");
    var result =
        await cartRepo!.invoiceDownloadCart(jsonEncode(selectedAddress.value));
    hideLoading();
    Get.back();
    if (result != null) {
      await CommonService()
          .downloadFile('cart_invoice.pdf', result['template']);
    }
  }

  String? getQuantityMetaValues(
      metafields, int quantity, Map<String, dynamic>? source) {
    if (quantity == 0 || source == null || source["metaId"] == null) {
      return quantity.toString();
    }

    final metaValues = metafields.firstWhere(
        (e) => e.customDataId == source['metaId'],
        orElse: () => CartMetafieldVM());
    if (metaValues != null &&
        metaValues.reference != null &&
        metaValues.reference['value'] != null) {
      String value = metaValues.reference['value'];

      // Replace # and expressions like #*10, #+5, etc.
      final regex = RegExp(r'#([*/+\-]\d+)?');
      value = value.replaceAllMapped(regex, (match) {
        final matchedText = match.group(0) ?? "#";

        if (matchedText == "#") return quantity.toString();

        final operator = matchedText[1];
        final number = int.tryParse(matchedText.substring(2)) ?? 0;

        switch (operator) {
          case '*':
            return (quantity * number).toString();
          case '+':
            return (quantity + number).toString();
          case '-':
            return (quantity - number).toString();
          case '/':
            return number != 0 ? (quantity / number).toString() : "0";
          default:
            return quantity.toString();
        }
      });
      return value;
    } else {
      return quantity.toString();
    }
  }

  @override
  void onClose() {
    loading.close();
    productListPopup.close();
    relatedProducts.close();
    productList.close();
    isLoading.close();
    isProgress.close();
    totlSummary.close();
    template.close();
    isTemplateLoading.close();
    summary.close();
    duration.close();
    isReload.close();
    super.onClose();
  }
}
