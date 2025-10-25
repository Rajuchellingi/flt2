// ignore_for_file: unused_local_variable

import 'package:b2b_graphql_package/modules/plugins/plugins_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../GraphQLConfiguration.dart';

class PluginsRepo {
  var graphQLConfiguration;

  var plugins;

  PluginsRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }

  Future getPlugins() async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    var pluginsGql = """
      query getAllEnabledIntegration {
        getAllEnabledIntegration {
          _id
          name
          status
          mobileNumber
          title
          code
          isReview
          secretKey
          workspace
        }
      }
    """;

    QueryResult result = await _client.query(QueryOptions(
        document: gql(pluginsGql),
        fetchPolicy: FetchPolicy.networkOnly,
        operationName: 'getAllEnabledIntegration'));
    if (!result.hasException) {
      graphQLConfiguration.getToken(result);
      var history = result.data!['getAllEnabledIntegration'];
      if (history != null) {
        plugins = pluginsFromJson(history);
      }
      return plugins;
    }
    return plugins;
  }
}
