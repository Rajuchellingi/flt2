import 'package:black_locust/view/register/components/design2/registration_form_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationBodyDesign2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Text("Register",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)),
                  const SizedBox(height: 30),
                  Container(
                      // color: Colors.white,
                      child: RegistrationFormDesign2()),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: const Divider(
                          thickness: 1,
                          color: const Color(0xFF6A5252),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "or",
                          style: TextStyle(
                              color: brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                      Expanded(
                        child: const Divider(
                          thickness: 1,
                          color: Color(0xFF6A5252),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Already have an account?",
                      style: TextStyle(
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAndToNamed('/login', arguments: {"path": "/home"});
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          color: brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ])));
  }
}
