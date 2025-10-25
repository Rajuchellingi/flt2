LoyalityProgramVM loyalityProgramVMFromJson(dynamic str) =>
    (LoyalityProgramVM.fromJson(str));
LoyaltyPointsRewardVM loyalityOrderPointsVMFromJson(dynamic str) =>
    (LoyaltyPointsRewardVM.fromJson(str));

class LoyalityProgramVM {
  late final bool? status;
  late final int? points;
  late final List<EarningRuleDataVM>? earningRuleData;
  late final List<RedemptionRuleDataVM>? redemptionRuleData;
  late final List<CustomerHistoryDetailsVM>? customerHistoryDetails;
  late final List<CustomerScratchcardHistoryVM>? customerScratchcardHistory;
  late final List<CouponDetailsVM>? couponDetails;
  late final List<CustomerAchievementsDetailsVM>? customerAchievementsDetails;
  late final int? waysToRedeemCount;
  late final int? couponsWithDiscountCodeCount;
  late final String? programName;
  late final String? primaryColor;
  late final String? textColor;
  late final String? fontFamily;
  late final String? emailId;
  late final String? mobileNumber;
  late final String? businessName;
  late final String? businessCategory;
  late final String? storeCurrency;
  late final String? storeCountry;
  late final String? storeUrl;
  late final String? storeSignupUrl;
  late final String? storeSignInUrl;
  late final String? storeRedemptionUrl;
  late final List<String>? showSelectedPages;
  late final List<String>? hideSelectedPages;
  late final String? bannerImageUrl;
  late final String? waysToEarnTitle;
  late final String? waysToRedeemTitle;
  late final String? mainTitleWithLogin;
  late final String? mainTitleWithoutLogin;
  late final String? titleWithoutLogin;
  late final String? descriptionWithoutLogin;
  late final String? callToActionSignUpText;
  late final String? calltoActionSignInText;
  late final String? referralProgramTitle;
  late final String? referralLoginDescription;
  late final String? referralLogoutDescription;
  late final String? facebookMessage;
  late final String? whatsappMessage;
  late final String? twitterMessage;
  late final String? emailMessage;
  late final String? copyButtonMessage;
  late final int? mobileOffset;
  late final String? mobileWidgetPosition;
  late final String? mobileWidgetType;
  late final int? desktopOffset;
  late final String? desktopWidgetPosition;
  late final String? desktopWidgetText;
  late final String? desktopWidgetType;
  late final bool? desktopAnimateWidget;
  late final bool? showMobile;
  late final bool? showDesktop;
  late final String? customImageUrl;
  late final String? rewardDesktopBannerLink;
  late final String? rewardMobileBannerLink;
  late final String? loginTitle;
  late final String? loginMainTitle;
  late final String? loginDescription;
  late final String? callToActionEarnLoginText;
  late final String? callToActionRedeemLoginText;
  late final String? logoutTitle;
  late final String? logoutDescription;
  late final String? callToActionSignupText;
  late final String? callToActionLoginText;
  late final String? explainerTitle;
  late final String? explainerDescription;
  late final String? sectionOneTitle;
  late final String? sectionOneDescription;
  late final String? sectionTwoTitle;
  late final String? sectionTwoDescription;
  late final String? sectionThreeTitle;
  late final String? sectionThreeDescription;
  late final String? wayToEarnTitle;
  late final String? wayToEarnDescription;
  late final String? referralDesktopBannerLink;
  late final String? referralMobileBannerLink;
  late final String? referralLoggedInDescription;
  late final String? referralLoggedOutDescription;
  late final String? referralLoggedOutCallToActionSingupText;
  late final String? referralLoggedOutCallToActionSingInText;
  late final String? wayToRedeemTitle;
  late final String? wayToRedeemDescription;
  late final String? referralId;

