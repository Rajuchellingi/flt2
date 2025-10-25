import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// Session service to cache user session data in memory
/// This reduces disk I/O by avoiding repeated GetStorage reads
class SessionService extends GetxService {
  String? userId;
  String? cartId;
  String? customerId;
  String? cartExpiry;

  Future<SessionService> init() async {
    // Load session data from storage once during initialization
    userId = GetStorage().read('utoken');
    cartId = GetStorage().read('cartId');
    customerId = GetStorage().read('customerId');
    cartExpiry = GetStorage().read('cartExpiry');
    return this;
  }

  /// Update user ID in both memory and storage
  void updateUserId(String? id) {
    userId = id;
    if (id != null) {
      GetStorage().write('utoken', id);
    } else {
      GetStorage().remove('utoken');
    }
  }

  /// Update cart ID in both memory and storage
  void updateCartId(String? id) {
    cartId = id;
    if (id != null) {
      GetStorage().write('cartId', id);
    } else {
      GetStorage().remove('cartId');
    }
  }

  /// Update customer ID in both memory and storage
  void updateCustomerId(String? id) {
    customerId = id;
    if (id != null) {
      GetStorage().write('customerId', id);
    } else {
      GetStorage().remove('customerId');
    }
  }

  /// Update cart expiry in both memory and storage
  void updateCartExpiry(String? expiry) {
    cartExpiry = expiry;
    if (expiry != null) {
      GetStorage().write('cartExpiry', expiry);
    } else {
      GetStorage().remove('cartExpiry');
    }
  }

  /// Clear all session data
  void clearSession() {
    userId = null;
    cartId = null;
    customerId = null;
    cartExpiry = null;
    GetStorage().remove('utoken');
    GetStorage().remove('cartId');
    GetStorage().remove('customerId');
    GetStorage().remove('cartExpiry');
  }

  /// Check if user is logged in
  bool get isLoggedIn => userId != null;
}
