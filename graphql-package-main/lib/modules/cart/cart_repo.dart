import 'package:b2b_graphql_package/GraphQLConfiguration.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'cart_model.dart';

class CartRepo {
  GraphQLConfiguration? graphQLConfiguration;
  var cartProduct;
  var addedCart;
  var productSummary;
  CartRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }

  Future createCart(input) async {
    GraphQLClient _client = graphQLConfiguration!.clientToQuery();

    var addCartGql = """
      mutation cartCreate(\$input:CartInput!) {
         cartCreate(input: \$input){
              cart {
                   id
                 createdAt
                 updatedAt
                   lines(first: 10) {
                     edges {
                       node {
                         id
                         quantity
                         merchandise {
                           ... on ProductVariant {
                             id
                           }
                         }
                       }
                     }
                   }
                  buyerIdentity {
                    email
                    phone
                    countryCode
                  }
             }
            userErrors {
              field
              message
            }
         }
     }
        
            """;
    final vble = {"input": input};
    QueryResult result = await _client.mutate(MutationOptions(
      document: gql(addCartGql),
      variables: vble,
    ));

    if (!result.hasException) {
      var cartAdd = result.data!['cartCreate'];

      if (cartAdd != null) {
        addedCart = cartAdd;
        return addedCart;
      }
    }
    return addedCart;
  }

  Future cartBuyerIdentityUpdate(cartId, input) async {
    GraphQLClient _client = graphQLConfiguration!.clientToQuery();

    var addCartGql = """
      mutation cartBuyerIdentityUpdate(\$cartId: ID!, \$buyerIdentity: CartBuyerIdentityInput!) {
        cartBuyerIdentityUpdate(cartId: \$cartId, buyerIdentity: \$buyerIdentity) {
          userErrors {
            field
            message
          }
         
        }
      }
        
            """;
    final vble = {"cartId": cartId, "buyerIdentity": input};
    QueryResult result = await _client
        .mutate(MutationOptions(document: gql(addCartGql), variables: vble));

    if (!result.hasException) {
      var cartAdd = result.data!['cartBuyerIdentityUpdate'];

      return cartAdd;
    }
    return null;
  }

  Future getCartCount(cartId) async {
    GraphQLClient _client = graphQLConfiguration!.clientToQuery(type: 1);
    var cartProductGql = """
      query cart(\$cartId: ID!) {
        cart(id: \$cartId) {
          id
          totalQuantity
        }
      }
    """;
    final vble = {
      "cartId": cartId,
    };
    QueryResult result = await _client.query(QueryOptions(
        document: gql(cartProductGql),
        variables: vble,
        fetchPolicy: FetchPolicy.noCache));
    try {
      if (!result.hasException) {
        var count = result.data!['cart'];
        if (count != null) {
          return cartCountFromJson(count);
        }
      }
      return null;
    } catch (e) {
      print(e);
      return cartProduct;
    }
  }

  Future addProductToCart(input) async {
    GraphQLClient _client = graphQLConfiguration!.clientToQuery(type: 1);

    var addCartGql = """
     mutation cartLinesAdd(\$cartId:ID!,\$lines:[CartLineInput!]!){
        cartLinesAdd(cartId: \$cartId, lines: \$lines){
              cart{
               id
               createdAt
               updatedAt
                lines(first: 10) {
                  edges {
                   node {
                     id
                     quantity
                     merchandise {
                       ... on ProductVariant {
                         id
                       }
                     }
                   }
                 }
                }
               buyerIdentity {
                 email
                 phone
                 countryCode
                }
             }
         }
     }
      
    """;
    final vble = {"cartId": input['cartId'], "lines": input['selectedProduct']};
    QueryResult result = await _client.query(QueryOptions(
      document: gql(addCartGql),
      variables: vble,
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    if (!result.hasException) {
      var cartLinesAdd = result.data!['cartLinesAdd'];

      if (cartLinesAdd != null) {
        addedCart = cartLinesAdd;
        return addedCart;
      }
    }
    return addedCart;
  }

  Future getCartProductByUser(cartId) async {
    GraphQLClient _client = graphQLConfiguration!.clientToQuery(type: 1);
    var cartProductGql = """
  query cart(\$cartId: ID!) {
  cart(id: \$cartId) {
    id
    createdAt
    updatedAt
    totalQuantity
    discountAllocations {
      discountedAmount {
        amount
      }
    }
    discountCodes {
      code
      applicable
    }
    checkoutUrl
    lines(first: 20) {
      edges {
        node {
          id
          quantity
          cost {
            amountPerQuantity {
              amount
            }
            compareAtAmountPerQuantity {
              amount
            }
            subtotalAmount {
              amount
            }
            totalAmount {
              amount
            }
          }
          discountAllocations {
            discountApplication {
              allocationMethod
              targetSelection
              targetType
            }
            ... on CartAutomaticDiscountAllocation {
              title
            }
            discountedAmount{
              amount
            }
          }
          merchandise {
            ... on ProductVariant {
              product {
                id
                title
              }
              id
              title
              selectedOptions {
                name
                value
              }
              availableForSale
               price {
                amount
                currencyCode
              }
              compareAtPrice {
                amount
                currencyCode
              }
              image {
                src
              }
            }
          }
          attributes {
            key
            value
          }
        }
      }
    }
    attributes {
      key
      value
    }
    cost {
      totalAmount {
        amount
        currencyCode
      }
      subtotalAmount {
        amount
        currencyCode
      }
      totalTaxAmount {
        amount
        currencyCode
      }
      totalDutyAmount {
        amount
        currencyCode
      }
      checkoutChargeAmount {
        amount
        currencyCode
      }
    }
    buyerIdentity {
      email
      phone
      customer {
        id
      }
      countryCode
      deliveryAddressPreferences {
        ... on MailingAddress {
          address1
          address2
          city
          provinceCode
          countryCodeV2
          zip
        }
      }
    }
  }

   }

    """;
    final vble = {
      "cartId": cartId,
    };
    // _client.resetStore();
    QueryResult result = await _client.query(QueryOptions(
        document: gql(cartProductGql),
        variables: vble,
        fetchPolicy: FetchPolicy.noCache));
    try {
      if (!result.hasException) {
        var product = result.data!['cart']['lines']['edges'];
        if (product != null && product.length > 0) {
          List nodes = product.map((edge) => edge['node']).toList();
          return cartProductFromJson(nodes);
        }
      }
      return cartProduct;
    } catch (e) {
      print(e);
      return cartProduct;
    }
  }

  Future getCartProducPricetSummaryByUser(cartId) async {
    GraphQLClient _client = graphQLConfiguration!.clientToQuery();
    var cartProductGql = """
  query cart(\$cartId: ID!) {
  cart(id: \$cartId) {
    id
    createdAt
    updatedAt
    totalQuantity
    attributes {
      key
      value
    }
    checkoutUrl
    discountAllocations {
      discountedAmount{
        amount
      }
    }
    discountCodes {
      applicable
      code
    }
    cost {
      totalAmount {
        amount
        currencyCode
      }
      subtotalAmount {
        amount
        currencyCode
      }
      totalTaxAmount {
        amount
        currencyCode
      }
      totalDutyAmount {
        amount
        currencyCode
      }
      checkoutChargeAmount {
        amount
        currencyCode
      }
    }
    buyerIdentity {
      email
      phone
      customer {
        id
      }
      countryCode
      deliveryAddressPreferences {
        ... on MailingAddress {
          address1
          address2
          city
          provinceCode
          countryCodeV2
          zip
        }
      }
    }
  }

   }

    """;
    final vble = {
      "cartId": cartId,
    };
    // _client.resetStore();
    QueryResult result = await _client.query(QueryOptions(
        document: gql(cartProductGql),
        variables: vble,
        fetchPolicy: FetchPolicy.noCache));
    if (!result.hasException) {
      var product = result.data!['cart'];
      if (product != null && product.length > 0) {
        productSummary = summaryProductCollectionFromJson(product);
      }
      return productSummary;
    }
    return productSummary;
  }

  Future updateCartProductQtyById(line, cartId) async {
    GraphQLClient _client = graphQLConfiguration!.clientToQuery();
    var updateCartQtyGql = """
        mutation cartLinesUpdate(\$cartId:ID!, \$lines:[CartLineUpdateInput!]!){
          cartLinesUpdate(cartId: \$cartId, lines: \$lines){
                 cart{
                      id
                    createdAt
                    updatedAt
                  lines(first: 10) {
                    edges {
                      node {
                        id
                        quantity
                        merchandise {
                          ... on ProductVariant {
                            id
                          }
                        }
                      }
                    }
                  }
                    buyerIdentity {
                      email
                      phone
                      countryCode
                    }     
                }
                  userErrors {
                    field
                    message
                  }
              }
          }

    """;
    final vble = {
      "lines": line,
      "cartId": cartId,
    };
    QueryResult result = await _client.mutate(
        MutationOptions(document: gql(updateCartQtyGql), variables: vble));
    if (!result.hasException) {
      var updateQty = result.data!['cartLinesUpdate'];
      if (updateQty != null) {
        return updateQty;
      } else {
        return null;
      }
    }
    return null;
  }

  Future removeCartById({cartId, String? type, String? sid, productId}) async {
    GraphQLClient _client = graphQLConfiguration!.clientToQuery();
    var removeCartByIdGql = """
    mutation cartLinesRemove(\$cartId:ID!, \$lineIds: [ID!]!) {
        cartLinesRemove(cartId: \$cartId, lineIds: \$lineIds){
            cart{
                id
                createdAt
                updatedAt
                
               lines(first: 10) {
                 edges {
                    node {
                     id
                     quantity
                      merchandise {
                        ... on ProductVariant {
                          id
                        }
                     }
                    }
                 }
                }
                  buyerIdentity {
                    email
                    phone
                    countryCode
                  }
            }
                userErrors {
                 field
                  message
                }
           
         }   
     }

    """;
    final vble = {
      "lineIds": productId,
      "type": type,
      "cartId": cartId,
      "sid": sid != null ? sid : "",
    };

    QueryResult result = await _client.mutate(
        MutationOptions(document: gql(removeCartByIdGql), variables: vble));
    if (!result.hasException) {
      var removeProduct = result.data!['cartLinesRemove'];
      if (removeProduct != null) {
        return removeProduct;
      } else {
        return null;
      }
    }
    return null;
  }

  Future getCart(String userId) async {}

  Future updateCartQuantity(data) async {}
  Future deleteCartQuantity(data) async {}
  Future invoiceDownloadCart(data) async {}
  Future initiateRazorPayPayment(cartId) async {
    GraphQLClient _client = graphQLConfiguration!.clientToQuery(type: 2);
    var apiGql = """
      query initiateRazorPayPayment(\$cartId: String) {
        initiateRazorPayPayment(cartId: \$cartId) {
          error
          message
          orderId
          token
        }
      }
    """;

    QueryResult result = await _client.query(QueryOptions(
        document: gql(apiGql),
        variables: {
          "cartId": cartId,
        },
        fetchPolicy: FetchPolicy.networkOnly,
        operationName: 'initiateRazorPayPayment'));
    if (!result.hasException) {
      graphQLConfiguration!.getToken(result);
      var data = result.data!['initiateRazorPayPayment'];
      if (data != null) {
        return data;
      }
    }
    return null;
  }

  Future initiateCartEnquiryByUser(data) async {}
  Future initiateProductEnquiryByUser(data) async {}
  Future checkEnquiryIsConfirmed(data) async {}
  Future quotationDownloadCart() async {}
  Future addBulkProductToCart(data) async {}
}
