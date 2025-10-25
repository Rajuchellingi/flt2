import 'package:b2b_graphql_package/GraphQLConfiguration.dart';
import 'package:b2b_graphql_package/modules/order/order_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class OrderRepo {
  var graphQLConfiguration;
  var orderCreated;
  var orderList;
  OrderRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }

  Future getUserOrderList(
      String userId, int pageNo, int limit, endCursorValue) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    var orderListGql = """
           query getUserOrder(\$customerAccessToken:String!, \$after: String) {
                     customer(customerAccessToken:\$customerAccessToken) {
                        id
                        email
                        firstName
                        lastName
                        phone
                           orders(first:$limit, after: \$after, sortKey: ID, reverse: true) {
                             edges {
                               node {
                                id
                                billingAddress{
                                    address1
                                    address2
                                    city
                                    company
                                    countryCodeV2
                                     firstName
                                    formatted
                                     formattedArea
                                    id
                                     lastName
                                    latitude
                                    longitude
                                    name
                                    phone
                                    province
                                    provinceCode
                                    zip}
                                cancelReason
                                canceledAt
                                currencyCode
                                currentTotalPrice{amount,currencyCode}
                                currentSubtotalPrice{amount,currencyCode}
                                currentTotalTax{amount,currencyCode}
                                customAttributes{
                                    key
                                    value
                                }
                                customerLocale
                                customerUrl
                                edited
                                 email
                                 financialStatus
                                fulfillmentStatus
                                 lineItems(first:100){
                                        nodes{
                                            currentQuantity
                                            customAttributes{
                                                key
                                                value
                                            }
                                            discountedTotalPrice{amount,currencyCode}
                                            originalTotalPrice{amount,currencyCode}
                                            quantity
                                            title
                                            variant{
                                                availableForSale
                                               barcode 
                                               compareAtPrice{amount,currencyCode}
                                               currentlyNotInStock
                                               id
                                                image{
                                                   altText
                                                   url
                                                   id
                                                   height
                                                   
                                               }
                                               price{amount,currencyCode}
                                               product{
                                                   id
                                                   title
                                                   handle
                                               }
                                               requiresShipping
                                               selectedOptions{
                                                   name
                                                   value
                                               }
                                               sku
                                               title
                                               unitPrice{amount,currencyCode}
                                               unitPriceMeasurement{
                                                   measuredType
                                                   quantityUnit
                                                   quantityValue
                                                   referenceUnit
                                                   referenceValue
                                               }
                                               weight
                                               weightUnit
                                            }
                                        }
                                }
                                name
                                 orderNumber
                                 originalTotalPrice{amount,currencyCode}
                                 phone
                                processedAt
                                shippingAddress{
                                    address1
                                    address2
                                    city
                                    company
                                    countryCodeV2
                                    firstName
                                    formatted
                                    formattedArea
                                    id
                                    lastName
                                    latitude
                                    longitude
                                    name
                                    phone
                                    province
                                    provinceCode
                                    zip}
                                    statusUrl
                                    subtotalPrice{amount,currencyCode}
                                    totalRefunded{amount,currencyCode}
                                    totalPrice{amount,currencyCode}
                                    totalShippingPrice{amount,currencyCode}
                                    totalTax{amount,currencyCode}
                              }
                            }
                            pageInfo{hasNextPage,endCursor}
                          }
                       }
                  }
            """;
    // final vble = {"userId": userId, "pageNo": pageNo, "limit": limit};
    final vble = {"customerAccessToken": userId, "after": endCursorValue};

    QueryResult result = await _client.query(QueryOptions(
      document: gql(orderListGql),
      variables: vble,
      fetchPolicy: FetchPolicy.networkOnly,
    ));
    if (!result.hasException) {
      var orderListModel = result.data!['customer']['orders']['edges'];
      var page = result.data!['customer']['orders']['pageInfo'];
      var customer = result.data!['customer'];
      var pageModel = {"page": page};
      // print("pageModel $pageModel");
      if (orderListModel != null && orderListModel.length > 0) {
        // print("orderListModel>>>111 $orderListModel");
        List nodes = orderListModel.map((edge) => edge['node']).toList();
        orderList = orderListModelFromJson(nodes, pageModel, customer);
        // print("orderList $orderList");
        return orderList;
      }
    }
    return null;
  }

  Future getOrderListByUser(pageNo, limit) async {}
  Future getSingleOrderDetail(orderId) async {}
  Future downloadInvoice(orderId) async {}
  Future cancelOrder(orderId, reason) async {}
  Future getRecentOrderAndBooking() async {}
}
