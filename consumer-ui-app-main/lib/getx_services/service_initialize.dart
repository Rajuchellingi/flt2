import 'package:black_locust/getx_services/filter_service.dart';
import 'package:get/get.dart';

class ServiceInit {
  void initServices() async {
    print('starting services ...');

    await Get.putAsync(() => FilterService().init());
    print('All services started...');
  }
}