  LoyalityProgramVM({
    required this.status,
    required this.points,
    required this.earningRuleData,
    required this.redemptionRuleData,
    required this.customerHistoryDetails,
    required this.customerScratchcardHistory,
    required this.customerAchievementsDetails,
    required this.waysToRedeemCount,
    required this.couponsWithDiscountCodeCount,
    required this.programName,
    required this.primaryColor,
    required this.textColor,
    required this.fontFamily,
    required this.emailId,
    required this.mobileNumber,
    required this.businessName,
    required this.businessCategory,
    required this.couponDetails,
    required this.storeCurrency,
    required this.storeCountry,
    required this.storeUrl,
    required this.storeSignupUrl,
    required this.storeSignInUrl,
    required this.storeRedemptionUrl,
    required this.showSelectedPages,
    required this.hideSelectedPages,
    required this.bannerImageUrl,
    required this.waysToEarnTitle,
    required this.waysToRedeemTitle,
    required this.mainTitleWithLogin,
    required this.mainTitleWithoutLogin,
    required this.titleWithoutLogin,
    required this.descriptionWithoutLogin,
    required this.callToActionSignUpText,
    required this.calltoActionSignInText,
    required this.referralProgramTitle,
    required this.referralLoginDescription,
    required this.referralLogoutDescription,
    required this.facebookMessage,
    required this.whatsappMessage,
    required this.twitterMessage,
    required this.emailMessage,
    required this.copyButtonMessage,
    required this.mobileOffset,
    required this.mobileWidgetPosition,
    required this.mobileWidgetType,
    required this.desktopOffset,
    required this.desktopWidgetPosition,
    required this.desktopWidgetText,
    required this.desktopWidgetType,
    required this.desktopAnimateWidget,
    required this.showMobile,
    required this.showDesktop,
    required this.customImageUrl,
    required this.rewardDesktopBannerLink,
    required this.rewardMobileBannerLink,
    required this.loginTitle,
    required this.loginMainTitle,
    required this.loginDescription,
    required this.callToActionEarnLoginText,
    required this.callToActionRedeemLoginText,
    required this.logoutTitle,
    required this.logoutDescription,
    required this.callToActionSignupText,
    required this.callToActionLoginText,
    required this.explainerTitle,
    required this.explainerDescription,
    required this.sectionOneTitle,
    required this.sectionOneDescription,
    required this.sectionTwoTitle,
    required this.sectionTwoDescription,
    required this.sectionThreeTitle,
    required this.sectionThreeDescription,
    required this.wayToEarnTitle,
    required this.wayToEarnDescription,
    required this.referralDesktopBannerLink,
    required this.referralMobileBannerLink,
    required this.referralLoggedInDescription,
    required this.referralLoggedOutDescription,
    required this.referralLoggedOutCallToActionSingupText,
    required this.referralLoggedOutCallToActionSingInText,
    required this.wayToRedeemTitle,
    required this.wayToRedeemDescription,
    required this.referralId,
  });
  LoyalityProgramVM.fromJson(dynamic json) {
    status = json.status;
    points = json.points;
    if (json.earningRuleData != null) {
      earningRuleData = [];
      json.earningRuleData.forEach((v) {
        earningRuleData!.add(new EarningRuleDataVM.fromJson(v));
      });
    }
    if (json.redemptionRuleData != null) {
      redemptionRuleData = [];
      json.redemptionRuleData.forEach((v) {
        redemptionRuleData!.add(new RedemptionRuleDataVM.fromJson(v));
      });
    }
    if (json.couponDetails != null) {
      couponDetails = [];
      json.couponDetails.forEach((v) {
        couponDetails!.add(new CouponDetailsVM.fromJson(v));
      });
    }
    if (json.customerHistoryDetails != null) {
      customerHistoryDetails = [];
      json.customerHistoryDetails.forEach((v) {
        customerHistoryDetails!.add(new CustomerHistoryDetailsVM.fromJson(v));
      });
    }
    if (json.customerScratchcardHistory != null) {
      customerScratchcardHistory = [];
      json.customerScratchcardHistory.forEach((v) {
        customerScratchcardHistory!
            .add(new CustomerScratchcardHistoryVM.fromJson(v));
      });
    }
    if (json.customerAchievementsDetails != null) {
      customerAchievementsDetails = [];
      json.customerAchievementsDetails.forEach((v) {
        customerAchievementsDetails!
            .add(new CustomerAchievementsDetailsVM.fromJson(v));
      });
    }
    waysToRedeemCount = json.waysToRedeemCount;
    couponsWithDiscountCodeCount = json.couponsWithDiscountCodeCount;
    programName = json.programName;
    primaryColor = json.primaryColor;
    textColor = json.textColor;
    fontFamily = json.fontFamily;
    emailId = json.emailId;
    mobileNumber = json.mobileNumber;
    businessName = json.businessName;
    businessCategory = json.businessCategory;
    storeCurrency = json.storeCurrency;
    storeCountry = json.storeCountry;
    storeUrl = json.storeUrl;
    storeSignupUrl = json.storeSignupUrl;
    storeSignInUrl = json.storeSignInUrl;
    storeRedemptionUrl = json.storeRedemptionUrl;
    showSelectedPages = json.showSelectedPages != null
        ? List<String>.from(json.showSelectedPages)
        : [];
    hideSelectedPages = json.hideSelectedPages != null
        ? List<String>.from(json.hideSelectedPages)
        : [];
    bannerImageUrl = json.bannerImageUrl;
    waysToEarnTitle = json.waysToEarnTitle;
    waysToRedeemTitle = json.waysToRedeemTitle;
    mainTitleWithLogin = json.mainTitleWithLogin;
    mainTitleWithoutLogin = json.mainTitleWithoutLogin;
    titleWithoutLogin = json.titleWithoutLogin;
    descriptionWithoutLogin = json.descriptionWithoutLogin;
    callToActionSignUpText = json.callToActionSignUpText;
    calltoActionSignInText = json.calltoActionSignInText;
    referralProgramTitle = json.referralProgramTitle;
    referralLoginDescription = json.referralLoginDescription;
    referralLogoutDescription = json.referralLogoutDescription;
    facebookMessage = json.facebookMessage;
    whatsappMessage = json.whatsappMessage;
    twitterMessage = json.twitterMessage;
    emailMessage = json.emailMessage;
    copyButtonMessage = json.copyButtonMessage;
    mobileOffset = json.mobileOffset;
    mobileWidgetPosition = json.mobileWidgetPosition;
    mobileWidgetType = json.mobileWidgetType;
    desktopOffset = json.desktopOffset;
    desktopWidgetPosition = json.desktopWidgetPosition;
    desktopWidgetText = json.desktopWidgetText;
    desktopWidgetType = json.desktopWidgetType;
    desktopAnimateWidget = json.desktopAnimateWidget;
    showMobile = json.showMobile;
    showDesktop = json.showDesktop;
    customImageUrl = json.customImageUrl;
    rewardDesktopBannerLink = json.rewardDesktopBannerLink;
    rewardMobileBannerLink = json.rewardMobileBannerLink;
    loginTitle = json.loginTitle;
    loginMainTitle = json.loginMainTitle;
    loginDescription = json.loginDescription;
    callToActionEarnLoginText = json.callToActionEarnLoginText;
    callToActionRedeemLoginText = json.callToActionRedeemLoginText;
    logoutTitle = json.logoutTitle;
    logoutDescription = json.logoutDescription;
    callToActionSignupText = json.callToActionSignupText;
    callToActionLoginText = json.callToActionLoginText;
    explainerTitle = json.explainerTitle;
    explainerDescription = json.explainerDescription;
    sectionOneTitle = json.sectionOneTitle;
    sectionOneDescription = json.sectionOneDescription;
    sectionTwoTitle = json.sectionTwoTitle;
    sectionTwoDescription = json.sectionTwoDescription;
    sectionThreeTitle = json.sectionThreeTitle;
    sectionThreeDescription = json.sectionThreeDescription;
    wayToEarnTitle = json.wayToEarnTitle;
    wayToEarnDescription = json.wayToEarnDescription;
    referralDesktopBannerLink = json.referralDesktopBannerLink;
    referralMobileBannerLink = json.referralMobileBannerLink;
    referralLoggedInDescription = json.referralLoggedInDescription;
    referralLoggedOutDescription = json.referralLoggedOutDescription;
    referralLoggedOutCallToActionSingupText =
        json.referralLoggedOutCallToActionSingupText;
    referralLoggedOutCallToActionSingInText =
        json.referralLoggedOutCallToActionSingInText;
    wayToRedeemTitle = json.wayToRedeemTitle;
    wayToRedeemDescription = json.wayToRedeemDescription;
    referralId = json.referralId;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['points'] = points;
    data['earningRuleData'] = earningRuleData!.map((e) => e.toJson()).toList();
    data['redemptionRuleData'] =
        redemptionRuleData!.map((e) => e.toJson()).toList();
    data['customerHistoryDetails'] =
        customerHistoryDetails!.map((e) => e.toJson()).toList();
    data['customerScratchcardHistory'] =
        customerScratchcardHistory?.map((e) => e.toJson()).toList();
    data['customerAchievementsDetails'] =
        customerAchievementsDetails!.map((e) => e.toJson()).toList();
    data['couponDetails'] = couponDetails!.map((e) => e.toJson()).toList();
    data['waysToRedeemCount'] = waysToRedeemCount;
    data['couponsWithDiscountCodeCount'] = couponsWithDiscountCodeCount;
    data['programName'] = programName;
    data['primaryColor'] = primaryColor;
    data['textColor'] = textColor;
    data['fontFamily'] = fontFamily;
    data['emailId'] = emailId;
    data['points'] = points;
    data['mobileNumber'] = mobileNumber;
    data['businessName'] = businessName;
    data['businessCategory'] = businessCategory;
    data['storeCurrency'] = storeCurrency;
    data['storeCountry'] = storeCountry;
    data['storeUrl'] = storeUrl;
    data['storeSignupUrl'] = storeSignupUrl;
    data['storeSignInUrl'] = storeSignInUrl;
    data['storeRedemptionUrl'] = storeRedemptionUrl;
    data['showSelectedPages'] = showSelectedPages;
    data['hideSelectedPages'] = hideSelectedPages;
    data['bannerImageUrl'] = bannerImageUrl;
    data['waysToEarnTitle'] = waysToEarnTitle;
    data['waysToRedeemTitle'] = waysToRedeemTitle;
    data['mainTitleWithLogin'] = mainTitleWithLogin;
    data['mainTitleWithoutLogin'] = mainTitleWithoutLogin;
    data['titleWithoutLogin'] = titleWithoutLogin;
    data['descriptionWithoutLogin'] = descriptionWithoutLogin;
    data['callToActionSignUpText'] = callToActionSignUpText;
    data['calltoActionSignInText'] = calltoActionSignInText;
    data['referralProgramTitle'] = referralProgramTitle;
    data['referralLoginDescription'] = referralLoginDescription;
    data['referralLogoutDescription'] = referralLogoutDescription;
    data['facebookMessage'] = facebookMessage;
    data['whatsappMessage'] = whatsappMessage;
    data['twitterMessage'] = twitterMessage;
    data['emailMessage'] = emailMessage;
    data['copyButtonMessage'] = copyButtonMessage;
    data['mobileOffset'] = mobileOffset;
    data['mobileWidgetPosition'] = mobileWidgetPosition;
    data['mobileWidgetType'] = mobileWidgetType;
    data['desktopOffset'] = desktopOffset;
    data['desktopWidgetPosition'] = desktopWidgetPosition;
    data['desktopWidgetText'] = desktopWidgetText;
    data['desktopWidgetType'] = desktopWidgetType;
    data['desktopAnimateWidget'] = desktopAnimateWidget;
    data['showMobile'] = showMobile;
    data['showDesktop'] = showDesktop;
    data['customImageUrl'] = customImageUrl;
    data['rewardDesktopBannerLink'] = rewardDesktopBannerLink;
    data['rewardMobileBannerLink'] = rewardMobileBannerLink;
    data['loginTitle'] = loginTitle;
    data['loginMainTitle'] = loginMainTitle;
    data['loginDescription'] = loginDescription;
    data['callToActionEarnLoginText'] = callToActionEarnLoginText;
    data['callToActionRedeemLoginText'] = callToActionRedeemLoginText;
    data['logoutTitle'] = logoutTitle;
    data['logoutDescription'] = logoutDescription;
    data['callToActionSignupText'] = callToActionSignupText;
    data['callToActionLoginText'] = callToActionLoginText;
    data['explainerTitle'] = explainerTitle;
    data['explainerDescription'] = explainerDescription;
    data['sectionOneTitle'] = sectionOneTitle;
    data['sectionOneDescription'] = sectionOneDescription;
    data['sectionTwoTitle'] = sectionTwoTitle;
    data['sectionTwoDescription'] = sectionTwoDescription;
    data['sectionThreeTitle'] = sectionThreeTitle;
    data['sectionThreeDescription'] = sectionThreeDescription;
    data['wayToEarnTitle'] = wayToEarnTitle;
    data['wayToEarnDescription'] = wayToEarnDescription;
    data['referralDesktopBannerLink'] = referralDesktopBannerLink;
    data['referralMobileBannerLink'] = referralMobileBannerLink;
    data['referralLoggedInDescription'] = referralLoggedInDescription;
    data['referralLoggedOutDescription'] = referralLoggedOutDescription;
    data['referralLoggedOutCallToActionSingupText'] =
        referralLoggedOutCallToActionSingupText;
    data['referralLoggedOutCallToActionSingInText'] =
        referralLoggedOutCallToActionSingInText;
    data['wayToRedeemTitle'] = wayToRedeemTitle;
    data['wayToRedeemDescription'] = wayToRedeemDescription;
    data['referralId'] = referralId;
    return data;
  }
}

