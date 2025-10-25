// ignore_for_file: unused_field

import 'package:black_locust/new_password/components/new_password_body.dart';
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          title: Text("New Password"),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: NewPasswordBody(),
      ),
      drawerEnableOpenDragGesture: false,
    );
  }
}
