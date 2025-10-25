// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member

import 'dart:convert';

import 'package:b2b_graphql_package/modules/loyality/loyality_repo.dart';
import 'package:b2b_graphql_package/modules/user/user_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/model/loyality.model.dart';
import 'package:black_locust/model/user_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoyalityController extends GetxController with BaseController {
  LoyalityRepo? loyalityRepo;
  var isDialogOpen = false.obs;
  var isLoyality = false.obs;
  UserRepo? userRepo;
  var loyality = new LoyalityProgramVM(
    earningRuleData: null,
    points: null,
    redemptionRuleData: null,
    customerHistoryDetails: null,
    customerAchievementsDetails: null,
    waysToRedeemCount: null,
    couponsWithDiscountCodeCount: null,
    programName: null,
    primaryColor: null,
    customerScratchcardHistory: null,
    referralId: null,
    status: null,
    textColor: null,
    fontFamily: null,
    emailId: null,
    mobileNumber: null,
    businessName: null,
    businessCategory: null,
    storeCurrency: null,
    storeCountry: null,
    storeUrl: null,
    storeSignupUrl: null,
    storeSignInUrl: null,
    storeRedemptionUrl: null,
    showSelectedPages: null,
    hideSelectedPages: null,
    bannerImageUrl: null,
    waysToEarnTitle: null,
    waysToRedeemTitle: null,
    mainTitleWithLogin: null,
    mainTitleWithoutLogin: null,
    titleWithoutLogin: null,
    descriptionWithoutLogin: null,
    callToActionSignUpText: null,
    calltoActionSignInText: null,
    referralProgramTitle: null,
    referralLoginDescription: null,
    referralLogoutDescription: null,
    facebookMessage: null,
    whatsappMessage: null,
    twitterMessage: null,
    emailMessage: null,
    copyButtonMessage: null,
    mobileOffset: null,
    couponDetails: null,
    mobileWidgetPosition: null,
    mobileWidgetType: null,
    desktopOffset: null,
    desktopWidgetPosition: null,
    desktopWidgetText: null,
    desktopWidgetType: null,
    desktopAnimateWidget: null,
    showMobile: null,
    showDesktop: null,
    customImageUrl: null,
    rewardDesktopBannerLink: null,
    rewardMobileBannerLink: null,
    loginTitle: null,
    loginMainTitle: null,
    loginDescription: null,
    callToActionEarnLoginText: null,
    callToActionRedeemLoginText: null,
    logoutTitle: null,
    logoutDescription: null,
    callToActionSignupText: null,
    callToActionLoginText: null,
    explainerTitle: null,
    explainerDescription: null,
    sectionOneTitle: null,
    sectionOneDescription: null,
    sectionTwoTitle: null,
    sectionTwoDescription: null,
    sectionThreeTitle: null,
    sectionThreeDescription: null,
    wayToEarnTitle: null,
    wayToEarnDescription: null,
    referralDesktopBannerLink: null,
    referralMobileBannerLink: null,
    referralLoggedInDescription: null,
    referralLoggedOutDescription: null,
    referralLoggedOutCallToActionSingupText: null,
    referralLoggedOutCallToActionSingInText: null,
    wayToRedeemTitle: null,
    wayToRedeemDescription: null,
  ).obs;
  var isLoading = false.obs;
  var route = 'login'.obs;
  var userProfile = new UserDetailsVM(
    sId: "",
    altIsdCode: 0,
    userTypeName: "",
    altMobileNumber: "",
    companyName: "",
    contactName: "",
    numberOfAddresses: 0,
    numberOfOrders: 0,
    emailId: null,
    firstName: "",
    gstNumber: "",
    metafields: null,
    isdCode: 0,
    lastName: "",
    mobileNumber: "",
  ).obs;

  var selectedRule = new RedemptionRuleDataVM(
          description: null,
          discountCode: null,
          expiryDays: null,
          id: null,
          isCodeGenerate: null,
          discountType: null,
          dynamicMaximumPossibleDiscount: null,
          dynamicStartingDiscount: null,
          offerType: null,
          isPublished: null,
          requiredCoin: null,
          title: null)
      .obs;

  var selectedCoupon = new CouponDetailsVM(
          couponCode: null,
          creationDate: null,
          expiryDays: null,
          status: null,
          description: null,
          title: null,
          id: null)
      .obs;
  var isCopied = false.obs;
  var isViewAll = false.obs;
  var isViewAllScratchCard = false.obs;
  var copiedCode = ''.obs;
  @override
  void onInit() {
    userRepo = new UserRepo();
    loyalityRepo = LoyalityRepo();
    super.onInit();
  }

  getLoyalityData() async {
    isLoading.value = true;
    isLoyality.value = true;
    var id = GetStorage().read('utoken');
    if (id != null) {
      route.value = 'home';
      await getUserDetails();
    }
    var result =
        await loyalityRepo!.getLoyalityRewardWidget(userProfile.value.emailId);
    if (result != null) {
      loyality.value = loyalityProgramVMFromJson(result);
    }
    isLoading.value = false;
  }

  getLoyalityDataAfterLogin() async {
    isLoading.value = true;
    var id = GetStorage().read('utoken');
    if (id != null) {
      route.value = 'home';
      await getUserDetails();
    }
    var result =
        await loyalityRepo!.getLoyalityRewardWidget(userProfile.value.emailId);
    if (result != null) {
      loyality.value = loyalityProgramVMFromJson(result);
    }
    isLoading.value = false;
  }

  changeRoute(page) {
    Get.toNamed(page);
    isDialogOpen.value = false;
  }

  changeWidgetPage(page) {
    if (page == 'back') {
      var id = GetStorage().read('utoken');
      route.value = id != null ? 'home' : 'login';
      return;
    }
    route.value = page;
  }

  copyCouponCode() {
    isCopied.value = true;
    Clipboard.setData(
        ClipboardData(text: selectedCoupon.value.couponCode.toString()));
    Future.delayed(Duration(seconds: 3), () {
      isCopied.value = false;
    });
  }

  copyHistoryCoupon(code) {
    copiedCode.value = code;
    Clipboard.setData(ClipboardData(text: code.toString()));
    Future.delayed(Duration(seconds: 3), () {
      copiedCode.value = '';
    });
  }

  setSelectedRule(rule) {
    selectedRule.value = rule;
  }

  setSelectedCoupon(rule) {
    route.value = 'redeemed-coupon';
    selectedCoupon.value = rule;
  }

  openOrCloseWidget() {
    isDialogOpen.value = !isDialogOpen.value;
    var id = GetStorage().read('utoken');
    route.value = id != null ? 'home' : 'login';
  }

  Future getUserDetails() async {
    var id = GetStorage().read('utoken');
    if (id == null) return;
    var result = await userRepo!.getUserById(id, []);
    if (result != null) {
      userProfile.value = userDetailsVMFromJson(result);
    }
  }

  Future redeemCoupon() async {
    showLoading("Loading....");
    var result = await loyalityRepo!.redeemLoyalityCoupon(
        userProfile.value.emailId,
        selectedRule.value.requiredCoin,
        selectedRule.value.id,
        userProfile.value.userTypeName);
    if (result != null) {
      selectedCoupon.value = new CouponDetailsVM(
          couponCode: result['couponCode'],
          creationDate: DateTime.now().toUtc().toIso8601String(),
          expiryDays: selectedRule.value.expiryDays,
          status: 'active',
          description: selectedRule.value.description,
          title: selectedRule.value.title,
          id: selectedRule.value.id);
      route.value = 'redeemed-coupon';
      await getCurrentLoayalityData();
      Future.delayed(Duration(seconds: 5), () {
        getCurrentLoayalityData();
      });
    }
    hideLoading();
  }

  getCurrentLoayalityData() async {
    var result =
        await loyalityRepo!.getLoyalityRewardWidget(userProfile.value.emailId);
    if (result != null) {
      loyality.value = loyalityProgramVMFromJson(result);
    }
  }

  Future redeemScratchCard(CustomerScratchcardHistoryVM history) async {
    // showLoading("Redeeming scratch card...");
    var condition =
        history.scartchCardCondition?.map((e) => e.toJson()).toList();
    var result = await loyalityRepo!.redeemScratchCard(
        userProfile.value.emailId,
        history.scratchCardId,
        jsonEncode(condition));
    if (result != null) {
      await getCurrentLoayalityData();
      // hideLoading();
      return true;
    }
    // hideLoading();
    return false;
  }

  Future redeemSpinWheel(spinHistoryId, spinWheelId, earningRuleId) async {
    // showLoading("Redeeming spin wheel reward...");
    var result = await loyalityRepo!.redeemSpinWheel(
        userProfile.value.emailId, spinHistoryId, spinWheelId, earningRuleId);
    if (result != null) {
      await getCurrentLoayalityData();
      // hideLoading();
      return true;
    }
    // hideLoading();
    return false;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
