import 'package:b2b_graphql_package/GraphQLConfiguration.dart';
import 'package:b2b_graphql_package/modules/product_detail/product_detail_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProductDetailRepo {
  var graphQLConfiguration;
  var productDetail;
  var productData;

  ProductDetailRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }

  Future getShopifyProductDetail(
      String id, bool isDefault, List variants, metaFields) async {
    print("meta fields $metaFields");
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    var productDetailGql = """
      query product(\$id:ID!, \$metaFields: [HasMetafieldsIdentifier!]!) {
        product(id:\$id) 
        {id
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
              totalInventory
              requiresSellingPlan
              seo{description,title}
              tags
              title
              trackingParameters
              metafields(identifiers: \$metaFields) {
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
                            handle
                            featuredImage{
                              id
                              url
                            }
                          }
                          ...on MediaImage {
                              id
                              mediaContentType
                              image {
                                  id
                                  url
                              }
                              mediaContentType
                              previewImage {
                                  id
                                  url
                              }
                          }
                          ... on Video {
                               id
                               mediaContentType
                              sources {
                                  format
                                  mimeType
                                  url
                              }
                          }
                        }
                    }
                }
                reference {
                  ...on MediaImage {
                      id
                      mediaContentType
                      image {
                          id
                          url
                      }
                      mediaContentType
                      previewImage {
                          id
                          url
                      }
                  }
                  ... on Video {
                       id
                       mediaContentType
                      sources {
                          format
                          mimeType
                          url
                      }
                  }
                }
              }
              collections(first: 10) {
                edges {
                  node {
                    id
                    handle
                    title
                  }
                }
              }
              vendor
                featuredImage{
                  id
                  url
                  altText
                  height
                  width
               }
              images(first: 10) {
                edges {
                  node {
                    id
                    url
                    altText
                    height
                    width
                  }
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
    final vble = {"id": id, "metaFields": metaFields};
    final stopwatch = Stopwatch()..start();
    QueryResult result = await _client.query(QueryOptions(
      document: gql(productDetailGql),
      variables: vble,
      fetchPolicy: FetchPolicy.networkOnly,
    ));
    stopwatch.stop();
    print('graphql Response time: ${stopwatch.elapsedMilliseconds} ms');
    if (!result.hasException) {
      var product = result.data!['product'];
      if (product != null && product.length > 0) {
        productDetail = productDetailFromJson(product);
      }
      return productDetail;
    }
    return productDetail;
  }

  Future getProductByHandle(String handle, metaFields) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    var productDetailGql = """
      query product(\$handle:String!) {
        product(handle:\$handle) 
        {id
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
            collections(first: 10) {
                edges {
                  node {
                    id
                    handle
                    title
                  }
                }
              }
               metafields(identifiers: $metaFields) {
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
                            handle
                            featuredImage{
                              id
                              url
                            }
                          }
                          ...on MediaImage {
                              id
                              mediaContentType
                              image {
                                  id
                                  url
                              }
                              mediaContentType
                              previewImage {
                                  id
                                  url
                              }
                          }
                          ... on Video {
                               id
                               mediaContentType
                              sources {
                                  format
                                  mimeType
                                  url
                              }
                          }
                        }
                    }
                }
                reference {
                  ...on MediaImage {
                      id
                      mediaContentType
                      image {
                          id
                          url
                      }
                      mediaContentType
                      previewImage {
                          id
                          url
                      }
                  }
                  ... on Video {
                       id
                       mediaContentType
                      sources {
                          format
                          mimeType
                          url
                      }
                  }
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
              images(first: 10) {
                edges {
                  node {
                    id
                    url
                    altText
                    height
                    width
                  }
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
      "handle": handle,
    };
    QueryResult result = await _client.query(QueryOptions(
      document: gql(productDetailGql),
      variables: vble,
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (!result.hasException) {
      var product = result.data!['product'];
      if (product != null && product.length > 0) {
        productDetail = productDetailFromJson(product);
      }
      return productDetail;
    }
    return productDetail;
  }

  Future getProductDetail(input) async {}
  Future createNotifyMe(input) async {
    String apiGql = """
      mutation createNotifyMe(\$input: NotifyMeInput){
        createNotifyMe(input: \$input){
          error
          message
        }
      }
    """;
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    final vble = {"input": input};
    QueryResult result = await _client.mutate(
      MutationOptions(
          document: gql(apiGql),
          variables: vble,
          operationName: 'createNotifyMe'),
    );
    graphQLConfiguration.getToken(result);
    if (!result.hasException) {
      var response = result.data!['createNotifyMe'];
      return response;
    }
    return null;
  }
}
