// ignore_for_file: unused_local_variable

import 'package:b2b_graphql_package/GraphQLConfiguration.dart';

class LoyalityRepo {
  var graphQLConfiguration;

  LoyalityRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }

  Future getLoyalityRewardWidget(emailId) async {}
  Future redeemLoyalityCoupon(emailId, requiredCoin, id, userTypeName) async {}
  Future redeemScratchCard(emailId, requiredCoin, id) async {}
  Future getLoyalityOrder(emailId, id) async {}
  Future redeemSpinWheel(emailId, requiredCoin, spinWheelId, id) async {}
}
