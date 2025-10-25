// ignore_for_file: invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/booking/booking_repo.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingHistoryController extends GetxController with BaseController {
  BookingRepo? bookingRepo;
  var bookingList = [].obs;
  var pageIndex = 1;
  var pageLimit = 20;
  var isLoading = false.obs;
  bool allLoaded = false;
  var newData = [];
  var loading = false.obs;
  var booking = new MyBookingsVM(bookingData: [], count: 0, totalPages: 0).obs;
  final ScrollController scrollController = new ScrollController();
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  @override
  void onInit() {
    bookingRepo = BookingRepo();
    initialLoad();
    getTemplate();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !loading.value) {
        paginationFetch();
      }
    });
    super.onInit();
  }

  paginationFetch() async {
    if (allLoaded) {
      return;
    }

    loading.value = true;

    await Future.wait([getBookingList(pageIndex, pageLimit)]);

    if (newData.isNotEmpty) {
      bookingList.addAll(newData);
      bookingList.refresh();
      pageIndex += 1;
    }
    loading.value = false;
    allLoaded = newData.isEmpty;
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates
        .firstWhereOrNull((value) => value['id'] == 'booking-history');
    isTemplateLoading.value = false;
  }

  Future initialLoad() async {
    this.isLoading.value = true;
    await Future.wait([getBookingList(pageIndex, pageLimit)]);
    if (newData.isNotEmpty) {
      bookingList.addAll(newData);
      bookingList.refresh();
      pageIndex += 1;
    }
    this.isLoading.value = false;
  }

  Future<Null> refreshPage() async {
    isLoading.value = true;
    allLoaded = false;
    bookingList.value = [];
    pageIndex = 1;
    await Future.wait([getBookingList(pageIndex, pageLimit)]);
    if (newData.isNotEmpty) {
      bookingList.addAll(newData);
      bookingList.refresh();
      pageIndex += 1;
    }
    isLoading.value = false;
  }

  snackMessage(String message) {
    Get.snackbar(
      "", message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kTextColor,
      colorText: Colors.white,
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

  Future<Null> refreshOrderList() async {}

  Future getBookingList(pageNo, limit) async {
    var result = await bookingRepo!.getBookingListByUser(pageNo, limit);
    if (result != null) {
      var orderData = myBookingsVMFromJson(result);
      newData = orderData.bookingData;
    } else {
      newData = [];
    }
  }

  Future navigateToBookingDetails(bookingItem) async {
    await Get.toNamed('/bookingDetail', arguments: {"id": bookingItem.sId});
  }

  @override
  void onClose() {
    isLoading.close();
    bookingList.close();
    template.close();
    isTemplateLoading.close();
    booking.close();
    scrollController.dispose();
    super.onClose();
  }
}
