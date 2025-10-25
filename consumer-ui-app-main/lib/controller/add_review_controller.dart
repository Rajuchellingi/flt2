// ignore_for_file: unnecessary_null_comparison, unused_local_variable, avoid_init_to_null, invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/user/user_repo.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/plugins_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/review_model.dart';
import 'package:black_locust/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:integration_package/modules/review/review_repo.dart';
import 'base_controller.dart';

class AddReviewController extends GetxController with BaseController {
  ReviewRepo? reviewRepo;
  var isLoading = false.obs;
  var isTemplateLoading = false.obs;
  var template = {}.obs;
  final themeController = Get.find<ThemeController>();
  final commonReviewController = Get.find<CommonReviewController>();
  final pluginController = Get.find<PluginsController>();
  var arguments;
  UserRepo? userRepo;
  TextEditingController? titleController, descriptionController;
  var rating = 0.obs;
  @override
  void onInit() {
    reviewRepo = ReviewRepo();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    arguments = Get.arguments;
    userRepo = UserRepo();
    getTemplate();
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'add-review');
    isTemplateLoading.value = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getProfile() async {
    var userId = GetStorage().read('utoken');
    var result = await userRepo!.getUserById(userId, []);
    if (result != null) {
      return userByIdVMFromJson(result);
    }
  }

  addStarRating(value) {
    rating.value = value;
  }

  Future submitReview() async {
    var userId = GetStorage().read('utoken');
    if (userId != null) {
      if (descriptionController!.text == null ||
          descriptionController!.text.isEmpty) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Review can not be blank'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (rating.value == 0) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Ratings can not be blank'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        await addReview();
      }
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Please login to perform action'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future addReview() async {
    var credentials = pluginController.getPluginValue('judgeme');
    if (credentials != null) {
      showLoading("Loading...");
      var user = await getProfile();
      var shopDomain = GetStorage().read('shop');
      var body = {
        "api_token": credentials.code,
        "shop_domain": shopDomain,
        "email": user.emailId,
        "name": getName(user),
        "body": descriptionController!.text,
        "id": arguments['id'].toString(),
        "rating": rating.value.toString(),
        "platform": "shopify"
      };

      if (titleController!.text != null && titleController!.text != "") {
        body['title'] = titleController!.text;
      }
      var result = await reviewRepo!.createReview(body);
      hideLoading();
      if (result != null) {
        if (result['status'] == 200 || result['status'] == 201) {
          addToAllReviews(body);
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text("Review added successfully"),
              behavior: SnackBarBehavior.floating,
            ),
          );

          Get.back(result: true);
        } else {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text(result['message']),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Failed to add review'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Failed to add review'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  addToAllReviews(review) {
    var reviewData = new ReviewVM(
        id: null,
        externalId: int.tryParse(review['id']),
        title: review['title'],
        body: review['body'],
        rating: int.tryParse(review['rating']),
        name: review['name'],
        published: false,
        createdAt: null,
        updatedAt: null);
    commonReviewController.addNewReview(reviewData);
  }

  getName(user) {
    if (user.firstName != null && user.lastName != null) {
      return user.firstName! + " " + user.lastName!;
    } else if (user.firstName != null) {
      return user.firstName!;
    } else if (user.lastName != null) {
      return user.lastName!;
    } else {
      return "";
    }
  }

  @override
  void onClose() {
    titleController!.dispose();
    descriptionController!.dispose();
    isLoading.close();
    isTemplateLoading.close();
    template.close();
    rating.close();
    super.onClose();
  }
}
