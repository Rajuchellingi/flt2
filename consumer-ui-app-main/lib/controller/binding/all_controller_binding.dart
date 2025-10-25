import 'package:black_locust/controller/account_setting_controller.dart';
import 'package:black_locust/controller/add_address_controller.dart';
import 'package:black_locust/controller/add_address_v1_controller.dart';
import 'package:black_locust/controller/background_music_controller.dart';
import 'package:black_locust/controller/cart_count_controller.dart';
import 'package:black_locust/controller/category_controller.dart';
import 'package:black_locust/controller/collection_filter.controller.dart';
import 'package:black_locust/controller/collection_filter_v1_controller.dart';
import 'package:black_locust/controller/common_controller.dart';
import 'package:black_locust/controller/common_review_controller.dart';
import 'package:black_locust/controller/common_wishlist_controller.dart';
import 'package:black_locust/controller/dynamic_form_controller.dart';
import 'package:black_locust/controller/forgot_password_controller.dart';
import 'package:black_locust/controller/login_controller.dart';
import 'package:black_locust/controller/login_v1_controller.dart';
import 'package:black_locust/controller/loyality_controller.dart';
import 'package:black_locust/controller/new_password_controller.dart';
import 'package:black_locust/controller/notification_controller.dart';
import 'package:black_locust/controller/order_setting_controller.dart';
import 'package:black_locust/controller/otp_verification_controller.dart';
import 'package:black_locust/controller/plugins_controller.dart';
import 'package:black_locust/controller/predictive_search_controller.dart';
import 'package:black_locust/controller/product_setting_controller.dart';
import 'package:black_locust/controller/profile_controller.dart';
import 'package:black_locust/controller/profile_v1_controller.dart';
import 'package:black_locust/controller/quick_cart_controller.dart';
import 'package:black_locust/controller/registration_controller.dart';
import 'package:black_locust/controller/registration_v1_controller.dart';
import 'package:black_locust/controller/secondary_form_controller.dart';
import 'package:black_locust/controller/sizeChart_controller.dart';
import 'package:black_locust/controller/sizeChart_web_controller.dart';
import 'package:black_locust/controller/speech_to_text_controller.dart';
import 'package:black_locust/controller/update_profile_controller.dart';
import 'package:black_locust/controller/wishlist_popup_controller.dart';
import 'package:get/get.dart';

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CommonReviewController());
    Get.put(LoyalityController());
    Get.put(PluginsController());
    Get.put(ProductSettingController());
    Get.put(CartCountController());
    Get.put(NotificationController());
    Get.put(CommonWishlistController());
    Get.put(OrderSettingController());
    Get.put(MusicController());
    Get.lazyPut<CommonController>(() => CommonController(), fenix: true);
    Get.lazyPut<NewPasswordController>(() => NewPasswordController(),
        fenix: true);
    Get.lazyPut<AddAddressController>(() => AddAddressController(),
        fenix: true);
    Get.lazyPut<AddAddressV1Controller>(() => AddAddressV1Controller(),
        fenix: true);
    Get.lazyPut<CategoryController>(() => CategoryController(), fenix: true);
    Get.lazyPut<QuickCartController>(() => QuickCartController(), fenix: true);
    Get.lazyPut<PredictiveSearchController>(() => PredictiveSearchController(),
        fenix: true);
    Get.lazyPut<SpeechToTextController>(() => SpeechToTextController(),
        fenix: true);
    Get.lazyPut<WishlistPopupController>(() => WishlistPopupController(),
        fenix: true);
    // Get.lazyPut<OrderSettingController>(() => OrderSettingController(),
    //     fenix: true);
    Get.lazyPut<CollectionFilterV1Controller>(
        () => CollectionFilterV1Controller(),
        fenix: true);
    Get.lazyPut<CollectionFilterController>(() => CollectionFilterController(),
        fenix: true);
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController(),
        fenix: true);
    Get.lazyPut<LoginV1Controller>(() => LoginV1Controller(), fenix: true);
    Get.lazyPut<LogInController>(() => LogInController(), fenix: true);
    Get.lazyPut<CommonWishlistController>(() => CommonWishlistController(),
        fenix: true);
    Get.lazyPut<DynamicFormController>(() => DynamicFormController(),
        fenix: true);
    Get.lazyPut<AccountSettingController>(() => AccountSettingController(),
        fenix: true);
    Get.lazyPut<UpdateProfileController>(() => UpdateProfileController(),
        fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<ProfileV1Controller>(() => ProfileV1Controller(), fenix: true);
    Get.lazyPut<OtpVerificationController>(() => OtpVerificationController(),
        fenix: true);
    Get.lazyPut<SizeChartController>(() => SizeChartController(), fenix: true);
    Get.lazyPut<RegistrationV1Controller>(() => RegistrationV1Controller(),
        fenix: true);
    Get.lazyPut<RegistrationController>(() => RegistrationController(),
        fenix: true);
    Get.lazyPut<SecondaryFormController>(() => SecondaryFormController(),
        fenix: true);
    Get.lazyPut<SizeChartDetailPaageController>(
        () => SizeChartDetailPaageController(),
        fenix: true);
  }
}
