import 'package:black_locust/controller/loyality_achievement_controller.dart';
import 'package:black_locust/view/loyality_achievement/components/loyality_achievement_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoyaltyAchievementScreen extends StatelessWidget {
  final _controller = Get.find<LoyalityAchievementController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Achievement'),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: LoyalityAchievementBody(controller: _controller),
    );
  }
}
