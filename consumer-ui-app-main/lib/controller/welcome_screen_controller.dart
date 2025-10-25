// ignore_for_file: unused_local_variable, invalid_use_of_protected_member, unnecessary_null_comparison

import 'package:black_locust/controller/base_controller.dart';
import 'package:black_locust/controller/theme_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreenController extends GetxController with BaseController {
  var template = {}.obs;
  var isTemplateLoading = false.obs;
  final themeController = Get.find<ThemeController>();
  var currentIndex = 0.obs;

  @override
  void onInit() {
    getTemplate();
    super.onInit();
  }

  getTemplate() async {
    isTemplateLoading.value = true;
    List<dynamic> allTemplates = themeController.allTemplate.value;
    template.value = allTemplates.firstWhere(
        (value) => value['id'] == 'welcome-screen',
        orElse: () => {});

    isTemplateLoading.value = false;
  }

  Future<void> goToHomePage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);
    Get.offAllNamed('/home');
  }

  Future openNextScreen(index) async {
    if (index == template.value['layout']['blocks'].length - 1) {
      await goToHomePage();
    } else {
      currentIndex.value = index + 1;
    }
  }

  openLoginPage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);
    Get.toNamed('/login', arguments: {"path": "/home"});
  }

  @override
  void onClose() {
    super.onClose();
  }
}
