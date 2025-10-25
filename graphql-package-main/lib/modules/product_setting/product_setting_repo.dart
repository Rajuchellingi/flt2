// ignore_for_file: unused_local_variable

import 'package:b2b_graphql_package/modules/product_setting/product_setting_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../GraphQLConfiguration.dart';

class ProductSettingRepo {
  var graphQLConfiguration;

  var notificationHistory;

  ProductSettingRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }

  Future getProductSetting() async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    var productSettingGql = """
      query getProductSettingForUI {
        getProductSettingForUI {
          _id
          showAvailableSize
          showSimilarStyles
          showRecentlyViewed
          showAddToCart
          productPolicy {
            _id
            title
            description
          }
        }
      }
    """;

    QueryResult result = await _client.query(QueryOptions(
        document: gql(productSettingGql),
        fetchPolicy: FetchPolicy.networkOnly,
        operationName: 'getProductSettingForUI'));
    if (!result.hasException) {
      graphQLConfiguration.getToken(result);
      var history = result.data!['getProductSettingForUI'];
      if (history != null) {
        notificationHistory = productSettingFromJson(history);
      }
      return notificationHistory;
    }
    return notificationHistory;
  }

  Future getSiteSetting() async {}
}
