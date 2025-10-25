// ignore_for_file: invalid_use_of_protected_member, sdk_version_since

import 'dart:async';

import 'package:b2b_graphql_package/modules/multi_booking/multi_booking_repo.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/checkout_v1_model.dart';
import 'package:b2b_graphql_package/modules/checkout/checkout_repo.dart';
import 'package:get/get.dart';

import 'base_controller.dart';

class BookingSummaryController extends GetxController with BaseController {
  MultiBookingRepo? bookingRepo;
  CheckoutRepo? checkoutRepo;
  bool allLoaded = false;
  var isLoading = false.obs;
  var checkoutData = new CheckoutDataVM(products: [], orderSummary: null).obs;
  var state;
  var selectedAddress = new CheckoutAddressVM(
          sId: null,
          city: null,
          country: null,
          contactName: null,
          emailId: null,
          mobileNumber: null,
          address: null,
          landmark: null,
          pinCode: null,
          state: null,
          shippingAddress: null,
          billingAddress: null)
      .obs;
  var bookingToken;
  var isReload = false.obs;
  var isTemplateLoading = false.obs;
  var template = {}.obs;
  final themeController = Get.find<ThemeController>();
  Timer? _timer;
  var duration = 60.obs;

  @override
  void onInit() {
    bookingRepo = MultiBookingRepo();
    checkoutRepo = CheckoutRepo();
    var arguments = Get.arguments;
    if (arguments != null) {
      state = arguments['state'];
    }
    initialLoad();
    getTemplate();
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates
        .firstWhereOrNull((value) => value['id'] == 'booking-summary');
    isTemplateLoading.value = false;
  }

  Future initialLoad() async {
    this.isLoading.value = true;
    await Future.wait([getCheckoutProducts()]);
    this.isLoading.value = false;
  }

  Future getCheckoutProducts() async {
    var result = await bookingRepo!.getBookingDetailByUser(state);
    if (result != null) {
      checkoutData.value = checkoutDataVMFromJson(result);
    }
  }

  Future createBooking() async {
    showLoading("Loading...");
    var result = await bookingRepo!.initiateMultiBookingByUser();
    if (result['error'] == false) {
      bookingToken = result['token'];
      fetchBookingStatus();
    } else {
      hideLoading();
    }
  }

  void fetchBookingStatus() {
    _timer = Timer.periodic(
        Duration(seconds: 1), (Timer t) => reloadBookingStatus());
  }

  void reloadBookingStatus() async {
    if (duration.value > 0) {
      duration.value--;
      if (isReload.value == false) {
        isReload.value = true;
        var result = await checkoutRepo!.checkBookingIsConfirmed(bookingToken);
        if (result != null) {
          if (result['error'] == false) {
            _timer?.cancel();
            hideLoading();
            Get.offAndToNamed('/bookingConfirmed',
                arguments: {"id": result['_id']});
            isReload.value = false;
          } else {
            isReload.value = false;
          }
        }
      }
    } else {
      hideLoading();
      _timer?.cancel();
    }
  }

  @override
  void onClose() {
    isLoading.close();
    checkoutData.close();
    selectedAddress.close();
    duration.close();
    isReload.close();
    template.close();
    isTemplateLoading.close();
    _timer!.cancel();
    super.onClose();
  }
}
