import 'package:black_locust/view/login/components/design2/login_form_design2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginBodyDesign2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text("Login",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black)),
                      const SizedBox(height: 50),
                      LoginFormDesign2(),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Expanded(
                            child: const Divider(
                              thickness: 1,
                              color: const Color(0xFF6A5252),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "or",
                              style: TextStyle(
                                  color: brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                          const Expanded(
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
                      Text("Don't have an account?",
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
                          Get.toNamed('/register', arguments: Get.arguments);
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              color: brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ])));
  }
}
