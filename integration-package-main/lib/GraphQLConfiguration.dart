import 'dart:io';

import 'package:integration_package/config/configConstant.dart';
import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";
import 'package:http/io_client.dart';

class GraphQLConfiguration {
  //static String uri = 'http://10.0.2.2:4300/graphql';
  static String uri = '';

  static late HttpClient hclient;
  static late HttpLink httpLink;
  late ValueNotifier<GraphQLClient> client;
  GraphQLConfiguration();
  GraphQLConfiguration.config() {
    uri = graphQlServiceUri + "graphql";
    hclient = HttpClient()..connectionTimeout = Duration(seconds: 120);
    httpLink = HttpLink(uri,
        defaultHeaders: {
          // "atoken": accessToken,
        },
        httpClient: IOClient(hclient));
  }

  Future<void> initiateGraphQl() async {
    await initHiveForFlutter();
    client = ValueNotifier(
      GraphQLClient(
          link: httpLink, cache: GraphQLCache(store: InMemoryStore())),
    );
  }

  GraphQLClient clientToQuery() {
    //type 1. shopify url, 2. service url

    return GraphQLClient(
      cache: GraphQLCache(
          // store: HiveStore()
          store: InMemoryStore()),
      link: httpLink,
    );
  }
}
