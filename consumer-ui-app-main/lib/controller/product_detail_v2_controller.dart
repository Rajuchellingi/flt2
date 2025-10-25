// ignore_for_file: unnecessary_null_comparison, unused_local_variable, invalid_use_of_protected_member, deprecated_member_use, unused_element

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:b2b_graphql_package/modules/cart/cart_repo.dart';
import 'package:b2b_graphql_package/modules/product_detail/product_detail_repo.dart';
import 'package:b2b_graphql_package/modules/trigger/trigger_repo.dart';
import 'package:black_locust/common_component/enquiry_popup.dart';
import 'package:black_locust/common_component/wishlist_popup.dart';
import 'package:black_locust/controller/cart_count_controller.dart';
import 'package:black_locust/controller/dynamic_form_controller.dart';
import 'package:black_locust/controller/plugins_controller.dart';
import 'package:black_locust/controller/shop_controller.dart';
import 'package:black_locust/controller/site_setting_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/keyboard.dart';
import 'package:b2b_graphql_package/modules/wishlist/wishlist_repo.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:black_locust/model/banner_model.dart';
import 'package:black_locust/model/detail_page_v1_model.dart';
import 'package:black_locust/model/wishlist_model.dart';
import 'package:black_locust/services/common_service.dart';
import 'package:black_locust/view/dynamic_form/components/dynamic_form_bottom_sheet.dart';
import 'package:black_locust/view/product_detail/components/related_products.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

// import 'package:social_share/social_share.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'package:get_storage/get_storage.dart';
import '../config/configConstant.dart';

class ProductDetailV2Controller extends GetxController with BaseController {
  TextEditingController? pinCodeController;
  ScrollController? scrollController;
  WishListRepo? wishListRepo;
  TriggerRepo? triggerRepo;
  CartRepo? cartRepo;
  ProductDetailRepo? productDetailRepo;
  var appbarOpacity = 0.obs;
  var packId;
  var packVariant;
  var similarPack = [].obs;
  var localRecentPack = [].obs;
  var productDetails = Object().obs;
  var relatedProduct = [].obs;
  var allWishlist = [];
  var isSizeChart = false.obs;
  var wishlistFlag = false.obs;
  var isProgress = false.obs;
  List<XFile> imageSharePath = [];
  var selectedVariant = new PackVariant(
          // id: "",
          attributeFieldValueId: '',
          attributeFieldId: '',
          isAssorted: null,
          metafields: [],
          isCustomizable: null,
          labelName: '',
          colorCode: '',
          fieldValue: '',
          setQuantity: null,
          setId: '',
          images: [],
          variantImage: null,
          variantOptions: [],
          sTypename: '')
      .obs;
  var arguments;
  var product = new ProductDetailPage(
          sId: '',
          isAssorted: false,
          isWishlist: false,
          wishlistCollection: [],
          productVariant: [],
          currencySymbol: null,
          showPrice: false,
          showPriceRange: false,
          isMultiple: false,
          imageId: '',
          productId: '',
          name: '',
          description: '',
          catalogUrl: null,
          downloadCatalogButtonName: null,
          downloadCatalogForm: null,
          productCatalog: [],
          showDownloadCatalog: null,
          packVariant: [],
          packQuantity: null,
          moq: 0,
          type: '',
          setQuantity: null,
          variants: [],
          price: null,
          images: [],
          isCustomizable: false,
          preferenceVariant: null,
          quantity: 1,
          sTypename: '',
          offer: null,
          showWishlist: null,
          relatedProducts: [],
          brandName: '',
          discountDisplayType: '',
          metafields: [],
          priceDisplayType: null,
          showAddToCart: null,
          showPriceAfterLogin: null,
          showUnits: null,
          showVariantInList: null,
          showVariantPrice: null,
          showVariantQuantity: null,
          units: '')
      .obs;

  var addedToWishList = false.obs;
  var productPackImage = [].obs;
  var productSize = [];
  var productSizeOption = [];
  var selectedProductVariant = [].obs;
  var currentVariant;
  var cartBagCount = 0.obs;
  var isLoading = false.obs;
  var loadingDonwload = false.obs;
  var toBagButtonText = 'Add To Bag'.obs;
  var selectedPackSizes = [];
  var userId;
  var packDetail;
  var isReturnable = false.obs;
  var isCODByCategory = false.obs;
  var deliverdByDate = "".obs;
  var pinCodeCheckBtnText = 'CHECK'.obs;
  var cashOnDeliveryText = "Cash on delivery might be available".obs;
  var varientCircleSize = 40.0.obs;
  var selectedColorVarient = "".obs;
  var selectedColorVariant = ''.obs;
  var sizesWithQuantities = {}.obs;
  var availableSizes = <String>[].obs;
  var sizeFieldValue = [].obs;
  var attributeFieldValues = [].obs;
  var quantities = {'S': 0, 'M': 0, 'L': 0, 'XL': 0}.obs;
  final List<String> sizes = ['S', 'M', 'L', 'XL'];
  var selectedColorss = ''.obs;
  var selectedSize = ''.obs;
  final storage = GetStorage();
  var newQuantity = {}.obs;
  var setCustoizableInputValue = [].obs;
  var custoizableInputValues = [].obs;
  var relatedProducts = [].obs;
  var variantControllers = [].obs;
  var selectedWishList = [];
  var selectedFilterAttr = [].obs;
  var colloctionListPopup = [].obs;
  final _cController = Get.find<CartCountController>();
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  final dynamicFormController = Get.find<DynamicFormController>();
  var recentlyView = [].obs;
  var duration = 60.obs;
  var isReload = false.obs;
  var summary = "".obs;
  TextEditingController? summaryController;
  Timer? _timer;
  var selectedCatalog = ''.obs;
  final _pluginController = Get.find<PluginsController>();
  final shopifyShopController = Get.find<ShopController>();
  final siteSettingController = Get.find<SiteSettingController>();
  var displayMode = ''.obs;
  var code = ''.obs;
  var shop = ''.obs;
  var totalPrice = 0.0.obs;

  @override
  void onInit() {
    arguments = Get.arguments;
    summaryController = TextEditingController(text: '');
    pinCodeController = TextEditingController();
    scrollController = ScrollController();
    wishListRepo = WishListRepo();
    triggerRepo = TriggerRepo();
    productDetailRepo = ProductDetailRepo();
    cartRepo = CartRepo();
    scrollController!.addListener(_scrollListener);
    userId = GetStorage().read('utoken');
    packDetail = Get.arguments;
    getTemplate();
    getProductDetails(packDetail, true, []);
    super.onInit();
  }