class EarningRuleDataVM {
  late final String? rewardTitle;
  late final String? rewardDescription;
  late final bool? status;
  late final String? type;
  late final int? rewardCoin;
  late final String? frequency;
  late final String? id;
  late final String? contentLink;
  late final String? contentDescription;
  late final int? mileStoneStage;
  late final String? mileStoneStageType;
  late final int? mileStoneStageExpiryDays;
  late final String? mileStoneStageOneTitle;
  late final int? mileStoneStageOneValue;
  late final String? mileStoneStageTwoTitle;
  late final int? mileStoneStageTwoValue;
  late final String? mileStoneStageThreeTitle;
  late final int? mileStoneStageThreeValue;
  late final String? mileStoneStageFourTitle;
  late final int? mileStoneStageFourValue;
  late final String? mileStoneStageFiveTitle;
  late final int? mileStoneStageFiveValue;
  late final bool? isFacebook;
  late final bool? isInstagram;
  late final bool? isLinkedin;
  late final bool? isTwitter;
  late final bool? isYoutube;
  late final bool? isSignUp;
  late final String? socialMediaLinkType;
  late final bool? isBirthDay;

  EarningRuleDataVM({
    required this.rewardTitle,
    required this.rewardDescription,
    required this.status,
    required this.type,
    required this.rewardCoin,
    required this.frequency,
    required this.id,
    required this.contentLink,
    required this.contentDescription,
    required this.mileStoneStage,
    required this.mileStoneStageType,
    required this.mileStoneStageExpiryDays,
    required this.mileStoneStageOneTitle,
    required this.mileStoneStageOneValue,
    required this.mileStoneStageTwoTitle,
    required this.mileStoneStageTwoValue,
    required this.mileStoneStageThreeTitle,
    required this.mileStoneStageThreeValue,
    required this.mileStoneStageFourTitle,
    required this.mileStoneStageFourValue,
    required this.mileStoneStageFiveTitle,
    required this.mileStoneStageFiveValue,
    required this.isFacebook,
    required this.isInstagram,
    required this.isLinkedin,
    required this.isTwitter,
    required this.isYoutube,
    required this.isSignUp,
    required this.socialMediaLinkType,
    required this.isBirthDay,
  });

