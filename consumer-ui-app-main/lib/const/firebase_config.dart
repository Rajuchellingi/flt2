// ignore_for_file: unused_local_variable, deprecated_member_use

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../controller/notification_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/common_model.dart';

class FirebaseConfig {
  void init() {
    initPushNotifications();
    initLocalNotifications();
  }
}

final _notificationController = Get.find<NotificationController>();

final _androidChannel = const AndroidNotificationChannel('id', 'name',
    description: 'description', importance: Importance.high);
final _localNotification = FlutterLocalNotificationsPlugin();

Future<void> handleBackgroundMessage(RemoteMessage? message) async {
  if (message != null) {
    var notificaitonId = message.data['notificationId'];
    if (notificaitonId != null)
      _notificationController.updateNotificationHistoryStatus(
          notificaitonId, 'read');
    var link = message.data['link'];
    var linkType = message.data['linkType'];
    checkUrlAndNavigate(linkType, link);
  }
}

Future<void> handleClickNotification(RemoteMessage? message) async {
  if (message != null) {
    var notificaitonId = message.data['notificationId'];
    if (notificaitonId != null)
      _notificationController.updateNotificationHistoryStatus(
          notificaitonId, 'read');

    var link = message.data['link'];
    var linkType = message.data['linkType'];
    checkUrlAndNavigate(linkType, link);
  }
}

Future initPushNotifications() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  FirebaseMessaging.instance.getInitialMessage().then(handleBackgroundMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(handleClickNotification);
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  FirebaseMessaging.onMessage.listen((message) async {
    final notification = message.notification;
    final imageUrl = message.data['imageUrl'];
    var base64String;
    if (imageUrl != null) base64String = await networkImageToBase64(imageUrl);
    if (notification == null) return;
    _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
                _androidChannel.id, _androidChannel.name,
                channelDescription: _androidChannel.description,
                importance: Importance.high,
                largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
                styleInformation: imageUrl != null
                    ? BigPictureStyleInformation(
                        ByteArrayAndroidBitmap.fromBase64String(
                            base64String.toString()),
                      )
                    : null,
                icon: "@mipmap/ic_launcher")),
        payload: jsonEncode(message.toMap()));
    _notificationController.getNotificationCount();
  });
}

Future<String?> networkImageToBase64(imageUrl) async {
  final response = await http.get(Uri.parse(imageUrl));
  final bytes = response.bodyBytes;
  final base64String = base64Encode(bytes);
  return base64String;
}

getPath(String? path, int type) {
  List<String> parts = path!.split("/");
  if (parts.length > 1) {
    String pathName = parts[type];
    return pathName;
  }
}

checkUrlAndNavigate(linkType, link) async {
  if (link != null) {
    if (link.contains('collections')) {
      var splittedLink = link.split('/');
      var collectionId = splittedLink[splittedLink.length - 1];
      var result =
          await Get.toNamed('/collection', arguments: {'id': collectionId});
    } else if (link.contains('products')) {
      var splittedLink = link.split('/');
      var productId = splittedLink[splittedLink.length - 1];
      var argument = new CommonModel(sId: productId);
      var result = await Get.toNamed('/productDetail', arguments: argument);
    } else if (link.contains('cart')) {
      var result = await Get.toNamed('/cart');
    } else if (linkType == 'external-url') {
      if (link.startsWith('http://') || link.startsWith('https://')) {
        final Uri url = Uri.parse(link);
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch $link';
        }
      }
    } else if (linkType == 'home') {
      var result = await Get.toNamed('/home');
    } else {
      var result = await Get.toNamed('/home');
    }
  } else {
    var result = await Get.toNamed('/home');
  }
}

Future initLocalNotifications() async {
  const ios = DarwinInitializationSettings();
  const android = AndroidInitializationSettings('@mipmap/ic_launcher');
  const settings = InitializationSettings(android: android, iOS: ios);
  await _localNotification.initialize(settings,
      onDidReceiveNotificationResponse: (payload) {
    final message =
        RemoteMessage.fromMap(jsonDecode(payload.payload.toString()));
    handleClickNotification(message);
  });

  final platform = _localNotification.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();
  await platform?.createNotificationChannel(_androidChannel);
}
