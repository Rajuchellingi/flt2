import 'package:b2b_graphql_package/GraphQLConfiguration.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'subscription_model.dart';

class SubscriptionRepo {
  var graphQlConfiguration;
  var subscription;
  var tokenConfiguration;

  SubscriptionRepo() {
    graphQlConfiguration = GraphQLConfiguration();
  }

  Future getSubscriptionDetail() async {
    GraphQLClient _client = graphQlConfiguration.clientToQuery(type: 2);
    var subscriptionGql = """
      query getAdminUserSubscriptionDetail {
        getAdminUserSubscriptionDetail {
          _id
          type
          expiryDate
          error
          message
        }
      }
    """;
    QueryResult result = await _client.query(QueryOptions(
        document: gql(subscriptionGql),
        fetchPolicy: FetchPolicy.networkOnly,
        operationName: "getAdminUserSubscriptionDetail"));
    if (!result.hasException) {
      graphQlConfiguration.getToken(result);
      var data = result.data!['getAdminUserSubscriptionDetail'];
      if (data != null) {
        return subscriptionModelFromJson(data);
      }
      return subscription;
    }
    return subscription;
  }

  Future getTokenConfiguration(accountId) async {
    GraphQLClient _client = graphQlConfiguration.clientToQuery(type: 2);
    var subscriptionGql = """
      query getTokenConfigurationForUI(\$accountId: String) {
        getTokenConfigurationForUI(accountId: \$accountId) {
          _id
          accountId
          clientId
          accessToken
          error
          message
        }
      }
    """;
    QueryResult result = await _client.query(QueryOptions(
        document: gql(subscriptionGql),
        variables: {"accountId": accountId},
        fetchPolicy: FetchPolicy.networkOnly,
        operationName: "getTokenConfigurationForUI"));
    if (!result.hasException) {
      graphQlConfiguration.getToken(result);
      var data = result.data!['getTokenConfigurationForUI'];
      if (data != null) {
        return tokenConfigurationFromJson(data);
      }
      return tokenConfiguration;
    }
    return tokenConfiguration;
  }

  Future getShopifyShopForUI() async {
    GraphQLClient _client = graphQlConfiguration.clientToQuery(type: 2);
    var subscriptionGql = """
      query getShopifyShopForUI {
        getShopifyShopForUI {
          error
          message
          shop
          name
          storefrontAccessToken
          clientId
        }
      }
    """;
    QueryResult result = await _client.query(QueryOptions(
        document: gql(subscriptionGql),
        fetchPolicy: FetchPolicy.networkOnly,
        operationName: "getShopifyShopForUI"));
    if (!result.hasException) {
      graphQlConfiguration.getToken(result);
      var data = result.data!['getShopifyShopForUI'];
      if (data != null) {
        return tokenConfigurationFromJson(data);
      }
      return tokenConfiguration;
    }
    return tokenConfiguration;
  }

  Future updateSubscriptionStatus(subscriptionId) async {
    String updateGql = """
    mutation updateSubscriptionStatus(\$subscriptionId: String) {
      updateSubscriptionStatus(subscriptionId: \$subscriptionId) {
        error
        message
      }
    }
    """;
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    final vble = {"subscriptionId": subscriptionId};
    QueryResult result = await _client.mutate(
      MutationOptions(
          document: gql(updateGql),
          variables: vble,
          operationName: 'updateSubscriptionStatus'),
    );
    graphQLConfiguration.getToken(result);
    if (!result.hasException) {
      var user = result.data!['updateSubscriptionStatus'];
      if (user != null) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
