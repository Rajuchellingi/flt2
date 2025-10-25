import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/model/loyality.model.dart';
import 'package:get/get.dart';

class LoyalityAchievementController extends GetxController with BaseController {
  var selectedRule = new EarningRuleDataVM(
          contentDescription: null,
          contentLink: null,
          frequency: null,
          id: null,
          mileStoneStage: null,
          mileStoneStageFiveTitle: null,
          isBirthDay: null,
          isFacebook: null,
          isInstagram: null,
          isLinkedin: null,
          isSignUp: null,
          isTwitter: null,
          isYoutube: null,
          mileStoneStageExpiryDays: null,
          socialMediaLinkType: null,
          mileStoneStageFiveValue: null,
          mileStoneStageFourTitle: null,
          mileStoneStageFourValue: null,
          mileStoneStageOneTitle: null,
          mileStoneStageOneValue: null,
          mileStoneStageThreeTitle: null,
          mileStoneStageThreeValue: null,
          mileStoneStageTwoTitle: null,
          mileStoneStageTwoValue: null,
          mileStoneStageType: null,
          rewardCoin: null,
          rewardDescription: null,
          rewardTitle: null,
          status: null,
          type: null)
      .obs;

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    if (args != null) selectedRule.value = args['rule'];
  }
}
