import 'package:black_locust/controller/search_page_controller.dart';
import 'package:black_locust/controller/search_page_v1_controller.dart';
import 'package:black_locust/controller/search_page_v2_controller.dart';
import 'package:black_locust/controller/subscription_controller.dart';
import 'package:get/get.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<SearchPageController>(() => SearchPageController());
    Get.create<SearchPageV1Controller>(() => SearchPageV1Controller());
    Get.create<SearchPageV2Controller>(() => SearchPageV2Controller());
    Get.create<SubscriptionController>(() => SubscriptionController());
  }
}
