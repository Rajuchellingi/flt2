// ignore_for_file: unused_local_variable

import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/model/product_setting_model.dart';
import 'package:get/get.dart';
import 'package:b2b_graphql_package/modules/product_setting/product_setting_repo.dart';

class ProductSettingController extends GetxController with BaseController {
  ProductSettingRepo? productSettingRepo;
  var productSetting = new ProductSettingVM(
          showAvailableSize: null,
          sTypename: null,
          productPolicy: null,
          showAddToCart: null,
          showSimilarStyles: null,
          showRecentlyViewed: null,
          cartSummaryType: null,
          priceDisplayType: null,
          showPrice: null,
          showVariantPrice: null)
      .obs;
  @override
  void onInit() {
    productSettingRepo = ProductSettingRepo();

    getProductSetting();
    super.onInit();
  }

  Future getProductSetting() async {
    var result = await productSettingRepo!.getProductSetting();
    if (result != null) {
      var response = productSettingVMFromJson(result);
      productSetting.value = response;
    } else {
      var result = await productSettingRepo!.getProductSetting();
      if (result == null) return;
      var response = productSettingVMFromJson(result);
      productSetting.value = response;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
