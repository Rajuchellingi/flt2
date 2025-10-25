import '../../GraphQLConfiguration.dart';

class OrderSettingRepo {
  var graphQLConfiguration;
  var orderSetting;

  OrderSettingRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }

  Future getOrderSetting() async {}
}
