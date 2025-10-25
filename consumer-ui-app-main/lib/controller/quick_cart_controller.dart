// ignore_for_file: unnecessary_null_comparison, unused_local_variable, avoid_init_to_null, invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/cart/cart_repo.dart';
import 'package:b2b_graphql_package/modules/trigger/trigger_repo.dart';
import 'package:black_locust/controller/cart_count_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/collection_model.dart';
import 'package:black_locust/model/related_product_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../helper/common_helper.dart';
import 'base_controller.dart';

class QuickCartController extends GetxController with BaseController {
  CartRepo? cartRepo;
  TriggerRepo? triggerRepo;
  var selectedProductVariants = [].obs;
  var productVariants = [].obs;
  var isAvailable = true.obs;
  var quantity = 1.obs;
  final _countController = Get.find<CartCountController>();
  final themeController = Get.find<ThemeController>();
  var arguments;
  @override
  void onInit() {
    cartRepo = CartRepo();
    triggerRepo = TriggerRepo();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
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
              var isAvailable = product.variants.any((el) =>
                  el.title!.split(' / ').contains(da.name) &&
                  el.availableForSale);
              var sizeList = new RelatedProductSizeOptions(
                  name: da.name, isAvailable: isAvailable);
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

  Future productAddToCart(product) async {
    var userId = GetStorage().read('utoken');
    var isAllowCart = themeController.isAllowCartBeforLogin();
    if (userId != null || isAllowCart) {
      var selectedVariantId = getSelectedProductVariant(product);
      if (selectedVariantId != null) {
        if (isAvailable.value == true) {
          var productInput = getSelectedProduct(selectedVariantId);
          var cartId = await getCartId();
          var cartExpiry = GetStorage().read("cartExpiry");
          showLoading("Loading...");
          var input = {"selectedProduct": productInput, "cartId": cartId};
          var result = await cartRepo!.addProductToCart(input);
          hideLoading();
          if (result != null) {
            Get.back(result: true);
            await triggerRepo!.createTrigger('abandoned-cart');
            CommonHelper.showSnackBarAddToBag("Successfully moved to bag ");
            _countController.getCartCount();
          }
        } else {
          CommonHelper.showSnackBarAddToBag(
              'Selected variant is currently unavilable');
        }
      } else {
        var context = Get.context!;
        CommonHelper.showSnackBarAddToBag("Please select the variant");
      }
      hideLoading();
    } else {
      var path = Get.currentRoute;
      var homePagesRoutes = ['/wishlistLoginMessage', '/cartLoginMessage'];
      var redirectPath = homePagesRoutes.contains(path) ? '/home' : path;
      var isMessage = themeController.isCartMessage();
      if (isMessage) {
        var result = await Get.toNamed('/cartLoginMessage',
            arguments: {"path": redirectPath, "arguments": arguments});
        if (result != null) {
          userId = GetStorage().read('utoken');
        }
      } else {
        var result = await Get.toNamed('/login',
            arguments: {"path": redirectPath, "arguments": arguments});
        if (result != null) {
          userId = GetStorage().read('utoken');
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

  getSelectedProduct(selectedVariantId) {
    if (selectedVariantId != null) {
      var request = {
        "quantity": quantity.value,
        "merchandiseId": selectedVariantId,
      };
      return request;
    } else {
      return null;
    }
  }

  getProductVaraiants(productVariants) {
    selectedProductVariants.value = [];
    isAvailable.value = true;
    quantity.value = 1;
    arguments = Get.arguments;
    productVariants.forEach((element) {
      var values = element.values;
      var variant;
      if (values != null && values.length == 1) {
        variant = {"type": element.name, "value": values.first.name};
      } else {
        variant = {"type": element.name, "value": null};
      }
      selectedProductVariants.add(variant);
    });
  }

  String? getSelectedProductVariant(product) {
    if (selectedProductVariants.value.length > 0) {
      bool isVariantSelected = selectedProductVariants.value
          .every((element) => element['value'] != null);
      if (isVariantSelected) {
        var selectedValues = selectedProductVariants.value
            .map((element) => element['value'])
            .toList();
        var skuIdss = product.variants;
        var selectedFieldValue;
        bool isVariant;
        for (var element in skuIdss!) {
          selectedFieldValue = element.title!.split(' / ');
          isVariant = selectedValues
              .every((element) => selectedFieldValue.contains(element));
          if (isVariant) {
            return element.sId;
          }
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
    return null;
  }

  getProductByVariant(type, value, product) {
    var variantIndex = selectedProductVariants.value
        .indexWhere((element) => element['type'] == type);
    selectedProductVariants.value[variantIndex]['value'] = value;
    selectedProductVariants.refresh();
    getAvailabelVariants(type, value, product);
  }

  Future getAvailabelVariants(type, value, product) async {
    productVariants.value = cartProductFromJson(product.options);
    var skuIds = product.variants;
    dynamic newVariants = [];
    var variantFieldValue = [];
    skuIds!.forEach((element) {
      var variantOptions = element.title!.split(' / ');
      var isContainsVariant = variantOptions.contains(value);
      if (isContainsVariant) {
        variantOptions.forEach((variant) {
          if (variant != value) {
            product.options.forEach((options) {
              if (options.name != type) {
                var availableVariant =
                    options.values!.firstWhere((da) => da.name == variant);
                if (availableVariant != null) {
                  var isExists = variantFieldValue.length > 0
                      ? variantFieldValue
                          .firstWhere((da) => da['type'] == options.name)
                      : null;

                  if (isExists != null) {
                    int existingVariant = variantFieldValue
                        .indexWhere((da) => da['type'] == options.name);

                    var existFieldValue = isExists['fieldValue']
                        .any((da) => da.name == availableVariant.name);
                    if (existFieldValue == false) {
                      variantFieldValue[existingVariant]['fieldValue']
                          .add(availableVariant);
                    }
                  } else {
                    variantFieldValue.add({
                      "type": options.name,
                      "fieldValue": [availableVariant]
                    });
                  }
                }
              }
            });
          }
        });
      }
    });

    variantFieldValue.forEach((element) {
      int existingIndex = productVariants.indexWhere(
          (existingVariant) => existingVariant.name == element['type']);
      if (existingIndex != null) {
        var existFieldValues = productVariants.firstWhere(
            (da) => da?.name == element['type'],
            orElse: () => null);
        if (existFieldValues != null) {
          productVariants.value[existingIndex].values =
              element["fieldValue"].cast<CartOptionsValue>();
          productVariants.refresh();
        }
      }
      var selectedSkuId = getSelectedProductVariant(product);
      if (selectedSkuId != null) {
        var skuIds = product.variants;
        var sku = skuIds!.firstWhere((element) => element.sId == selectedSkuId);
        if (sku.availableForSale == false) {
          isAvailable.value = false;
          CommonHelper.showSnackBarAddToBag(
              'Selected variant is currently unavilable');
        } else {
          isAvailable.value = true;
        }
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