  getSizeChart() {
    var sizeChart = _pluginController.getPluginValue('ri-size-chart-10');
    // isSizeChart.value = sizeChart != null;
    if (sizeChart != null) showSizeChartOpen(sizeChart);
  }

  // Future<void> showSizeChartOpen(sizeChart) async {
  //   print("sizeChart----->>>>>>>>>>>>> ${sizeChart.toJson()}");
  //   print("product.value ----->>>>>>> ${product.value.toJson()}");
  //   var productId = product.value.sId;
  //   var code = sizeChart.code;
  //   var shop = "test.store.rietail.com";
  //   isSizeChart.value = sizeChart.status != null;
  //   print('productId ${productId} code ${code} shop${shop}');
  //   var detailPageUrl =
  //       "https://eiwqak3tpd.execute-api.ap-south-1.amazonaws.com/prod/getIframeSizechartRetailShop?$productId&$code&$shop";
  //   // print("detailPageUrl---->>>>> ${detailPageUrl}");
  //   // openWebView(detailPageUrl);
  // }
  Future<void> showSizeChartOpen(sizeChart) async {
    // print("sizeChart----->>>>>>>>>>>>> ${sizeChart.toJson()}");
    // print("product.value ----->>>>>>> ${product.value.toJson()}");

    var productId = product.value.sId;
    code.value = sizeChart.code;
    shop.value = shopifyShopController.shopDetail.value.shop ?? '';

    var apiUrl =
        "https://eiwqak3tpd.execute-api.ap-south-1.amazonaws.com/prod/getIframeSizechartRetailShop?productId=$productId&code=$code&shop=$shop";

    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        isSizeChart.value = data['sizechart'] != null;
        displayMode.value = data['displayMode'];
      }
    } catch (e) {
      print("API Call Failed: $e");
    }
  }

  Future<Null> refreshLocalGallery() async {
    getProductDetails(packDetail, true, []);
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'products');
    isTemplateLoading.value = false;
  }

  // Future getProductDetails(packDetail, isDefault, List variants) async {
  //   isLoading.value = true;
  //   var result = await productDetailRepo!
  //       .getProductDetail(packDetail.sId, isDefault, variants, '');
  //   var response = productDetailFromVson(result);
  //   product.value = response;
  //   relatedProducts.value = response.relatedProducts;
  //   var images = response.toJson();

  //   mapPackImage(response.images, response.images);
  //   isLoading.value = false;

  //   if (product.value.packVariant != null &&
  //       product.value.packVariant!.isNotEmpty) {
  //     var firstFieldValue = product.value.packVariant![0];
  //     if (firstFieldValue != null) {
  //       selectedColor(firstFieldValue.toJson(), firstFieldValue.images);
  //     }
  //   }
  //   getSizeChart();
  // }

  Future getProductDetails(packDetail, isDefault, List variants) async {
    // print("template.value ------>>>> ${template.value.toString()}");

    var metaBlocks = [];
    var priceChart;

    if (template.value['layout']?['blocks'] != null) {
      for (var block in template.value['layout']['blocks']) {
        if (block['componentId'] == "meta-component") {
          var rawMetaBlocks = block['source']?['layout']?['blocks'] ?? [];
          metaBlocks = rawMetaBlocks.map((meta) {
            return {
              "metaId": meta['metaId'],
              "metaName": meta['metaName'],
            };
          }).toList();
        }
        if (block['componentId'] == "price-chart") {
          priceChart = block;
        }
      }
    }

    // print("packDetail ${packDetail.toJson()}");
    var input = {
      "input": {
        "collectionId": packDetail.sId,
        "productUrl": packDetail.sId,
        // "priceChart": priceChart,
        "priceChart":
            '{"componentId": "price-chart","instanceId": "design1","source": {"title": "", "blocks": []},"visibility": {"hide": true}}',
        "metaData": metaBlocks,
        "titleMetaData": "null"
      }
    };

    isLoading.value = true;
    var result = await productDetailRepo!.getProductDetail(input);
    var response = productDetailFromVson(result);
    product.value = response;
    relatedProducts.value = response.relatedProducts;

    mapPackImage(response.images, response.images);
    isLoading.value = false;

    if (template.value['layout']?['blocks'] != null) {
      for (var block in template.value['layout']['blocks']) {
        if (block['componentId'] == "varaint-selector" &&
            block['instanceId'] == "design7") {
          if (product.value.packVariant != null &&
              product.value.packVariant!.isNotEmpty) {
            for (var variant in product.value.packVariant!) {
              selectedColor(variant.toJson(), variant.images);
            }
          }
        } else {
          if (product.value.packVariant != null &&
              product.value.packVariant!.isNotEmpty) {
            var firstFieldValue = product.value.packVariant![0];
            if (firstFieldValue != null) {
              selectedColor(firstFieldValue.toJson(), firstFieldValue.images);
            }
          }
        }
      }
    }

    getSizeChart();
  }

  triggetProductAction() {
    var google = {
      "name": "view_product",
      "data": {
        "ecommerce": {
          "items": [
            {
              "item_name": product.value.name,
              "item_id": product.value.sId,
              "price": (product.value.price != null &&
                      product.value.price!.sellingPrice != null &&
                      product.value.price!.sellingPrice! > 0)
                  ? product.value.price!.sellingPrice
                  : product.value.price!.mrp
            }
          ]
        }
      }
    };
    var facebook = {
      "name": "ViewContent",
      "data": {
        "content_type": "product",
        "content_id": product.value.sId,
        "content_name": product.value.name,
        "price": (product.value.price != null &&
                product.value.price!.sellingPrice != null &&
                product.value.price!.sellingPrice! > 0)
            ? product.value.price!.sellingPrice
            : product.value.price!.mrp
      }
    };
    var data = {"google": google, "facebook": facebook};
    siteSettingController.trackActions(data);
  }

  Future addProductToWishList(String productId, product) async {
    openWishListPopup(productId, product);
  }

  mapPackImage(packImages, imageId) {
    // print("cllllllllllllllllllllllllllllllllll meeeeeeeeeeeeeeeeeeeeeeee");
    List<ImageSliderVWModel> bannerSliderList = [];
    // print(
    //     "packImages ------------->>>>> ${packImages.map((e) => e.toJson()).toList()}");
    packImages.forEach((element) {
      var imageName = '$productImageUrl' +
          element.imageId +
          '/' +
          "420-560" +
          "/" +
          element.imageName;
      var imageList =
          new ImageSliderVWModel(element.imageId, imageName, '', '', '');
      bannerSliderList.add(imageList);
    });
    productPackImage.value = bannerSliderList;
    // print(
    //     "productPackImage.value imageName ${productPackImage.value[0].imageName}");
    // print("productPackImage.value ${productPackImage.value.map((e) => e.toJson()).toList()}");
  }

  void _scrollListener() {
    if (scrollController!.offset > 510) {
      appbarOpacity.value = 1;
    }
    if (scrollController!.offset < 510) {
      appbarOpacity(0);
    }
  }

  void changeTotalPrice(price, quantity) {
    var value = num.parse(quantity.toString());
    totalPrice.value = (num.parse(price.toString()) * value).toDouble();
  }

  void selectedValue(variantId, value) {
    int index = custoizableInputValues
        .indexWhere((element) => element['variantId'] == variantId);

    if (index != -1) {
      custoizableInputValues[index]['quantity'] = value;
    } else {
      custoizableInputValues.add({"variantId": variantId, "quantity": value});
    }
  }

  void addVariantQuantity(variantId, price) {
    int index = custoizableInputValues
        .indexWhere((element) => element['variantId'] == variantId);
    var controller = getVariantController(variantId);
    if (index != -1) {
      var value = num.parse(
              (custoizableInputValues[index]['quantity'] ?? '0').toString()) +
          1;
      custoizableInputValues[index]['quantity'] = value.toString();
      changeTotalPrice(price, value);
      controller.text = value.toString();
    } else {
      custoizableInputValues.add({"variantId": variantId, "quantity": '1'});
      controller.text = '1';
      changeTotalPrice(price, 1);
    }
  }

  void minusVariantQuantity(variantId, price) {
    int index = custoizableInputValues
        .indexWhere((element) => element['variantId'] == variantId);

    if (index != -1) {
      var controller = getVariantController(variantId);

      var value = num.parse(
              (custoizableInputValues[index]['quantity'] ?? 0).toString()) -
          1;
      if (value >= 0) {
        controller.text = value.toString();
        custoizableInputValues[index]['quantity'] = value.toString();
        changeTotalPrice(price, value);
      }
    }
  }

  getVariantController(variantId) {
    int index = variantControllers.value
        .indexWhere((element) => element['variantId'] == variantId);

    if (index != -1) {
      return variantControllers.value[index]['controller'];
    } else {
      var controller = TextEditingController(text: '');
      variantControllers.value
          .add({'variantId': variantId, "controller": controller});
      return controller;
    }
  }

  Future productAddToCart(context, controller) async {
    var uToken = storage.read('utoken');
    if (uToken != null) {
      KeyboardUtil.hideKeyboard(context);
      var data = {};
      var colorData;
      var inputValue;
      var data2 = [];
      var data3;
      for (var attribute in attributeFieldValues) {
        colorData = {
          "setId": attribute['setId'],
          "isCustomizable": attribute['isCustomizable'],
          'value': attribute['value'],
          'color': attribute['color'],
          'availableSize': []
        };

        for (var size in attribute['availableSize']) {
          inputValue = attribute['inputValues']
              .firstWhere(
                (input) => input['size'] == size['size'],
                orElse: () => null,
              )['value']
              .text;
          colorData['availableSize']
              .add({'variantId': size['variantId'], 'inputValue': inputValue});
        }
        data[attribute['color']] = colorData;
      }
      data2 = [];

      data.forEach((key, value) {
        if (value['isCustomizable'] == true) {
          for (var size in value['availableSize']) {
            if (size['inputValue'] != null && size['inputValue'].isNotEmpty) {
              data2.add({
                "setId": value['setId'],
                "variantId": size['variantId'],
                "quantity": int.parse(size['inputValue'])
              });
            }
          }
        } else if (value['isCustomizable'] == false) {
          data2.add({
            "setId": value['setId'],
            "quantity": int.parse(value['value'].text)
          });
        }
      });
      data3 = {"productId": product.value.sId, "variants": data2};
      if (uToken != null) {
        var data;
        if (product.value.isCustomizable == true &&
            product.value.type == "pack") {
          data = data3;
        } else if (product.value.isCustomizable == true &&
            product.value.type == "set") {
          var setVariant = [];
          custoizableInputValues.forEach((element) {
            if (element['quantity'] != null && element['quantity'].isNotEmpty)
              setVariant.add({
                'variantId': element['variantId'],
                'quantity': int.parse(element['quantity'])
              });
          });
          data = {
            "productId": product.value.sId,
            "variants": setVariant,
          };
        } else if (product.value.type == 'product') {
          if (selectedProductVariant.value.isEmpty ||
              selectedProductVariant.value.length !=
                  product.value.productVariant!.length) {
            data = null;
            CommonHelper.showSnackBarAddToBag("Please select variant");
            return;
          } else {
            data = {
              "productId": product.value.sId,
              "variantId": currentVariant.variantId,
              "quantity": 1
            };
          }
        } else {
          data = {
            "productId": product.value.sId,
            "quantity": product.value.quantity
          };
        }
        if (data != null) {
          isProgress.value = true;
          showLoading("Loading...");
          var result = await cartRepo!.addProductToCart(data);
          hideLoading();
          isProgress.value = false;
          if (result['error'] == false) {
            await triggerRepo!.createTrigger('abandoned-cart');
            // hideLoading();
            // showSnackBarAddToBagDetail(result['message']);
            _cController.getCartCount();
            triggetProductCartAction(data);
            openRelatedProductPopup(result['message'], '', controller);
          } else if (result['error'] == true) {
            CommonHelper.showSnackBarAddToBag(result['message']);
          }
        } else {
          // hideLoading();
          CommonHelper.showSnackBarAddToBag("Please add quantity");
        }
      }
    } else {
      Get.toNamed('/login',
          arguments: {"path": "/productDetail", "arguments": arguments});
    }
  }

  triggetProductCartAction(input) {
    var totalQuantity;
    if (input['variants'] != null && input['variants'].length > 0) {
      totalQuantity = input['variants'].fold(0, (total, variant) {
            return total + (variant['quantity'] ?? 0);
          }) ??
          0;
    } else {
      totalQuantity = input['quantity'] ?? 1;
    }
    var google = {
      "name": "add_to_cart",
      "data": {
        "ecommerce": {
          "items": [
            {
              "item_name": product.value.name,
              "item_id": product.value.sId,
              "price": (product.value.price != null &&
                      product.value.price!.sellingPrice != null &&
                      product.value.price!.sellingPrice! > 0)
                  ? product.value.price!.sellingPrice
                  : product.value.price!.mrp
            }
          ]
        }
      }
    };

    var data = {"google": google};
    siteSettingController.trackActions(data);
  }

  void onSelectVariant(event) {
    var selectedVariant = selectedProductVariant.value;

    if (selectedVariant.isNotEmpty) {
      bool isVariantExists = selectedVariant.any((da) =>
          da['attributeFieldId'] == event['variant']['attributeFieldId']);

      if (isVariantExists) {
        selectedVariant = selectedVariant
            .where((da) =>
                da['attributeFieldId'] != event['variant']['attributeFieldId'])
            .toList();
        selectedVariant.add({
          'attributeFieldId': event['variant']['attributeFieldId'],
          'attributeFieldValueId': event['variantOption']
              ['attributeFieldValueId']
        });
        selectedProductVariant.value = selectedVariant;
        changeVariant(event['variant'], event['variantOption']);
      } else {
        selectedVariant.add({
          'attributeFieldId': event['variant']['attributeFieldId'],
          'attributeFieldValueId': event['variantOption']
              ['attributeFieldValueId']
        });
        selectedProductVariant.value = selectedVariant;
        changeVariant(event['variant'], event['variantOption']);
      }
    } else {
      selectedVariant.add({
        'attributeFieldId': event['variant']['attributeFieldId'],
        'attributeFieldValueId': event['variantOption']['attributeFieldValueId']
      });
      selectedProductVariant.value = selectedVariant;
      changeVariant(event['variant'], event['variantOption']);
    }
  }

  void changeVariant(
      Map<String, dynamic> attribute, Map<String, dynamic> attributeValue) {
    final productVariants = product.value.productVariant ?? [];
    final allVariants = product.value.variants ?? [];

    if (selectedProductVariant.value.length == productVariants.length) {
      List<dynamic> checkVariantExists = allVariants.where((variant) {
        List<dynamic> variantAttributes = variant.attribute ?? [];
        return selectedProductVariant.value.every((attr) {
          return variantAttributes.any((variantAttr) =>
              variantAttr.attributeFieldId == attr['attributeFieldId'] &&
              variantAttr.attributeFieldValueId ==
                  attr['attributeFieldValueId']);
        });
      }).toList();

      if (checkVariantExists.isNotEmpty) {
        currentVariant = checkVariantExists.first;
      }
    } else {
      if (attribute['attributeFieldSetting'] == 'color') {
        List<dynamic> currentVariantData = allVariants.where((variant) {
          List<dynamic> variantAttributes = variant.attribute ?? [];
          return variantAttributes.any((attr) =>
              attr.attributeFieldId == attribute['attributeFieldId'] &&
              attr.attributeFieldValueId ==
                  attributeValue['attributeFieldValueId']);
        }).toList();

        if (currentVariantData.isNotEmpty) {
          currentVariant = currentVariantData.first;
        }
      }
    }
  }

  bool hasVariant(attribute, attributeValue) {
    if (selectedProductVariant.value.isNotEmpty) {
      bool isExistInSelected = selectedProductVariant.value
          .any((da) => da['attributeFieldId'] == attribute.attributeFieldId);

      List<dynamic> currentVariantData =
          product.value.variants!.where((variant) {
        List<dynamic> attrs = variant.attribute ?? [];
        return attrs.any((attr) =>
            attr.attributeFieldId == attribute.attributeFieldId &&
            attr.attributeFieldValueId == attributeValue.attributeFieldValueId);
      }).toList();

      if (!isExistInSelected) {
        List<dynamic> checkVariantExists = currentVariantData.where((variant) {
          List<dynamic> variantAttrs = variant.attribute ?? [];
          return selectedProductVariant.value.every((attr) => variantAttrs.any(
              (variantAttr) =>
                  variantAttr.attributeFieldId == attr['attributeFieldId'] &&
                  variantAttr.attributeFieldValueId ==
                      attr['attributeFieldValueId']));
        }).toList();

        return checkVariantExists.isNotEmpty;
      } else {
        var withoutCurrentVariant = selectedProductVariant.value
            .where((da) => da['attributeFieldId'] != attribute.attributeFieldId)
            .toList();

        List<dynamic> checkVariantExists = currentVariantData.where((variant) {
          var variantAttrs = variant.attribute ?? [];
          return withoutCurrentVariant.every((attr) => variantAttrs.any(
              (variantAttr) =>
                  variantAttr.attributeFieldId == attr['attributeFieldId'] &&
                  variantAttr.attributeFieldValueId ==
                      attr['attributeFieldValueId']));
        }).toList();

        return checkVariantExists.isNotEmpty;
      }
    } else {
      return true;
    }
  }

  bool isVariantSelected(variant, variantValue) {
    if (selectedProductVariant.value.isNotEmpty) {
      return selectedProductVariant.value.any((da) =>
          da['attributeFieldId'] == variant.attributeFieldId &&
          da['attributeFieldValueId'] == variantValue.attributeFieldValueId);
    } else {
      return false;
    }
  }

  Future<void> openRelatedProductPopup(cartStatus, product, controller) async {
    await Get.bottomSheet(
      Container(
        // height: MediaQuery.of(Get.context!).size.height /
        //     2, // Half of screen height
        decoration: BoxDecoration(
          color: Colors.white, // Set the background color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the Row content
                children: [
                  Icon(
                    Icons.check_circle, // Tick icon
                    color: Colors.green,
                  ),
                  SizedBox(width: 8), // Spacing between icon and text
                  Text(
                    cartStatus,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RelatedProductsWidget(controller: controller),
            ),
          ],
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
  }

  static showSnackBarAddToBagDetail(String msg) {
    Get.snackbar("", msg,
        snackPosition: SnackPosition.TOP,
        backgroundColor: kTextColor,
        colorText: Colors.white,
        duration: Duration(milliseconds: 10000),
        maxWidth: SizeConfig.screenWidth,
        borderRadius: 0,
        titleText: Container(),
        snackStyle: SnackStyle.FLOATING,
        padding: EdgeInsets.all(kDefaultPadding / 2),
        margin: EdgeInsets.all(0));
  }

  customQuantityMinus(quantity, sku) {
    if (this.product.value.type == "set") {
      setQuantityMinus(quantity, sku);
    } else if (this.product.value.type == "pack") {
      packQuantityMinus(quantity, sku);
    }
  }

  setQuantityMinus(quantity, sku) {}

  customQuantityAdd(quantity, sku) {
    if (this.product.value.type == "set") {
      setQuantityAdd(quantity, sku);
    } else if (this.product.value.type == "pack") {
      packQuantityAdd(quantity, sku);
    }
  }

  packQuantityAdd(quantity, sku) {}

  packQuantityMinus(quantity, sku) {}

  setQuantityAdd(quantity, sku) {}

  quantityMinus(quantity, productId) {
    if (quantity != null && quantity > this.product.value.moq) {
      this.product.value.quantity = quantity - 1;
      this.product.refresh();
    }
    updateNewQuantity();
    return this.product.value.quantity;
  }

  quantityAdd(quantity, productId) {
    if (quantity != null) {
      this.product.value.quantity = quantity + 1;
      this.product.refresh();
    }
    updateNewQuantity();
    return this.product.value.quantity;
  }

  void updateNewQuantity() {
    newQuantity.value = {
      "quantityValue": product.value.quantity!,
      "id": product.value.sId,
      "type": product.value.type,
      "isCustomizable": product.value.isCustomizable,
    };
    // print("New Quantity: $newQuantity");
  }

  Future openCart() async {
    await Get.toNamed("/cart");
  }

  showSnackBar(String msg, SnackPosition position) {
    Get.snackbar(
      "", msg,
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
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }

  Future addToWishList(productId, product) async {
    var isLoggedIn = GetStorage().read('utoken');
    if (isLoggedIn != null)
      openWishListPopup(productId, product);
    else
      Get.toNamed('/login',
          arguments: {"path": "/productDetail", "arguments": arguments});
  }

  Future<void> shareImageFromUrl() async {
    showLoading('Loading..');
    int index = 0;
    this.imageSharePath = [];
    // await Future.forEach(this.productPackImage, (element) async {
    //   await asyncTwo(element, index);
    //   index = index + 1;
    // });
    if (productPackImage.isNotEmpty) {
      await asyncTwo(productPackImage[0], 0);
    }
    String content =
        '\n <p><strong>${product.value.name!}</strong><p> \n ${product.value.description}';
    hideLoading();
    ShareResult shareResult = await Share.shareXFiles(this.imageSharePath,
        subject: product.value.name,
        text: parse(content).documentElement!.text);
    if (shareResult.status == ShareResultStatus.success) {}
    ShareResultStatus status = shareResult.status;
    // print(shareResult.status.su);
    // result.contains((needle) => print(needle));
  }

  asyncTwo(element, index) async {
    var imageurl = productImageUrl +
        element.id +
        '/' +
        "420-560" +
        "/" +
        element.imageName;
    var imageName = 'image' + index.toString() + '.jpg';
    var uri = Uri.parse(imageurl);
    var response = await http.get(uri);
    var bytes = response.bodyBytes;
    var temp = await getTemporaryDirectory();
    var path = '${temp.path}/' + imageName;
    File(path).writeAsBytesSync(bytes);
    imageSharePath.add(XFile(path));
  }

  // Future downloadProductImage(context) async {
  //   // showLoading('Downloading...');

  //   // loadingDonwload.value = true;
  //   // for (final image in product.value.images!) {
  //   //   await GallerySaver.saveImage(
  //   //           promotionImageBaseUri +
  //   //               product.value.imageId! +
  //   //               '/' +
  //   //               image.imageName!,
  //   //           albumName: product.value.name,
  //   //           toDcim: true)
  //   //       .then((value) => {print('response'), print(value)});
  //   // }
  //   // hideLoading();
  //   // showSnackBar('Download successfully', SnackPosition.TOP);
  // }

  getPackVariants() {}

  void addSizes(List<String> sizesToAdd) {
    availableSizes.assignAll(sizesToAdd);
  }

  void setSelectedColor(String color) {
    selectedColorss.value = color;
  }

  void setSelectedColorVariant(String colorVariant) {
    selectedColorVariant.value = colorVariant;
  }

  void clearSizesWithQuantities() {
    sizesWithQuantities.clear();
  }

  void clearSizes() {
    availableSizes.clear();
  }

  void setSelectedSize(String size) {
    selectedSize.value = size;
  }

  int get totalQuantity {
    int total = 0;
    quantities.forEach((key, value) {
      total += value;
    });
    return total;
  }

  var selectedColors = <String>[].obs;

  // Add a selected color to the list
  void addSelectedColor(String color) {
    if (!selectedColors.contains(color)) {
      selectedColors.add(color);
    }
  }

  // Remove a selected color from the list
  void removeSelectedColor(String color) {
    selectedColors.remove(color);
  }

  changeImageVariant(variant) {
    selectedVariant.value = variant;
    // print("selectedVariant.value ${selectedVariant.value}");
    var images = product.value.images!
        .where(
            (da) => da.attributeFieldValueId == variant.attributeFieldValueId)
        .toList();
    mapPackImage(images, product.value.imageId);
  }

  getWishListonClick(productId) {
    var result = false;
    if (userId != null) {
      if (allWishlist != null) {
        for (var i = 0; i < allWishlist.length; i++) {
          if (allWishlist[i].productId == productId) {
            result = true;
          }
        }
        return result;
      }
    }
    return result;
  }

  Future navigateToProductDetails(product) async {
    var result = await Get.to('/productDetail',
        routeName: '/productDetail',
        preventDuplicates: false,
        arguments: product);
  }

  bool isColorAlreadySelected(color) {
    return attributeFieldValues.any((element) => element['color'] == color);
  }

  void selectedColorVariants(fieldValue) {
    //  if (!isColorAlreadySelected(fieldValue.color)) {
    var matchingVariant = product.value.packVariant!.firstWhere(
      (variant) =>
          variant.attributeFieldValueId == fieldValue.attributeFieldValueId,
    );
    selectedColor(matchingVariant.toJson(), matchingVariant.images);
    //  }
  }

  void selectedColorVariantsbyIndex(fieldValue, field, context, images) {
    // print("fieldValue ==>>> ${fieldValue.toString()}");
    // print("data here");
    var index = attributeFieldValues.indexWhere((element) =>
        element["attributeFieldValueId"] == field['attributeFieldValueId']);
    // print("index===>>> $index");
    var matchingVariant = product.value.packVariant!.firstWhere(
      (variant) =>
          variant.attributeFieldValueId == fieldValue['attributeFieldValueId'],
    );
    if (attributeFieldValues.isNotEmpty) {
      // print(
      //     "attributeFieldValues selectedColorVariants ${attributeFieldValues.toJson()}");
      var defaultField = attributeFieldValues[index];

      defaultField['color'] = matchingVariant.fieldValue;
      defaultField['colorCode'] = matchingVariant.colorCode;
      defaultField['attributeFieldValueId'] =
          matchingVariant.attributeFieldValueId;
      defaultField['imageId'] = matchingVariant.variantImage?.imageId;
      defaultField['imageName'] = matchingVariant.variantImage?.imageName;
      defaultField['isCustomizable'] = matchingVariant.isCustomizable;
      defaultField['isAssorted'] = matchingVariant.isAssorted;
      defaultField['setQuantity'] = matchingVariant.setQuantity;
      defaultField['availableSize'] =
          matchingVariant.variantOptions?.map((variant) {
        return {
          "size": variant.attributeFieldValue,
          "id": variant.attributeFieldValueId,
          "sellingPrice": variant.sellingPrice,
          "moq": variant.moq,
          "totalQuantity": variant.totalQuantity,
          "trackQuantity": variant.trackQuantity,
          "continueSellingWhenOutOfStock": variant.continueSellingWhenOutOfStock
        };
      }).toList();
      defaultField['inputValues'] =
          matchingVariant.variantOptions?.map((variant) {
        return {
          "size": variant.attributeFieldValue,
          "value": TextEditingController(),
        };
      }).toList();
      attributeFieldValues[index] = defaultField;
      attributeFieldValues.refresh();
      Navigator.pop(context);
      // var imagesValue =images['images'].toString();
      mapPackImage(matchingVariant.images, '');
    }
  }

  void selectedColor(fieldValue, images) {
    // print("packImages--->>>>images: ${images.map((e) => e.toJson()).toList()}");
    // print("fieldValue===>>> ${fieldValue}");
    var field = {
      "setId": fieldValue['setId'],
      "labelName": fieldValue['labelName'],
      "attributeFieldValueId": fieldValue['attributeFieldValueId'],
      "color": fieldValue['fieldValue'],
      "colorCode": fieldValue['colorCode'],
      "metafields": fieldValue['metafields'],
      "isCustomizable": fieldValue['isCustomizable'],
      "isAssorted": fieldValue['isAssorted'],
      "setQuantity": fieldValue['setQuantity'],
      "imageId": fieldValue['variantImage'] != null
          ? fieldValue['variantImage']['imageId']
          : '',
      "imageName": fieldValue['variantImage'] != null
          ? fieldValue['variantImage']['imageName']
          : '',
      "value": TextEditingController(text: '1'),
      "availableSize": fieldValue['variantOptions'].map((variant) {
        return {
          "variantId": variant['variantId'],
          "size": variant['attributeFieldValue'],
          "colorCode": variant['colorCode'],
          "id": variant['attributeFieldValueId'],
          "sellingPrice": variant['sellingPrice'],
          "moq": variant['moq'],
          "totalQuantity": variant['totalQuantity'],
          "trackQuantity": variant['trackQuantity'],
          "continueSellingWhenOutOfStock":
              variant['continueSellingWhenOutOfStock']
        };
      }).toList(),
      "inputValues": fieldValue['variantOptions'].map((variant) {
        return {
          "size": variant['attributeFieldValue'],
          "value": TextEditingController(),
        };
      }).toList(),
    };

    var existingColorIndex = attributeFieldValues.indexWhere((item) =>
        item['attributeFieldValueId'] == field['attributeFieldValueId']);
    if (existingColorIndex != -1) {
      attributeFieldValues[existingColorIndex] = field;
    } else {
      attributeFieldValues.add(field);
      // mapPackImage(attributeFieldValues,attributeFieldValues);
    }
    mapPackImage(images, '');
    attributeFieldValues.refresh();
    // print("attributeFieldValues===>>> ${attributeFieldValues}");
    // print(
    //     "attributeFieldValues===>>> ${attributeFieldValues.map((e) => e.toJson()).toList()}");
  }

  void updateDefaultColor(fieldValue) {
    // print("fieldValue updateDefaultColor ${fieldValue.toJson()}");

    if (attributeFieldValues.isNotEmpty) {
      var defaultField = attributeFieldValues[attributeFieldValues.length - 1];

      defaultField['color'] = fieldValue.fieldValue;
      defaultField['colorCode'] = fieldValue.colorCode;
      defaultField['attributeFieldValueId'] = fieldValue.attributeFieldValueId;
      defaultField['imageId'] = fieldValue.variantImage.imageId;
      defaultField['imageName'] = fieldValue.variantImage.imageName;
      defaultField['isCustomizable'] = fieldValue.isCustomizable;
      defaultField['isAssorted'] = fieldValue.isAssorted;
      defaultField['setQuantity'] = fieldValue.setQuantity;
      defaultField['availableSize'] = fieldValue.variantOptions.map((variant) {
        return {
          "size": variant.attributeFieldValue,
          "id": variant.attributeFieldValueId,
          "sellingPrice": variant.sellingPrice,
          "totalQuantity": variant.totalQuantity,
          "moq": variant.moq,
          "trackQuantity": variant.trackQuantity,
          "continueSellingWhenOutOfStock": variant.continueSellingWhenOutOfStock
        };
      }).toList();
      defaultField['inputValues'] = fieldValue.variantOptions.map((variant) {
        return {
          "size": variant.attributeFieldValue,
          "value": TextEditingController(),
        };
      }).toList();

      attributeFieldValues[attributeFieldValues.length - 1] = defaultField;
      attributeFieldValues.refresh();
    }

    mapPackImage(fieldValue.images, '');
  }

  List<Map<String, dynamic>> getRemainingColors() {
    List allColorIds = product.value.packVariant!
        .map((variant) => variant.attributeFieldValueId)
        .toList();

    List selectedColorIds = attributeFieldValues
        .map((field) => field['attributeFieldValueId'])
        .toList();

    List remainingColorIds =
        allColorIds.where((id) => !selectedColorIds.contains(id)).toList();

    return product.value.packVariant!
        .where((variant) =>
            remainingColorIds.contains(variant.attributeFieldValueId))
        .map((variant) => {
              'attributeFieldValueId': variant.attributeFieldValueId,
              'colorCode': variant.colorCode,
              'fieldValue': variant.fieldValue,
            })
        .toList();
  }

  void updateQuantity(String color, String? size, quantity) {
    attributeFieldValues.value = attributeFieldValues.value.map((field) {
      if (field['color'] == color && field['isCustomizable'] == true) {
        field['inputValues'] = field['inputValues'].map((inputValue) {
          if (inputValue['size'] == size) {
            inputValue['value'].text = quantity;
          }
          return inputValue;
        }).toList();
      } else if (field['color'] == color && field['isCustomizable'] == false) {
        field['value'].text = quantity;
      }
      return field;
    }).toList();
    attributeFieldValues.refresh();
  }

  void removeColor(String color) {
    attributeFieldValues.removeWhere((field) => field['color'] == color);
    attributeFieldValues.refresh();
  }

  num calculateTotalQuantity() {
    num totalQuantity = 0;
    // print("field ==>>>>> ${attributeFieldValues}");
    for (var field in attributeFieldValues) {
      // print("field ==>>>>> ${field}");
      if (field['isCustomizable'] == true) {
        for (var inputValue in field['inputValues']) {
          int quantity = int.tryParse(inputValue['value'].text) ?? 0;
          totalQuantity += quantity;
          // print("totalQuantity ${totalQuantity}");
        }
      } else if (field['isCustomizable'] == false) {
        var quantity = int.tryParse(field['value'].text) ?? 0;
        for (var variant in field['availableSize']) {
          totalQuantity += quantity * variant['moq'];
          // print("totalQuantity ${totalQuantity}");
        }
      }
    }
    return totalQuantity;
  }

  Future<void> openWishListPopup(productId, product) async {
    //  print("selectedFilter:openWishListPopup ${product.map((e) => e.toJson()).toList()}");
    // createWishListCollection(product.wishlistCollection, '', '');
    // selectedWishList = await Get.bottomSheet(
    //   Container(
    //     height: MediaQuery.of(Get.context!).size.height /
    //         0.1, // Half of screen height
    //     // height: 1500,
    //     child: WishlistPopupWidget(
    //       product: productId,
    //     ),
    //   ),
    //   enterBottomSheetDuration: Duration(milliseconds: 200),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(20),
    //       topRight: Radius.circular(20),
    //     ),
    //   ),
    // );
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
    if (result != null) getProductDetails(packDetail, true, []);
  }

  Future<void> createWishListCollection(collectionId, page, collection) async {
    var userIds = "";
    var search = "";
    var pagelimit = 10;
    var result =
        await wishListRepo!.wishlistPageCollectionList(search, pagelimit);
    var productColectionListDetails = wishListCollectionListVMFromJson(result);
    colloctionListPopup.value = productColectionListDetails.product;
    if (collectionId.isEmpty) {
      var firstDefaultCollection = colloctionListPopup.value
          .where((collection) => collection.isDefault)
          .toList();
      if (firstDefaultCollection.isNotEmpty) {
        var collectionIds =
            firstDefaultCollection.map((collection) => collection.sId).toList();
        selectedWishListCollection(collectionIds);
        // print(
        //     "firstDefaultCollection isEmpty===>>>: ${firstDefaultCollection.map((e) => e.toJson()).toList()}");
      }
    } else if (collectionId.isNotEmpty) {
      var firstDefaultCollection = collectionId;
      if (firstDefaultCollection.isNotEmpty) {
        selectedWishListCollection(firstDefaultCollection);
      }
    }
  }

  void selectedWishListCollection(fieldValue) {
    // print("value ==============]]]]]]]]]]]]]] ${fieldValue}");
    selectedFilterAttr.clear();
    if (fieldValue.isNotEmpty) {
      var field;
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

    // Future<void> allCollectionListPopup(selectedCollectionID) async {
    Future<void> allCollectionListPopup(selectedCollectionID) async {
      var userIds = "111111";
      var collectionIds = selectedFilterAttr.map((e) => e['id']).toList();
      var result = await wishListRepo!
          .createListoverall(collectionIds, selectedCollectionID);
      if (result['error'] == false) {
        showSnackBar(result['message'], SnackPosition.BOTTOM);
      } else if (result['error'] == true) {
        showSnackBar(result['message'], SnackPosition.BOTTOM);
      }
      hideLoading();
    }
  }

  Future downloadProductCatalog(BuildContext context, dynamic design) async {
    var userId = GetStorage().read('utoken');
    var metaId = design['source']?['metaId'];

    // Find the matching metafield by metaId
    var matchedMeta = product.value.metafields
        ?.firstWhereOrNull((mf) => mf.customDataId == metaId);

    String? fileName;
    String? fileUrl;

    if (matchedMeta != null && matchedMeta.reference?['file'] != null) {
      fileName = matchedMeta.reference['file']['fileName'];
      fileUrl = matchedMeta.reference['file']['fileUrl'];
    }

    if (userId != null) {
      if (fileUrl != null && fileName != null) {
        await CommonService().downloadFile(fileName, fileUrl);
      }
    } else {
      if (product.value.downloadCatalogForm != null) {
        dynamicFormController.initialLoad(product.value.downloadCatalogForm);
        Get.bottomSheet(
          Container(child: DynamicFormBottomSheet()),
          enterBottomSheetDuration: Duration(milliseconds: 200),
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ).then((value) async {
          if (value == true) {
            if (fileUrl != null && fileName != null) {
              await CommonService().downloadFile(fileName, fileUrl);
            } else if (product.value.catalogUrl != null) {
              var fallbackName = product.value.catalogUrl!.split('/').last;
              await CommonService()
                  .downloadFile(fallbackName, product.value.catalogUrl);
            }
          }
        });
      } else if (fileUrl != null && fileName != null) {
        await CommonService().downloadFile(fileName, fileUrl);
      } else if (product.value.catalogUrl != null) {
        var fallbackName = product.value.catalogUrl!.split('/').last;
        await CommonService()
            .downloadFile(fallbackName, product.value.catalogUrl);
      }
    }
  }

  Future downloadProductImage(context, design) async {
    for (var downloadCatalog in productPackImage.value) {
      final fileUrl = downloadCatalog.imageName;

      if (fileUrl != null && fileUrl.isNotEmpty) {
        // Extract the last part of the URL (filename)
        final fileName = fileUrl.split('/').last;

        print("fileUrl $fileUrl");
        print("fileName $fileName");

        await CommonService().downloadFile(fileName, fileUrl);
      }
    }

    // if (userId != null) {
    // if (product.value.productCatalog != null &&
    //     product.value.productCatalog!.fileUrl != null) {
    //   await CommonService().downloadFile(
    //       product.value.productCatalog!.fileName,
    //       product.value.productCatalog!.fileUrl);
    // }

    // } else {
    //   if (product.value.downloadCatalogForm != null) {
    //     dynamicFormController.initialLoad(product.value.downloadCatalogForm);
    //     Get.bottomSheet(
    //       Container(child: DynamicFormBottomSheet()),
    //       enterBottomSheetDuration: Duration(milliseconds: 200),
    //       isScrollControlled: true,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.only(
    //           topLeft: Radius.circular(20),
    //           topRight: Radius.circular(20),
    //         ),
    //       ),
    //     ).then((value) async {
    //       if (value == true) {
    //         if (product.value.catalogUrl != null) {
    //           var fileName = product.value.catalogUrl!.split('/').last;
    //           await CommonService()
    //               .downloadFile(fileName, product.value.catalogUrl);
    //         }
    //       }
    //     });
    //   } else if (product.value.catalogUrl != null) {
    //     var fileName = product.value.catalogUrl!.split('/').last;
    //     await CommonService().downloadFile(fileName, product.value.catalogUrl);
    //   }
    // }
  }

  Future downloadCatalog(fileName, fileUrl) async {
    var userId = GetStorage().read('utoken');
    productPackImage.value;

    if (userId != null) {
      // if (product.value.productCatalog != null &&
      //     product.value.productCatalog!.fileUrl != null) {
      //   await CommonService().downloadFile(
      //       product.value.productCatalog!.fileName,
      //       product.value.productCatalog!.fileUrl);
      // }
      for (var downloadCatalog in product.value.productCatalog) {
        if (downloadCatalog != null && fileUrl != null) {
          await CommonService().downloadFile(fileName, fileUrl);
        }
      }
    } else {
      if (product.value.downloadCatalogForm != null) {
        dynamicFormController.initialLoad(product.value.downloadCatalogForm);
        Get.bottomSheet(
          Container(child: DynamicFormBottomSheet()),
          enterBottomSheetDuration: Duration(milliseconds: 200),
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ).then((value) async {
          if (value == true) {
            if (product.value.catalogUrl != null) {
              var fileName = product.value.catalogUrl!.split('/').last;
              await CommonService()
                  .downloadFile(fileName, product.value.catalogUrl);
            }
          }
        });
      } else if (product.value.catalogUrl != null) {
        var fileName = product.value.catalogUrl!.split('/').last;
        await CommonService().downloadFile(fileName, product.value.catalogUrl);
      }
    }
  }

  openCheckoutPage(_controller) {
    Get.dialog(
        EnquiryNowPopup(type: "productEnquiry", controller: _controller));
  }

  void updateSummaryProduct(context) async {
    var uToken = storage.read('utoken');
    if (uToken != null) {
      // KeyboardUtil.hideKeyboard(context);
      var data = {};
      for (var attribute in attributeFieldValues) {
        var colorData = {
          "setId": attribute['setId'],
          'color': attribute['color'],
          'availableSize': []
        };

        for (var size in attribute['availableSize']) {
          var inputValue = attribute['inputValues']
              .firstWhere(
                (input) => input['size'] == size['size'],
                orElse: () => null,
              )['value']
              .text;
          colorData['availableSize']
              .add({'variantId': size['variantId'], 'inputValue': inputValue});
        }
        data[attribute['color']] = colorData;
      }
      var data2 = [];
      data.forEach((key, value) {
        for (var size in value['availableSize']) {
          if (size['inputValue'] != null && size['inputValue'].isNotEmpty) {
            data2.add({
              "setId": value['setId'],
              "variantId": size['variantId'],
              "quantity": int.parse(size['inputValue'])
            });
          }
        }
      });
      var data3 = {
        "productId": product.value.sId,
        "variants": data2,
        "channel": "mobile-app",
        "message": summaryController!.text,
        "userId": null
      };
      // var data;
      if (product.value.isCustomizable == true &&
          product.value.type == "pack") {
        data = data3;
      } else if (product.value.isCustomizable == true &&
          product.value.type == "set") {
        var setVariant = [];
        custoizableInputValues.forEach((element) {
          if (element['quantity'] != null && element['quantity'].isNotEmpty)
            setVariant.add({
              'variantId': element['variantId'],
              'quantity': int.parse(element['quantity']),
            });
        });
        data = {
          "productId": product.value.sId,
          "variants": setVariant,
          "channel": "mobile-app",
          "message": summaryController!.text,
          "userId": null
        };
      } else {
        data = {
          "productId": product.value.sId,
          "quantity": product.value.quantity,
          "channel": "mobile-app",
          "message": summaryController!.text,
          "userId": null
        };
      }
      showLoading("Loading...");
      if (data != null) {
        var result = await cartRepo!.initiateProductEnquiryByUser(data);
        if (result != null) {
          if (result['error'] == false) {
            summary.value = result['token'];
            fetchOrderStatusProduct();
            isReload.value = false;
          } else {
            isReload.value = false;
            snackMessage(result['message']);
            hideLoading();
          }
        }
      }
    }
  }

  void fetchOrderStatusProduct() {
    _timer =
        Timer.periodic(Duration(seconds: 1), (Timer t) => addConfirmation());
  }

  void addConfirmation() async {
    if (duration.value > 0) {
      duration.value--;
      if (isReload.value == false) {
        isReload.value = true;
        var result = await cartRepo!.checkEnquiryIsConfirmed(summary.value);
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
          }
        }
      }
    } else {
      hideLoading();
      _timer?.cancel();
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

  String? getQuantityMetaValues(
      metafields, int quantity, Map<String, dynamic>? source) {
    if (quantity == 0 || source == null || source["metaId"] == null) {
      return quantity.toString();
    }

    final metaValues = metafields.firstWhere(
        (e) => e["customDataId"] == source['metaId'],
        orElse: () => <String, dynamic>{});
    if (metaValues != null &&
        metaValues['reference'] != null &&
        metaValues['reference']['value'] != null) {
      String value = metaValues['reference']['value'];

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
  void dispose() {
    scrollController!.removeListener(_scrollListener);
    scrollController!.dispose();
    super.dispose();
  }
}