  EarningRuleDataVM.fromJson(dynamic json) {
    rewardTitle = json.rewardTitle;
    rewardDescription = json.rewardDescription;
    status = json.status;
    type = json.type;
    rewardCoin = json.rewardCoin;
    frequency = json.frequency;
    id = json.id;
    contentLink = json.contentLink;
    contentDescription = json.contentDescription;
    mileStoneStage = json.mileStoneStage;
    mileStoneStageType = json.mileStoneStageType;
    mileStoneStageExpiryDays = json.mileStoneStageExpiryDays;
    mileStoneStageOneTitle = json.mileStoneStageOneTitle;
    mileStoneStageOneValue = json.mileStoneStageOneValue;
    mileStoneStageTwoTitle = json.mileStoneStageTwoTitle;
    mileStoneStageTwoValue = json.mileStoneStageTwoValue;
    mileStoneStageThreeTitle = json.mileStoneStageThreeTitle;
    mileStoneStageThreeValue = json.mileStoneStageThreeValue;
    mileStoneStageFourTitle = json.mileStoneStageFourTitle;
    mileStoneStageFourValue = json.mileStoneStageFourValue;
    mileStoneStageFiveTitle = json.mileStoneStageFiveTitle;
    mileStoneStageFiveValue = json.mileStoneStageFiveValue;
    isFacebook = json.isFacebook;
    isInstagram = json.isInstagram;
    isLinkedin = json.isLinkedin;
    isTwitter = json.isTwitter;
    isYoutube = json.isYoutube;
    isSignUp = json.isSignUp;
    socialMediaLinkType = json.socialMediaLinkType;
    isBirthDay = json.isBirthDay;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rewardTitle'] = rewardTitle;
    data['rewardDescription'] = rewardDescription;
    data['status'] = status;
    data['type'] = type;
    data['rewardCoin'] = rewardCoin;
    data['frequency'] = frequency;
    data['id'] = id;
    data['contentLink'] = contentLink;
    data['contentDescription'] = contentDescription;
    data['mileStoneStage'] = mileStoneStage;
    data['mileStoneStageType'] = mileStoneStageType;
    data['mileStoneStageExpiryDays'] = mileStoneStageExpiryDays;
    data['mileStoneStageOneTitle'] = mileStoneStageOneTitle;
    data['mileStoneStageOneValue'] = mileStoneStageOneValue;
    data['mileStoneStageTwoTitle'] = mileStoneStageTwoTitle;
    data['mileStoneStageTwoValue'] = mileStoneStageTwoValue;
    data['mileStoneStageThreeTitle'] = mileStoneStageThreeTitle;
    data['mileStoneStageThreeValue'] = mileStoneStageThreeValue;
    data['mileStoneStageFourTitle'] = mileStoneStageFourTitle;
    data['mileStoneStageFourValue'] = mileStoneStageFourValue;
    data['mileStoneStageFiveTitle'] = mileStoneStageFiveTitle;
    data['mileStoneStageFiveValue'] = mileStoneStageFiveValue;
    data['isFacebook'] = isFacebook;
    data['isInstagram'] = isInstagram;
    data['isLinkedin'] = isLinkedin;
    data['isTwitter'] = isTwitter;
    data['isYoutube'] = isYoutube;
    data['isSignUp'] = isSignUp;
    data['socialMediaLinkType'] = socialMediaLinkType;
    data['isBirthDay'] = isBirthDay;
    return data;
  }
}

