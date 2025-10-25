// ignore_for_file: invalid_use_of_protected_member, deprecated_member_use

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/plugins_model.dart';
import 'package:black_locust/model/review_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:integration_package/modules/review/review_repo.dart';

class CommonReviewController extends GetxController {
  ReviewRepo? reviewRepo;
  var allReviews = [].obs;
  var isLoading = false.obs;
  var pluginData = new PluginsVM(
          code: null,
          name: null,
          mobileNumber: null,
          isReview: null,
          sId: null,
          status: null,
          title: null,
          secretKey: null,
          workspace: null)
      .obs;
  final themeController = Get.find<ThemeController>();
  var showRatingsForAll = false;
  @override
  void onInit() {
    reviewRepo = ReviewRepo();
    assignShowRating();
    super.onInit();
  }

  assignShowRating() {
    var product = themeController.instance('product');
    if (product != null && product['source'] != null) {
      showRatingsForAll = product['source']['show-ratings-for-all'] ?? false;
    }
  }

  assignReviewData(credentials) {
    pluginData.value = credentials;
    isLoading.value = false;
  }

  Future getAllReviews(credentials) async {
    var allData = [];
    var product = themeController.instance('product');
    var isGetAllReveiws = product['source']['get-all-reviews'] ?? true;
    if (isGetAllReveiws == true) {
      int currentPage = 1;
      bool hasMoreData = true;
      isLoading.value = true;
      var shopDomain = GetStorage().read('shop');
      while (hasMoreData) {
        var params = {
          "api_token": credentials.code,
          "shop_domain": shopDomain,
          "per_page": "2000",
          "page": currentPage.toString()
        };
        var result = await reviewRepo!.getReviews(params);
        if (result != null) {
          var response = reviewDataVMFromJson(result);
          if (response.reviews.isNotEmpty) {
            allData.addAll(response.reviews);
            currentPage++;
          } else {
            hasMoreData = false;
          }
        } else {
          hasMoreData = false;
        }
      }
      allReviews.value = allData;
      isLoading.value = false;
    }
  }

  Widget ratingsWidget(productId,
      {iconSize = 15.0,
      fontSize = 12.0,
      color = Colors.amber,
      showAverage = true,
      showCount = true,
      emptyHeight = 5.0}) {
    var brightness = Theme.of(Get.context!).brightness;
    if (brightness == Brightness.dark && kPrimaryColor == Colors.black) {
      color = Colors.white;
    }
    if (pluginData.value.name == 'judgeme') {
      return processByJudgeMe(productId, iconSize, fontSize, color, showAverage,
          showCount, emptyHeight);
    } else if (pluginData.value.name == 'nectar' &&
        pluginData.value.isReview == true) {
      return processByNector(productId, iconSize, fontSize, color, showAverage,
          showCount, emptyHeight);
    } else {
      return SizedBox(height: emptyHeight);
    }
  }

  String colorToHex(Color color, {bool includeAlpha = false}) {
    String alpha =
        includeAlpha ? color.alpha.toRadixString(16).padLeft(2, '0') : '';
    String red = color.red.toRadixString(16).padLeft(2, '0');
    String green = color.green.toRadixString(16).padLeft(2, '0');
    String blue = color.blue.toRadixString(16).padLeft(2, '0');
    return "#$alpha$red$green$blue".toUpperCase();
  }

