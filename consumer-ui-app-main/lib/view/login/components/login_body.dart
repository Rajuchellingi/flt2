import 'package:black_locust/const/constant.dart';
import 'package:black_locust/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../const/size_config.dart';
import 'login_form.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key, required controller})
      : _controller = controller,
        super(key: key);

  final LogInController _controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              LoginForm(),
              const SizedBox(height: 20),
              if (_controller.isPrizma.value == false) ...[
                Center(
                    child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/forgotPassword');
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: kPrimaryColor),
                  ),
                )),
                const SizedBox(height: 5),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/register', arguments: Get.arguments);
                    },
                    child: const Text(
                      "Register here",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
