// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';

import 'package:b2b_graphql_package/modules/cart/cart_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/multi_booking_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b2b_graphql_package/modules/multi_booking/multi_booking_repo.dart';

class MultiBookingController extends GetxController with BaseController {
  MultiBookingRepo? multiBookingRepo;
  CartRepo? cartRepo;
  var products = [].obs;
  var productIds = [];
  var isLoading = false.obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  var quantity = 0.obs;
  var totalQuantity = 0.obs;
  var totalAmount = (0.0).obs;
  var variantControllers = [].obs;
  final themeController = Get.find<ThemeController>();
  List<Map<String, dynamic>> appliedQuantities = [];
  var pageId;

  @override
  void onInit() {
    multiBookingRepo = MultiBookingRepo();
    cartRepo = CartRepo();
    var args = Get.arguments;
    productIds = args['productIds'];
    pageId = args['pageId'];
    getTemplate();
    getMultiBookingProducts();
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == pageId);
    isTemplateLoading.value = false;
  }

  Future getMultiBookingProducts() async {
    isLoading.value = true;
    var result = await multiBookingRepo!.getMultiBookingProducts(productIds);
    isLoading.value = false;
    if (result != null) {
      var response = multiBookingProductsVMFromJson(result);
      products.value = response;
    }
  }

  removeProduct(index) {
    productIds.removeAt(index);
    getMultiBookingProducts();
  }

  onChangeQuantity(value) {
    if (value != null && value.isNotEmpty) {
      quantity.value = int.parse(value);
      calculateTotals();
    } else {
      quantity.value = 0;
      totalQuantity.value = 0;
      totalAmount.value = 0;
    }
  }

  void calculateTotals() {
    int enteredPacks = quantity.value;

    for (MultiBookingProductVM product in products) {
      int productQuantity = 0;
      double productAmount = 0.0;
      var priceDisplayType = product.priceDisplayType;

      // PACK NON-CUSTOMIZABLE
      if (product.type == 'pack' && !(product.isCustomizable ?? false)) {
        int unitCount = product.packQuantity!.totalQuantity ?? 1;
        productQuantity = enteredPacks * unitCount;
        double price = priceDisplayType == 'mrp'
            ? double.tryParse(product.price!.mrp?.toString() ?? '0') ?? 0
            : double.tryParse(product.price!.sellingPrice?.toString() ?? '0') ??
                0;
        productAmount = productQuantity * price;
        appliedQuantities.add({
          'productId': product.id,
          'quantity': enteredPacks,
        });

        // SET NON-CUSTOMIZABLE
      } else if (product.type == 'set' && !(product.isCustomizable ?? false)) {
        int unitCount = product.setQuantity!.totalQuantity ?? 1;
        productQuantity = enteredPacks * unitCount;
        double price = priceDisplayType == 'mrp'
            ? double.tryParse(product.price!.mrp.toString()) ?? 0
            : double.tryParse(product.price!.sellingPrice.toString()) ?? 0;
        productAmount = productQuantity * price;
        appliedQuantities.add({
          'productId': product.id,
          'quantity': enteredPacks,
        });

        // SET CUSTOMIZABLE
      } else if (product.type == 'set' && (product.isCustomizable ?? false)) {
        List<dynamic> variants = product.variants ?? [];
        List<Map<String, dynamic>> variantList = [];

        for (var variant in variants) {
          int qty = enteredPacks;
          double price = priceDisplayType == 'mrp'
              ? double.tryParse(variant.price!.mrp.toString()) ?? 0
              : double.tryParse(variant.price.sellingPrice.toString()) ?? 0;
          productQuantity += qty;
          productAmount += qty * price;

          variantList.add({
            'variantId': variant.variantId,
            'quantity': qty,
          });
        }

        appliedQuantities.add({
          'productId': product.id,
          'variants': variantList,
        });

        // PACK CUSTOMIZABLE
      } else if (product.type == 'pack' && (product.isCustomizable ?? false)) {
        List<Map<String, dynamic>> variantList = [];

        for (var variant in (product.packVariant ?? [])) {
          var setId = variant.setId;
          List<dynamic> options = variant.variantOptions ?? [];

          for (var opt in options) {
            int qty = enteredPacks;
            double price = priceDisplayType == 'mrp'
                ? double.tryParse(opt.mrp.toString()) ?? 0
                : double.tryParse(opt.sellingPrice.toString()) ?? 0;
            productQuantity += qty;
            productAmount += qty * price;

            variantList.add({
              'setId': setId,
              'variantId': opt.variantId,
              'quantity': qty,
            });
          }
        }

        appliedQuantities.add({
          'productId': product.id,
          'variants': variantList,
        });
      }

      totalQuantity.value += productQuantity;
      totalAmount.value += productAmount;
    }
  }

  onSubmit() async {
    if (quantity > 0) {
      showLoading("Loading...");
      await multiBookingRepo!.createTempBooking(jsonEncode(appliedQuantities));
      hideLoading();
      Get.toNamed('/bookingSummary', arguments: {});
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text("Please add quantity"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  onAddToCartSameQuantity() async {
    if (quantity > 0) {
      showLoading("Loading...");
      await cartRepo!.addBulkProductToCart(appliedQuantities);
      hideLoading();
      Get.toNamed('/cart');
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text("Please add quantity"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  getVariantController(product, setId, variantId) {
    int index = -1;
    if (product.type == 'product') {
      index = variantControllers.value
          .indexWhere((element) => element['productId'] == product.id);
    } else if (product.type == 'set' && product.isCustomizable == true) {
      index = variantControllers.value.indexWhere((element) =>
          element['variantId'] == variantId &&
          element['productId'] == product.id);
    } else if (product.type == 'set' && product.isCustomizable == false) {
      index = variantControllers.value
          .indexWhere((element) => element['productId'] == product.id);
    } else if (product.type == 'pack' && product.isCustomizable == false) {
      index = variantControllers.value
          .indexWhere((element) => element['productId'] == product.id);
    } else if (product.type == 'pack' && product.isCustomizable == true) {
      index = variantControllers.value.indexWhere((element) =>
          element['variantId'] == variantId &&
          element['setId'] == setId &&
          element['productId'] == product.id);
    }

    if (index != -1) {
      return variantControllers.value[index]['controller'];
    } else {
      var controller = TextEditingController(text: '0');
      variantControllers.value.add({
        'variantId': variantId,
        "productId": product.id,
        "setId": setId,
        "controller": controller
      });
      return controller;
    }
  }

  void addProductQuantity(product) {
    var productId = product.id;
    int index = variantControllers
        .indexWhere((element) => element['productId'] == productId);
    if (index != -1) {
      var value = num.parse(
              (variantControllers[index]['controller'].text ?? '0')
                  .toString()) +
          1;
      variantControllers[index]['controller'].text = value.toString();
    } else {
      variantControllers.add({
        "productId": productId,
        "controller": TextEditingController(text: '1')
      });
    }
    variantControllers.refresh();
  }

  void minusProductQuantity(product) {
    var productId = product.id;
    int index = variantControllers
        .indexWhere((element) => element['productId'] == productId);

    if (index != -1) {
      var value = num.parse(
              (variantControllers[index]['controller'].text ?? '0')
                  .toString()) -
          1;
      if (value >= 0) {
        variantControllers[index]['controller'].text = value.toString();
      }
    }
    variantControllers.refresh();
  }

  onSubmitDifferentQuantity() async {
    var isValid = validateDifferentQuantity();
    if (isValid == true) {
      showLoading("Loading...");
      var quantity = differentQuantityInput();
      await multiBookingRepo!.createTempBooking(jsonEncode(quantity));
      hideLoading();
      Get.toNamed('/bookingSummary', arguments: {});
    }
  }

  onSubmitAddToCart() async {
    var isValid = validateDifferentQuantity();
    if (isValid == true) {
      showLoading("Loading...");
      var quantity = differentQuantityInput();
      await cartRepo!.addBulkProductToCart(quantity);
      hideLoading();
      Get.toNamed('/cart');
    }
  }

  differentQuantityInput() {
    var input = [];
    for (MultiBookingProductVM product in products.value) {
      if ((product.type == 'set' && product.isCustomizable == false) ||
          (product.type == 'pack' && product.isCustomizable == false)) {
        var controller = getVariantController(product, null, null);
        var value = controller.text.isEmpty ? '0' : controller.text;
        var quantity = int.parse(value);
        if (quantity > 0)
          input.add({'productId': product.id, "quantity": quantity});
      } else if ((product.type == 'set' && product.isCustomizable == true)) {
        var variantsInput = [];
        for (var variant in product.variants!) {
          var controller =
              getVariantController(product, null, variant.variantId);
          var value = controller.text.isEmpty ? '0' : controller.text;
          var quantity = int.parse(value);
          if (quantity > 0)
            variantsInput
                .add({'variantId': variant.variantId, "quantity": quantity});
        }
        input.add({'productId': product.id, "variants": variantsInput});
      } else if ((product.type == 'pack' && product.isCustomizable == true)) {
        var variantsInput = [];
        for (var set in product.packVariant!) {
          for (var variant in set.variantOptions!) {
            var controller =
                getVariantController(product, set.setId, variant.variantId);
            var value = controller.text.isEmpty ? '0' : controller.text;
            var quantity = int.parse(value);
            if (quantity > 0)
              variantsInput.add({
                'variantId': variant.variantId,
                "setId": set.setId,
                "quantity": quantity
              });
          }
        }
        input.add({'productId': product.id, "variants": variantsInput});
      }
    }
    return input;
  }

  validateDifferentQuantity() {
    for (MultiBookingProductVM product in products.value) {
      if ((product.type == 'set' && product.isCustomizable == false) ||
          (product.type == 'pack' && product.isCustomizable == false)) {
        var controller = getVariantController(product, null, null);
        if (controller.text.isEmpty) {
          showMessage(
              "The minimum order quantity for '${product.productName}' is ${product.moq}. You have selected 0");
          return false;
        } else {
          var value = int.parse(controller.text);
          if (value < product.moq!) {
            showMessage(
                "The minimum order quantity for '${product.productName}' is ${product.moq}. You have selected ${value}");
            return false;
          }
        }
      } else if ((product.type == 'set' && product.isCustomizable == true) ||
          (product.type == 'pack' && product.isCustomizable == true)) {
        var totalQuantity = getTotalQuantityForProduct(product.id);
        if (totalQuantity < product.moq!) {
          showMessage(
              "The minimum order quantity for '${product.productName}' is ${product.moq}. You have selected ${totalQuantity}");
          return false;
        }
      }
    }
    return true;
  }

  int getTotalQuantityForProduct(productId) {
    int total = 0;
    for (var item in variantControllers.value) {
      if (item['productId'] == productId) {
        int quantity = int.tryParse(item['controller'].text) ?? 0;
        total += quantity;
      }
    }
    return total;
  }

  calculateTotalPrice() {
    var currentTotal = 0.0;
    var currentQuantity = 0;
    for (MultiBookingProductVM product in products.value) {
      var priceDisplayType = product.priceDisplayType;
      if ((product.type == 'set' && product.isCustomizable == false) ||
          (product.type == 'pack' && product.isCustomizable == false)) {
        var controller = getVariantController(product, null, null);
        var value = controller.text.isEmpty ? '0' : controller.text;
        var quantity = int.parse(value);
        if (quantity > 0) {
          double price = priceDisplayType == 'mrp'
              ? double.tryParse(product.price!.mrp?.toString() ?? '0') ?? 0
              : double.tryParse(
                      product.price!.sellingPrice?.toString() ?? '0') ??
                  0;
          currentQuantity += quantity;
          currentTotal += quantity * price;
        }
      } else if ((product.type == 'set' && product.isCustomizable == true)) {
        for (var variant in product.variants!) {
          var controller =
              getVariantController(product, null, variant.variantId);
          var value = controller.text.isEmpty ? '0' : controller.text;
          var quantity = int.parse(value);
          if (quantity > 0) {
            double price = priceDisplayType == 'mrp'
                ? double.tryParse(variant.price!.mrp?.toString() ?? '0') ?? 0
                : double.tryParse(
                        variant.price!.sellingPrice?.toString() ?? '0') ??
                    0;
            currentQuantity += quantity;
            currentTotal += quantity * price;
          }
        }
      } else if ((product.type == 'pack' && product.isCustomizable == true)) {
        for (var set in product.packVariant!) {
          for (var variant in set.variantOptions!) {
            var controller =
                getVariantController(product, set.setId, variant.variantId);
            var value = controller.text.isEmpty ? '0' : controller.text;
            var quantity = int.parse(value);
            if (quantity > 0) {
              double price = priceDisplayType == 'mrp'
                  ? double.tryParse(variant.mrp?.toString() ?? '0') ?? 0
                  : double.tryParse(variant.sellingPrice?.toString() ?? '0') ??
                      0;
              currentQuantity += quantity;
              currentTotal += quantity * price;
            }
          }
        }
      }
    }
    totalQuantity.value = currentQuantity;
    totalAmount.value = currentTotal;
  }

  String getProductTotalPrice(product) {
    var priceDisplayType = product.priceDisplayType;
    double price = priceDisplayType == 'mrp'
        ? double.tryParse(product.price!.mrp?.toString() ?? '0') ?? 0
        : double.tryParse(product.price!.sellingPrice?.toString() ?? '0') ?? 0;
    var totalPrice = 0.0;
    for (var item in variantControllers.value) {
      if (item['productId'] == product.id) {
        int quantity = int.tryParse(item['controller'].text) ?? 0;
        totalPrice += price * quantity;
      }
    }
    return totalPrice.toString();
  }

  showMessage(message) {
    Get.snackbar(
      'Minimum Quantity Required',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      margin: EdgeInsets.all(16),
    );
  }
}
