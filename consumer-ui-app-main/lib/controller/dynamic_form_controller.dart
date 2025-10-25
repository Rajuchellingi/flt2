// ignore_for_file: unnecessary_null_comparison, deprecated_member_use, unused_local_variable, invalid_use_of_protected_member

import 'package:b2b_graphql_package/modules/user/user_repo.dart';
import 'package:b2b_graphql_package/modules/dynamic_form/dynamic_form_repo.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:black_locust/model/dynamic_form_model.dart';
import 'package:black_locust/model/postal_code_model.dart';

import '../helper/keyboard.dart';
import '../model/enum.dart';
import '../services/common_service.dart';
import 'base_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DynamicFormController extends GetxController with BaseController {
  DynamicFormRepo? dynamicFormRepo;
  UserRepo? userRepo;
  CommonService? commonService;

  var isLoading = false.obs;
  var isProgress = false.obs;
  var textController = [].obs;
  var disableField = [].obs;
  var hiddenField = [].obs;
  var matchField = [].obs;
  var template = {}.obs;
  var link;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  var dynamicForm =
      new DynamicFormVM(form: null, formField: [], sTypename: "").obs;

  @override
  void onInit() {
    dynamicFormRepo = DynamicFormRepo();
    commonService = CommonService();
    getTemplate();

    userRepo = UserRepo();
    var arguments = Get.arguments;
    // if (arguments != null) {
    //   link = arguments['link'];
    //   getFormByLink();
    // }
    super.onInit();
  }

  initialLoad(formLink) {
    isProgress.value = false;
    textController.value = [];
    disableField.value = [];
    hiddenField.value = [];
    matchField.value = [];
    link = formLink;
    getFormByLink();
  }

  Future getFormByLink() async {
    this.isLoading.value = true;
    var result = await dynamicFormRepo!.getFormByLink(link);
    if (result != null) {
      var response = dynamicFormVMFromJson(result);
      dynamicForm.value = response;
      setTextFieldValue();
      setInitialValidation();
    }
    this.isLoading.value = false;
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

  Future<void> submitRegistration() async {
    if (isProgress.value == true) return;
    showLoading("Loading...");
    var input = getUserInput();
    // print("input $input");
    KeyboardUtil.hideKeyboard(Get.context!);
    isProgress.value = true;
    var result = await dynamicFormRepo!.createCustomFormDetail(input);
    hideLoading();
    if (result != null) {
      if (result['error'] == false) {
        snackMessage("Form submitted successfully");
        Get.back(result: true);
      } else {
        snackMessage(result['message']);
      }
    } else {
      snackMessage("Something went wrong");
    }
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
    var userInput = [];

    // print("getUserInput user value: ${dynamicForm.value.formField!.map((e) => e.toJson()).toList()}");

    dynamicForm.value.formField!.forEach((element) {
      var data = {
        "labelName": element.label,
        "name": element.name,
        "value": getControllerValue(element.name),
      };
      userInput.add(data);
    });
    // print("userInput ${userInput}");
    return {"formId": dynamicForm.value.form!.sId, "details": userInput};
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

  @override
  void onClose() {
    super.onClose();
  }
}
