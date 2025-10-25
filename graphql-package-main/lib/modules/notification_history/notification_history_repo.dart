// ignore_for_file: unused_local_variable

import 'package:graphql_flutter/graphql_flutter.dart';

import '../../GraphQLConfiguration.dart';
import 'notification_history_model.dart';

class NotificationHistoryRepo {
  var graphQLConfiguration;

  var notificationHistory;
  var notificaitonCount;

  NotificationHistoryRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }

  Future getNotificationHistory(pageNo, limit) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    var notificationHistoryGql = """
      query getNotificationHistoryByUser(\$userId: String, \$pageNo: Int, \$limit: Int) {
        getNotificationHistoryByUser(userId: \$userId, pageNo: \$pageNo, limit: \$limit) {
          notification {
            _id
            title
            description
            notificationStatus
            linkType
            link
            image
            creationDate
          }
          count
          totalPages
        }
      }
    """;
    final vble = {
      "pageNo": pageNo,
      "limit": limit,
    };

    QueryResult result = await _client.query(QueryOptions(
        document: gql(notificationHistoryGql),
        variables: vble,
        fetchPolicy: FetchPolicy.networkOnly,
        operationName: 'getNotificationHistoryByUser'));
    if (!result.hasException) {
      graphQLConfiguration.getToken(result);
      var history = result.data!['getNotificationHistoryByUser'];
      if (history != null) {
        notificationHistory = notificationHistoryFromJson(history);
      }
      return notificationHistory;
    }
    return notificationHistory;
  }

  Future getUnreadNotificationCount() async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    var notificationHistoryGql = """
      query getUnreadNotificationCount(\$userId: String) {
        getUnreadNotificationCount(userId: \$userId) {
          count
        }
      }
    """;

    QueryResult result = await _client.query(QueryOptions(
        document: gql(notificationHistoryGql),
        fetchPolicy: FetchPolicy.networkOnly,
        operationName: 'getUnreadNotificationCount'));
    if (!result.hasException) {
      graphQLConfiguration.getToken(result);
      var count = result.data!['getUnreadNotificationCount'];
      if (count != null) {
        notificaitonCount = notificationCountFromJson(count);
      }
      return notificaitonCount;
    }
    return notificaitonCount;
  }

  Future updateRecentNotificationStatus(status) async {}

  Future updateNotificationHistoryStatus(notificationId, status) async {
    String addUserGql = """
      mutation updateNotificationHistoryStatus(\$notificationId: String, \$status: String) {
        updateNotificationHistoryStatus(notificationId: \$notificationId, status: \$status) {
          error
          message
        }
      }
    """;
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    final vble = {"notificationId": notificationId, "status": status};
    QueryResult result = await _client.mutate(
      MutationOptions(
          document: gql(addUserGql),
          variables: vble,
          operationName: 'updateNotificationHistoryStatus'),
    );
    if (!result.hasException) {
      graphQLConfiguration.getToken(result);
      var user = result.data!['updateNotificationHistoryStatus'];
      if (user != null) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
