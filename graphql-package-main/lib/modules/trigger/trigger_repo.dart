import 'package:b2b_graphql_package/GraphQLConfiguration.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TriggerRepo {
  var graphQLConfiguration;

  TriggerRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }

  Future createTrigger(type) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    var apiGql = """
      mutation createTrigger(\$args: TriggerInput) {
        createTrigger(args: \$args) {
          error
          message
        }
      }
    """;

    QueryResult result = await _client.mutate(MutationOptions(
        document: gql(apiGql),
        variables: {
          "args": {"type": type}
        },
        operationName: 'createTrigger'));
    if (!result.hasException) {
      graphQLConfiguration.getToken(result);
      var history = result.data!['createTrigger'];
      if (history != null) {
        return true;
      }
      return false;
    }
    return null;
  }

  Future cancelTriggerNotification(type) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    var apiGql = """
      mutation cancelTriggerNotification(\$args: TriggerInput) {
        cancelTriggerNotification(args: \$args) {
          error
          message
        }
      }
    """;

    QueryResult result = await _client.mutate(MutationOptions(
        document: gql(apiGql),
        variables: {
          "args": {"type": type}
        },
        operationName: 'cancelTriggerNotification'));
    if (!result.hasException) {
      graphQLConfiguration.getToken(result);
      var history = result.data!['cancelTriggerNotification'];
      if (history != null) {
        return true;
      }
      return false;
    }
    return null;
  }
}
