// ignore_for_file: unnecessary_null_comparison, unused_local_variable, avoid_init_to_null, invalid_use_of_protected_member

import 'package:black_locust/controller/plugins_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/review_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:integration_package/modules/review/review_repo.dart';
import 'base_controller.dart';

class ReviewController extends GetxController with BaseController {
  ReviewRepo? reviewRepo;
  var pagelimit = "10";
  var reviewList = [].obs;
  var newData = [];
  var isLoading = false.obs;
  var pageIndex = 1;
  var argument;
  var loading = false.obs;
  var allLoaded = false.obs;
  var userId;
  late ScrollController scrollController;
  var reviewData =
      new ReviewDataVM(currentPage: null, perPage: null, reviews: []).obs;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  final _pluginController = Get.find<PluginsController>();
  var ratingData = [].obs;
  @override
  void onInit() {
    reviewRepo = ReviewRepo();
    userId = GetStorage().read('utoken');
    argument = Get.arguments;
    scrollController = new ScrollController();
    getTemplate();
    if (argument != null) {
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
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'review');
    isTemplateLoading.value = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  paginationFetch() async {
    if (allLoaded.value) {
      return;
    }

    loading.value = true;
    await Future.wait([getReviewData()]);
    if (newData.isNotEmpty) {
      reviewList.addAll(newData);
      reviewList.refresh();
      pageIndex += 1;
    }
    loading.value = false;
    allLoaded.value = newData.isEmpty;
  }

  Future initialLoad() async {
    this.isLoading.value = true;
    await Future.wait([getReviewData(), reviewCount()]);
    if (newData.isNotEmpty) {
      reviewList.addAll(newData);
      reviewList.refresh();
      pageIndex += 1;
    } else {
      allLoaded.value = true;
    }
    this.isLoading.value = false;
  }

  Future<Null> refreshPage() async {
    isLoading.value = true;
    allLoaded.value = false;
    reviewList.value = [];
    pageIndex = 1;
    await Future.wait([getReviewData(), reviewCount()]);

    if (newData.isNotEmpty) {
      reviewList.addAll(newData);
      reviewList.refresh();
      pageIndex += 1;
    }
    isLoading.value = false;
  }

  Future getReviewData() async {
    var review = _pluginController.getPluginValue('judgeme');
    var shopDomain = GetStorage().read('shop');
    if (review != null) {
      var params = {
        "api_token": review.code,
        "shop_domain": shopDomain,
        "per_page": pagelimit,
        "page": pageIndex.toString(),
        "product_id": argument['id'].toString(),
      };
      var result = await reviewRepo!.getReviews(params);
      if (result != null) {
        var response = reviewDataVMFromJson(result);
        reviewData.value = response;
        newData = response.reviews;
      }
    }
  }

  Future openAddReview() async {
    userId = GetStorage().read('utoken');
    if (userId != null) {
      var result = await Get.toNamed('/addReview',
          arguments: {"id": argument['externalId']});
      if (result == true) refreshPage();
    } else {
      Get.toNamed('/login', arguments: {"path": "/review"});
    }
  }

  Future reviewCount() async {
    ratingData.value = await Future.wait([
      getReviewCount(1),
      getReviewCount(2),
      getReviewCount(3),
      getReviewCount(4),
      getReviewCount(5)
    ]);
  }

  Future getReviewCount(rating) async {
    var review = _pluginController.getPluginValue('judgeme');
    var shopDomain = GetStorage().read('shop');
    var count = 0;
    if (review != null) {
      var params = {
        "api_token": review.code,
        "shop_domain": shopDomain,
        "product_id": argument['id'].toString(),
        'rating': rating.toString()
      };
      if (rating != null) {}
      var result = await reviewRepo!.getReviewCount(params);
      if (result != null) {
        count = result['count'] ?? 0;
      }
    }
    return {
      "stars": rating,
      "count": count,
    };
  }

  @override
  void onClose() {
    super.onClose();
  }
}