class CouponDetailsVM {
  late final String? couponCode;
  late final String? creationDate;
  late final int? expiryDays;
  late final String? status;
  late final String? description;
  late final String? title;
  late final String? id;

  CouponDetailsVM({
    required this.couponCode,
    required this.creationDate,
    required this.expiryDays,
    required this.status,
    required this.description,
    required this.title,
    required this.id,
  });

  CouponDetailsVM.fromJson(dynamic json) {
    couponCode = json.couponCode;
    creationDate = json.creationDate;
    expiryDays = json.expiryDays;
    status = json.status;
    description = json.description;
    title = json.title;
    id = json.id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['couponCode'] = couponCode;
    data['creationDate'] = creationDate;
    data['expiryDays'] = expiryDays;
    data['status'] = status;
    data['description'] = description;
    data['title'] = title;
    data['id'] = id;
    return data;
  }
}

class RedemptionRuleDataVM {
  late final String? title;
  late final String? description;
  late final int? expiryDays;
  late final int? requiredCoin;
  late final String? discountCode;
  late final bool? isCodeGenerate;
  late final bool? isPublished;
  late final String? id;
  late final int? dynamicStartingDiscount;
  late final int? dynamicMaximumPossibleDiscount;
  late final String? discountType;
  late final String? offerType;

