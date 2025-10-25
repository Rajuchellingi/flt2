import 'dart:io';

import 'package:b2b_graphql_package/config/configConstant.dart';
import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";
import 'package:http/io_client.dart';
import 'package:get_storage/get_storage.dart';

const sizeChartUrl =
    'https://eiwqak3tpd.execute-api.ap-south-1.amazonaws.com/prod/getSizechartByCollectionsTestingCondition/';

class GraphQLConfiguration {
  //static String uri = 'http://10.0.2.2:4300/graphql';
  static String uri = '';

  static late HttpClient hclient;
  static late HttpLink shopifyHttpLink;
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

  GraphQLConfiguration.shopifyConfig(String shopifyServiceUri) {
    shopifyHttpLink = HttpLink(
      shopifyServiceUri,
      // defaultHeaders: {
      //   'client-id': "1ae43728-f207-4248-b077-cdf4346e52b2",
      //   'bussiness-type': '1'
      // },
      defaultHeaders: {
        // "X-Shopify-Storefront-Access-Token": "f0bfe8d388002854f37b3b5c172d1628",

        // "X-Shopify-Storefront-Access-Token": accessToken
      },
      httpClient: IOClient(hclient),
    );
  }

  setHeaders() {
    var cToken = GetStorage().read('ctoken');
    var tempToken = GetStorage().read('temptoken');
    var uToken = GetStorage().read('userToken');
    if (cToken != null) httpLink.defaultHeaders['ctoken'] = cToken;
    if (tempToken != null) httpLink.defaultHeaders['temptoken'] = tempToken;
    if (uToken != null) httpLink.defaultHeaders['utoken'] = uToken;
    httpLink.defaultHeaders['client-id'] = clientId;
  }

  setShopifyHeaders() {
    var accessToken = GetStorage().read('accessToken');
    if (accessToken != null)
      shopifyHttpLink.defaultHeaders['X-Shopify-Storefront-Access-Token'] =
          accessToken;
  }

  getToken(QueryResult result) {
    final dynamic httpLinkContext =
        result.context.entry<HttpLinkResponseContext>()!.headers;
    var cToken = httpLinkContext["ctoken"];
    var tempToken = httpLinkContext["temptoken"];
    var uToken = httpLinkContext["utoken"];
    if (tempToken != null) {
      GetStorage().write('temptoken', tempToken);
    }
    if (cToken != null) {
      GetStorage().write('ctoken', cToken);
      GetStorage().remove('temptoken');
    }
    if (uToken != null) {
      GetStorage().write('userToken', uToken);
      GetStorage().remove('temptoken');
    } else {
      // GetStorage().remove('userToken');
    }
  }

  Future<void> initiateGraphQl() async {
    await initHiveForFlutter();
    client = ValueNotifier(
      GraphQLClient(
          queryRequestTimeout: const Duration(seconds: 20),
          link: shopifyHttpLink,
          cache: GraphQLCache(
              // store: HiveStore()
              store: InMemoryStore())),
    );
  }

  GraphQLClient clientToQuery({type = 1}) {
    var link = type == 1 ? shopifyHttpLink : httpLink;
    //type 1. shopify url, 2. service url

    if (type == 2) setHeaders();
    if (type == 1) setShopifyHeaders();
    return GraphQLClient(
      queryRequestTimeout: const Duration(seconds: 20),
      cache: GraphQLCache(
          // store: HiveStore()
          store: InMemoryStore()),
      link: link,
    );
  }
}
