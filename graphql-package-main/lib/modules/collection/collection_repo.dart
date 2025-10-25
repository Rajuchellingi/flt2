// ignore_for_file: unused_local_variable

import 'package:b2b_graphql_package/modules/collection/collection_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../GraphQLConfiguration.dart';

class CollectionRepo {
  var graphQLConfiguration;

  var homePage;
  var productList;
  var filter;
  CollectionRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }

  Future getProductsByCollection(input) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    var productListWithPriceGql = """
    query getCollectionById(\$handle: String!, \$after: String, \$filters: [ProductFilter!], \$productIdentifiers: [HasMetafieldsIdentifier!]!, \$identifiers: [HasMetafieldsIdentifier!]!) {
      collection(handle: \$handle) {
        id
        title
        description
        handle
        image {
          originalSrc
          altText
        }     
        products(first: ${input['first']}, after: \$after, filters: \$filters, sortKey: ${input['sort'].sortKey}, reverse: ${input['sort'].reverse}) {
          pageInfo {
            hasNextPage
            hasPreviousPage
            endCursor
          }
          filters {
            id
            label
            type
            values {
              count
              id
              input
              label
            }
          }
          edges {
            cursor
            node {
              id
              title
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
              featuredImage{
                id
                url
                altText
                height
                width
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
              variants(first: 50) {
                edges {
                  node { 
                    id
                    title
                    availableForSale
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
          metafields(identifiers: \$identifiers) {
            id
            description
            type
            key
            namespace
            value
            references(first: 10) {
              edges {
                node {
                  ...on Product {
                    id
                    title
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
            }
        }
      }
    """;
    final vble = {
      "handle": input['id'],
      "after": input['endCursor'],
      "filters": input['filters'],
      "identifiers": input['identifiers'],
      "productIdentifiers": input['productIdentifiers']
    };
    QueryResult result = await _client.query(QueryOptions(
      document: gql(productListWithPriceGql),
      variables: vble,
      fetchPolicy: FetchPolicy.networkOnly,
    ));
    // print("result $result");

    if (!result.hasException) {
      var proudct = result.data!['collection'];

      if (proudct != null && proudct.length > 0) {
        var collectionProduct = {"values": proudct};
        productList = productCollectionFromJson(collectionProduct);
      }
      return productList;
    }
    return productList;
  }

  Future getAttributeByCollection(categoryLink) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    var attributeGql = """
      query getProductFilters(\$handle: String!) {
        collection(handle: \$handle) {
          id
          title
          products(first: 200) {
            filters {
              id
              label
              type
              values {
                count
                id
                input
                label
              }
            }
          }
        }
      }
  """;
    final vble = {"handle": categoryLink};
    // final vble = {"collectionId": categoryLink};
    QueryResult result = await _client.query(QueryOptions(
      document: gql(attributeGql),
      variables: vble,
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (!result.hasException) {
      var data = result.data!['collection'];
      if (data != null) {
        var collections = data['products']['filters'];
        var variantsEdges = [];
        if (collections.isNotEmpty) {
          var attributeObject = {"attribute": collections};
          filter = collectionAttributeFromJson(attributeObject);
        }
      }
      return filter;
    }
  }

  Future getPromotionProductsByCollection(
      handle, count, productIdentifiers) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 1);
    var homePageGql = """
     query getCollectionById(\$handle: String!, \$productIdentifiers: [HasMetafieldsIdentifier!]!) {
                collection(handle: \$handle) {
                    title
                    products(first: $count) {
                        edges {
                            node {
                                id
                                title
                                availableForSale
                                priceRange {
                                    minVariantPrice {
                                        amount
                                    }
                                }
                                options {
                                    id,
                                    name,
                                    values
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
                                    maxVariantPrice {
                                        amount
                                    }
                                }
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
                                    url
                                }
                            }
                        }
                    }
                }
            }
    """;

    QueryResult result = await _client.query(QueryOptions(
      document: gql(homePageGql),
      variables: {"handle": handle, "productIdentifiers": productIdentifiers},
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (!result.hasException) {
      var productData = result.data!['collection'];

      if (productData != null) {
        var collectionProduct = productData['products']['edges'];

        return homePagePromotionFromJson(collectionProduct);
      }
      return null;
    }
    return null;
  }

  Future getProductFilters(input) async {}
  Future shareProductCatalogByProductIds(input) async {}
  Future getProductsByBrandForUIV1(input) async {}
  Future getMetaValueForDownload(input) async {}
  Future downloadProductCatalogByProductIds(input) async {}
}
