import 'package:get/get.dart';

class FilterService extends GetxService {
  var isValue = false.obs;

  Future<FilterService> init() async {
    await 2.delay();
    return this;
  }
}
