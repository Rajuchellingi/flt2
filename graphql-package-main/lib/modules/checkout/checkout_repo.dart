// ignore_for_file: unused_local_variable

import 'package:graphql_flutter/graphql_flutter.dart';

import '../../GraphQLConfiguration.dart';

class CheckoutRepo {
  var graphQLConfiguration;

  var checkoutData;
  var address;
  CheckoutRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }

  Future getCheckoutDetailByUser(state) async {}

  Future getAllAddressByUser() async {}

  Future changeShippingAddress(addressId) async {}

  Future changeBillingAddress(addressId) async {}

  Future initiateBookingByUser() async {}

  Future checkBookingIsConfirmed(token) async {
    GraphQLClient _client = graphQLConfiguration!.clientToQuery(type: 2);
    var apiGql = """
      mutation checkOrderIsCreated(\$token: String) {
        checkOrderIsCreated(token: \$token) {
          error
          message
          orderId
        }
      }
    """;

    QueryResult result = await _client.mutate(MutationOptions(
        document: gql(apiGql),
        variables: {
          "token": token,
        },
        operationName: 'checkOrderIsCreated'));
    if (!result.hasException) {
      graphQLConfiguration!.getToken(result);
      var data = result.data!['checkOrderIsCreated'];
      if (data != null) {
        return data;
      }
    }
    return null;
  }

  Future checkPaymentAndCreateOrder(token) async {
    GraphQLClient _client = graphQLConfiguration!.clientToQuery(type: 2);
    var apiGql = """
      mutation createOrderByRazorpayPayment(\$token: String) {
        createOrderByRazorpayPayment(token: \$token) {
          error
          message
        }
      }
    """;

    QueryResult result = await _client.mutate(MutationOptions(
        document: gql(apiGql),
        variables: {
          "token": token,
        },
        operationName: 'createOrderByRazorpayPayment'));
    print(
        'order payment dataaaaaaaaaaaa ${result.hasException} ${result.exception}');
    if (!result.hasException) {
      graphQLConfiguration!.getToken(result);
      var data = result.data!['createOrderByRazorpayPayment'];
      if (data != null) {
        return data;
      }
    }
    return null;
  }

  Future updateDiscountByClosePayment(tempOrderId) async {}
  Future initiatePaymentByTransaction(tempOrderId) async {}
  Future initiateOrderByUser() async {}
  Future checkCODOrderIsConfirmed(tempOrderId) async {}
  Future initiateCODOrder() async {}
}
