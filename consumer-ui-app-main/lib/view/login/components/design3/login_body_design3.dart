import 'package:black_locust/const/constant.dart';
import 'package:black_locust/view/login/components/design3/login_form_design3.dart';
import 'package:flutter/material.dart';

class LoginBodyDesign3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return SingleChildScrollView(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text("Login",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: brightness == Brightness.dark
                    ? Colors.white
                    : kPrimaryTextColor,
              )),
          const SizedBox(height: 60),
          LoginFormDesign3(),
        ],
      ),
    ));
  }
}