  RedemptionRuleDataVM({
    required this.title,
    required this.description,
    required this.expiryDays,
    required this.requiredCoin,
    required this.discountCode,
    required this.isCodeGenerate,
    required this.isPublished,
    required this.id,
    required this.dynamicStartingDiscount,
    required this.dynamicMaximumPossibleDiscount,
    required this.discountType,
    required this.offerType,
  });

  RedemptionRuleDataVM.fromJson(dynamic json) {
    title = json.title;
    description = json.description;
    expiryDays = json.expiryDays;
    requiredCoin = json.requiredCoin;
    discountCode = json.discountCode;
    isCodeGenerate = json.isCodeGenerate;
    isPublished = json.isPublished;
    id = json.id;
    dynamicStartingDiscount = json.dynamicStartingDiscount;
    dynamicMaximumPossibleDiscount = json.dynamicMaximumPossibleDiscount;
    discountType = json.discountType;
    offerType = json.offerType;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = title;
    data['description'] = description;
    data['expiryDays'] = expiryDays;
    data['requiredCoin'] = requiredCoin;
    data['discountCode'] = discountCode;
    data['isCodeGenerate'] = isCodeGenerate;
    data['isPublished'] = isPublished;
    data['id'] = id;
    data['dynamicStartingDiscount'] = dynamicStartingDiscount;
    data['dynamicMaximumPossibleDiscount'] = dynamicMaximumPossibleDiscount;
    data['discountType'] = discountType;
    data['offerType'] = offerType;
    return data;
  }
}

