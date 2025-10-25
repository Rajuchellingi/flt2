// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/model/product_setting_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:b2b_graphql_package/modules/product_setting/product_setting_repo.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class SiteSettingController extends GetxController with BaseController {
  ProductSettingRepo? productSettingRepo;
  var siteSetting = new SiteSettingVM(
          googleAnalyticsId: null,
          googleAnalyticsMeasurementId: null,
          enhancedEcommerce: null,
          reCaptcha: null,
          googleTagManagerId: null,
          facebookPixelId: null,
          measurementProtocolApiSecret: null,
          facebookPixelAccessToken: null,
          dynamicAds: null,
          customRobotsUrl: null,
          customSitemapUrl: null,
          themeColor: null)
      .obs;

  @override
  void onInit() {
    productSettingRepo = ProductSettingRepo();
    super.onInit();
  }

  Future getSiteSetting() async {
    var result = await productSettingRepo!.getSiteSetting();
    if (result != null) {
      var response = siteSettingVMFromJson(result);
      siteSetting.value = response;
      return response;
    }
  }

  Future<void> trackPageView(String pathName) async {
    final setting = siteSetting.value;

    if (setting.googleAnalyticsMeasurementId != null &&
        setting.measurementProtocolApiSecret != null) {
      await trackByGoogleAnalytics(pathName);
    }
    if (setting.facebookPixelId != null &&
        setting.facebookPixelAccessToken != null) {
      trackByFacebookPixel(pathName);
    }
  }

  Future<void> trackByFacebookPixel(String pathName) async {
    final String endpoint =
        "https://graph.facebook.com/v22.0/${siteSetting.value.facebookPixelId}/events";
    final Map<String, dynamic> event = {
      "access_token": siteSetting.value.facebookPixelAccessToken,
      "data": [
        {
          "event_name": "PageView",
          "event_time": (DateTime.now().millisecondsSinceEpoch / 1000).round(),
          "user_data": {},
          "custom_data": {"page_path": pathName, "page_title": "Flutter Page"}
        }
      ]
    };

    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(event),
      );
      print("Facebook Pixel Response: ${response.body}");
    } catch (error) {
      print("Error sending Facebook Pixel event: $error");
    }
  }

  Future<void> trackByGoogleAnalytics(String pathName) async {
    final String endpoint =
        "https://www.google-analytics.com/mp/collect?measurement_id=${siteSetting.value.googleAnalyticsMeasurementId}&api_secret=${siteSetting.value.measurementProtocolApiSecret}";

    final Map<String, dynamic> event = {
      "client_id": getClientId(),
      "events": [
        {
          "name": "page_view",
          "params": {
            "page_location": pathName,
            "page_title": "Flutter Page",
          }
        }
      ]
    };

    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(event),
      );

      if (response.statusCode == 200) {
        print("Event sent successfully to Google Analytics");
      } else {
        print("Failed to send event: ${response.body}");
      }
    } catch (error) {
      print("Error sending event: $error");
    }
  }

  String getClientId() {
    String? clientId = GetStorage().read("ga_client_id");

    if (clientId == null) {
      clientId =
          "${DateTime.now().millisecondsSinceEpoch}.${(1000000 + (9999999 * (1 + DateTime.now().second) / 60)).round()}";
      GetStorage().write("ga_client_id", clientId);
    }

    return clientId;
  }

  Future trackActions(event) async {
    final setting = siteSetting.value;
    var google = event['google'];
    var facebook = event['facebook'];
    if (setting.googleAnalyticsMeasurementId != null &&
        setting.enhancedEcommerce == 'enabled' &&
        google != null) {
      await FirebaseAnalytics.instance.logEvent(
        name: google['name'],
        parameters: google['data'],
      );
    }
    if (setting.facebookPixelId != null &&
        setting.facebookPixelAccessToken != null &&
        setting.dynamicAds == 'enabled' &&
        facebook != null) {
      await sendPixelAdEvent(facebook['name'], facebook['data']);
    }
  }

  Future<void> sendPixelAdEvent(
      String event, Map<String, dynamic> eventData) async {
    var accessToken = siteSetting.value.facebookPixelAccessToken;
    var pixelId = siteSetting.value.facebookPixelId;

    final url = Uri.parse('https://graph.facebook.com/v22.0/$pixelId/events');

    final payload = {
      "data": [
        {
          "event_name": event,
          "event_time": (DateTime.now().millisecondsSinceEpoch ~/ 1000),
          "custom_data": eventData,
        }
      ],
      "access_token": accessToken,
    };

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      print('Event sent successfully!');
    } else {
      print('Error sending event: ${response.body}');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
