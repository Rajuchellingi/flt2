import 'package:b2b_graphql_package/GraphQLConfiguration.dart';
import 'package:b2b_graphql_package/modules/registration/registration_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RegistrationRepo {
  var graphQlConfiguration;
  var customerDetails;

  RegistrationRepo() {
    graphQlConfiguration = GraphQLConfiguration();
  }

  Future customerCreate(input) async {
    GraphQLClient _client = graphQlConfiguration.clientToQuery();
    var loginGql = """
      mutation customerCreate(\$input: CustomerCreateInput!) {
  customerCreate(input: \$input) {
    customer {
      firstName
      lastName
      email
      phone
      acceptsMarketing
    }
    customerUserErrors {
      field
      message
      code
    }
  }
}

    """;

    final vble = {"input": input};
    QueryResult result = await _client.query(QueryOptions(
        document: gql(loginGql),
        variables: vble,
        // fetchPolicy: FetchPolicy.networkOnly,
        operationName: "customerCreate"));
    // print('datasssssss ${result.hasException}');
    if (!result.hasException) {
      var data = result.data!['customerCreate'];
      if (data != null) {
        // login = loginDataFromJson(data);
        customerDetails = registrationModelFromJson(data);
      }
    } else {
      var data = {
        "customer": null,
        "customerUserErrors": [
          {
            "message": result.exception?.graphqlErrors.first.message,
            "__typename": "Error"
          }
        ]
      };
      customerDetails = registrationModelFromJson(data);
    }
    return customerDetails;
  }

  Future createShopifyUser(user) async {
    String addUserGql = """
        mutation createShopifyUser(\$user: ShopifyUserInput) {
          createShopifyUser(user: \$user) {
            userId
            error
            message
          }
        }
      """;
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    final vble = {"user": user};
    QueryResult result = await _client.mutate(
      MutationOptions(
          document: gql(addUserGql),
          variables: vble,
          operationName: 'createShopifyUser'),
    );
    var userData;
    graphQLConfiguration.getToken(result);
    if (!result.hasException) {
      var user = result.data!['createShopifyUser'];
      if (user != null) {
        userData = userRegisterFromJson(user);
        return userData;
      } else {
        return userData;
      }
    }
    return null;
  }

  Future updateCustomerMetafields(customerId, metafields) async {
    String addUserGql = """
      mutation updateCustomerMetafields(\$customerId: String, \$metafields: [CustomMetafieldsInput]) {
        updateCustomerMetafields(customerId: \$customerId, metafields: \$metafields) {
          error
          message
        }
      }
      """;
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    final vble = {"customerId": customerId, "metafields": metafields};
    QueryResult result = await _client.mutate(
      MutationOptions(
          document: gql(addUserGql),
          variables: vble,
          operationName: 'updateCustomerMetafields'),
    );
    graphQLConfiguration.getToken(result);
    if (!result.hasException) {
      var user = result.data!['updateCustomerMetafields'];
      return user;
    }
    return null;
  }

  Future updateShopifyUserDeviceToken(userId, deviceToken) async {
    String addUserGql = """
      mutation updateShopifyUserDeviceToken(\$userId: String, \$deviceToken: String) {
        updateShopifyUserDeviceToken(userId: \$userId, deviceToken: \$deviceToken) {
          error
          message
        }
      }
    """;
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    final vble = {"userId": userId, "deviceToken": deviceToken};
    QueryResult result = await _client.mutate(
      MutationOptions(
          document: gql(addUserGql),
          variables: vble,
          operationName: 'updateShopifyUserDeviceToken'),
    );
    graphQLConfiguration.getToken(result);
    if (!result.hasException) {
      var user = result.data!['updateShopifyUserDeviceToken'];
      if (user != null) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
