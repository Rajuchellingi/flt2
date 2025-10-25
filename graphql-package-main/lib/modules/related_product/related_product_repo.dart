import 'package:b2b_graphql_package/modules/related_product/related_product_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../GraphQLConfiguration.dart';

class RelatedProductRepo {
  var graphQLConfiguration;
  var relatedProduct;
  var products;
  var cartCollectionList;
  RelatedProductRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }

  Future getRelatedProducts(String productId, productIdentifiers) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    var relatedProductGql = """
  query productRecommendations(\$productId: ID!, \$productIdentifiers: [HasMetafieldsIdentifier!]!){
       productRecommendations(productId: \$productId) {
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
                metafields(identifiers: \$productIdentifiers) {
                  type
                  value
                  key
                  namespace
                }
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
                     pageInfo {
                       hasNextPage
                        hasPreviousPage
                      } 
               }
            }
   }
    """;
    final vble = {
      "productId": productId,
      "productIdentifiers": productIdentifiers
      // "productId": "gid://shopify/Product/8500412154156"
    };
    QueryResult result = await _client.query(QueryOptions(
      document: gql(relatedProductGql),
      variables: vble,
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    try {
      if (!result.hasException) {
        var product = result.data!['productRecommendations'];
        if (product != null && product.length > 0) {
          List nodes = product.map((edge) => edge).toList();
          return relatedProductFromJson(nodes);
        }
        return relatedProduct;
      }
    } catch (e) {
      print(e);
      return relatedProduct;
    }
    return relatedProduct;
  }

  Future getProductsbyId(productIds) async {
    // print("selectedFilter model $filters");
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    var productListWithPriceGql = """
       query products(\$ids: [ID!]!) {
        nodes(ids: \$ids) {
            ... on Product {
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
                     pageInfo {
                       hasNextPage
                        hasPreviousPage
                      } 
               }               
        }
        }
        }
    """;
    final vble = {"ids": productIds};

    QueryResult result = await _client.query(QueryOptions(
      document: gql(productListWithPriceGql),
      variables: vble,
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (!result.hasException) {
      var product = result.data!['nodes'];

      if (product != null && product.length > 0) {
        products = relatedProductFromJson(product);
      }
      return products;
    }
    return products;
  }

  Future getProductsByCollectionForCart(handle, limit) async {
    // print("selectedFilter model $filters");
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    var productListWithPriceGql = """
    query getCollectionById(\$handle: String!) {
      collection(handle: \$handle) {
        title
        products(first: $limit) {
          edges {
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
                     pageInfo {
                       hasNextPage
                        hasPreviousPage
                      } 
               }               
            }
          }
        }
      }
    }
    """;
    final vble = {"handle": handle};

    QueryResult result = await _client.query(QueryOptions(
      document: gql(productListWithPriceGql),
      variables: vble,
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (!result.hasException) {
      var product = result.data!['collection'];

      if (product != null && product.length > 0) {
        var collectionProduct = product['products']['edges'];
        cartCollectionList = cartCollectionProductFromJson(collectionProduct);
      }
      return cartCollectionList;
    }
    return cartCollectionList;
  }
}
