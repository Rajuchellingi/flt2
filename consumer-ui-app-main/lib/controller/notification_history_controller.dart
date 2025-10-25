// ignore_for_file: unused_local_variable, deprecated_member_use, unused_field, invalid_use_of_protected_member

import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/notification_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/notification_history_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:b2b_graphql_package/modules/notification_history/notification_history_repo.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/common_model.dart';

class NotificationHistoryController extends GetxController with BaseController {
  NotificationHistoryRepo? notificationHistoryRepo;
  var userId;
  var isLoading = false.obs;
  var notificationHistory = new NotificationHistoryVM(
          count: null, totalPages: null, notification: null, sTypename: null)
      .obs;
  bool allLoaded = false;
  var pagelimit = 10;
  var pageIndex = 1;

  var historyList = [].obs;
  var newData = [];
  var loading = false.obs;

  ScrollController? scrollController;
  final _notificationController = Get.find<NotificationController>();
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();

  @override
  void onInit() {
    notificationHistoryRepo = NotificationHistoryRepo();
    scrollController = new ScrollController();
    userId = GetStorage().read('utoken');
    if (userId != null) {
      initialLoad();
    }
    scrollController!.addListener(() {
      if (scrollController!.position.pixels >=
              scrollController!.position.maxScrollExtent &&
          !loading.value) {
        paginationFetch();
      }
    });
    getTemplate();
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'notification');
    isTemplateLoading.value = false;
  }

  Future initialLoad() async {
    this.isLoading.value = true;
    await Future.wait([getNotificationHistory()]);
    if (newData.isNotEmpty) {
      historyList.addAll(newData);
      historyList.refresh();
      pageIndex += 1;
    }
    this.isLoading.value = false;
  }

  Future getNotificationHistory() async {
    userId = GetStorage().read('utoken');
    if (userId != null) {
      var result = await notificationHistoryRepo!
          .getNotificationHistory(pageIndex, pagelimit);
      if (result != null) {
        var response = notificationHistoryVMFromJson(result);
        notificationHistory.value = response;
        newData = notificationHistory.value.notification!;
      }
    } else {
      newData = [];
    }
  }

  paginationFetch() async {
    if (allLoaded) {
      return;
    }

    loading.value = true;

    await Future.wait([
      getNotificationHistory(),
    ]);

    if (newData.isNotEmpty) {
      historyList.addAll(newData);
      historyList.refresh();
      pageIndex += 1;
    }
    loading.value = false;
    allLoaded = newData.isEmpty;
  }

  Future refreshPage() async {
    isLoading.value = true;
    allLoaded = false;
    historyList.value = [];
    historyList.refresh();
    // scrollController = new ScrollController();
    pageIndex = 1;
    await Future.wait([getNotificationHistory()]);
    if (newData.isNotEmpty) {
      historyList.addAll(newData);
      historyList.refresh();
      pageIndex += 1;
    }
    isLoading.value = false;
  }

  onTapNotification(notification) async {
    var result = await _notificationController.updateNotificationHistoryStatus(
        notification.sId, 'read');
    getNotificationHistory();
    checkUrlAndNavigate(notification.linkType, notification.link);
  }

  checkUrlAndNavigate(linkType, link) async {
    if (link != null) {
      if (link.contains('collections')) {
        var splittedLink = link.split('/');
        var collectionId = splittedLink[splittedLink.length - 1];
        var result =
            await Get.toNamed('/collection', arguments: {'id': collectionId});
        refreshPage();
      } else if (link.contains('products')) {
        var splittedLink = link.split('/');
        var productId = splittedLink[splittedLink.length - 1];
        var argument = new CommonModel(sId: productId);
        var result = await Get.toNamed('/productDetail', arguments: argument);
        refreshPage();
      } else if (link.contains('cart')) {
        var result = await Get.toNamed('/cart');
        refreshPage();
      } else if (linkType == 'external-url') {
        if (link.startsWith('http://') || link.startsWith('https://')) {
          if (await canLaunch(link)) {
            await launch(link);
          } else {
            throw 'Could not launch $link';
          }
        }
      } else {
        var result = await Get.toNamed('/home');
        refreshPage();
      }
    } else if (linkType == 'home') {
      var result = await Get.offAndToNamed('/home');
      refreshPage();
    }
  }

  @override
  void dispose() {
    scrollController!.dispose();
    super.dispose();
  }
}
