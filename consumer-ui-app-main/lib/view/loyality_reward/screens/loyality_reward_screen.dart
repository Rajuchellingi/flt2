import 'package:black_locust/controller/loyality_controller.dart';
import 'package:black_locust/view/loyality_reward/components/loyality_logout.dart';
import 'package:black_locust/view/loyality_reward/components/loyality_reward_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoyalityRewardScreen extends StatelessWidget {
  const LoyalityRewardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<LoyalityController>();
    final isLoggedIn = GetStorage().read('utoken') != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards Center'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.notifications_none), onPressed: () {}),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: isLoggedIn ? LoyalityRewardBody() : LoyalityLogout(),
    );
  }
}
