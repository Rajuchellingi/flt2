import 'package:black_locust/controller/account_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<AccountController>(() => AccountController());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
