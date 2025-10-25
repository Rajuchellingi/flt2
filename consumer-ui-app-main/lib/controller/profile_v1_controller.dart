// ignore_for_file: unused_local_variable, invalid_use_of_protected_member, unnecessary_null_comparison

import 'dart:io';

import 'package:b2b_graphql_package/modules/dynamic_form/dynamic_form_repo.dart';
import 'package:b2b_graphql_package/modules/user/user_repo.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/const/size_config.dart';
import 'package:black_locust/controller/background_music_controller.dart';
import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/notification_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/helper/keyboard.dart';
import 'package:black_locust/model/dynamic_form_model.dart';
import 'package:black_locust/model/enum.dart';
import 'package:black_locust/model/postal_code_model.dart';
import 'package:black_locust/services/common_service.dart';
import 'package:black_locust/services/video_upload_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileV1Controller extends GetxController with BaseController {
  // final ControllerA = Get.lazyPut(()=>BottomNavigationController());
  UserRepo? userRepo;
  var profileData = {}.obs;
  final TextEditingController companyNameMetaController =
      TextEditingController();
  final TextEditingController contactNameMetaController =
      TextEditingController();
  final TextEditingController emailMetaController = TextEditingController();
  final TextEditingController mobileMetaController = TextEditingController();
  final TextEditingController gstNumberMetaController = TextEditingController();
  final TextEditingController billingAddressMetaController =
      TextEditingController();
  final TextEditingController dropdownMetaController = TextEditingController();
  final TextEditingController singleUploadMetaController =
      TextEditingController();
  final TextEditingController bulkUploadMetaController =
      TextEditingController();

  // ======================================
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController gstNumberController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  // TextEditingController? contactNameController,
  //     oldPasswordController,
  //     confirmPasswordController,
  //     newPasswordController;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController additionalEmailController = TextEditingController();
  FirebaseAuth? auth;
  var verificationId;
  var isEditingPersonalInfo = false.obs;
  var isEditingEmail = false.obs;
  var isEditingMobile = false.obs;
  var isEditingAdditionalInfo = false.obs;
  var isLoading = false.obs;
  var emailUpdateError = false.obs;
  var mobileUpdateError = false.obs;
  final _notficationController = Get.find<NotificationController>();
  final musicController = Get.find<MusicController>();
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  var dynamicForm =
      new DynamicFormVM(form: null, formField: [], sTypename: "").obs;
  DynamicFormRepo? dynamicFormRepo;
  CommonService? commonService;
  var textController = [].obs;
  var disableField = [].obs;
  var hiddenField = [].obs;
  var matchField = [].obs;
  var personalInforFields = ['emailId', 'mobileNumber', 'password'];
  var activeSection = ''.obs;
  var btnText = 'Update'.obs;
  var imageNames = <String>[].obs;
  late List<XFile>? imageFiles = [];
  var videoNameMap = {}.obs;
  var videoFilesValue = {}.obs;
  var fileName = {}.obs;
  var fileLocation = {}.obs;
  var fileType = {}.obs;
  var fileBulkValues = [].obs;
  var errorMessage = <String, String>{}.obs;
  var videoName = "".obs;
  var isVideo = false.obs;
  late XFile? videoFile;
  var isProgress = false.obs;
  var isUserType = false.obs;
  var isError = false.obs;

  @override
  void onInit() {
    super.onInit();
    commonService = CommonService();
    dynamicFormRepo = DynamicFormRepo();
    getTemplate();
    auth = FirebaseAuth.instance;
    userRepo = UserRepo();
    myAccountUserData();
  }

  Future<void> myAccountUserData() async {
    isLoading.value = true;
    var result =
        await userRepo!.getUserDetailById(profileData.value['_id'] ?? '');
    profileData.value = result['value'];
    // print("profileData.value ${profileData.value}");

    await getFormByType(profileData['userType']);

    // Loop through metafields and assign values dynamically
    if (profileData['metafields'] != null) {
      for (var field in profileData['metafields']) {
        // print("field--------------->>>>>> ${field}");
        String key = field['key'];
        var value =
            field['reference'] != null ? field['reference']['value'] : null;
        // print("value--------------->>>>>> ${value}");
        // Assigning file values
        // if (field['customDatatype'] == "file" &&
        //     field['customDataValueType'] == "single" &&
        //     field['reference']?['file'] != null) {
        //   singleUploadMetaController.text =
        //       field['reference']['file']['fileUrl'] ?? '';
        // }

        // if (field['customDatatype'] == "file" &&
        //     field['customDataValueType'] == "multiple" &&
        //     field['references']?['files'] != null) {
        //   bulkUploadMetaController.value = field['references']['files']
        //       .map((file) => file['fileUrl'])
        //       .toList();
        // }
        switch (key) {
          case 'company_name':
            companyNameMetaController.text = value ?? '';
            break;
          case 'contact_names':
            contactNameMetaController.text = value ?? '';
            break;
          case 'email_id':
            emailMetaController.text = value ?? '';
            break;
          case 'mobile_numbers':
            mobileMetaController.text = value ?? '';
            break;
          case 'gst_number':
            gstNumberMetaController.text = value ?? '';
            break;
          case 'billing_address':
            billingAddressMetaController.text = value ?? '';
            break;
          case 'dropdownlist':
            dropdownMetaController.text =
                (field['references']?['values']?.isNotEmpty ?? false)
                    ? field['references']['values'][0]
                    : '';
            break;
          // case 'file' : singleUploadMetaController.text =
        }
      }
    }

    firstNameController.text = profileData['firstName'] ?? '';
    lastNameController.text = profileData['lastName'] ?? '';
    emailController.text = profileData['emailId'] ?? '';
    mobileController.text = profileData['mobileNumber'] ?? '';
    gstNumberController.text = profileData['gstNumber'] ?? '';
    companyNameController.text = profileData['companyName'] ?? '';
    additionalEmailController.text = profileData['additionalEmail'] ?? '';

    isLoading.value = false;
    // print("profileData ${profileData.value}");
  }

  Future<void> cancelUpdate() async {
    textController.value = [];
    disableField.value = [];
    hiddenField.value = [];
    matchField.value = [];
    setTextFieldValue();
    setInitialValidation();
  }

  // Future<void> myAccountUserData() async {
  //   isLoading.value = true;
  //   var result = await userRepo!.getUserDetailById('');
  //   profileData.value = result['value'];
  //   print("profileData.value ${profileData.value}");
  //   await getFormByType(profileData['userType']);
  //   companyNameMetaController.text = profileData['companyName'] ?? '';
  //   contactNameMetaController.text = profileData['contactName'] ?? '';
  //   emailMetaController.text = profileData['emailId'] ?? '';
  //   mobileMetaController.text = profileData['mobileNumber'] ?? '';
  //   gstNumberMetaController.text = profileData['gstNumber'] ?? '';
  //   billingAddressMetaController.text = profileData['billingAddress'] ?? '';
  //   dropdownMetaController.text = profileData['dropdown'] ?? '';
  //   // ================================================
  //   firstNameController.text = profileData['firstName'] ?? '';
  //   lastNameController.text = profileData['lastName'] ?? '';
  //   emailController.text = profileData['emailId'] ?? '';
  //   mobileController.text = profileData['mobileNumber'] ?? '';
  //   gstNumberController.text = profileData['gstNumber'] ?? '';
  //   companyNameController.text = profileData['companyName'] ?? '';
  //   additionalEmailController.text = profileData['additionalEmail'] ?? '';
  //   isLoading.value = false;
  // }

  Future getFormByType(userType) async {
    var formType = "registration-form";
    var result = await dynamicFormRepo!.getFormByUserType(formType, userType);
    if (result != null) {
      var response = dynamicFormVMFromJson(result);
      dynamicForm.value = response;
      setTextFieldValue();
      setInitialValidation();
    }
  }

  Map<String, dynamic> getProfileData() {
    return {
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'email': emailController.text,
      'mobile': mobileController.text,
      'gstNumber': gstNumberController.text,
      'companyName': companyNameController.text,
      'additionalEmail': additionalEmailController.text,
      'companyNames': companyNameMetaController.text,
      'contactName': contactNameMetaController.text,
      'emailId': emailMetaController.text,
      'mobileNumber': mobileMetaController.text,
      'gstNumbers': gstNumberMetaController.text,
      'billingAddress': billingAddressMetaController.text,
      'dropdown': dropdownMetaController.text,
    };
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'my-profile');
    isTemplateLoading.value = false;
  }

  Future<void> updatePersonalInfo() async {
    var data = getUserInput();
    var result = await userRepo!.updateUserDetails(data);
    if (result['error'] == true) {
      showSnackBar(result?['message'], SnackPosition.BOTTOM);
    } else if (result['error'] == false) {
      showSnackBar(result?['message'], SnackPosition.BOTTOM);
//  Get.toNamed('/profile', preventDuplicates: false);
    }
    myAccountUserData();
    refresh();
  }

  Future<void> updateEmail() async {
    print(" profileData.value['_id'] ${profileData.value}");
    var data = {
      "id": profileData.value['_id'],
      "oldEmailId": profileData['emailId'],
      "newEmailId": emailController.text
    };
    var result = await userRepo!.emailUpdatedReq(data);
    if (result['error'] == true) {
      showSnackBar(result?['message'], SnackPosition.BOTTOM);
      emailUpdateError.value = true;
    } else if (result['error'] == false) {
      showSnackBar(result?['message'], SnackPosition.BOTTOM);
      emailUpdateError.value = false;
      _showOtpDialog(Get.context!);
//  Get.toNamed('/profile', preventDuplicates: false);
    }
    myAccountUserData();
    refresh();
  }

  Future updateMobile() async {
    if (isEditingMobile.value == true) {
      var newMobileNumber = mobileController.value.text;
      var mobileNumber = profileData.value['mobileNumber'];
      var result =
          await userRepo!.mobileNumberUpdateReq(mobileNumber, newMobileNumber);
      if (result['error'] == true) {
        showSnackBar(result?['message'], SnackPosition.BOTTOM);
        isEditingMobile.value = false;
      } else {
        phoneSignIn(newMobileNumber);
      }
    } else {
      isEditingMobile.value = true;
    }
  }

  Future<void> _showOtpDialog(BuildContext context) async {
    TextEditingController otpController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter OTP'),
          content: TextField(
            controller: otpController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            decoration: InputDecoration(
              hintText: 'Enter 6-digit OTP',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () async {
                await verifyOtpAndSaveEmail(otpController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  // Future updateMobile() async {
  //   var newMobileNumber = mobileController.value.text;
  //   var mobileNumber = profileData.value['mobileNumber'];
  //   print("newMobileNumber $newMobileNumber");
  //   print("mobileNumber $mobileNumber");
  //   if (mobileController.value != null) {
  //     // var newMobileNumber = mobileController.value.text;
  //     // var mobileNumber = profileData.value['mobileNumber'];
  //     var result = await userRepo!
  //         .mobileNumberUpdateReq(mobileNumber, newMobileNumber);
  //     print("result updateMobile ${result}");
  //     if (result['error'] == true) {
  //       showSnackBar(result?['message'], SnackPosition.BOTTOM);
  //       isEditingMobile.value = true;
  //       mobileUpdateError.value = true;
  //       myAccountUserData();
  //       refresh();
  //     } else if ((result['error'] == false)) {
  //       showSnackBar(result?['message'], SnackPosition.BOTTOM);
  //       // isEditingMobile.value = true;
  //       mobileUpdateError.value = false;
  //       isEditingMobile.value = true;
  //       myAccountUserData();
  //       refresh();
  //     } else {
  //       phoneSignIn(newMobileNumber);
  //     }
  //   } else {
  //     isEditingMobile.value = true;
  //     // if (isEditingMobile.value == true) {
  //     //   myAccountUserData();
  //     //   refresh();
  //     // }
  //   }
  // }

  Future<void> phoneSignIn(mobileNumber) async {
    await auth!.verifyPhoneNumber(
      phoneNumber: "+91$mobileNumber",
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: _onVerificationFailed,
      codeSent: _onCodeSent,
      codeAutoRetrievalTimeout: _onCodeTimeout,
      timeout: const Duration(seconds: 60),
    );
  }

  _onCodeTimeout(String timeout) {
    print(timeout);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (authCredential.smsCode != null) {
      try {
        UserCredential credential =
            await user!.linkWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await auth!.signInWithCredential(authCredential);
        }
      }
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      print("The phone number entered is invalid!");
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) async {
    this.verificationId = verificationId;
    openOTPDialog();
    showSnackBar("OTP Sent Successfully", SnackPosition.BOTTOM);
  }

  openOTPDialog() {
    Get.dialog(
      Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          insetPadding: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "OTP Verification",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                kDefaultHeight(kDefaultPadding / 2),
                TextField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter OTP',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                          isEditingMobile.value = false;
                        },
                        child: Text("Cancel",
                            style: TextStyle(color: Colors.black))),
                    ElevatedButton(
                        onPressed: () {
                          verifySMSOTP();
                        },
                        child: Text("Verify",
                            style: TextStyle(color: Colors.black)))
                  ],
                )
              ],
            ),
          )),
      barrierDismissible: true,
    );
  }

  Future verifySMSOTP() async {
    try {
      var credential = await auth!.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: otpController.text));
      if (credential.user != null) {
        var result =
            await userRepo!.changeMobileNumber(mobileController.text, true);
        if (result['error'] == true) {
          showSnackBar(result?['message'], SnackPosition.BOTTOM);
        } else if (result['error'] == false) {
          Get.back();
          isEditingMobile.value = false;
          otpController = TextEditingController();
          showSnackBar(result?['message'], SnackPosition.BOTTOM);
          myAccountUserData();
        }
      }
    } catch (error) {
      showSnackBar("Incorrect OTP", SnackPosition.BOTTOM);
      print('errrror $error');
    }
  }

  void updateAdditionalInfo() {}

  void updateProfile() {
    var profileData = getProfileData();
    // Handle profile update logic
  }

  Future updatePassWord(context) async {
    var input = {
      "id": null,
      "newPassword": newPasswordController.text,
      "password": oldPasswordController.text
    };
    // print("input ${input}");
    if (input != null) {
      var result = await userRepo!.updateUserPasswordById(input);
      if (result['error'] == true) {
        showSnackBar(result?['message'], SnackPosition.BOTTOM);
      } else if (result['error'] == false) {
        showSnackBar(result?['message'], SnackPosition.BOTTOM);
        Navigator.pop(context);
        //  Get.toNamed('/profile', preventDuplicates: false);
      }
    }
    myAccountUserData();
    refresh();
  }

  Future<void> verifyOtpAndSaveEmail(otp) async {
    var result = await userRepo!.otpChecker(otp);
    if (result['error'] == true) {
      showSnackBar(result?['message'], SnackPosition.BOTTOM);
    } else if (result['error'] == false) {
      showSnackBar(result?['message'], SnackPosition.BOTTOM);
//  Get.toNamed('/profile', preventDuplicates: false);
    }
  }

  showSnackBar(String msg, SnackPosition position) {
    Get.snackbar(
      "", msg,
      snackPosition: position,
      backgroundColor: kTextColor,
      colorText: Colors.white,
      // duration: Duration(milliseconds: 10000),
      maxWidth: SizeConfig.screenWidth,
      borderRadius: 0,
      titleText: Container(),
      snackStyle: SnackStyle.FLOATING,
      // padding: EdgeInsets.all(kDefaultPadding / 2),
      // margin: EdgeInsets.all(0));
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }

  forgotPassword() {
    GetStorage().remove('utoken');
    GetStorage().remove('userId');
    GetStorage().remove('searchHistory');
    Get.offAllNamed('/forgotPassword');
    _notficationController.onLogout();
    musicController.stopMusic();
    // ControllerA.cartCount();
    refresh();
  }

  onLogout() {
    GetStorage().remove('utoken');
    GetStorage().remove('userId');
    GetStorage().remove('cartId');
    GetStorage().remove('searchHistory');
    showSnackBar("Logout Successfull!!!", SnackPosition.BOTTOM);
    Get.offAllNamed('/home');
    _notficationController.onLogout();
    musicController.stopMusic();
    // ControllerA.cartCount();
    refresh();
  }

  Future updateProfilePage(type) async {
    var result = await Get.toNamed('/updateMyProfile',
        arguments: [profileData.value, type]);
    if (result != null && result == true) {
      // getProfile(userId);
      // myAccountUserData();
    }
  }

  Future submitUpdate() async {
    if (activeSection.value == 'personal-info') {
      updatePersonalInfo();
    } else if (activeSection.value == 'email-id') {
      updateEmail();
    } else if (activeSection.value == 'mobile-number') {
      updateMobile();
    }
  }

  // setTextFieldValue() {
  //   dynamicForm.value.formField!.forEach((element) {
  //     if (!personalInforFields.contains(element.name)) {
  //       var _fController = {};
  //       _fController[element.name] =
  //           TextEditingController(text: profileData.value[element.name] ?? '');
  //       textController.add(_fController);
  //     }
  //   });
  // }

  void setTextFieldValue() {
    // print("profileData.value ${profileData.value}");

    dynamicForm.value.formField!.forEach((element) {
      // print("element.setTextFieldValue ${element.toJson()}");

      if (!personalInforFields.contains(element.name)) {
        var _fController = {};

        if (element.fieldType == "metafield" && element.metafield != null) {
          // Find the corresponding metafield entry in profileData
          var matchedMetafield = profileData.value['metafields']?.firstWhere(
            (meta) => meta['customDataId'] == element.metafield!.sId,
            orElse: () => null,
          );

          if (matchedMetafield != null) {
            if (matchedMetafield['customDataValueType'] == 'single') {
              // Assign the single reference value
              _fController[element.name] = TextEditingController(
                text: matchedMetafield['reference']?['value']?.toString() ?? '',
              );
            } else if (matchedMetafield['customDataValueType'] == 'multiple') {
              // Assign multiple values as a comma-separated string
              _fController[element.name] = TextEditingController(
                text: (matchedMetafield['references']?['values']
                            as List<dynamic>?)
                        ?.join(', ') ??
                    '',
              );
            } else if (matchedMetafield['customDataValueType'] == 'single' &&
                matchedMetafield['customDatatype'] == 'file') {
              // Assign multiple values as a comma-separated string
              _fController[element.name] = TextEditingController(
                text: matchedMetafield['reference']?['file']?.toString() ?? '',
              );
            } else if (matchedMetafield['customDataValueType'] == 'multiple' &&
                matchedMetafield['customDatatype'] == 'file') {
              // Assign multiple values as a comma-separated string
              _fController[element.name] = TextEditingController(
                text:
                    (matchedMetafield['references']?['files'] as List<dynamic>?)
                            ?.join(', ') ??
                        '',
              );
            }
          } else {
            // If no metafield match, assign an empty string
            _fController[element.name] = TextEditingController(text: '');
          }
        } else {
          // Normal field assignment
          _fController[element.name] = TextEditingController(
            text: profileData.value[element.name] ?? '',
          );
        }

        textController.add(_fController);
      }
    });
  }

  // setInitialValidation() {
  //   var value;
  //   dynamicForm.value.formField!.forEach((element) {
  //     if (!personalInforFields.contains(element.name)) {
  //       hiddenField.add({"name": element.name, "value": false});
  //       disableField.add({"name": element.name, "value": false});
  //       matchField.add({"name": element.name, "value": false});
  //       setFormValidation(element, value);
  //     }
  //   });
  // }

  setInitialValidation() {
    var value;
    dynamicForm.value.formField!.forEach((element) {
      if (!personalInforFields.contains(element.name)) {
        hiddenField.add({"name": element.name, "value": false});
        disableField.add({"name": element.name, "value": false});
        matchField.add({"name": element.name, "value": false});
        setFormValidation(element, value);
      }
    });
  }

  getInputType(element) {
    switch (element.type) {
      case 1:
        return InputType.text;
      case 2:
        return InputType.number;
      case 3:
        return InputType.file;
      case 4:
        return InputType.select;
      case 5:
        return InputType.radio;
      case 6:
        return InputType.checkbox;
      case 7:
        return InputType.email;
      case 8:
        return InputType.password;
      case 9:
        return InputType.number;
      case 10:
        return InputType.date;
      case 11:
        return InputType.multiLine;
      default:
        return InputType.text;
    }
  }

  getInputMetaType(element) {
    // print("getInputType element---->>>> ${element.toJson()}");
    switch (element.metafield.type) {
      case "single-line-text":
        return InputType.text;
      case "integer":
        return InputType.number;
      case "multi-line-text":
        return InputType.multiLine;
      case 1:
        return InputType.text;
      case 2:
        return InputType.number;
      case 3:
        return InputType.file;
      case 4:
        return InputType.select;
      case 5:
        return InputType.radio;
      case 6:
        return InputType.checkbox;
      case 7:
        return InputType.email;
      case 8:
        return InputType.password;
      case 9:
        return InputType.number;
      case 10:
        return InputType.date;
      case 11:
        return InputType.multiLine;
      default:
        return InputType.text;
    }
  }

  Future onPinCodeChange(value, context) async {
    var country = getUserDetails('country');
    if (value != null &&
        value.length == 6 &&
        country.toLowerCase() == "india") {
      showLoading('Loading..');
      var result = await commonService!.getPostalCode(value);
      var response = postalCodeVMFromJson(result);
      if (response != null && response.postOffice.length > 0) {
        var address = response.postOffice.first;
        setAddressByPincode(address);
      }
      KeyboardUtil.hideKeyboard(context);
      hideLoading();
    }
  }

  setAddressByPincode(address) {
    var details = [];
    dynamicForm.value.formField!.forEach((element) {
      if (!personalInforFields.contains(element.name)) {
        var value = getUserDetails(element.name);
        var _fController = {};
        if (element.name == 'city')
          _fController[element.name] =
              TextEditingController(text: address.district);
        else if (element.name == 'state')
          _fController[element.name] =
              TextEditingController(text: address.state);
        else
          _fController[element.name] = TextEditingController(text: value);
        details.add(_fController);
      }
    });
    textController.value = [];
    textController.value = details;
  }

  getUserDetails(name) {
    // print("name ${name}");
    // print("textController ${textController.toJson()}");
    var textEditingController =
        textController.firstWhere((textField) => textField[name] != null);
    if (textEditingController != null)
      return textEditingController[name].text;
    else
      return null;
  }

  dropValueChange(value, name) {
    int index = textController.indexWhere((item) => item.containsKey(name));
    var selected = textController[index];
    selected[name] = TextEditingController(text: value.value);
    textController.refresh();
  }

  changeCheckBoxValue(value, element, name) {
    int index = textController.indexWhere((item) => item.containsKey(name));
    var selected = textController[index];
    selected[name] =
        TextEditingController(text: value == true ? element.value : null);
    checkFormValidation(value);
    textController.refresh();
  }

  changeRadioButtonValue(value, element, option, name) {
    int index = textController.indexWhere((item) => item.containsKey(name));
    var selected = textController[index];
    selected[name] = TextEditingController(text: value);
    checkFormValidation(value);
    textController.refresh();
  }

  snackMessage(String message) {
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  getUserInput() {
    Map<String, dynamic> userInput = {};

    // print("getUserInput user value: ${dynamicForm.value.formField!.map((e) => e.toJson()).toList()}");

    dynamicForm.value.formField!.forEach((element) {
      if (!personalInforFields.contains(element.name)) {
        userInput[element.name.toString()] = getControllerValue(element.name);
      }
    });
    // print("userInput ${userInput}");
    return userInput;
    // return new UserVM.fromRequestJson(userInput);
  }

  getControllerValue(name) {
    var textEditingController =
        textController.firstWhere((textField) => textField[name] != null);
    if (textEditingController[name].text.isNotEmpty) {
      var value = textEditingController[name].text;
      if (name == "pincode") {
        return value;
      } else {
        if (num.tryParse(value) != null) {
          return int.parse(value);
        } else if (value.toLowerCase() == "true" ||
            value.toLowerCase() == "false") {
          return value.toLowerCase() == "true" ? true : false;
        } else {
          return value;
        }
      }
    } else
      return null;
  }

  checkFormValidation(value) {
    dynamicForm.value.formField!.forEach((element) {
      if (!personalInforFields.contains(element.name)) {
        setFormValidation(element, value);
      }
    });
  }

  setFormValidation(DynamicFormFieldVM field, dynamic inputValue) {
    var value = getUserDetails(field.name);
    var matchIndex = getMatchFieldIndex(field.name);
    var hiddenIndex = getHiddenFieldIndex(field.name);
    var disabledIndex = getDisableFieldIndex(field.name);
    var hiddenTemp = [];
    var disableTemp = [];
    var matchTemp = [];
    if (field.settings != null && field.settings!.compare!.length > 0) {
      field.settings!.compare!.forEach((compare) {
        var hidden = compare.action == 1 ? true : false;
        var disable = compare.action == 2 ? true : false;
        var validate = compare.action == 3 ? true : false;
        var otherFieldValue =
            getUserDetails(compare.otherField!.name).toLowerCase();
        if (compare.type == 1) {
          //compare null
          if (compare.operator == 1) {
            //compare value == null
            if (otherFieldValue == null) {
              matchTemp.add(false);
              hiddenTemp.add(hidden);
              disableTemp.add(disable);
            } else {
              if (validate == true) {
                matchTemp.add(true);
              } else {
                disableTemp.add(false);
                hiddenTemp.add(false);
              }
            }
          } else if (compare.operator == 2) {
            //compare value != null
            if (value != otherFieldValue) {
              matchTemp.add(false);
              hiddenTemp.add(hidden);
              disableTemp.add(disable);
            } else {
              if (validate == true) {
                matchTemp.add(true);
              } else {
                disableTemp.add(false);
                hiddenTemp.add(false);
              }
            }
          }
        } else if (compare.type == 2) {
          //compare not null
          if (compare.operator == 1) {
            //compare value == notnull
            if (value == otherFieldValue) {
              matchTemp.add(false);
              hiddenTemp.add(hidden);
              disableTemp.add(disable);
            } else {
              if (validate == true) {
                matchTemp.add(true);
              } else {
                disableTemp.add(false);
                hiddenTemp.add(false);
              }
            }
          } else if (compare.operator == 2) {
            //compare value != notnull
            if (value != otherFieldValue) {
              matchTemp.add(false);
              hiddenTemp.add(hidden);
              disableTemp.add(disable);
            } else {
              if (validate == true) {
                matchTemp.add(true);
              } else {
                disableTemp.add(false);
                hiddenTemp.add(false);
              }
            }
          }
        } else if (compare.type == 3) {
          //compare same value
          if (compare.operator == 1) {
            if (value == otherFieldValue) {
              matchTemp.add(false);
              hiddenTemp.add(hidden);
              disableTemp.add(disable);
            } else {
              if (validate == true) {
                matchTemp.add(true);
              } else {
                disableTemp.add(false);
                hiddenTemp.add(false);
              }
            }
          } else if (compare.operator == 2) {
            if (value != otherFieldValue) {
              matchTemp.add(false);
              hiddenTemp.add(hidden);
              disableTemp.add(disable);
            } else {
              if (validate == true) {
                matchTemp.add(true);
              } else {
                disableTemp.add(false);
                hiddenTemp.add(false);
              }
            }
          }
        } else if (compare.type == 4) {
          //compare value
          var compareValue = compare.value!.toLowerCase();
          if (compare.operator == 1) {
            if (compareValue == otherFieldValue) {
              matchTemp.add(false);
              hiddenTemp.add(hidden);
              disableTemp.add(disable);
            } else {
              if (validate == true) {
                matchTemp.add(true);
              } else {
                disableTemp.add(false);
                hiddenTemp.add(false);
              }
            }
          } else if (compare.operator == 2) {
            if (compareValue != otherFieldValue) {
              matchTemp.add(false);
              hiddenTemp.add(hidden);
              disableTemp.add(disable);
            } else {
              if (validate == true) {
                matchTemp.add(true);
              } else {
                disableTemp.add(false);
                hiddenTemp.add(false);
              }
            }
          }
        }
      });
    }
    // print("matchField[matchIndex]['value'] ${matchIndex}");
    matchField[matchIndex]['value'] = matchTemp.contains(true) ? true : false;
    hiddenField[hiddenIndex]['value'] =
        hiddenTemp.contains(true) ? true : false;
    disableField[disabledIndex]['value'] =
        disableTemp.contains(true) ? true : false;
    hiddenField.refresh();
    disableField.refresh();
    matchField.refresh();
  }

  getMatchFieldIndex(name) {
    // print("getMatchFieldIndex name ${name}");
    // print("getMatchFieldIndex matchField ${matchField.toJson()}");

    return matchField.indexWhere((element) => element['name'] == name);
  }

  getHiddenFieldIndex(name) {
    return hiddenField.indexWhere((element) => element['name'] == name);
  }

  getDisableFieldIndex(name) {
    return disableField.indexWhere((element) => element['name'] == name);
  }

  getMatchField(name) {
    var result = matchField.firstWhere(
        (element) => element['name'] == name && element['value'] == true,
        orElse: () => null);
    if (result != null)
      return false;
    else
      return true;
  }

  getHiddenField(name) {
    var result = hiddenField.firstWhere(
        (element) => element['name'] == name && element['value'] == true,
        orElse: () => null);
    if (result != null)
      return false;
    else
      return true;
  }

  getDisableField(name) {
    var result = disableField.firstWhere(
        (element) => element['name'] == name && element['value'] == true,
        orElse: () => null);
    if (result != null)
      return false;
    else
      return true;
  }

  Future pickFileSingle(ImageSource source, String fieldId) async {
    var videoStatus = await Permission.videos.status;
    var status = await Permission.storage.status;
    if (status == PermissionStatus.granted ||
        videoStatus == PermissionStatus.granted) {
      final pickedVideo = await ImagePicker().pickVideo(source: source);
      if (pickedVideo != null) {
        var videoData = File(pickedVideo.path);
        final fileSize = await videoData.length();
        final fileSizeInMB = fileSize / (1024 * 1024);
        if (fileSizeInMB < 3 || fileSizeInMB > 20) {
          errorMessage[fieldId] = "Please select a File between 3MB to 15MB";
          isError.value = true;
        } else {
          errorMessage.remove(fieldId);
          isError.value = false;
          videoNameMap[fieldId] = [
            pickedVideo.name
          ]; // Store as a list of one string
          isVideo.value = true;
          videoFile = pickedVideo;
          videoFilesValue[fieldId] = videoFile;
          uploadVideo(fieldId);
        }
      }
    } else if (status == PermissionStatus.denied ||
        videoStatus == PermissionStatus.denied) {
      var deniedVideoStatus = await Permission.videos.request();
      var deniedStatus = await Permission.storage.request();
      if (deniedStatus.isPermanentlyDenied ||
          deniedVideoStatus.isPermanentlyDenied) openPermissionMessage();
    } else if (status == PermissionStatus.permanentlyDenied ||
        videoStatus == PermissionStatus.permanentlyDenied) {
      openPermissionMessage();
    }
  }

  Future pickFileBulk(ImageSource source, fieldId) async {
    var photosStatus = await Permission.photos.status;
    var status = await Permission.storage.status;

    if (status == PermissionStatus.granted ||
        photosStatus == PermissionStatus.granted) {
      final pickedImages = await ImagePicker().pickMultiImage();

      if (pickedImages != null && pickedImages.isNotEmpty) {
        bool hasError = false;
        imageNames.clear();
        List<String> fileNames = [];
        imageFiles = pickedImages;

        for (var image in pickedImages) {
          var imageData = File(image.path);
          final fileSize = await imageData.length();
          final fileSizeInMB = fileSize / (1024 * 1024);

          if (fileSizeInMB > 20) {
            errorMessage[fieldId] = "Please select images below 20MB";
            isError.value = true;
            hasError = true;
            break;
          } else {
            fileNames.add(image.name);
          }
        }

        if (!hasError) {
          errorMessage.remove(fieldId);
          isError.value = false;
          videoNameMap[fieldId] = fileNames;
          videoFilesValue[fieldId] = pickedImages;
          uploadBulk(fieldId);
        }
      }
    } else {
      _requestPermissions(photosStatus, status);
    }
  }

  void _requestPermissions(
      PermissionStatus photosStatus, PermissionStatus status) async {
    if (status == PermissionStatus.denied ||
        photosStatus == PermissionStatus.denied) {
      var deniedPhotosStatus = await Permission.photos.request();
      var deniedStatus = await Permission.storage.request();
      if (deniedStatus.isPermanentlyDenied ||
          deniedPhotosStatus.isPermanentlyDenied) {
        openPermissionMessage();
      }
    } else if (status == PermissionStatus.permanentlyDenied ||
        photosStatus == PermissionStatus.permanentlyDenied) {
      openPermissionMessage();
    }
  }

  openPermissionMessage() {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Allow To Automation to access gallery",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Container(
                  child: const Text(
                      "To upload Files need access to your gallery",
                      textAlign: TextAlign.center)),
              SizedBox(
                  height: getProportionateScreenHeight(kDefaultPadding / 2)),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                  onPressed: () {
                    openAppSettings();
                  },
                  child: const Text(
                    "Go to app settings",
                    style: TextStyle(color: kSecondaryColor),
                  ))
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void clearSelectedFiles() {
    imageFiles = [];
    imageNames.clear();
    isError.value = false;
  }

  clearSelectedFile() {
    videoFile = null;

    videoName.value = "No video selected";
    isVideo.value = false;
    isError.value = false;
  }

  Future uploadVideo(fieldId) async {
    if (isVideo.value == true) {
      showLoading("Loading...");
      final videoData = File(videoFilesValue[fieldId]!.path);

      var videoFormat = getFileExtension(videoFilesValue[fieldId]!.name);
      var createMultiPart = {
        "originalname": videoFilesValue[fieldId]!.name,
      };
      var multiUploadArray = [];
      var partSize = 1024 * 1024 * 6;
      var chunkSize = 6 * 1024 * 1024;
      var fileSize = await videoFilesValue[fieldId]!.length();
      var chunkCount = (fileSize / chunkSize).ceil();
      var multiPart =
          await VideoUploadService().createMulitPart(createMultiPart);
      for (int i = 0; i < chunkCount; i++) {
        var start = i * chunkSize;
        var end = (i + 1) * chunkSize;
        var fileBlob = (i + 1) < chunkCount
            ? videoData.readAsBytesSync().sublist(start, end)
            : videoData.readAsBytesSync().sublist(start);

        Map<String, dynamic> signedUrlParam = {
          'partNumber': i + 1,
          'key': multiPart['key'],
          'uploadId': multiPart['uploadId'],
        };
        var signedUrlMultipart =
            await VideoUploadService().preSignedURLForMulitpart(signedUrlParam);
        print("signedUrlMultipart length ${signedUrlMultipart.length}");
        var valueLink = signedUrlMultipart.last['signedUrl'];
        var uploadFile = await VideoUploadService().uploadVideoToAWS(
            valueLink.toString(), fileBlob, videoFilesValue[fieldId]!.name);
        multiUploadArray.add({"ETag": uploadFile, "partName": i + 1});
      }
      var params = {
        "multipartDetail": multiUploadArray,
        "uploadId": multiPart['uploadId'],
        "key": multiPart['key']
      };
      var signedUrlMultipart =
          await VideoUploadService().completeMultiPartUpload(params);
      print("signedUrlMultipart name ${signedUrlMultipart}");
      hideLoading();
      var imageData = {
        "videoName": signedUrlMultipart['originalName'],
      };
      print("videoFile!.name ${videoFilesValue[fieldId]!.name}");
      fileName[fieldId] = videoFilesValue[fieldId]!.name;
      fileLocation[fieldId] = signedUrlMultipart['Location'];
      List<String> parts = fileName[fieldId].split(".");
      fileType[fieldId] = parts.last;
      // Get.back(result: imageData);
    } else {
      errorMessage[fieldId] = "Please select a file";
      isError.value = true;
    }
  }

  Future uploadBulk(fieldId) async {
    print("videoFilesValue[fieldId]---->>>> ${videoFilesValue[fieldId]}");
    // print(
    //     "Landing Page Data: ${videoFilesValue[fieldId].map((e) => e.toJson()).toList()}");
    // if (isVideo.value == true) {
    if (videoFilesValue[fieldId] != null) {
      showLoading("Loading...");

      // List<Map<String, dynamic>> uploadedImages = [];
      for (var imageFile in videoFilesValue[fieldId]!) {
        // print("imageFile----->>>> ${imageFile.toJson()}");
        final videoData = File(imageFile!.path);

        var videoFormat = getFileExtension(imageFile!.name);
        var createMultiPart = {
          "originalname": imageFile!.name,
        };
        var multiUploadArray = [];
        var partSize = 1024 * 1024 * 6;
        var chunkSize = 6 * 1024 * 1024;
        var fileSize = await imageFile!.length();
        var chunkCount = (fileSize / chunkSize).ceil();
        var multiPart =
            await VideoUploadService().createMulitPart(createMultiPart);
        for (int i = 0; i < chunkCount; i++) {
          var start = i * chunkSize;
          var end = (i + 1) * chunkSize;
          var fileBlob = (i + 1) < chunkCount
              ? videoData.readAsBytesSync().sublist(start, end)
              : videoData.readAsBytesSync().sublist(start);

          Map<String, dynamic> signedUrlParam = {
            'partNumber': i + 1,
            'key': multiPart['key'],
            'uploadId': multiPart['uploadId'],
          };
          var signedUrlMultipart = await VideoUploadService()
              .preSignedURLForMulitpart(signedUrlParam);
          print("signedUrlMultipart length ${signedUrlMultipart.length}");
          var valueLink = signedUrlMultipart.last['signedUrl'];
          var uploadFile = await VideoUploadService().uploadVideoToAWS(
              valueLink.toString(), fileBlob, imageFile!.name);
          multiUploadArray.add({"ETag": uploadFile, "partName": i + 1});
        }
        var params = {
          "multipartDetail": multiUploadArray,
          "uploadId": multiPart['uploadId'],
          "key": multiPart['key']
        };
        var signedUrlMultipart =
            await VideoUploadService().completeMultiPartUpload(params);
        print("signedUrlMultipart name ${signedUrlMultipart}");
        hideLoading();
        var imageData = {
          "videoName": signedUrlMultipart['originalName'],
        };
        print("videoFile!.name ${imageFile!.name}");
        var fileName1 = imageFile!.name;
        List<String> parts = fileName1.split(".");
        var fileType1 = parts.last;
        fileBulkValues.add({
          "fileName": imageFile!.name,
          "fileUrl": signedUrlMultipart['Location'],
          "fileType": fileType1,
        });

        // Get.back(result: imageData);
      }
      // }
    } else {
      errorMessage[fieldId] = "Please select a file";
      isError.value = true;
    }
  }

  void openFile(String url) async {
    if (url.isNotEmpty) {
      try {
        await launchUrl(Uri.parse(url));
      } catch (e) {
        // Handle the exception
      }
    }
    // ...
  }

  String? getFileExtension(String fileName) {
    try {
      return fileName.split('.').last;
    } catch (e) {
      return null;
    }
  }
}
