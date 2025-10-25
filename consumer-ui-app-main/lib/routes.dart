import 'package:black_locust/common_component/test_widget.dart';
import 'package:black_locust/config/configConstant.dart';
import 'package:black_locust/controller/binding/account_binding.dart';
import 'package:black_locust/controller/binding/add_review_binding.dart';
import 'package:black_locust/controller/binding/addreess_binding.dart';
import 'package:black_locust/controller/binding/apply_coupen_binding.dart';
import 'package:black_locust/controller/binding/booking_confirmed_binding.dart';
import 'package:black_locust/controller/binding/booking_detail_binding.dart';
import 'package:black_locust/controller/binding/booking_history_binding.dart';
import 'package:black_locust/controller/binding/booking_payment_binding.dart';
import 'package:black_locust/controller/binding/booking_payment_success_binding.dart';
import 'package:black_locust/controller/binding/booking_summary_binding.dart';
import 'package:black_locust/controller/binding/cart_binding.dart';
import 'package:black_locust/controller/binding/cart_login_message_binding.dart';
import 'package:black_locust/controller/binding/category_binding.dart';
import 'package:black_locust/controller/binding/checkout_binding.dart';
import 'package:black_locust/controller/binding/collection_binding.dart';
import 'package:black_locust/controller/binding/collection_brand_binding.dart';
import 'package:black_locust/controller/binding/enquiry_confirmation_binding.dart';
import 'package:black_locust/controller/binding/enquiry_detail_binding.dart';
import 'package:black_locust/controller/binding/enquiry_history_binding.dart';
import 'package:black_locust/controller/binding/forgot_password_binding.dart';
import 'package:black_locust/controller/binding/home_page_binding.dart';
import 'package:black_locust/controller/binding/html_web_view_binding.dart';
import 'package:black_locust/controller/binding/landing_page_binding.dart';
import 'package:black_locust/controller/binding/loyality_achievement_binding.dart';
import 'package:black_locust/controller/binding/loyality_coupon_wallet_binding.dart';
import 'package:black_locust/controller/binding/multi_booking_binding.dart';
import 'package:black_locust/controller/binding/notification_binding.dart';
import 'package:black_locust/controller/binding/order_confirmed_binding.dart';
import 'package:black_locust/controller/binding/order_detail_binding.dart';
import 'package:black_locust/controller/binding/order_history_binding.dart';
import 'package:black_locust/controller/binding/pages_binding.dart';
import 'package:black_locust/controller/binding/payment_verification_binding.dart';
import 'package:black_locust/controller/binding/payment_web_view_binding.dart';
import 'package:black_locust/controller/binding/product_detail_binding.dart';
import 'package:black_locust/controller/binding/profile_binding.dart';
import 'package:black_locust/controller/binding/return_binding.dart';
import 'package:black_locust/controller/binding/review_binding.dart';
import 'package:black_locust/controller/binding/search_binding.dart';
import 'package:black_locust/controller/binding/update_profile_binding.dart';
import 'package:black_locust/controller/binding/welcome_screen_binding.dart';
import 'package:black_locust/controller/binding/wishlist_binding.dart';
import 'package:black_locust/controller/binding/wishlist_collection_binding.dart';
import 'package:black_locust/controller/binding/wishlist_login_message_binding.dart';
import 'package:black_locust/new_password/screens/new_password_screen.dart';
import 'package:black_locust/view/add_address/screens/add_address_screen.dart';
import 'package:black_locust/view/add_address_v1/screens/add_address_v1_screen.dart';
import 'package:black_locust/view/add_review/screens/add_review_screen.dart';
import 'package:black_locust/view/address/screens/address_screen.dart';
import 'package:black_locust/view/address_v1/screens/address_v1_screen.dart';
import 'package:black_locust/view/apply_coupen/screens/apply_coupen_screen.dart';
import 'package:black_locust/view/booking_confirmed/screens/booking_confirmed_screen.dart';
import 'package:black_locust/view/booking_detail/screens/booking_detail_screen.dart';
import 'package:black_locust/view/booking_history/screens/booking_history_screen.dart';
import 'package:black_locust/view/booking_payment/screens/booking_payment_screen.dart';
import 'package:black_locust/view/booking_payment_success/screens/booking_payment_success_screen.dart';
import 'package:black_locust/view/booking_summary/screens/booking_summary_screen.dart';
import 'package:black_locust/view/cart_login_message/screens/cart_login_message_screen.dart';
import 'package:black_locust/view/cart_v1/screens/cart_v1_screen.dart';
import 'package:black_locust/view/checkout/screens/checkout_screen.dart';
import 'package:black_locust/view/cart/screens/cart_screen.dart';
import 'package:black_locust/view/checkout_v1/screens/checkout_v1_screen.dart';
import 'package:black_locust/view/checkout_v1/screens/payment_verification.dart';
import 'package:black_locust/view/checkout_v1/screens/payment_web_view.dart';
import 'package:black_locust/view/collection/screens/collection_filter_screen.dart';
import 'package:black_locust/view/collection/screens/collection_screen.dart';
import 'package:black_locust/view/collection_brand/screens/brandCollection_screen.dart';
import 'package:black_locust/view/enquiry_Details/screens/enquiry_detail_v1_screen.dart';
import 'package:black_locust/view/enquiry_confirmed/screens/enquiry_confirmed_screen.dart';
import 'package:black_locust/view/enquiry_history/screens/enquiry_history_screen.dart';
import 'package:black_locust/view/forgot_password/screens/forgot_password_screen.dart';
import 'package:black_locust/view/forgot_password_v1/screens/forgot_password_v1_screen.dart';
import 'package:black_locust/view/html_web_view/screens/html_web_view_screen.dart';
import 'package:black_locust/view/landing_page/screens/landing_page_screen.dart';
import 'package:black_locust/view/login/screens/login_screen.dart';
import 'package:black_locust/view/loyality_achievement/screens/loyality_achievement_screen.dart';
import 'package:black_locust/view/loyality_coupon_wallet/screens/loyality_coupon_wallet_screen.dart';
import 'package:black_locust/view/loyality_reward/screens/loyality_reward_screen.dart';
import 'package:black_locust/view/multi_booking/screens/apply_different_quantity_screen.dart';
import 'package:black_locust/view/multi_booking/screens/apply_same_quantity_screen.dart';
import 'package:black_locust/view/multi_booking/screens/multi_booking_screen.dart';
import 'package:black_locust/view/my_account/screens/my_account_screen.dart';
import 'package:black_locust/view/my_profile/screens/my_profile_screen.dart';
import 'package:black_locust/view/my_profile_v1/screens/my_profile_v1_screen.dart';
import 'package:black_locust/view/notifications/screens/notification_screen.dart';
import 'package:black_locust/view/order_confirmed/screens/order_confirmed_screen.dart';
import 'package:black_locust/view/order_detail/screens/order_detail_screen.dart';
import 'package:black_locust/view/order_detail_v1/screens/order_detail_v1_screen.dart';
import 'package:black_locust/view/order_history/screens/order_history_screen.dart';
import 'package:black_locust/view/otp_verification/screens/otp_verification_screen.dart';
import 'package:black_locust/view/product_detail/screens/product_detail_screen.dart';
import 'package:black_locust/view/register/screens/registration_screen.dart';
import 'package:black_locust/view/return/screens/return_screen.dart';
import 'package:black_locust/view/review/screens/review_screen.dart';
import 'package:black_locust/view/search/screens/search_screen.dart';
import 'package:black_locust/view/secondary_form/screens/secondary_form_screen.dart';
import 'package:black_locust/view/update_profile/screens/update_profile_screen.dart';
import 'package:black_locust/view/welcom_screen/screens/welcome_screen.dart';
import 'package:black_locust/view/wishlist/screens/wishlist_screen.dart';
import 'package:black_locust/view/wishlist_collection/screens/wishlist_collection_screen.dart';
import 'package:black_locust/view/wishlist_login_message/screens/wishlist_login_message_screen.dart';
import 'package:black_locust/view/wishlist_v1/screens/wishlist_v1_screen.dart';
import 'package:get/get.dart';