  Widget processByJudgeMe(productId, iconSize, fontSize, color, showAverage,
      showCount, emptyHeight) {
    var splittedData = productId.split('/');
    var externalId = int.tryParse(splittedData.last);
    var productReviews = allReviews.value
        .where((element) => element.externalId == externalId)
        .toList();
    if (productReviews.isNotEmpty) {
      var reviewCountData = [
        {
          'stars': 1,
          "count": productReviews.where((element) => element.rating == 1).length
        },
        {
          'stars': 2,
          "count": productReviews.where((element) => element.rating == 2).length
        },
        {
          'stars': 3,
          "count": productReviews.where((element) => element.rating == 3).length
        },
        {
          'stars': 4,
          "count": productReviews.where((element) => element.rating == 4).length
        },
        {
          'stars': 5,
          "count": productReviews.where((element) => element.rating == 5).length
        },
      ];
      final int totalRatings = reviewCountData.fold<int>(
          0, (sum, rating) => sum + (rating['count'] as int));
      final double averageRating = totalRatings > 0
          ? reviewCountData.fold<double>(0, (sum, rating) {
                final int stars = rating['stars'] as int;
                final int count = rating['count'] as int;
                return sum + (stars * count);
              }) /
              totalRatings
          : 0.0;
      return Container(
          margin: const EdgeInsets.only(top: 5),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    if (index + 1 <= averageRating) {
                      return Icon(Icons.star, color: color, size: iconSize);
                    } else if (index < averageRating) {
                      return Icon(Icons.star_half,
                          color: color, size: iconSize);
                    } else {
                      return Icon(Icons.star_border,
                          color: color, size: iconSize);
                    }
                  }),
                ),
                if (showAverage) ...[
                  SizedBox(width: 5),
                  Text(averageRating.toStringAsFixed(1),
                      style: TextStyle(fontSize: fontSize)),
                ],
                if (showCount) ...[
                  SizedBox(width: 3),
                  Text('(${totalRatings.toString()})',
                      style: TextStyle(color: Colors.grey, fontSize: fontSize))
                ],
              ]));
    } else {
      if (showRatingsForAll == true) {
        var totalRatings = 0;
        var averageRating = 0.0;
        return Container(
            margin: const EdgeInsets.only(top: 5),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      if (index + 1 <= averageRating) {
                        return Icon(Icons.star, color: color, size: iconSize);
                      } else if (index < averageRating) {
                        return Icon(Icons.star_half,
                            color: color, size: iconSize);
                      } else {
                        return Icon(Icons.star_border,
                            color: color, size: iconSize);
                      }
                    }),
                  ),
                  if (showAverage) ...[
                    SizedBox(width: 5),
                    Text(averageRating.toStringAsFixed(1),
                        style: TextStyle(fontSize: fontSize)),
                  ],
                  if (showCount) ...[
                    SizedBox(width: 3),
                    Text('(${totalRatings.toString()})',
                        style:
                            TextStyle(color: Colors.grey, fontSize: fontSize))
                  ],
                ]));
      } else {
        return SizedBox(height: emptyHeight);
      }
    }
  }

  Widget processByNector(productId, iconSize, fontSize, color, showAverage,
      showCount, emptyHeight) {
    var splittedData = productId.split('/');
    var externalId = splittedData.last;
    var productReview = allReviews.value.firstWhere(
        (element) => element['productId'] == externalId,
        orElse: () => null);
    if (productReview != null) {
      var totalRatings = productReview['data']['count'];
      var totalSum = productReview['data']['sum'];
      final double averageRating =
          totalRatings > 0 ? (totalSum / totalRatings).toDouble() : 0.0;
      if ((showRatingsForAll == false && totalRatings > 0) ||
          showRatingsForAll == true) {
        return Container(
            margin: const EdgeInsets.only(top: 5, bottom: 2),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      if (index + 1 <= averageRating) {
                        return Icon(Icons.star, color: color, size: iconSize);
                      } else if (index < averageRating) {
                        return Icon(Icons.star_half,
                            color: color, size: iconSize);
                      } else {
                        return Icon(Icons.star_border,
                            color: color, size: iconSize);
                      }
                    }),
                  ),
                  if (showAverage) ...[
                    SizedBox(width: 5),
                    Text(averageRating.toStringAsFixed(1),
                        style: TextStyle(fontSize: fontSize)),
                  ],
                  if (showCount) ...[
                    SizedBox(width: 3),
                    Text('(${totalRatings.toString()})',
                        style: TextStyle(color: color, fontSize: fontSize))
                  ],
                ]));
      } else {
        return SizedBox(height: emptyHeight);
      }
    } else {
      return SizedBox(height: emptyHeight);
    }
  }

  addNewReview(review) {
    allReviews.value.add(review);
    allReviews.refresh();
  }

  Future getAllNectarReviews(productIds) async {
    var currentIds = [];
    for (var element in productIds) {
      var splittedData = element.split('/');
      var externalId = splittedData.last;
      var isExists =
          allReviews.value.any((review) => review['productId'] == externalId);
      if (!isExists) {
        currentIds.add(externalId);
      }
    }
    if (currentIds.isNotEmpty) {
      var allData = await Future.wait(
          currentIds.map((id) => getSingleNectarReviews(id)).toList());
      allReviews.value.addAll(allData.where((element) => element != null));
    }
    isLoading.refresh();
  }

  Future getSingleNectarReviews(productId) async {
    var result =
        await reviewRepo!.getNectorReview(productId, pluginData.value.code);
    if (result != null) {
      return {"productId": productId, "data": result};
    } else {
      return null;
    }
  }

  @override
  void onClose() {
    allReviews.close();
    isLoading.close();
    pluginData.close();
    super.onClose();
  }
}
