import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/address_v1_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressV1Body extends StatelessWidget {
  const AddressV1Body({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);

  final AddressV1Controller _controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool isAdding = _controller.isEditing['new'] ?? false;
        bool isEditing = _controller.profileData
            .any((address) => _controller.isEditing[address.sId] ?? false);

        if (isAdding || isEditing) {
          var addressBeingEdited = isAdding
              ? null
              : _controller.profileData.firstWhere(
                  (address) => _controller.isEditing[address.sId] ?? false,
                  orElse: () => null,
                );
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(addressBeingEdited),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: kPrimaryColor,
                  side: const BorderSide(color: kPrimaryColor, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                onPressed: () {
                  _controller.setEditing('new', true);
                },
                child: const Text(
                  'Add Address',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ..._controller.profileData.map((address) {
                return _buildInfoBox(address);
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildForm(address) {
    final id = address?.sId ?? 'new';
    final formKey = _controller.formKeys[id] ?? GlobalKey<FormState>();
    _controller.formKeys[id] = formKey;

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidateMode: _controller.validationState[id] == true
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                'Contact Name',
                _controller.contactNameController,
                isRequired: true,
              ),
              _buildTextField(
                'Email Id',
                _controller.emailController,
                isEmail: true,
                isRequired: true,
              ),
              _buildTextField(
                'Mobile Number',
                _controller.mobileController,
                isPhoneNumber: true,
                isRequired: true,
              ),
              _buildTextField(
                'Address',
                _controller.addressController,
                isRequired: true,
              ),
              _buildTextField('Landmark', _controller.landmarkController),
              _buildPincodeField(
                'Pincode',
                _controller.pinCodeController,
                id,
              ),
              _buildTextField(
                'City',
                _controller.cityController,
                isRequired: true,
              ),
              _buildTextField(
                'State',
                _controller.stateController,
                isEnabled: false,
              ),
              _buildTextField(
                'Country',
                _controller.countryController,
                isEnabled: false,
              ),
              CheckboxListTile(
                title: const Text("Billing Address"),
                value: _controller.billingAddress[id] ?? false,
                onChanged: (newValue) {
                  _controller.updateBillingAddress(id, newValue);
                },
              ),
              CheckboxListTile(
                title: const Text("Shipping Address"),
                value: _controller.shippingAddress[id] ?? false,
                onChanged: (newValue) {
                  _controller.updateShippingAddress(id, newValue);
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState != null) {
                        if (formKey.currentState!.validate()) {
                          if (id == 'new') {
                            await _controller.addNewAddress(id);
                          } else {
                            await _controller.updatePersonalInfo(id);
                          }
                          _controller.setEditing(id, false);
                        } else {
                          // Trigger auto-validation if the form fails validation.
                          _controller.updateValidationState(id, true);
                        }
                      }
                    },
                    child: Text(id == 'new' ? 'Add Address' : 'Save'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      _controller.setEditing(id, false);
                      _controller.updateValidationState(id, false);
                      Get.back();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox(address) {
    final id = address?.sId ?? 'defaultKey';

    return Obx(() {
      bool isEditing = _controller.isEditing[id] ?? false;

      return Card(
        color: Colors.white,
        margin: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isEditing ? Colors.transparent : kPrimaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isEditing) ...[
                SizedBox(height: 8),
                Text('${address.contactName}', style: TextStyle(fontSize: 16)),
                Text('${address.emailId}', style: TextStyle(fontSize: 16)),
                Text('${address.mobileNumber}', style: TextStyle(fontSize: 16)),
                Text('${address.address}', style: TextStyle(fontSize: 16)),
                Text('${address.landmark}', style: TextStyle(fontSize: 16)),
                Text('${address.pinCode}', style: TextStyle(fontSize: 16)),
                Text('${address.city}', style: TextStyle(fontSize: 16)),
                Text('${address.state}', style: TextStyle(fontSize: 16)),
                Text('${address.country}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 5),
                if (address.shippingAddress == true)
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: kPrimaryColor, size: 18),
                      SizedBox(width: 4),
                      Text(
                        'Shipping Address',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                if (address.billingAddress == true)
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: kPrimaryColor, size: 18),
                      SizedBox(width: 4),
                      Text(
                        'Billing Address',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        backgroundColor: kPrimaryColor,
                        side: BorderSide(color: kPrimaryColor, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      onPressed: () {
                        _controller.setEditingValues(address, id);
                        _controller.setEditing(id, true);
                      },
                      child: Text(
                        'Edit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        backgroundColor: kPrimaryColor,
                        side: BorderSide(color: kPrimaryColor, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      onPressed: () async {
                        _controller.removePersonalInfo(id);
                      },
                      child: Text(
                        'Remove',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isEmail = false,
    bool isPhoneNumber = false,
    bool isEnabled = true,
    bool isRequired = false,
  }) {
    final brightness = Theme.of(Get.context!).brightness;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        enabled: isEnabled,
        controller: controller,
        cursorColor:
            brightness == Brightness.dark ? Colors.white : Colors.black,
        keyboardType: isPhoneNumber ? TextInputType.phone : TextInputType.text,
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'is required';
          }
          if (isEmail && value != null) {
            if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                .hasMatch(value)) {
              return 'Please enter a valid email';
            }
          }
          if (isPhoneNumber && value != null) {
            if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
              return 'Please enter a valid 10-digit mobile number';
            }
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildPincodeField(
      String label, TextEditingController controller, String id) {
    final brightness = Theme.of(Get.context!).brightness;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        cursorColor:
            brightness == Brightness.dark ? Colors.white : Colors.black,
        controller: controller,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required';
          }
          if (value.length != 6) {
            return 'Please enter a valid 6-digit pincode';
          }
          return null;
        },
        onChanged: (value) async {
          if (value.length == 6) {
            await _controller.fetchStateAndCountry(value, id);
          }
        },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
