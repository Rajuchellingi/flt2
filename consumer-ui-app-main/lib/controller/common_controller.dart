import 'package:b2b_graphql_package/modules/registration/registration_repo.dart';
import 'package:black_locust/controller/background_music_controller.dart';
import 'package:black_locust/controller/cart_count_controller.dart';
import 'package:black_locust/controller/common_wishlist_controller.dart';
import 'package:black_locust/controller/notification_controller.dart';
import 'package:black_locust/helper/common_helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CommonController extends GetxController {
  var imageSliderCurrentPageIndex = 0.obs;
  var imageCarouselCurrentPageIndex = 0.obs;
  var pageIndex = 0.obs;
  var previousPage = 0.obs;
  final _countController = Get.find<CartCountController>();
  final musicController = Get.find<MusicController>();
  final _notificationController = Get.find<NotificationController>();
  final commonWishlistController = Get.find<CommonWishlistController>();
  RegistrationRepo? registrationRepo;

  @override
  void onInit() {
    registrationRepo = RegistrationRepo();
    super.onInit();
  }

  imageSliderPageChanges(pageIndex) {
    imageSliderCurrentPageIndex.value = pageIndex;
  }

  imageCarouselPageChanges(pageIndex) {
    imageCarouselCurrentPageIndex.value = pageIndex;
  }

  Future logOut({page = 'home', message = 'Logged out successfully.'}) async {
    GetStorage().remove('utoken');
    GetStorage().remove('cartId');
    GetStorage().remove('customerId');
    GetStorage().remove('wishlist');
    CommonHelper.showSnackBarAddToBag(message);
    _countController.onLogout();
    _notificationController.onLogout();
    musicController.stopMusic();
    registrationRepo!.updateShopifyUserDeviceToken(null, null);
    commonWishlistController.clearAllWishlist();
    if (page == 'login')
      Get.offAndToNamed('/login', arguments: {"path": "/home"});
    else
      Get.offAndToNamed('/home');
  }

  @override
  void onClose() {
    imageSliderCurrentPageIndex.close();
    imageCarouselCurrentPageIndex.close();
    pageIndex.close();
    previousPage.close();
    super.onClose();
  }
}