import 'common_component/connectivity_wrapper.dart';
import 'view/category/screens/category_screen.dart';
import 'view/home/screens/home_screen.dart';
import 'view/policy_page/screens/policy_page_screen.dart';

class RouteConfig {
  static var route = [
    GetPage(
        preventDuplicates: true,
        transition: Transition.noTransition,
        binding: HomePageBinding(),
        name: '/home',
        page: () => ConnectivityWrapper(child: HomeScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/category',
        binding: CategoryBinding(),
        page: () => ConnectivityWrapper(child: CategoryScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/collection',
        binding: CollectionBinding(),
        page: () => ConnectivityWrapper(child: CollectionScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/brandCollection',
        binding: BrandCollectionBinding(),
        page: () => ConnectivityWrapper(child: BrandCollectionScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/collectionFilter',
        page: () => ConnectivityWrapper(child: CollectionFilterScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/productDetail',
        binding: ProductDetailBinding(),
        page: () => ConnectivityWrapper(child: ProductDetailScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/cart',
        page: () => ConnectivityWrapper(
            child: platform == 'shopify' ? CartScreen() : CartV1Screen()),
        binding: CartBinding()),
    GetPage(
        transition: Transition.noTransition,
        name: '/checkout',
        binding: CheckoutBinding(),
        page: () => ConnectivityWrapper(
            child:
                platform == 'shopify' ? CheckoutScreen() : CheckoutV1Screen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/checkoutSummary',
        binding: CheckoutBinding(),
        page: () => ConnectivityWrapper(child: CheckoutV1Screen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/applyCoupon',
        binding: ApplyCoupenBinding(),
        page: () => ConnectivityWrapper(child: ApplyCoupenScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/notification',
        binding: NotificationBinding(),
        page: () => ConnectivityWrapper(child: NotificationScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/myAccount',
        binding: AccountBinding(),
        page: () => ConnectivityWrapper(child: MyAccountScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/pages',
        binding: PagesBinding(),
        page: () => ConnectivityWrapper(child: PolicyPageScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/webView',
        binding: HtmlWebViewBinding(),
        page: () => ConnectivityWrapper(child: HtmlWebViewScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/paymentWebView',
        binding: PaymentWebViewBinding(),
        page: () => ConnectivityWrapper(child: PaymentWebView())),
    GetPage(
        transition: Transition.noTransition,
        name: '/paymentVerification',
        binding: PaymentVerificationBinding(),
        page: () => ConnectivityWrapper(child: PaymentVerification())),
    GetPage(
        transition: Transition.noTransition,
        name: '/login',
        page: () => ConnectivityWrapper(child: LoginScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/register',
        page: () => ConnectivityWrapper(child: RegistrationScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/address',
        binding: AddressBinding(),
        page: () => ConnectivityWrapper(
            child:
                platform == 'shopify' ? AddressScreen() : AddressV1Screen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/addAddress',
        page: () => ConnectivityWrapper(
            child: platform == 'shopify'
                ? AddAddressScreen()
                : AddAddressV1Screen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/orderHistory',
        binding: OrderHistoryBinding(),
        page: () => ConnectivityWrapper(child: OrderHistoryScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/enquiryHistory',
        binding: EnquiryHistoryBinding(),
        page: () => ConnectivityWrapper(child: EnquiryHistoryScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/return',
        binding: ReturnBinding(),
        page: () => ConnectivityWrapper(child: ReturnScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/orderDetail',
        binding: OrderDetailBinding(),
        page: () => ConnectivityWrapper(
            child: platform == 'shopify'
                ? OrderDetailScreen()
                : OrderDetailV1Screen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/enquiryDetail',
        binding: EnquiryDetailBinding(),
        page: () => ConnectivityWrapper(child: EnquiryDetailV1Screen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/profile',
        binding: ProfileBinding(),
        page: () => ConnectivityWrapper(
            child: platform == 'shopify'
                ? MyProfileScreen()
                : MyProfileV1Screen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/updateProfile',
        binding: UpdateProfileBinding(),
        page: () => ConnectivityWrapper(child: UpdateProfileScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/wishlist',
        binding: WishlistBinding(),
        page: () => ConnectivityWrapper(
            child:
                platform == 'shopify' ? WishlistScreen() : WishlistV1Screen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/searchPage',
        binding: SearchBinding(),
        preventDuplicates: false,
        page: () => ConnectivityWrapper(child: SearchScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/multiBooking',
        binding: MultiBookingBinding(),
        preventDuplicates: false,
        page: () => ConnectivityWrapper(child: MultiBookingScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/applySameQuantity',
        binding: MultiBookingBinding(),
        preventDuplicates: false,
        page: () => ConnectivityWrapper(child: ApplySameQuantityScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/applyDifferentQuantity',
        binding: MultiBookingBinding(),
        preventDuplicates: false,
        page: () => ConnectivityWrapper(child: ApplyDifferentQuantityScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/bookingSummary',
        binding: BookingSummaryBinding(),
        preventDuplicates: false,
        page: () => ConnectivityWrapper(child: BookingSummaryScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/bookingConfirmed',
        binding: BookingConfirmedBinding(),
        page: () => ConnectivityWrapper(child: BookingConfirmedScreen())),
    GetPage(
        transition: Transition.noTransition,
        name: '/paymentSuccess',
        binding: BookingPaymentSuccessBinding(),
        page: () => ConnectivityWrapper(child: BookingPaymentSuccessScreen())),
    GetPage(
        transition: Transition.noTransition,
        preventDuplicates: false,
        name: '/orderConfirmation',
        binding: OrderConfirmedBinding(),
        page: () => ConnectivityWrapper(child: OrderConfirmedScreen())),
    GetPage(
        transition: Transition.noTransition,
        preventDuplicates: false,
        name: '/enquiryConfirmation',
        binding: EnquiryConfirmationBinding(),
        page: () => ConnectivityWrapper(child: EnquiryConfirmedScreen())),
    GetPage(
        transition: Transition.noTransition,
        preventDuplicates: false,
        name: '/otp',
        page: () => ConnectivityWrapper(child: OtpVerificationScreen())),
    GetPage(
        transition: Transition.noTransition,
        preventDuplicates: false,
        name: '/forgotPassword',
        binding: ForgotPasswordBinding(),
        page: () => ConnectivityWrapper(
            child: platform == 'shopify'
                ? ForgotPasswordV1Screen()
                : ForgotPasswordScreen())),
    GetPage(
        transition: Transition.noTransition,
        preventDuplicates: false,
        name: '/bookingHistory',
        binding: BookingHistoryBinding(),
        page: () => ConnectivityWrapper(child: BookingHistoryScreen())),
    GetPage(
        transition: Transition.noTransition,
        preventDuplicates: false,
        name: '/bookingDetail',
        binding: BookingDetailBinding(),
        page: () => ConnectivityWrapper(child: BookingDetailScreen())),
    GetPage(
        transition: Transition.noTransition,
        preventDuplicates: false,
        name: '/landingPage',
        binding: LandingPageBinding(),
        page: () => ConnectivityWrapper(child: LandingPageScreen())),
    GetPage(
        transition: Transition.noTransition,
        preventDuplicates: false,
        name: '/newPassword',
        page: () => ConnectivityWrapper(child: NewPasswordScreen())),
    GetPage(
        transition: Transition.noTransition,
        preventDuplicates: false,
        name: '/secondaryDetails',
        page: () => ConnectivityWrapper(child: SecondaryFormScreen())),
    GetPage(
        transition: Transition.noTransition,
        preventDuplicates: false,
        name: '/bookingPayment',
        binding: BookingPaymentBinding(),
        page: () => ConnectivityWrapper(child: BookingPaymentScreen())),
    GetPage(
        transition: Transition.noTransition,
        preventDuplicates: false,
        name: '/wishlistCollection',
        binding: WishlistCollectionBinding(),
        page: () => ConnectivityWrapper(child: WishlistCollectionScreen())),
    GetPage(
        transition: Transition.noTransition,
        preventDuplicates: false,
        name: '/wishlistLoginMessage',
        binding: WishlistLoginMessageBinding(),
        page: () => ConnectivityWrapper(child: WishlistLoginMessageScreen())),
    GetPage(
        transition: Transition.noTransition,
        preventDuplicates: false,
        name: '/cartLoginMessage',
        binding: CartLoginMessageBinding(),
        page: () => ConnectivityWrapper(child: CartLoginMessageScreen())),
    GetPage(
        transition: Transition.noTransition,
        preventDuplicates: false,
        name: '/review',
        binding: ReviewBinding(),
        page: () => ConnectivityWrapper(child: ReviewScreen())),
    GetPage(
        transition: Transition.noTransition,
        preventDuplicates: false,
        name: '/addReview',
        binding: AddReviewBinding(),
        page: () => ConnectivityWrapper(child: AddReviewScreen())),
    GetPage(
        transition: Transition.noTransition,
        preventDuplicates: false,
        name: '/welcomeScreen',
        binding: WelcomeScreenBinding(),
        page: () => ConnectivityWrapper(child: WelcomeScreen())),
    GetPage(
        preventDuplicates: false,
        name: '/loyalityReward',
        page: () => ConnectivityWrapper(child: LoyalityRewardScreen())),
    GetPage(
        preventDuplicates: false,
        binding: LoyalityAchievementBinding(),
        name: '/loyalityAchievement',
        page: () => ConnectivityWrapper(child: LoyaltyAchievementScreen())),
    GetPage(
        preventDuplicates: false,
        binding: LoyalityCouponWalletBinding(),
        name: '/loyalityCouponWallet',
        page: () => ConnectivityWrapper(child: LoyalityCouponWalletScreen())),
    GetPage(
        preventDuplicates: false,
        name: '/test',
        page: () => ConnectivityWrapper(child: IntegrationTest())),
    // GetPage(
    // preventDuplicates: false,
    // name: '/enquityNowPopup',
    // page: () => ConnectivityWrapper(child: EnquiryNowPopup())),
  ];
}
