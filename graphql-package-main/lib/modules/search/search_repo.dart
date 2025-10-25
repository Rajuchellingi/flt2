import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:b2b_graphql_package/modules/search/search_model.dart';

import '../../GraphQLConfiguration.dart';

class SearchRepo {
  var graphQLConfiguration;

  var productList;
  var productAttribute;
  var product;
  var searchSetting;
  var searchList;
  SearchRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }

  Future getSearchProducts(
      String searchText, after, sort, productIdentifiers) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    var productListWithPriceGql = """
      query searchProducts(\$first: Int, \$after: String, \$query: String!, \$sortKey: SearchSortKeys, \$reverse: Boolean, \$productIdentifiers: [HasMetafieldsIdentifier!]!) {
        search(query: \$query, first: \$first, after: \$after, types: PRODUCT, sortKey: \$sortKey, reverse: \$reverse) {
          pageInfo {
            hasNextPage
            hasPreviousPage
            endCursor
          }
          edges {
            node {
              ... on Product {
                id
                title
                description
                handle
                availableForSale
                createdAt
                description
                descriptionHtml
                handle
                isGiftCard
                onlineStoreUrl
                options{id,name,values}
                productType
                publishedAt
                requiresSellingPlan
                seo{description,title}
                tags
                title
                trackingParameters
                vendor
                metafields(identifiers: \$productIdentifiers) {
                  type
                  value
                  key
                  namespace
                }
                images(first: 10) {
                  nodes {
                      id
                      url
                      altText
                      height
                      width
                  }
                }
                featuredImage{
                  id
                  url
                  altText
                  height
                  width
                }
                variants(first: 50) {
                 edges {
                    node { 
                      id
                      title
                      availableForSale
                    }
                  }
                }
                compareAtPriceRange {
                  minVariantPrice {
                    amount
                    currencyCode
                  }
                   maxVariantPrice {
                    amount
                    currencyCode
                  }
                }
                priceRange {
                  minVariantPrice {
                    amount
                    currencyCode
                  }
                  maxVariantPrice {
                    amount
                    currencyCode
                  }
                }
              }
            }
          }
        }
      }
    """;

    final vble = {
      "query": searchText,
      "first": 10,
      "after": after,
      "sortKey": sort.sortKey,
      "reverse": sort.reverse,
      "productIdentifiers": productIdentifiers
    };
    QueryResult result = await _client.query(QueryOptions(
      document: gql(productListWithPriceGql),
      variables: vble,
      fetchPolicy: FetchPolicy.networkOnly,
    ));
    // print("result $result");

    if (!result.hasException) {
      var searchProducts = result.data!['search']['edges'];
      var searchData = result.data!['search'];
      if (searchData != null && searchProducts.length > 0) {
        List nodes = searchProducts.map((edge) => edge['node']).toList();
        var response = {"pageInfo": searchData['pageInfo'], "products": nodes};
        productList = productCollectionFromJson(response);
      }

      // if (proudct != null) {
      //   productList = productCollectionFromJson(proudct);
      // }
      return productList;
    }
    return productList;
  }

  Future getAttributeByCollection(argument) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    var attributeGql = """
     query getProducts(\$first: Int, \$query: String) {
         products(first: \$first, query: \$query) {
            edges {
              node {
                id
                options{id,name,values}
                variants(first: 5) {
                  edges {
                    node {
                      id
                      title
                      priceV2 {
                        amount
                        currencyCode
                      }
                    }
                  }
                }
              }
            }
        }
     }
  """;

    final vble = {
      // "query": "title: $argument",
      "query": "$argument",
      "first": 100,
      // "filter": filter
    };
    QueryResult result = await _client.query(QueryOptions(
      document: gql(attributeGql),
      variables: vble,
      fetchPolicy: FetchPolicy.networkOnly,
    ));
    if (!result.hasException) {
      var filterProducts = result.data!['products']['edges'];
      if (filterProducts.isNotEmpty) {
        // var productsEdges = collections[0]['node']['products']['edges'];
        for (var productEdge in filterProducts) {
          var variantsEdges = productEdge['node']['options'];
          if (variantsEdges != null && variantsEdges.length > 0) {
            var attributeObject = {"attribute": variantsEdges};
            product = searchProductCollectionFromJson(attributeObject);
          }
          // }
        }
      }
      return productList;
    }
    return productList;
  }

  Future getPredictiveSearch(query) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    var searchGql = """
     query predictiveSearch(\$query: String!, \$types: [PredictiveSearchType!]) {
         predictiveSearch( query: \$query, types: \$types) {
            queries {
              text
            }
            products {
              id
              title
              featuredImage {
                url
              }
            }
        }
     }
  """;

    final vble = {
      "query": query,
      "types": ["QUERY", "PRODUCT"]
    };
    QueryResult result = await _client.query(QueryOptions(
      document: gql(searchGql),
      variables: vble,
      fetchPolicy: FetchPolicy.networkOnly,
    ));
    if (!result.hasException) {
      var searchData = result.data!['predictiveSearch'];
      if (searchData != null) {
        searchList = predictiveSearchFromJson(searchData);
      }
      return searchList;
    }
    return searchList;
  }

  Future getProductsBySearchForUIV1(searchText, pageIndx, value) async {}
  Future getSearchSetting() async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    var productSettingGql = """
      query getSearchSettingForUI {
        getSearchSettingForUI {
          _id
          recommendedProducts {
            _id
            count
            collectionUrl
            title
          }
          popularSearches {
            _id
            title
          }
        }
      }
    """;

    QueryResult result = await _client.query(QueryOptions(
        document: gql(productSettingGql),
        fetchPolicy: FetchPolicy.networkOnly,
        operationName: 'getSearchSettingForUI'));
    if (!result.hasException) {
      graphQLConfiguration.getToken(result);
      var history = result.data!['getSearchSettingForUI'];
      if (history != null) {
        searchSetting = searchSettingFromJson(history);
      }
      return searchSetting;
    }
    return searchSetting;
  }
}
