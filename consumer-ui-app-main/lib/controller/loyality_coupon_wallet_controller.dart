import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/model/loyality.model.dart';
import 'package:get/get.dart';

class LoyalityCouponWalletController extends GetxController
    with BaseController {
  var searchQuery = ''.obs;
  var status = 'all'.obs;
  @override
  void onInit() {
    super.onInit();
  }

  List<CouponDetailsVM> getCoupons(
    List<CouponDetailsVM> allCoupons,
    String? query,
    String? status,
  ) {
    // Step 1: Filter by status
    List<CouponDetailsVM> coupons;
    if (status == null || status == "all") {
      coupons = allCoupons;
    } else {
      coupons = allCoupons.where((coupon) => coupon.status == status).toList();
    }

    // Step 2: If query is null/empty, return filtered list
    if (query == null || query.isEmpty) {
      return coupons;
    }

    // Step 3: Convert query to lowercase
    final lowerQuery = query.toLowerCase();

    // Step 4: Filter by couponCode or title
    return coupons.where((coupon) {
      final couponCode = coupon.couponCode!.toLowerCase();
      final title = coupon.title!.toLowerCase();
      return couponCode.contains(lowerQuery) || title.contains(lowerQuery);
    }).toList();
  }
}
