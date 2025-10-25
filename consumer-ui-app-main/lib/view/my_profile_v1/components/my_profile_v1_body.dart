// ignore_for_file: invalid_use_of_protected_member, unused_element, unused_local_variable

import 'package:black_locust/common_component/custom_checkbox.dart';
import 'package:black_locust/common_component/custom_drop_down_field.dart';
import 'package:black_locust/common_component/custom_drop_down_meta_field.dart';
import 'package:black_locust/common_component/custom_radio_button.dart';
import 'package:black_locust/common_component/custom_textArea_field.dart';
import 'package:black_locust/common_component/custom_text_field_v1.dart';
import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/profile_v1_controller.dart';
import 'package:black_locust/helper/validation_helper.dart';
import 'package:black_locust/model/enum.dart';
import 'package:black_locust/view/my_profile_v1/components/updatePassword_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileV1Body extends StatelessWidget {
  MyProfileV1Body({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final ProfileV1Controller _controller;
  final _formKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _emailMetaFormKey = GlobalKey<FormState>();

  final _mobileFormKey = GlobalKey<FormState>();
  final RxString emailError = ''.obs;

  @override
  Widget build(BuildContext context) {
    // print(
    //     "_controller.dynamicForm.value--->>> ${_controller.dynamicForm.value.toJson()}");
    return Obx(
      () => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(
                  'Personal Information', 'personal-info', _formKey),
              Form(key: _formKey, child: _buildPersonalInfo()),
              SizedBox(height: 12),
              if (_controller.dynamicForm.value.formField!
                  .any((element) => element.name == 'emailId')) ...[
                _buildSectionTitle('Email Id', 'email-id', _emailFormKey),
                Form(key: _emailFormKey, child: _buildEmailInfo()),
                const SizedBox(height: 32)
              ],
              // if (_controller.dynamicForm.value.formField!.any((element) =>
              //     element?.fieldType == "metafield" &&
              //     element?.type == 'custom.email_id')) ...[
              //   _buildSectionTitle('Email Id', 'email-id', _emailMetaFormKey),
              //   Form(key: _emailMetaFormKey, child: _buildEmailMetaInfo()),
              //   SizedBox(height: 32)
              // ],
              if (_controller.dynamicForm.value.formField!
                  .any((element) => element.name == 'mobileNumber')) ...[
                _buildSectionTitle(
                    'Mobile Number', 'mobile-number', _mobileFormKey),
                Form(key: _mobileFormKey, child: _buildNumInfo()),
                const SizedBox(height: 32)
              ],
              _buildSearchAndInviteRow(context),
              const SizedBox(height: 32),
            ],
          )),
    );
  }

  Widget _buildSectionTitle(String title, type, formKey) {
    // print("type ${type}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Text
        Text(
          title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8), // Add some space between title and buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // if (isEditing.value ==
            //     true) // Show 'Cancel' button only when editing
            //   TextButton(
            //     onPressed: onCancel,
            //     child: const Text(
            //       'Cancel',
            //       style: TextStyle(fontSize: 12),
            //     ),
            //   ),
            if (_controller.activeSection.value == type)
              TextButton(
                onPressed: () {
                  _controller.cancelUpdate();
                  _controller.activeSection.value = '';
                },
                child: const Text(
                  'Cancel',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ElevatedButton(
              onPressed: () {
                if (_controller.activeSection.value == type) {
                  if (formKey.currentState != null) {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      _controller.submitUpdate();
                    }
                  }
                } else {
                  _controller.activeSection.value = type;
                }
              },
              child: Obx(() => Text(
                    _controller.activeSection.value == type ? 'Save' : 'Edit',
                    style: const TextStyle(fontSize: 12),
                  )),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPersonalInfo() {
    // print(
    //     "_controller.dynamicForm.value --->>>> ${_controller.dynamicForm.value.toJson()}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var element in _controller.dynamicForm.value.formField!)
          if (!_controller.personalInforFields.contains(element.name)) ...[
            // buildFormField(element),
            element.fieldType == "metafield"
                ? buildMetaFormField(element)
                : buildFormField(element),
            const SizedBox(height: 10)
          ]
        // _buildTextField(
        //   'First Name',
        //   _controller.firstNameController,
        //   _controller.isEditingPersonalInfo.value,
        //   (value) => ValidationHelper.validate(InputType.text, value,
        //       errorMsg: "First Name is required"),
        // ),
        // _buildTextField(
        //   'Last Name',
        //   _controller.lastNameController,
        //   _controller.isEditingPersonalInfo.value,
        //   (value) => ValidationHelper.validate(InputType.text, value,
        //       errorMsg: "Last Name is required"),
        // ),
      ],
    );
  }

  Widget _buildEmailInfo() {
    var emailField = _controller.dynamicForm.value.formField!
        .firstWhere((element) => element.name == 'emailId');

    return CustomTextFieldV1(
        textEditingController: _controller.emailController,
        hintText: emailField.placeHolder,
        isReadOnly: _controller.activeSection.value != 'email-id',
        labelText: emailField.label,
        errorMsg:
            emailField.required == true ? 'Enter ' + emailField.label! : null,
        inputType: InputType.email,
        controller: _controller);
  }

  Widget _buildNumInfo() {
    var mobileField = _controller.dynamicForm.value.formField!
        .firstWhere((element) => element.name == 'mobileNumber');
    return CustomTextFieldV1(
        textEditingController: _controller.mobileController,
        hintText: mobileField.placeHolder,
        isReadOnly: _controller.activeSection.value != 'mobile-number',
        labelText: mobileField.label,
        errorMsg:
            mobileField.required == true ? 'Enter ' + mobileField.label! : null,
        inputType: InputType.number,
        controller: _controller);
  }

  Widget _buildAdditionalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          'GST Number',
          _controller.gstNumberController,
          _controller.isEditingAdditionalInfo.value,
          (value) => ValidationHelper.validate(InputType.text, value,
              errorMsg: "GST Number is required"),
        ),
        _buildTextField(
          'Company Name',
          _controller.companyNameController,
          _controller.isEditingAdditionalInfo.value,
          (value) => ValidationHelper.validate(InputType.text, value,
              errorMsg: "Company Name is required"),
        ),
        _buildTextField(
          'Additional Email Id',
          _controller.additionalEmailController,
          _controller.isEditingAdditionalInfo.value,
          (value) => ValidationHelper.validate(InputType.email, value,
              errorMsg: "Additional Email Id is required"),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      bool isEditing, String? Function(String?) validator) {
    final brightness = Theme.of(Get.context!).brightness;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        readOnly: !isEditing,
        cursorColor:
            brightness == Brightness.dark ? Colors.white : Colors.black,
        decoration: InputDecoration(
          floatingLabelStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: label.contains('Email')
            ? TextInputType.emailAddress
            : TextInputType.text,
        style: const TextStyle(fontSize: 13),
        validator: validator,
      ),
    );
  }

  Future<void> _showOtpDialog(BuildContext context) async {
    TextEditingController otpController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter OTP'),
          content: TextField(
            controller: otpController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            decoration: const InputDecoration(
              hintText: 'Enter 6-digit OTP',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Submit'),
              onPressed: () async {
                await _controller.verifyOtpAndSaveEmail(otpController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handleEditToggle(RxBool isEditing, VoidCallback updateFunction) {
    _closeOtherSections(isEditing);
    isEditing.value = !isEditing.value;
    if (!isEditing.value) {
      updateFunction();
    }
  }

  void _closeOtherSections(RxBool activeSection) {
    if (activeSection != _controller.isEditingPersonalInfo) {
      _controller.isEditingPersonalInfo.value = false;
    }
    if (activeSection != _controller.isEditingEmail) {
      _controller.isEditingEmail.value = false;
    }
    if (activeSection != _controller.isEditingMobile) {
      _controller.isEditingMobile.value = false;
    }
    if (activeSection != _controller.isEditingAdditionalInfo) {
      _controller.isEditingAdditionalInfo.value = false;
    }
  }

  buildFormField(element) {
    switch (element.type) {
      case 1:
        return buildTextField(element);
      case 2:
        return buildTextField(element);
      case 4:
        return buildSelectTextField(element);
      case 5:
        return buildRadioButton(element);
      case 6:
        return buildCheckboxField(element);
      case 7:
        return buildTextField(element);
      case 8:
        return buildTextField(element);
      case 9:
        return buildTextField(element);
      case 11:
        return buildTextField(element);
      default:
        return buildTextField(element);
    }
  }

  buildMetaFormField(element) {
    if (element.metafield.type == "single-line-text" &&
        element.metafield.isPresetChoices == true) {
      return buildSelectTextMetaField(element);
    }

    if (element.metafield.type == "single-line-text" &&
        element.metafield.key == "email_id") {
      return _buildEmailMetaInfo(element);
    }

    if (element.metafield.type == "integer") {
      return _buildMobileMetaInfo(element);
    }

    switch (element.metafield.type) {
      case "single-line-text":
        return buildTextMetaField(element);
      case "multi-line-text":
        return buildTextAreaMetaField(element);
      case "file":
        return buildMetaFileUploader(element);
      default:
        return buildTextMetaField(element);
    }
  }

  Container buildTextField(element) {
    var validationPattern;
    if (element.settings != null && element.settings.validation != null) {
      for (var validation in element.settings.validation) {
        if (validation.rule == '3') {
          validationPattern = validation.value;
          break;
        } else if (validation.rule == '1') {
          validationPattern = r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$';
          break;
        }
      }
    }
    return _controller.getHiddenField(element.name)
        ? Container(
            child: Column(
              children: [
                CustomTextFieldV1(
                  textEditingController: getTextEditingController(element),
                  hintText: element.placeHolder,
                  isReadOnly:
                      _controller.activeSection.value != 'personal-info',
                  labelText: element.label,
                  enabled: _controller.getDisableField(element.name),
                  errorMsg: element.required == true
                      ? 'Enter ' + element.label
                      : null,
                  inputType: _controller.getInputType(element),
                  pattern: validationPattern,
                  controller: _controller,
                  isTextChanged: element.name == 'pincode',
                  onTextChange: element.name == 'pincode'
                      ? (value) {
                          _controller.onPinCodeChange(value, Get.context);
                        }
                      : null,
                  isPhoneCode: (element.name == 'whatsAppNumber' ||
                      element.name == 'mobileNumber'),
                ),
                kDefaultHeight(kDefaultPadding),
              ],
            ),
          )
        : Container();
  }

  Container buildTextMetaField(element) {
    return _controller.getHiddenField(element.metafield.name)
        ? Container(
            child: Column(
              children: [
                CustomTextFieldV1(
                  minlength: element.metafield.minimumCharacterCount,
                  maxlength: element.metafield.maximumCharacterCount,
                  textEditingController: getTextEditingController(element),
                  hintText: element.placeHolder,
                  labelText: element.label,
                  enabled: _controller.getDisableField(element.name),
                  errorMsg: element.required == true
                      ? 'Enter ' + element.label
                      : null,
                  inputType: _controller.getInputMetaType(element),
                  // pattern: validationPattern,
                  pattern: element.metafield.regularExpression,
                  controller: _controller,
                  isTextChanged: element.name == 'pincode',
                  onTextChange: element.name == 'pincode'
                      ? (value) {
                          _controller.onPinCodeChange(value, Get.context);
                        }
                      : null,
                  isPhoneCode: (element.name == 'whatsAppNumber' ||
                      element.name == 'mobileNumber'),
                ),
                kDefaultHeight(kDefaultPadding),
              ],
            ),
          )
        : Container();
  }

  Container _buildMobileMetaInfo(element) {
    return _controller.getHiddenField(element.metafield.name)
        ? Container(
            child: Column(
              children: [
                _buildSectionTitle(
                    'Mobile Number', 'mobile_number', _emailMetaFormKey),
                CustomTextFieldV1(
                  minlength: element.metafield.minimumCharacterCount,
                  maxlength: element.metafield.maximumCharacterCount,
                  textEditingController: getTextEditingController(element),
                  hintText: element.placeHolder,
                  labelText: element.label,
                  enabled: _controller.getDisableField(element.name),
                  errorMsg: element.required == true
                      ? 'Enter ' + element.label
                      : null,
                  inputType: _controller.getInputMetaType(element),
                  // pattern: validationPattern,
                  pattern: element.metafield.regularExpression,
                  controller: _controller,
                  isTextChanged: element.name == 'pincode',
                  onTextChange: element.name == 'pincode'
                      ? (value) {
                          _controller.onPinCodeChange(value, Get.context);
                        }
                      : null,
                  isPhoneCode: (element.name == 'whatsAppNumber' ||
                      element.name == 'mobileNumber'),
                ),
                kDefaultHeight(kDefaultPadding),
              ],
            ),
          )
        : Container();
  }

  Container _buildEmailMetaInfo(element) {
    return _controller.getHiddenField(element.metafield.name)
        ? Container(
            child: Column(
              children: [
                _buildSectionTitle('Email Id', 'email_Id', _emailMetaFormKey),
                CustomTextFieldV1(
                  minlength: element.metafield.minimumCharacterCount,
                  maxlength: element.metafield.maximumCharacterCount,
                  textEditingController: getTextEditingController(element),
                  hintText: element.placeHolder,
                  labelText: element.label,
                  enabled: _controller.getDisableField(element.name),
                  errorMsg: element.required == true
                      ? 'Enter ' + element.label
                      : null,
                  inputType: _controller.getInputMetaType(element),
                  // pattern: validationPattern,
                  pattern: element.metafield.regularExpression,
                  controller: _controller,
                  isTextChanged: element.name == 'pincode',
                  onTextChange: element.name == 'pincode'
                      ? (value) {
                          _controller.onPinCodeChange(value, Get.context);
                        }
                      : null,
                  isPhoneCode: (element.name == 'whatsAppNumber' ||
                      element.name == 'mobileNumber'),
                ),
                kDefaultHeight(kDefaultPadding),
              ],
            ),
          )
        : Container();
  }

  Widget buildMetaFileUploader(element) {
    print("buildMetaFileUploader element ----->>> ${element.toJson()}");
    print(
        "getTextEditingController(element) --->>> ${_controller.profileData.value}");

    var metafield = _controller.profileData.value['metafields']?.firstWhere(
      (meta) => meta['customDataId'] == element.metafield.sId,
      orElse: () => null,
    );

    if (metafield == null ||
        !_controller.getHiddenField(element.metafield.name)) {
      return Container();
    }

    print("metafield---->>>>> ${metafield}");

    String title = metafield['key'] ?? "Change a file";
    List<Map<String, dynamic>> files = [];

    if (metafield['customDataValueType'] == "multiple") {
      files = List<Map<String, dynamic>>.from(
          metafield['references']?['files'] ?? []);
    } else if (metafield['customDataValueType'] == "single") {
      var file = metafield['reference']?['file'];
      if (file != null) files.add(file);
    }

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                ),
                onPressed: () {
                  if (metafield['customDataValueType'] == "multiple") {
                    _controller.pickFileBulk(
                        ImageSource.gallery, element.metafield.sId);
                  } else {
                    _controller.pickFileSingle(
                        ImageSource.gallery, element.metafield.sId);
                  }
                },
                child: const Text('Select File',
                    style:
                        const TextStyle(fontSize: 12, color: kSecondaryColor)),
              ),
              const SizedBox(width: 10),
              files.isNotEmpty
                  ? Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: files.map((file) {
                          return GestureDetector(
                            onTap: () => _controller.openFile(file['fileUrl']),
                            child: Text(
                              file['fileName'] ?? "Unnamed File",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : const Text("No file selected",
                      style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 10),
          const Text("Select a File between 5MB to 15MB",
              style: const TextStyle(color: Colors.black, fontSize: 12)),
          const SizedBox(height: 10),
          Obx(() => _controller.isError.value
              ? Text(
                  _controller.errorMessage[metafield['_id']] ?? "",
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Container buildSelectTextField(element) {
    return _controller.getHiddenField(element.name) == true
        ? Container(
            child: Column(children: [
            CustomDropdownField(

                // name: element.name,
                // enabled: _controller.getDisableField(element.name),
                // placeholder: element.placeHolder,
                dropdownList: element.settings.options,
                lableText: element.label,
                selectedType: getSelectType(element),
                controller: _controller),
            kDefaultHeight(kDefaultPadding),
          ]))
        : Container();
  }

  Container buildTextAreaMetaField(element) {
    // print("buildTextAreaMetaField element ----->>> ${element.toJson()}");

    if (!_controller.getHiddenField(element.metafield.name)) {
      return Container();
    }

    bool isTextArea =
        _controller.getInputType(element) == TextInputType.multiline;

    return Container(
      child: Column(
        children: [
          CustomTextAreaFieldV1(
            textEditingController: getTextEditingController(element),
            hintText: element.placeHolder,
            labelText: element.label,
            enabled: _controller.getDisableField(element.name),
            errorMsg:
                element.required == true ? 'Enter ${element.label}' : null,
            inputType: _controller.getInputMetaType(element),
            pattern: element.metafield.regularExpression,
            controller: _controller,
            isTextChanged: element.name == 'pincode',
            onTextChange: element.name == 'pincode'
                ? (value) {
                    _controller.onPinCodeChange(value, Get.context);
                  }
                : null,
            isPhoneCode: (element.name == 'whatsAppNumber' ||
                element.name == 'mobileNumber'),
          ),
          kDefaultHeight(kDefaultPadding),
        ],
      ),
    );
  }

  Container buildRadioButton(element) {
    return _controller.getHiddenField(element.name) == true
        ? Container(
            child: Column(
            children: [
              CustomRadioButton(
                  controller: _controller,
                  enabled: _controller.getDisableField(element.name),
                  label: element.label,
                  name: element.name,
                  element: element,
                  options: element.settings.options,
                  value: getCheckBoxValue(element)),
              kDefaultHeight(kDefaultPadding),
            ],
          ))
        : Container();
  }

  Container buildCheckboxField(element) {
    return _controller.getHiddenField(element.name) == true
        ? Container(
            child: Column(
            children: [
              for (var input in element.settings.options)
                CustomCheckbox(
                    controller: _controller,
                    name: element.name,
                    label: input.name,
                    element: input,
                    enabled: _controller.getDisableField(element.name),
                    value: getCheckBoxValue(element)),
              kDefaultHeight(kDefaultPadding),
            ],
          ))
        : Container();
  }

  Container buildSelectTextMetaField(element) {
    return _controller.getHiddenField(element.name) == true
        ? Container(
            child: Column(children: [
            CustomDropdownMetaField(
                name: element.name,
                enabled: _controller.getDisableField(element.name),
                hintText: element.placeHolder,
                dropdownList: element.metafield.presetChoices,
                lableText: element.label,
                selectedType: getSelectmetafieldType(element),
                controller: _controller),
            kDefaultHeight(kDefaultPadding),
          ]))
        : Container();
  }

  getSelectmetafieldType(element) {
    var _fController = _controller.textController.value
        .firstWhere((textField) => textField[element.name] != null);
    if (_fController[element.metafield.name] != null) {
      var value = _fController[element.metafield.name];
      var selectedType =
          element.metafield.presetChoices.firstWhere((da) => da.value == value);
      // print("selectedType---->>> ${selectedType}");
      if (selectedType != null)
        return selectedType;
      else
        return null;
    } else {
      return null;
    }
  }

  getSelectType(element) {
    var _fController = _controller.textController.value
        .firstWhere((textField) => textField[element.name] != null);
    if (_fController[element.name].text.isNotEmpty) {
      var value = _fController[element.name].text;
      var selectedType =
          element.settings.options.firstWhere((da) => da.value == value);
      if (selectedType != null)
        return selectedType;
      else
        return null;
    } else {
      return null;
    }
  }

  getCheckBoxValue(element) {
    var textEditingController = _controller.textController.value
        .firstWhere((textField) => textField[element.name] != null);
    if (textEditingController[element.name].text.isNotEmpty)
      return textEditingController[element.name].text;
    else
      return null;
  }

  getTextEditingController(element) {
    // print("element.name---->>> ${element.toJson()}");
    var textEditingController = _controller.textController.value
        .firstWhere((textField) => textField[element.name] != null);
    return textEditingController[element.name];
  }

  Widget _buildSearchAndInviteRow(BuildContext context) {
    // return Row(
    //   children: [
    //     SizedBox(width: 10),
    //     ElevatedButton(
    //       onPressed: () => _showFormPopup(context, isEdit: false),
    //       child: Text('Change Password'),
    //     ),
    //   ],
    // );
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Password",
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          GestureDetector(
              onTap: () {
                // updateController.assignRegistrationForm(
                //     _controller.userProfile.value, 'personal-info');
                // updateController.setInitialValues(
                //     _controller.userProfile.value, 'personal-info');
                Get.bottomSheet(
                  Container(child: MyUpdatePasswordPopup()),
                  enterBottomSheetDuration: const Duration(milliseconds: 200),
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                );
                // .then((value) {
                //   _controller.getProfile(_controller.userId);
                // });
              },
              child: const Text("Change",
                  style: const TextStyle(fontSize: 13, color: Colors.grey)))
        ]);
  }

  void _showFormPopup(BuildContext context, {required bool isEdit}) {
    final TextEditingController oldPassWordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmNewPasswordController =
        TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: oldPassWordController,
                    decoration:
                        const InputDecoration(labelText: 'Old Password *'),
                    obscureText: true,
                    validator: (value) => value!.trim().isEmpty
                        ? 'Current Password is required'
                        : null,
                  ),
                  TextFormField(
                    controller: newPasswordController,
                    decoration:
                        const InputDecoration(labelText: 'New Password *'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'New Password is required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: confirmNewPasswordController,
                    decoration: const InputDecoration(
                        labelText: 'Confirm New Password *'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm Password is required';
                      }
                      if (value != newPasswordController.text) {
                        return "New Password and Confirm Password don't match";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);
                        // Call API or perform password change logic
                      }
                    },
                    child: const Text('Change Password'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
