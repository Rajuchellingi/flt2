import 'package:b2b_graphql_package/modules/my_account/myAccount_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AccountSettingController extends GetxController with BaseController {
  // UserRepo? userRepo;
  MyAccoutRepo? myAccoutRepo;
  var userId;
  var isLoading = false.obs;
  var cartBagCount = 0.obs;
  var isLoggedIn = false.obs;
  var pageIndex = 0.obs;
  var phoneNumber;
  var accoundMenuCollections = [].obs;

  @override
  void onInit() {
    userId = GetStorage().read('utoken');
    myAccoutRepo = new MyAccoutRepo();
    myAccountCollections();
    // if (userId != null) {
    //   getProfile(userId);
    // }
    super.onInit();
  }

  @override
  void onClose() {
    isLoading.close();
    cartBagCount.close();
    isLoggedIn.close();
    pageIndex.close();
    accoundMenuCollections.close();
    super.onClose();
  }

  void onTabTapped(int index) {
    this.pageIndex.value = index;
  }

  Future myAccountCollections() async {
    this.isLoading.value = true;
    var result = await myAccoutRepo!.myAccountPageMenuList();
    // print("result myAccountCollections ${result}");
    // if (result != null) {
    accoundMenuCollections.value = result['policiesLink'];
    // }
    this.isLoading.value = false;
  }
}