class CustomerHistoryDetailsVM {
  late final String? id;
  late final String? title;
  late final String? description;
  late final String? redeemCoins;
  late final String? creationDate;

  CustomerHistoryDetailsVM({
    required this.id,
    required this.title,
    required this.description,
    required this.redeemCoins,
    required this.creationDate,
  });

  CustomerHistoryDetailsVM.fromJson(dynamic json) {
    id = json.id;
    title = json.title;
    description = json.description;
    redeemCoins = json.redeemCoins;
    creationDate = json.creationDate;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['redeemCoins'] = redeemCoins;
    data['creationDate'] = creationDate;
    return data;
  }
}

class CustomerAchievementsDetailsVM {
  late final currentStage;
  late final earningRuleId;
  late final amount;
  late final status;
  late final creationDate;

  CustomerAchievementsDetailsVM({
    required this.currentStage,
    required this.earningRuleId,
    required this.amount,
    required this.status,
    required this.creationDate,
  });

  CustomerAchievementsDetailsVM.fromJson(dynamic json) {
    currentStage = json.currentStage;
    earningRuleId = json.earningRuleId;
    amount = json.amount;
    status = json.status;
    creationDate = json.creationDate;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentStage'] = currentStage;
    data['earningRuleId'] = earningRuleId;
    data['amount'] = amount;
    data['status'] = status;
    data['creationDate'] = creationDate;
    return data;
  }
}

class CustomerScratchcardHistoryVM {
  late final String? shopId;
  late final String? customerId;
  late final String? orderId;
  late final String? creationDate;
  late final bool? visibility;
  late final List<ScratchCardConditionVM>? scartchCardCondition;
  late final List<SpinWheelConditionVM>? spinWheelCondition;
  late final String? scratchCardId;
  late final String? type;
  late final String? earningRuleId;
  late final String? expiryDays;
  late final String? seletedSpinWheelId;

  CustomerScratchcardHistoryVM({
    required this.shopId,
    required this.customerId,
    required this.creationDate,
    required this.visibility,
    required this.scartchCardCondition,
    required this.spinWheelCondition,
    required this.scratchCardId,
    required this.orderId,
    required this.type,
    required this.earningRuleId,
    required this.expiryDays,
    required this.seletedSpinWheelId,
  });

