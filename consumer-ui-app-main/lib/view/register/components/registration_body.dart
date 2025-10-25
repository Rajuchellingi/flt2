import 'package:black_locust/view/register/components/registration_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/constant.dart';

class RegistrationBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        // color: Color.fromARGB(223, 186, 203, 255),
        child: SingleChildScrollView(
            child: Column(children: [
          Container(
              // color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: RegistrationFormField()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Get.offAndToNamed('/login', arguments: {"path": "/home"});
                },
                child: const Text(
                  "Login here",
                  style: const TextStyle(color: kPrimaryColor),
                ),
              )
            ],
          )
        ])));
  }
}
