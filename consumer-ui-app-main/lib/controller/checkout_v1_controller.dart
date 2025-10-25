// ignore_for_file: invalid_use_of_protected_member, sdk_version_since

import 'dart:async';

import 'package:b2b_graphql_package/modules/booking/booking_repo.dart';
import 'package:b2b_graphql_package/modules/trigger/trigger_repo.dart';
import 'package:b2b_graphql_package/modules/user/user_repo.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/checkout_v1_model.dart';
import 'package:black_locust/model/secondary_detail_model.dart';
import 'package:black_locust/model/user_model.dart';
import 'package:blaze_sdk_flutter/blaze_sdk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b2b_graphql_package/modules/checkout/checkout_repo.dart';
import 'package:b2b_graphql_package/modules/secondary_detail/secondary_detail_repo.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckoutV1Controller extends GetxController with BaseController {
  CheckoutRepo? checkoutRepo;
  BookingRepo? bookingRepo;
  UserRepo? userRepo;
  SecondaryDetailRepo? secondaryFormRepo;
  bool allLoaded = false;
  var isLoading = false.obs;
  var checkoutData = new CheckoutDataVM(products: [], orderSummary: null).obs;
  var address = [].obs;
  var state;
  var paymentMode = 'online'.obs;
  var newQuantityIncrease;
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
  var currentStage = 'address'.obs;
  Timer? _timer;
  var duration = 60.obs;
  late Razorpay _razorpay;
  var bookingToken;
  var isReload = false.obs;
  var secondaryDetails = new SecondaryRegistrationDetailsVM(
          error: null, message: null, formDetails: null)
      .obs;
  var template = {}.obs;
  final themeController = Get.find<ThemeController>();
  var tempOrderId;
  var tempTransactionId;
  var isTemplateLoading = false.obs;
  TriggerRepo? triggerRepo;
  var userProfile = new UserDetailsVM(
    sId: "",
    altIsdCode: 0,
    altMobileNumber: "",
    companyName: "",
    userTypeName: "",
    contactName: "",
    numberOfAddresses: 0,
    numberOfOrders: 0,
    emailId: "",
    firstName: "",
    gstNumber: "",
    isdCode: 0,
    metafields: null,
    lastName: "",
    mobileNumber: "",
  ).obs;

  @override
  void onInit() {
    triggerRepo = TriggerRepo();
    checkoutRepo = CheckoutRepo();
    userRepo = UserRepo();
    bookingRepo = BookingRepo();
    secondaryFormRepo = SecondaryDetailRepo();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    var arguments = Get.arguments;
    if (arguments != null) {
      currentStage.value = arguments['currentStage'];
      state = arguments['state'];
    }
    initialLoad();
    getTemplate();
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'checkout');
    isTemplateLoading.value = false;
  }

  Future initialLoad() async {
    this.isLoading.value = true;
    await Future.wait([getCheckoutProducts(), getAddress(), getUserById()]);
    this.isLoading.value = false;
  }

  Future getUserById() async {
    var result = await userRepo!.getUserById('', null);
    if (result != null) {
      userProfile.value = userDetailsVMFromJson(result);
    }
  }

  Future getCheckoutProducts() async {
    var result = await checkoutRepo!.getCheckoutDetailByUser(state);
    if (result != null) {
      checkoutData.value = checkoutDataVMFromJson(result);
    }
  }

  Future getAddress() async {
    var result = await checkoutRepo!.getAllAddressByUser();
    if (result != null) {
      address.value = checkoutAddressVMFromJson(result);
      if (address.value.isNotEmpty) {
        selectedAddress.value = address.value
            .firstWhereOrNull((element) => element.shippingAddress == true);
      }
    }
  }

  Future changeBillingAddress(addressId) async {
    showLoading("Loading...");
    var result = await checkoutRepo!.changeBillingAddress(addressId);
    if (result != null) {
      await getAddress();
    }
    hideLoading();
  }

  Future changeShippingAddress(addressId) async {
    showLoading("Loading...");
    var result = await checkoutRepo!.changeShippingAddress(addressId);
    if (result != null) {
      await getAddress();
    }
    hideLoading();
  }

  Future openAddAddress() async {
    var result = await Get.toNamed('/addAddress', arguments: {'type': 'new'});
    if (result != null) getAddress();
  }

  Future openEditAddress(address) async {
    var result = await Get.toNamed('/addAddress',
        arguments: {'type': 'edit', 'address': address});
    if (result != null) getAddress();
  }

  Future createBooking() async {
    showLoading("Loading...");
    var result = await checkoutRepo!.initiateBookingByUser();
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
            await triggerRepo!.cancelTriggerNotification('abandoned-cart');
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

  Future getSecondaryForm() async {
    var result = await secondaryFormRepo!.getSecondaryRegistrationFormByUser();
    if (result != null) {
      secondaryDetails.value = secondaryRegistrationFormVMFromJson(result);
    }
  }

  Future openSummaryPage() async {
    showLoading("Loading...");
    var result = await secondaryFormRepo!.getSecondaryRegistrationFormByUser();
    hideLoading();
    var arguments = {
      "currentStage": 'summary',
      "state": selectedAddress.value.state
    };
    if (result != null) {
      secondaryDetails.value = secondaryRegistrationFormVMFromJson(result);
      if (secondaryDetails.value.error == false)
        Get.toNamed('/secondaryDetails', arguments: arguments);
      else
        Get.toNamed('/checkoutSummary', arguments: arguments);
    } else {
      Get.toNamed('/checkoutSummary', arguments: arguments);
    }
  }

  changePaymentMode(mode) {
    paymentMode.value = mode;
  }

  placeOrder() {
    if (paymentMode.value == 'online')
      initiatePayment();
    else if (paymentMode.value == 'cash-on-delivery') initiateCODOrder();
  }

  Future initiateCODOrder() async {
    showLoading("Loading...");
    var result = await checkoutRepo!.initiateCODOrder();
    if (result != null) {
      if (result['error'] == false) {
        tempOrderId = result['tempOrderId'];
        fetchCODOrderStatus(result['tempOrderId']);
      } else {
        hideLoading();
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void fetchCODOrderStatus(tempOrderId) {
    duration.value = 60;
    _timer = Timer.periodic(Duration(seconds: 1),
        (Timer t) => checkCODOrderIsCompleted(tempOrderId));
  }

  void checkCODOrderIsCompleted(tempOrderId) async {
    if (duration.value > 0) {
      duration.value--;
      if (isReload.value == false) {
        isReload.value = true;
        var result = await checkoutRepo!.checkCODOrderIsConfirmed(tempOrderId);
        if (result != null) {
          if (result['error'] == false) {
            _timer?.cancel();
            hideLoading();
            await triggerRepo!.cancelTriggerNotification('abandoned-cart');
            Get.offAndToNamed('/orderConfirmation',
                arguments: {"id": result['orderId']});
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

  Future initiatePayment() async {
    showLoading("Loading...");
    var result = await checkoutRepo!.initiateOrderByUser();
    if (result != null) {
      if (result['error'] == false) {
        tempOrderId = result['tempOrderId'];
        fetchPaymentInitiateStatus(result['tempOrderId']);
      } else {
        hideLoading();
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void fetchPaymentInitiateStatus(tempOrderId) {
    duration.value = 60;
    _timer = Timer.periodic(Duration(seconds: 1),
        (Timer t) => checkPaymentIsInitiated(tempOrderId));
  }

  void checkPaymentIsInitiated(tempOrderId) async {
    if (duration.value > 0) {
      duration.value--;
      if (isReload.value == false) {
        isReload.value = true;
        var result =
            await checkoutRepo!.initiatePaymentByTransaction(tempOrderId);
        if (result != null) {
          if (result['error'] == false) {
            tempTransactionId = result['tempTransactionId'];
            hideLoading();
            _timer?.cancel();
            isReload.value = false;
            if (result['type'] == 'razorpay')
              openPaymentGateway(result);
            else if (result['type'] == 'phonepe')
              Get.toNamed('/paymentWebView',
                  arguments: {"url": result['link'], "type": "order"});
            else if (result['type'] == 'hdfc')
              Get.toNamed('/paymentWebView',
                  arguments: {"url": result['link'], "type": "order"});
            else if (result['type'] == 'juspay') {
              initiateJuspay(result);
            }
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

  Future initiateJuspay(response) async {
    final _blaze = BlazeSdkFlutter();
    var initiatePayload = {
      "merchantId": response['userId'],
      "shopUrl": response['storeUrl'],
      "environment": response['environment']
    };
    var initSDKPayload = {
      "requestId": tempOrderId,
      "service": 'in.breeze.onecco',
      "payload": initiatePayload
    };
    // print('init payload ${initSDKPayload}');
    await _blaze.initiate(initSDKPayload, handleCallbackEvent);
    var processPaylod = {
      "action": "startCheckout",
      "skipOTP": true,
      "customer": {
        "name": userProfile.value.contactName,
        "phoneNumber": userProfile.value.mobileNumber,
        // "phoneNumber": "9876543210",
        "countryCode": "+91",
        "email": userProfile.value.emailId
        // "email": "john.doe@gmail.com"
      },
      // "shippingAddress": {
      //   "name": "John Doe",
      //   "phoneNumber": "9876543210",
      //   "postalCode": "560095",
      //   "state": "Karnataka",
      //   "city": "Bangalore",
      //   "fullAddress": "123, ABC Street, XYZ Area",
      //   "country": "India",
      //   "countryPhoneCode": "+91"
      // },
      "shippingAddress": {
        "name": selectedAddress.value.contactName,
        "phoneNumber": selectedAddress.value.mobileNumber,
        "postalCode": selectedAddress.value.pinCode,
        "state": selectedAddress.value.state,
        "city": selectedAddress.value.city,
        "fullAddress": selectedAddress.value.address,
        "country": "India",
        "countryPhoneCode": "+91"
      },
      "cart": response['payload'],
      "signature": response['signature']
    };
    var processSDKPayload = {
      "requestId": tempOrderId,
      "service": "in.breeze.onecco",
      "payload": processPaylod
    };
    // print('process payload ${processSDKPayload}');
    await _blaze.process(processSDKPayload);
  }

  void handleCallbackEvent(Map<String, dynamic> callbackEvent) {
    print("Callback Event: $callbackEvent");
  }

  void openPaymentGateway(response) async {
    var prefill = {};

    var options = {
      "key": response['key'],
      'order_id': response['paymentId'],
      "amount": "50000",
      "currency": "INR",
      "name": "To Automation",
      "description": "Transaction",
      "prefill": prefill,
      "notes": {"address": "Razorpay Corporate Office"},
      "theme": {"color": "#3399cc"}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    fetchPaymentStatus();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    hideLoading();
    if (response.code == Razorpay.PAYMENT_CANCELLED) {
      checkoutRepo!.updateDiscountByClosePayment(tempOrderId);
    }
    // updatePaymentByResponse();
  }

  void fetchPaymentStatus() async {
    showLoading("Loading...");
    print('temp transactionm id 2 $tempTransactionId');
    var result =
        await checkoutRepo!.checkPaymentAndCreateOrder(tempTransactionId);
    if (result['error'] == false) {
      duration.value = 60;
      _timer = Timer.periodic(
          Duration(seconds: 1), (Timer t) => checkPaymentIsCompleted());
    } else {
      hideLoading();
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void checkPaymentIsCompleted() async {
    if (duration.value > 0) {
      duration.value--;
      if (isReload.value == false) {
        isReload.value = true;
        var result =
            await bookingRepo!.checkOrderIsConfirmed(tempTransactionId);
        if (result != null) {
          if (result['error'] == false) {
            _timer?.cancel();
            hideLoading();
            await triggerRepo!.cancelTriggerNotification('abandoned-cart');
            Get.offAndToNamed('/orderConfirmation',
                arguments: {"id": result['orderId']});
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
    address.close();
    paymentMode.close();
    selectedAddress.close();
    currentStage.close();
    duration.close();
    isReload.close();
    secondaryDetails.close();
    template.close();
    isTemplateLoading.close();
    _timer!.cancel();
    _razorpay.clear();
    super.onClose();
  }
}
