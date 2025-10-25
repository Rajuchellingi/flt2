import 'package:black_locust/controller/collection_brand_controller.dart';
import 'package:get/get.dart';

class BrandCollectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<CollectionBrandController>(() => CollectionBrandController());
  }
}
