// ignore_for_file: unused_local_variable

import 'package:b2b_graphql_package/modules/cart_setting/cart_setting_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../GraphQLConfiguration.dart';

class CartSettingRepo {
  var graphQLConfiguration;

  var cartSetting;

  CartSettingRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }

  Future getCartSetting() async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    var cartSettingGql = """
      query getCartSettingForUI {
        getCartSettingForUI {
          _id
          showDiscountProgressBar
          discountProgressBar {
            _id
            title
            discountValue
            discountType
            requirementType
            requirementValue
          }
          recommendedProducts {
            _id
            title
            type
            collections {
              _id
              title
              imageName
              collectionUrl
            }
            singleCollectionUrl
          }
        }
      }
    """;

    QueryResult result = await _client.query(QueryOptions(
        document: gql(cartSettingGql),
        fetchPolicy: FetchPolicy.networkOnly,
        operationName: 'getCartSettingForUI'));
    if (!result.hasException) {
      graphQLConfiguration.getToken(result);
      var history = result.data!['getCartSettingForUI'];
      if (history != null) {
        cartSetting = cartSettingFromJson(history);
      }
      return cartSetting;
    }
    return cartSetting;
  }
}
