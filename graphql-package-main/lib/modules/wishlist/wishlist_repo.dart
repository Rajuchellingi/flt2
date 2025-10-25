import 'package:b2b_graphql_package/modules/wishlist/wishlist_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../GraphQLConfiguration.dart';

class WishListRepo {
  var graphQLConfiguration;

  WishListRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }
  var allWishList = [];
  var wishListCheck = false;

  Future getAllWishListWithProduct(productIds) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    var orderListGql = """
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
              variants(first: 10) {
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
      document: gql(orderListGql),
      variables: vble,
      fetchPolicy: FetchPolicy.networkOnly,
    ));
    if (!result.hasException) {
      var allWishList = result.data!['nodes'];
      if (allWishList != null && allWishList.length > 0) {
        var products = allWishList.where((element) => element != null).toList();
        // allWishList = wishlistProductDetailFromJson(allWishList);
        allWishList = allWishListWithProductFromJson(products);
        return allWishList;
      }
    }
    return null;
  }

  Future createWishlist(input) async {
    String apiGql = """
      mutation createWishlist(\$input: WishlistInput) {
        createWishlist(input: \$input) {
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
          operationName: 'createWishlist'),
    );
    graphQLConfiguration.getToken(result);
    if (!result.hasException) {
      var response = result.data!['createWishlist'];
      return response;
    }
    return null;
  }

  Future removeWishlist(wishlistId) async {
    String apiGql = """
      mutation removeWishlist(\$wishlistId: String) {
        removeWishlist(wishlistId: \$wishlistId) {
          error
          message
        }
      }
    """;
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    final vble = {"wishlistId": wishlistId};
    QueryResult result = await _client.mutate(
      MutationOptions(
          document: gql(apiGql),
          variables: vble,
          operationName: 'removeWishlist'),
    );
    graphQLConfiguration.getToken(result);
    if (!result.hasException) {
      var response = result.data!['removeWishlist'];
      return response;
    }
    return null;
  }

  Future getAllWishlistWithPagination(pageNo, limit) async {
    String apiGql = """
      query getAllWishlistWithPagination(\$pageNo: Int, \$limit: Int, \$search: String, \$userId: String) {
        getAllWishlistWithPagination(pageNo: \$pageNo, limit: \$limit, search: \$search, userId: \$userId) {
          wishlistData {
            _id
            userId
            productId
          }
          count
          totalPages
        }
      }
    """;
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    final vble = {"pageNo": pageNo, "limit": limit};
    QueryResult result = await _client.query(
      QueryOptions(
          document: gql(apiGql),
          variables: vble,
          fetchPolicy: FetchPolicy.networkOnly,
          operationName: 'getAllWishlistWithPagination'),
    );
    graphQLConfiguration.getToken(result);
    if (!result.hasException) {
      var response = result.data!['getAllWishlistWithPagination'];
      return wishilstDataFromJson(response);
    }
    return null;
  }

  Future getAllWishlistForUSer() async {
    String apiGql = """
      query getAllWishlistForUSer(\$userId: String) {
        getAllWishlistForUSer(userId: \$userId) {
          _id
          userId
          productId
        }
      }
    """;
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    final vble = {"userId": ""};
    QueryResult result = await _client.query(
      QueryOptions(
          document: gql(apiGql),
          variables: vble,
          fetchPolicy: FetchPolicy.networkOnly,
          operationName: 'getAllWishlistForUSer'),
    );
    graphQLConfiguration.getToken(result);
    if (!result.hasException) {
      var response = result.data!['getAllWishlistForUSer'];
      return wishlistProductDataFromJson(response);
    }
    return null;
  }

  Future createWishListName(collectionName) async {}
  Future wishlistPageCollectionList(search, limit) async {}
  Future createListoverall(collectionIds, selectedCollectionID) async {}
  Future allWishlistPageCollectionList(String userId) async {}
  Future removeOverallColectionWishlist(collectionId) async {}
  Future changeCollectionName(collectionId, name, userId) async {}
  Future removeColectionWishlist(wishlistId, collectionId) async {}
  Future getProductsByWishlistCollection(
      userId, collectionId, limit, pageIndex) async {}
}
