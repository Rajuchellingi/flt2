import 'package:black_locust/controller/profile_v1_controller.dart';
import 'package:black_locust/view/my_profile_v1/components/updatePassword_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAddressPersonalInfoBody extends StatelessWidget {
  MyAddressPersonalInfoBody({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final ProfileV1Controller _controller;
  final _emailFormKey = GlobalKey<FormState>();
  final _mobileFormKey = GlobalKey<FormState>();
  final RxString emailError = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_controller.dynamicForm.value.formField!
                .any((element) => element.name == 'emailId')) ...[
              const Text(
                'Email Id',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Form(
                  key: _emailFormKey,
                  child: _buildEmailField(context, 'email-id')),
            ],
            if (_controller.dynamicForm.value.formField!
                .any((element) => element.name == 'mobileNumber')) ...[
              const Text(
                'Phone Number',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Form(
                  key: _mobileFormKey,
                  child: _buildMobileField(context, 'mobile-number')),
            ],
            _buildSearchAndInviteRow(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileField(BuildContext context, type) {
    final mobileField = _controller.dynamicForm.value.formField!
        .firstWhere((e) => e.name == 'mobileNumber');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _controller.activeSection.value == 'mobile-number'
              ? TextFormField(
                  controller: _controller.mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: mobileField.placeHolder,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  validator: (value) {
                    if (mobileField.required == true &&
                        (value == null || value.isEmpty)) {
                      return 'Enter ${mobileField.label}';
                    }
                    return null;
                  },
                )
              : Text(
                  _controller.mobileController.text,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1D1E2C),
                  ),
                ),
        ),
        const SizedBox(width: 8),
        if (_controller.activeSection.value == 'mobile-number') ...[
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () {
              _controller.cancelUpdate();
              _controller.activeSection.value = '';
            },
          ),
          IconButton(
            icon: const Icon(Icons.check, color: Colors.green),
            onPressed: () {
              if (_controller.activeSection.value == type) {
                if (_mobileFormKey.currentState != null) {
                  if (_mobileFormKey.currentState!.validate()) {
                    _mobileFormKey.currentState!.save();
                    _controller.submitUpdate();
                  }
                }
              } else {
                _controller.activeSection.value = type;
              }
            },
          ),
        ] else ...[
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.green),
            onPressed: () {
              _controller.activeSection.value = 'mobile-number';
            },
          ),
        ]
      ],
    );
  }

  Widget _buildEmailField(BuildContext context, type) {
    final emailField = _controller.dynamicForm.value.formField!
        .firstWhere((e) => e.name == 'emailId');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Email Input or Text
        Expanded(
          child: _controller.activeSection.value == 'email-id'
              ? TextFormField(
                  controller: _controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: emailField.placeHolder,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  validator: (value) {
                    if (emailField.required == true &&
                        (value == null || value.isEmpty)) {
                      return 'Enter ${emailField.label}';
                    }
                    return null;
                  },
                )
              : Text(
                  _controller.emailController.text,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1D1E2C),
                  ),
                ),
        ),
        const SizedBox(width: 8),
        if (_controller.activeSection.value == 'email-id') ...[
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () {
              _controller.cancelUpdate();
              _controller.activeSection.value = '';
            },
          ),
          IconButton(
            icon: const Icon(Icons.check, color: Colors.green),
            // onPressed: () {
            //   if (_emailFormKey.currentState!.validate()) {
            //     _emailFormKey.currentState!.save();
            //     _controller.submitUpdate();
            //     _controller.activeSection.value = '';
            //   }
            // },
            onPressed: () {
              if (_controller.activeSection.value == type) {
                if (_emailFormKey.currentState != null) {
                  if (_emailFormKey.currentState!.validate()) {
                    _emailFormKey.currentState!.save();
                    _controller.submitUpdate();
                  }
                }
              } else {
                _controller.activeSection.value = type;
              }
            },
          ),
        ] else ...[
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.green),
            onPressed: () {
              _controller.activeSection.value = 'email-id';
            },
          ),
        ]
      ],
    );
  }

  Widget _buildSearchAndInviteRow(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                _controller.forgotPassword();
              },
              child: const Text("Forgot Password?",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black38,
                      decoration: TextDecoration.underline))),
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
              child: const Text("Change Password",
                  style: const TextStyle(fontSize: 15, color: Colors.green)))
        ]);
  }
}
