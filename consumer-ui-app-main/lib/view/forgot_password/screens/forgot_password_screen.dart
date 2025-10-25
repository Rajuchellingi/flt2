// ignore_for_file: unused_field

import 'package:black_locust/view/forgot_password/components/forgot_password_body.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          title: const Text("Forgot Password"),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: ForgotPasswordBody(),
      ),
      drawerEnableOpenDragGesture: false,
    );
  }
}
