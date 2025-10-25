// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'package:b2b_graphql_package/modules/notification_history/notification_history_repo.dart';
import 'package:black_locust/model/notification_history_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotificationController extends GetxController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  NotificationHistoryRepo? notificationHistoryRepo;
  var notificationCount = 0.obs;

  @override
  void onInit() {
    notificationHistoryRepo = NotificationHistoryRepo();
    getNotificationCount();
    super.onInit();
  }

  Future<String?> checkPermissionAndGetToken() async {
    NotificationSettings settings =
        await _firebaseMessaging.getNotificationSettings();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      var token = await _firebaseMessaging.getToken();
      return token;
    } else {
      print('User declined notification permissions.');
      return null;
    }
  }

  Future updateNotificationHistoryStatus(notifcaitonId, status) async {
    var result = await notificationHistoryRepo!
        .updateNotificationHistoryStatus(notifcaitonId, status);
    getNotificationCount();
  }

  Future updateRecentNotificationStatus(status) async {
    var result =
        await notificationHistoryRepo!.updateRecentNotificationStatus(status);
    getNotificationCount();
  }

  Future getNotificationCount() async {
    var userId = GetStorage().read('utoken');
    if (userId != null) {
      var result = await notificationHistoryRepo!.getUnreadNotificationCount();
      if (result != null) {
        var response = notificationCountVMFromJson(result);
        notificationCount.value = response.count!;
        print("notification count ${notificationCount.value}");
      }
    } else {
      notificationCount.value = 0;
    }
  }

  onLogout() {
    notificationCount.value = 0;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
