import 'package:black_locust/const/constant.dart';
import 'package:black_locust/view/register/components/design3/registration_form_design3.dart';
import 'package:flutter/material.dart';

class RegistrationBodyDesign3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Sign Up",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : kPrimaryTextColor,
                  )),
              const SizedBox(height: 35),
              Container(child: RegistrationFormDesign3()),
            ])));
  }
}
