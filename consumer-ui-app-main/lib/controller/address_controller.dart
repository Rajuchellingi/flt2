// ignore_for_file: unused_local_variable, invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/user/user_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/address_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddressController extends GetxController with BaseController {
  UserRepo? userRepo;
  var userId;
  var isLoading = false.obs;
  var userAddress = [].obs;
  var selectedShippingAddress;
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();

  @override
  void onInit() {
    userId = GetStorage().read('utoken');
    userRepo = new UserRepo();
    getTemplate();
    if (userId != null) {
      getAddress(userId);
    }

    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates
        .firstWhereOrNull((value) => value['id'] == 'manage-address');
    isTemplateLoading.value = false;
  }

  Future getAddress(String id) async {
    this.isLoading.value = true;
    var result = await userRepo!.getUserDetailArrayById(id);
    if (result != null) {
      userAddress.value = userByAddressVMFromJson(result);
      userAddress.refresh();
      // getBillingAddress();
    } else {
      userAddress.value = [];
    }
    this.isLoading.value = false;
  }

  Future editAddress(address) async {
    var result = await Get.toNamed('/addAddress', arguments: address);
    if (result != null && result == true) {
      getAddress(userId);
    }
  }

  Future addAddressPage() async {
    var result = await Get.toNamed('/addAddress');
    if (result != null && result == true) {
      getAddress(userId);
    }
  }

  Future updateDefaltAddress(addressId) async {
    showLoading('Loading...');
    var request = {
      "addressId": addressId,
      // addressInput: new UpdateBillingAddressInput(billingAddress: true),
      "customerAccessToken": userId
    };
    var result = await userRepo!.updateDefaultAddress(request);
    if (result == true) {
      getAddress(userId);
    }
    hideLoading();
  }

  Future updateShippingAddress(addressId) async {
    var request = UpdateShippingAddressRequestModel(
        addressId: addressId, enable: true, sId: userId);
    var result = await userRepo!.updateShippingAddress(request);
    if (result == true) {
      getAddress(userId);
    }
  }

  Future removeAddress(addressId) async {
    showLoading('Loading...');
    var result = await userRepo!.removeAddress(addressId, userId);
    if (result == true) {
      getAddress(userId);
    }
    hideLoading();
  }

  getBillingAddress() {
    var address =
        userAddress.where((address) => address.billingAddress == true).first();
  }

  @override
  void onClose() {
    isLoading.close();
    userAddress.close();
    template.close();
    isTemplateLoading.close();
    super.onClose();
  }
}
