// ignore_for_file: unnecessary_null_comparison, deprecated_member_use, unused_local_variable, invalid_use_of_protected_member

import 'dart:convert';
import 'dart:io';

import 'package:b2b_graphql_package/modules/user/user_repo.dart';
import 'package:b2b_graphql_package/modules/dynamic_form/dynamic_form_repo.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/dynamic_form_model.dart';
import 'package:black_locust/model/postal_code_model.dart';
import 'package:black_locust/services/video_upload_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../const/constant.dart';
import '../const/size_config.dart';
import '../helper/keyboard.dart';
import '../model/enum.dart';
import '../services/common_service.dart';
import 'base_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationV1Controller extends GetxController with BaseController {
  DynamicFormRepo? dynamicFormRepo;
  UserRepo? userRepo;
  CommonService? commonService;
  FirebaseAuth? auth;

  var verificationId;
  var isLoading = false.obs;
  var isProgress = false.obs;
  var isUserType = false.obs;
  var isError = false.obs;
  var userType = "".obs;
  var allForms = [].obs;
  var userTypeOptions = [].obs;
  var textController = [].obs;
  var disableField = [].obs;
  var hiddenField = [].obs;
  var matchField = [].obs;
  var userData = {}.obs;
  var template = {}.obs;
  var visibilityField = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  var dynamicForm =
      new DynamicFormVM(form: null, formField: [], sTypename: "").obs;
  // var errorMessage = "Please select a File".obs;
  // var errorMessage = {}.obs;
  var errorMessage = <String, String>{}.obs;
  var videoName = "".obs;
  var isVideo = false.obs;
  late XFile? videoFile;
  late List<XFile>? imageFiles = [];
  var imageNames = <String>[].obs;
  var videoNameMap = {}.obs;
  var videoFilesValue = {}.obs;
  var fileName = {}.obs;
  var fileLocation = {}.obs;
  var fileType = {}.obs;
  var fileBulkValues = [].obs;
  var isTermsAccepted = false.obs;
  @override
  void onInit() {
    auth = FirebaseAuth.instance;
    dynamicFormRepo = DynamicFormRepo();
    commonService = CommonService();
    getTemplate();

    userRepo = UserRepo();
    getAllRegistrationForm();
    // getFormByType();
    super.onInit();
  }

  Future getAllRegistrationForm() async {
    this.isLoading.value = true;
    var result = await dynamicFormRepo!.getAllRegistrationForm();
    if (result != null) {
      var response = allFormVMFromJson(result);
      allForms.value = response;
      if (allForms.value.length > 1) {
        userTypeOptions.value = allForms.value.map((e) => e.userType).toList();
        isLoading.value = false;
        isUserType.value = true;
      } else {
        var form = allForms.value.first;
        userType.value = form.userType;
        getFormByType();
      }
    }
  }

  Future getFormByType() async {
    this.isLoading.value = true;
    var formType = "registration-form";
    var result =
        await dynamicFormRepo!.getFormByUserType(formType, userType.value);
    if (result != null) {
      var response = dynamicFormVMFromJson(result);
      dynamicForm.value = response;
      setTextFieldValue();
      setInitialValidation();
    }
    this.isLoading.value = false;
  }

  Future getRegistrationFormByType() async {
    showLoading("Loading....");
    var formType = "registration-form";
    var result =
        await dynamicFormRepo!.getFormByUserType(formType, userType.value);
    if (result != null) {
      var response = dynamicFormVMFromJson(result);
      dynamicForm.value = response;
      setTextFieldValue();
      setInitialValidation();
      isUserType.value = false;
    }
    hideLoading();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value =
        allTemplates.firstWhereOrNull((value) => value['id'] == 'register');
    isTemplateLoading.value = false;
  }

  setTextFieldValue() {
    dynamicForm.value.formField!.forEach((element) {
      var _fController = {};
      _fController[element.name] = TextEditingController();
      textController.add(_fController);
    });
  }

  setInitialValidation() {
    var value;
    dynamicForm.value.formField!.forEach((element) {
      hiddenField.add({"name": element.name, "value": false});
      disableField.add({"name": element.name, "value": false});
      matchField.add({"name": element.name, "value": false});
      setFormValidation(element, value);
    });
  }

  getInputType(element) {
    // print("getInputType element---->>>> ${element.toJson()}");
    switch (element.type) {
      case 'text':
        return InputType.text;
      case 'number':
        return InputType.number;
      case 'file':
        return InputType.file;
      case 'select':
        return InputType.select;
      case 'radio':
        return InputType.radio;
      case 'checkbox':
        return InputType.checkbox;
      case 'email':
        return InputType.email;
      case 'password':
        if (visibilityField.value[element.name] == true)
          return InputType.text;
        else
          return InputType.password;
      case 'phone':
        return InputType.number;
      case 'date':
        return InputType.date;
      case 'textarea':
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
      var value = getUserDetails(element.name);
      var _fController = {};
      if (element.name == 'city')
        _fController[element.name] =
            TextEditingController(text: address.district);
      else if (element.name == 'state')
        _fController[element.name] = TextEditingController(text: address.state);
      else
        _fController[element.name] = TextEditingController(text: value);
      details.add(_fController);
    });
    textController.value = [];
    textController.value = details;
  }

  getUserDetails(name) {
    var textEditingController =
        textController.firstWhere((textField) => textField[name] != null);
    if (textEditingController != null)
      return textEditingController[name].text;
    else
      return null;
  }

  changeVisibility(name) {
    visibilityField.value[name] =
        visibilityField.value[name] == true ? false : true;
    visibilityField.refresh();
  }

  dropValueChange(value, name) {
    print("value ===>>> ${value}");
    print("name ====>>> ${name}");
    int index = textController.indexWhere((item) => item.containsKey(name));
    var selected = textController[index];
    selected[name] = TextEditingController(text: value.value);
    textController.refresh();
  }

  dropMetaValueChange(value, name) {
    print("value ===>>> ${value}");
    print("name ====>>> ${name}");
    int index = textController.indexWhere((item) => item.containsKey(name));
    var selected = textController[index];
    selected[name] = TextEditingController(text: value);
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

  Future<void> submitRegistration() async {
    if (isProgress.value == true) return;
    var input = getUserInput();
    print("input $input");
    KeyboardUtil.hideKeyboard(Get.context!);
    isProgress.value = true;
    input['userType'] = userType.value;
    showLoading("Loading...");
    var result = await userRepo!.createUser(input);
    hideLoading();
    print("result submitRegistration result $result");
    if (result['error'] == false) {
      var data = jsonDecode(result['response']);
      print("result submitRegistration data $data");
      userData.value = {
        'tempId': data['tempId'],
        'mobileNumber': data['mobileNumber'],
        'emailId': data['emailId'],
        'emailOtp': data['emailOtp'],
        'smsOtp': data['smsOtp']
      };
      if (data['smsOtp'] == true) {
        phoneSignIn(userData);
      } else {
        isProgress.value = false;
        snackMessage(result['message']);
        Get.toNamed('/otp',
            arguments: {'userData': userData, 'verificationId': verificationId},
            preventDuplicates: false);
      }
    } else if (result['error'] == true) {
      isProgress.value = false;
      snackMessage(result['message']);
    }
  }

  Future<void> phoneSignIn(data) async {
    // print("hello 0");
    print("mobileNumber ${data['mobileNumber']}");
    isProgress.value = true;
    await auth!.verifyPhoneNumber(
      phoneNumber: "+91" + data['mobileNumber'],
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: _onVerificationFailed,
      codeSent: (verificationId, resendToken) {
        isProgress.value = false;
        this.verificationId = verificationId;
        Get.toNamed('/otp',
            arguments: {'userData': userData, 'verificationId': verificationId},
            preventDuplicates: false);
      },
      codeAutoRetrievalTimeout: _onCodeTimeout,
      timeout: const Duration(seconds: 60),
    );
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("hello 1");
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
    snackMessage(exception.code);
  }

  // _onCodeSent(String verificationId, int? forceResendingToken) async {
  //   print("hello 3");
  //   print(verificationId);
  //   print(forceResendingToken);
  //   print("code sent");
  // }

  _onCodeTimeout(String timeout) {
    print("hello 4");
    print(timeout);
  }

  snackMessage(String message) {
    Get.snackbar(
      "", message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kTextColor,
      colorText: Colors.white,
      // duration: Duration(milliseconds: 10000),
      maxWidth: SizeConfig.screenWidth,
      borderRadius: 0,
      titleText: Container(),
      snackStyle: SnackStyle.FLOATING,
      // padding: EdgeInsets.all(kDefaultPadding / 2),
      // margin: EdgeInsets.all(0)
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }

  // getUserInput() {
  //   Map<String, dynamic> userInput = {};

  //   // print("getUserInput user value: ${dynamicForm.value.formField!.map((e) => e.toJson()).toList()}");

  //   dynamicForm.value.formField!.forEach((element) {
  //     userInput[element.name.toString()] = getControllerValue(element.name);
  //   });
  //   // print("userInput ${userInput}");
  //   return userInput;
  //   // return new UserVM.fromRequestJson(userInput);
  // }
  Map<String, dynamic> getUserInput() {
    Map<String, dynamic> userInput = {};
    List<Map<String, dynamic>> metafields = [];
    print(
        "fileLocation.value ${fileLocation.value} fileType.value ${fileType.value} fileName.value ${fileName.value}");
    print("fileBulkValues.value ${fileBulkValues.value}");

    dynamicForm.value.formField!.forEach((element) {
      print("element final ---->>> ${element.toJson()}");
      var inputName = getControllerValue(element.name).toString();
      var inputValue = getControllerValue(element.name).toString();

      if (element.fieldType == "metafield") {
        Map<String, dynamic> metafieldData = {
          "customDataId": element.metafield?.sId,
          "definition": element.metafield?.definition,
          "namespace": element.metafield?.namespace,
          "key": element.metafield?.key,
          "customDatatype": element.metafield?.type,
          "customDataValueType": element.metafield?.valueType,
        };

        if (element.metafield?.valueType == "multiple") {
          if (fileBulkValues.value.isNotEmpty &&
              element.metafield?.type == "file") {
            metafieldData["references"] = {"files": fileBulkValues.value};
          } else {
            metafieldData["references"] = {
              "values": inputName.isNotEmpty ? inputName : [],
            };
          }
        } else {
          if (fileLocation.value.isNotEmpty &&
              fileType.value.isNotEmpty &&
              fileName.value.isNotEmpty &&
              element.metafield?.valueType == "single" &&
              element.metafield?.type == "file") {
            metafieldData["reference"] = {
              "file": {
                "fileUrl": fileLocation[element.sId],
                "fileType": fileType[element.sId],
                "fileName": fileName[element.sId],
              }
            };
          } else {
            metafieldData["reference"] = {
              "value": inputName.isNotEmpty ? inputName : "",
            };
          }
        }

        metafields.add(metafieldData);
      } else {
        userInput[element.name.toString()] = inputValue;
      }
    });

    userInput["metafields"] = metafields;
    return userInput;
  }
  // getUserInput() {
  //   Map<String, dynamic> userInput = {};
  //   List<Map<String, dynamic>> metafields = [];

  //   dynamicForm.value.formField!.forEach((element) {
  //     print("element final ---->>> ${element.toJson()}");
  //     var inputName = getControllerValue(element.name).toString();
  //     var inputValue = getControllerValue(element.name).toString();
  //     print(
  //         "fileLocation.value ${fileLocation.value} fileType.value ${fileType.value} fileName.value ${fileName.value}");
  //     if (element.fieldType == "metafield") {
  //       var inputValue = metafields.add({
  //         "customDataId": element.metafield?.sId,
  //         "definition": element.metafield?.definition,
  //         "namespace": element.metafield?.namespace,
  //         "key": element.metafield?.key,
  //         "customDatatype": element.metafield?.type,
  //         "customDataValueType": element.metafield?.valueType,
  //         if (element.metafield?.valueType == "multiple")
  //           "references": {"values": inputName != null ? inputName : []}
  //         else
  //           "reference": {"value": inputName.isNotEmpty ? inputName : ""},
  //       });
  //     } else {
  //       userInput[element.name.toString()] = inputValue;
  //     }
  //   });
  //   userInput["metafields"] = metafields;
  //   return userInput;
  // }

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
      setFormValidation(element, value);
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
                      "To upload Files  need access to your gallery",
                      textAlign: TextAlign.center)),
              SizedBox(
                  height: getProportionateScreenHeight(kDefaultPadding / 2)),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                  onPressed: () {
                    openAppSettings();
                  },
                  child: const Text("Go to app settings",
                      style: TextStyle(color: kSecondaryColor)))
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
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

  String? getFileExtension(String fileName) {
    try {
      return fileName.split('.').last;
    } catch (e) {
      return null;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
