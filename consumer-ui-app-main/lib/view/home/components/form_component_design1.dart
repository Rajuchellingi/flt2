// form_component_design1.dart

import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/home_controller.dart';
import 'package:black_locust/helper/validation_helper.dart';
import 'package:black_locust/model/dynamic_form_model.dart';
import 'package:black_locust/model/enum.dart';
import 'package:flutter/material.dart';

class FormComponentDesign1 extends StatefulWidget {
  const FormComponentDesign1({
    Key? key,
    required this.design,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;
  final Map<String, dynamic> design;

  @override
  State<FormComponentDesign1> createState() => _FormComponentDesign1State();
}

class _FormComponentDesign1State extends State<FormComponentDesign1> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String?> _dropdownValues = {};
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final matchedFormComponent = widget.controller.formComponents.firstWhere(
      (element) => element['id'] == widget.design['id'],
      orElse: () => null,
    );

    if (matchedFormComponent == null) {
      return const SizedBox.shrink();
    }

    final DynamicFormVM formVM = matchedFormComponent['form'];

    return Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (formVM.form?.name != null)
                Text(
                  formVM.form!.name!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (formVM.form?.description != null) ...[
                const SizedBox(height: 8),
                Text(
                  formVM.form!.description!,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
              const SizedBox(height: 20),
              ...?formVM.formField?.map((field) {
                final String type = field.type ?? 'text';
                final String label = field.label ?? '';
                final String placeholder = field.placeHolder ?? '';
                final String name = field.name ?? '';

                if (type == 'select') {
                  final List options = field.settings?.options ?? [];
                  _dropdownValues.putIfAbsent(name,
                      () => options.isNotEmpty ? options.first.value : null);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: DropdownButtonFormField<String>(
                      validator: (value) {
                        if (field.required == true) {
                          var validationMsg = ValidationHelper.validate(
                              InputType.select, value,
                              errorMsg: '$label is required');
                          if (validationMsg != '') {
                            return validationMsg;
                          }
                        }
                        return null;
                      },
                      value: _dropdownValues[name],
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Colors.black),
                        labelText: label,
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                      items: options
                          .map<DropdownMenuItem<String>>(
                              (opt) => DropdownMenuItem<String>(
                                    value: opt.value,
                                    child: Text(opt.value ?? ''),
                                  ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _dropdownValues[name] = value;
                        });
                      },
                    ),
                  );
                } else {
                  _controllers.putIfAbsent(name, () => TextEditingController());

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: TextFormField(
                      validator: (value) {
                        if (field.required == true) {
                          var validationMsg = ValidationHelper.validate(
                              InputType.text, value,
                              errorMsg: '$label is required');
                          if (validationMsg != '') {
                            return validationMsg;
                          }
                        }
                        return null;
                      },
                      controller: _controllers[name],
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Colors.black),
                        labelText: label,
                        hintText: placeholder,
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                      keyboardType: type == 'number'
                          ? TextInputType.number
                          : (type == 'email'
                              ? TextInputType.emailAddress
                              : TextInputType.text),
                      maxLines: type == 'textarea' ? 4 : 1,
                    ),
                  );
                }
              }),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor, // button background color
                    foregroundColor: kSecondaryColor, // text & icon color
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      widget.controller.submitDynamicForm(
                        formVM,
                        _controllers,
                        _dropdownValues,
                      );
                    }
                  },
                  child: Text(
                    formVM.form?.buttonLabel ?? 'Submit',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
