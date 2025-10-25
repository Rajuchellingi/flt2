// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison

import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/loyality_controller.dart';
import 'package:black_locust/model/plugins_model.dart';
import 'package:get/get.dart';
import 'package:b2b_graphql_package/modules/plugins/plugins_repo.dart';
import 'package:url_launcher/url_launcher.dart';

class PluginsController extends GetxController with BaseController {
  PluginsRepo? pluginsRepo;
  var plugins = [].obs;
  var isWhatsapp = false.obs;
  var isLoyality = false.obs;
  final reviewController = Get.find<CommonReviewController>();
  final loyalityController = Get.find<LoyalityController>();
  @override
  void onInit() {
    pluginsRepo = PluginsRepo();
    getPlugins();
    super.onInit();
  }

  Future getPlugins() async {
    var result = await pluginsRepo!.getPlugins();
    if (result != null) {
      var response = pluginsVMFromJson(result);
      // var response = pluginsV2VMFromJson(result);
      plugins.value = response;
      // print("plugins.value ---===--->>>> ${plugins.value}");
      getAllReviews();
      checkIsWhatsapp();
      getLoyality();
    }
  }

  getAllReviews() {
    if (plugins.value != null && plugins.value.length > 0) {
      var pluginData = plugins.value
          .firstWhereOrNull((element) => element.name == 'judgeme');
      if (pluginData != null) {
        reviewController.getAllReviews(pluginData);
        reviewController.assignReviewData(pluginData);
      }
      var nectarRating = plugins.value.firstWhereOrNull(
          (element) => element.name == 'nectar' && element.isReview == true);
      if (nectarRating != null) {
        reviewController.assignReviewData(nectarRating);
      }
    }
  }

  getLoyality() {
    var loyality = getPluginValue('ri-loyality-and-rewards');
    if (loyality != null) {
      isLoyality.value = true;
      loyalityController.getLoyalityData();
    }
  }

  checkIsWhatsapp() {
    var value = getPluginValue('whatsapp');
    if (value != null) {
      isWhatsapp.value = true;
    }
  }

  getPluginValue(type) {
    if (plugins.value != null && plugins.value.length > 0) {
      var pluginData =
          plugins.value.firstWhereOrNull((element) => element.name == type);
      if (pluginData != null) {
        return pluginData;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<void> openWhatsApp() async {
    var value = getPluginValue('whatsapp');
    if (value != null && value.mobileNumber != null) {
      final String phoneNumber = !value.mobileNumber.startsWith('+')
          ? '+91${value.mobileNumber}'
          : value.mobileNumber;
      final String url = "https://wa.me/$phoneNumber";
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        print("Could not launch $url");
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
