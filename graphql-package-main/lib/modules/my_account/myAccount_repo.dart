import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';

import '../../GraphQLConfiguration.dart';

class MyAccoutRepo {
  var graphQLConfiguration;

  MyAccoutRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }
  var myAccountMenus;

  Future myAccountPageMenuList() async {
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    // GraphQLClient _client = graphQLConfiguration.clientToQuery();
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);

    var orderListGql = """
     query getAccountPageSettingForUI {
  getAccountPageSettingForUI
}
     """;

    // final vble = {"userId": "", "search": "", "limit": limit};
    QueryResult result = await _client.query(QueryOptions(
      document: gql(orderListGql),
      // variables: vble,
      // fetchPolicy: FetchPolicy.networkOnly,
      operationName: "getAccountPageSettingForUI",
    ));

    if (!result.hasException) {
      graphQLConfiguration.getToken(result);
      var allMyAccountCollections = result.data!['getAccountPageSettingForUI'];
      // print("allWishList---->>> ${allMyAccountCollections}");
      if (allMyAccountCollections != null) {
        var data = jsonDecode(allMyAccountCollections);
        // allWishList = wishlistCollectionFromJson(data);
        myAccountMenus = data;
        return myAccountMenus;
      }
    }
    return myAccountMenus;
  }
}