  CustomerScratchcardHistoryVM.fromJson(dynamic json) {
    shopId = json.shopId;
    customerId = json.customerId;
    creationDate = json.creationDate;
    orderId = json.orderId;
    visibility = json.visibility;
    if (json.scartchCardCondition != null) {
      scartchCardCondition = [];
      json.scartchCardCondition.forEach((v) {
        scartchCardCondition!.add(new ScratchCardConditionVM.fromJson(v));
      });
    }
    if (json.spinWheelCondition != null) {
      spinWheelCondition = [];
      json.spinWheelCondition.forEach((v) {
        spinWheelCondition!.add(new SpinWheelConditionVM.fromJson(v));
      });
    }
    scratchCardId = json.scratchCardId;
    type = json.type;
    earningRuleId = json.earningRuleId;
    expiryDays = json.expiryDays;
    seletedSpinWheelId = json.seletedSpinWheelId;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopId'] = shopId;
    data['customerId'] = customerId;
    data['orderId'] = orderId;
    data['creationDate'] = creationDate;
    data['visibility'] = visibility;
    data['scartchCardCondition'] =
        scartchCardCondition?.map((e) => e.toJson()).toList();
    data['spinWheelCondition'] =
        spinWheelCondition?.map((e) => e.toJson()).toList();
    data['scratchCardId'] = scratchCardId;
    data['type'] = type;
    data['earningRuleId'] = earningRuleId;
    data['expiryDays'] = expiryDays;
    data['seletedSpinWheelId'] = seletedSpinWheelId;
    return data;
  }
}

class ScratchCardConditionVM {
  late final String? scratchCardType;
  late final String? scratchCardDiscountType;
  late final String? scratchCardValue;
  late final String? scratchCardRedemptionExpirayDays;
  late final String? scratchCardLabel;
  late final String? id;

  ScratchCardConditionVM({
    required this.scratchCardType,
    required this.scratchCardDiscountType,
    required this.scratchCardValue,
    required this.scratchCardRedemptionExpirayDays,
    required this.scratchCardLabel,
    required this.id,
  });

  ScratchCardConditionVM.fromJson(dynamic json) {
    scratchCardType = json.scratchCardType;
    scratchCardDiscountType = json.scratchCardDiscountType;
    scratchCardValue = json.scratchCardValue;
    scratchCardRedemptionExpirayDays = json.scratchCardRedemptionExpirayDays;
    scratchCardLabel = json.scratchCardLabel;
    id = json.id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scratchCardType'] = scratchCardType;
    data['scratchCardDiscountType'] = scratchCardDiscountType;
    data['scratchCardValue'] = scratchCardValue;
    data['scratchCardRedemptionExpirayDays'] = scratchCardRedemptionExpirayDays;
    data['scratchCardLabel'] = scratchCardLabel;
    data['_id'] = id;
    return data;
  }
}

class SpinWheelConditionVM {
  late final String? spinWheelType;
  late final String? spinWheelDiscountType;
  late final String? spinWheelValue;
  late final String? spinWheelRedemptionExpirayDays;
  late final bool? isScratchCard;
  late final String? spinWheelLabel;
  late final String? spinWheelId;
  late final String? id;

  SpinWheelConditionVM({
    required this.spinWheelType,
    required this.spinWheelDiscountType,
    required this.spinWheelValue,
    required this.spinWheelRedemptionExpirayDays,
    required this.isScratchCard,
    required this.spinWheelLabel,
    required this.spinWheelId,
    required this.id,
  });

  SpinWheelConditionVM.fromJson(dynamic json) {
    spinWheelType = json.spinWheelType;
    spinWheelDiscountType = json.spinWheelDiscountType;
    spinWheelValue = json.spinWheelValue;
    spinWheelRedemptionExpirayDays = json.spinWheelRedemptionExpirayDays;
    isScratchCard = json.isScratchCard;
    spinWheelLabel = json.spinWheelLabel;
    spinWheelId = json.spinWheelId;
    id = json.id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spinWheelType'] = spinWheelType;
    data['spinWheelDiscountType'] = spinWheelDiscountType;
    data['spinWheelValue'] = spinWheelValue;
    data['spinWheelRedemptionExpirayDays'] = spinWheelRedemptionExpirayDays;
    data['isScratchCard'] = isScratchCard;
    data['spinWheelLabel'] = spinWheelLabel;
    data['spinWheelId'] = spinWheelId;
    data['_id'] = id;
    return data;
  }
}

class LoyaltyPointsRewardVM {
  late final int? points;
  late final int? coinsToReward;

  LoyaltyPointsRewardVM({
    required this.points,
    required this.coinsToReward,
  });

  LoyaltyPointsRewardVM.fromJson(dynamic json) {
    points = json.points;
    coinsToReward = json.coinsToReward;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = points;
    data['coinsToReward'] = coinsToReward;
    return data;
  }
}
