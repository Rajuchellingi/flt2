// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:b2b_graphql_package/modules/coupen_codes/coupen_code_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../GraphQLConfiguration.dart';

class CoupenCodeRepo {
  var graphQLConfiguration;

  var coupenCode;

  CoupenCodeRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }

  Future getAllCoupenCodeForUI() async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    var queryGql = """
      query getAllCoupenCodeForUI {
        getAllCoupenCodeForUI
      }
    """;

    QueryResult result = await _client.query(QueryOptions(
        document: gql(queryGql),
        fetchPolicy: FetchPolicy.networkOnly,
        operationName: 'getAllCoupenCodeForUI'));
    if (!result.hasException) {
      graphQLConfiguration.getToken(result);
      var history = result.data!['getAllCoupenCodeForUI'];
      if (history != null) {
        coupenCode = coupenCodesFromJson(jsonDecode(history));
      }
      return coupenCode;
    }
    return coupenCode;
  }

  Future applyDiscountCoupen(cartId, discountCodes) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 1);
    var queryGql = """
      mutation cartDiscountCodesUpdate(\$cartId: ID!, \$discountCodes: [String!]) {
        cartDiscountCodesUpdate(cartId: \$cartId, discountCodes: \$discountCodes) {
          cart {
            id
            checkoutUrl
            discountCodes {
              applicable
              code
            }
          }
          userErrors {
            field
            message
          }
        }
      }
    """;

    QueryResult result = await _client.query(QueryOptions(
        document: gql(queryGql),
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"cartId": cartId, "discountCodes": discountCodes},
        operationName: 'cartDiscountCodesUpdate'));
    if (!result.hasException) {
      var data = result.data!['cartDiscountCodesUpdate'];
      if (data != null) {
        return data;
      }
      return null;
    }
    return null;
  }
}
