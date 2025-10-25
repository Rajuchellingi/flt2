import 'package:black_locust/common_component/loading_image.dart';
import 'package:black_locust/controller/secondary_form_controller.dart';
import 'package:black_locust/view/secondary_form/components/secondary_form_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondaryFormScreen extends StatelessWidget {
  final _controller = Get.find<SecondaryFormController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Additional Information'),
      ),
      body: Obx(() => _controller.isLoading.value == true
          ? Center(child: LoadingImage())
          : SecondaryFormBody()),
    );
  }
}
