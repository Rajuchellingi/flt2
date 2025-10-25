// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'package:b2b_graphql_package/modules/subscription/subscription_repo.dart';
import 'package:black_locust/model/subscription.model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/foundation.dart';

class ShopController extends GetxController {
  SubscriptionRepo? subscriptionRepo;
  final _storage = GetStorage();
  final _cacheKey = 'shop_details_cache';
  final _cacheDuration = const Duration(minutes: 30);

  var shopDetail = TokenConfigurationVM(
    accessToken: null,
    error: null,
    shop: null,
    name: null,
    storefrontAccessToken: null,
    message: null,
    sTypename: null,
  ).obs;

  @override
  void onInit() {
    subscriptionRepo = SubscriptionRepo();
    super.onInit();
  }

  Future<String?> getShopifyShopDetails() async {
    try {
      // Check cache first
      final cachedData = _getCachedShopDetails();
      if (cachedData != null) {
        return cachedData;
      }

      // If no cache, fetch from API
      final configuration = await subscriptionRepo!.getShopifyShopForUI();
      if (configuration != null) {
        final configData = tokenConfigurationVMFromJson(configuration);
        shopDetail.value = configData;

        if (configData.storefrontAccessToken != null) {
          await _storage.write("accessToken", configData.storefrontAccessToken);
          await _storage.write("shop", configData.shop);

          // Cache the shop details
          _cacheShopDetails(configData.shop);
        }
        return configData.shop;
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching shop details: $e');
      return null;
    }
  }

  String? _getCachedShopDetails() {
    final cachedData = _storage.read(_cacheKey);
    if (cachedData != null) {
      final timestamp = _storage.read('${_cacheKey}_timestamp');
      if (timestamp != null) {
        final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
        if (DateTime.now().difference(cacheTime) < _cacheDuration) {
          return cachedData;
        }
      }
    }
    return null;
  }

  void _cacheShopDetails(String? shop) {
    if (shop != null) {
      _storage.write(_cacheKey, shop);
      _storage.write(
          '${_cacheKey}_timestamp', DateTime.now().millisecondsSinceEpoch);
    }
  }

  void clearCache() {
    _storage.remove(_cacheKey);
    _storage.remove('${_cacheKey}_timestamp');
  }

  @override
  void onClose() {
    super.onClose();
  }
}
