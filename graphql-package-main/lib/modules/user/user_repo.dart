import 'package:b2b_graphql_package/GraphQLConfiguration.dart';
import 'package:b2b_graphql_package/modules/user/user_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserRepo {
  var graphQLConfiguration;
  var updateDatails;
  var userDetails;
  UserRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }

  Future getUserById(String id, metafields) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();

    var getUserByIdGql = """
                query getByUserId(\$customerAccessToken:String!, \$metafields: [HasMetafieldsIdentifier!]!) {
                 customer(customerAccessToken: \$customerAccessToken) {
                  id
                  email
                  firstName
                  lastName
                  phone
                  createdAt
                  updatedAt
                  numberOfOrders
                  acceptsMarketing
                  defaultAddress {
                    id
                    firstName
                    lastName
                    address1
                    address2
                    city
                    country
                    province
                    zip
                    phone
                  }
                   addresses(first: 100) {
                    edges {
                      node {
                        id
                        address1
                        address2
                        city
                        province
                        zip
                        country
                        phone
                      }
                    }
                  }
                  metafields(identifiers: \$metafields) {
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
                  orders(first: 5) {
                    edges {
                      node {
                        id
                        totalPrice{amount,currencyCode}
                      }
                    }
                    totalCount
               }
            }

         }

   """;
    final vble = {"customerAccessToken": id, "metafields": metafields};
    // final vble = {
    //   "id": id,
    // };
    QueryResult result = await _client.query(QueryOptions(
      document: gql(getUserByIdGql),
      variables: vble,
      fetchPolicy: FetchPolicy.networkOnly,
    ));

    try {
      if (!result.hasException) {
        var userDetailsModel = result.data!['customer'];
        if (userDetailsModel != null && userDetailsModel.length > 0) {
          userDetails = userDetailsFromJson(userDetailsModel);
          return userDetails;
        }
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getUserDetailArrayById(String id) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();

    var getUserArrayByIdGql = """
                query getByUserId(\$customerAccessToken:String!) {
                 customer(customerAccessToken: \$customerAccessToken) {
                   addresses(first: 100) {
                    edges {
                      node {
                        firstName
                        lastName
                        company
                        id
                        address1
                        address2
                        city
                        province
                        zip
                        country
                        phone 
                      }
                    }
                    
                  }
                    defaultAddress {
                      address1
                      id
                      address2
                      city
                      province
                      country
                      zip
                    }

            }

         }

   """;
    final vble = {
      "customerAccessToken": id,
    };
    // final vble = {
    //   "id": id,
    // };
    QueryResult result = await _client.query(QueryOptions(
      document: gql(getUserArrayByIdGql),
      variables: vble,
      fetchPolicy: FetchPolicy.networkOnly,
    ));
    try {
      if (!result.hasException) {
        var userDetailsArray = result.data!['customer']['addresses']['edges'];
        var defaultAdrees = result.data!['customer']['defaultAddress'];
        // print("defaultAdrees $defaultAdrees");
        if (userDetailsArray != null && userDetailsArray.length > 0) {
          List nodes = userDetailsArray.map((edge) => edge['node']).toList();
          // print("nodes $nodes");
          var value = userDetailsArrayFromJson(nodes, defaultAdrees);
          // print("value---->>> ${value[1].toJson()}");
          return value;
        }
      }
      return userDetails;
    } catch (e) {
      print(e);
      return userDetails;
    }
  }

  Future<bool> updateDefaultAddress(request) async {
    String addUserGql = """
       mutation customerDefaultAddressUpdate(\$addressId: ID!, \$customerAccessToken: String!) {
         customerDefaultAddressUpdate(addressId: \$addressId, customerAccessToken: \$customerAccessToken) {
           customer {
                        firstName
                        lastName
                        id
                        phone          
                         }
         }
       }      
    """;
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    final vble = request;
    // print("vble customerDefaultAddressUpdate $vble");
    QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(addUserGql),
        variables: vble,
      ),
    );
    if (!result.hasException) {
      var updateBillingAddress = result.data!['updateBillingAddress'];
      if (updateBillingAddress != null && updateBillingAddress["_id"] != null) {
        return true;
      } else {
        return true;
      }
    }
    return false;
  }

  Future<bool> updateShippingAddress(userAddressModel) async {
    String addUserGql =
        """mutation updateShippingAddress(\$id: String, \$addressId: String, \$enable: Boolean) {
                updateShippingAddress(id: \$id, addressId: \$addressId, enable: \$enable) {
                  _id
                  __typename
                }
              }""";
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    final vble = {
      "addressId": userAddressModel.addressId,
      "enable": userAddressModel.enable,
      "id": userAddressModel.sId
    };
    QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(addUserGql),
        variables: vble,
      ),
    );
    if (!result.hasException) {
      var updateShippingAddress = result.data!['updateShippingAddress'];
      if (updateShippingAddress != null &&
          updateShippingAddress["_id"] != null) {
        return true;
      } else {
        return true;
      }
    }
    return false;
  }

  Future<bool> removeAddress(addressId, userId) async {
    String addUserGql = """
        mutation customerAddressDelete(\$id:ID!,\$customerAccessToken:String!){
          customerAddressDelete(customerAccessToken: \$customerAccessToken, id: \$id) {
           customerUserErrors{
              code
              field
              message
            }
            }
          }
    """;

    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    final vble = {
      "id": addressId,
      "customerAccessToken": userId,
    };
    QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(addUserGql),
        variables: vble,
      ),
    );
    if (!result.hasException) {
      var removeAddress = result.data!['customerAddressDelete'];
      if (removeAddress != null) {
        return true;
      } else {
        return true;
      }
    }
    return false;
  }

  Future<bool> updateAddress(request, userId, addressId) async {
    String addUserGql = """
        mutation customerAddressUpdate(\$id:ID!,\$customerAccessToken:String!,\$address:MailingAddressInput!){
          customerAddressUpdate (address: \$address, customerAccessToken: \$customerAccessToken, id: \$id){
            customerUserErrors{
              code
              field
              message
            }
          }
        }
           """;
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    final vble = {
      "customerAccessToken": userId,
      "address": request,
      "id": addressId,
    };
    QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(addUserGql),
        variables: vble,
      ),
    );
    if (!result.hasException) {
      var updateAddress = result.data!['customerAddressUpdate'];
      if (updateAddress != null) {
        return true;
      } else {
        return true;
      }
    }
    return false;
    //   else {
    //   var errors = result.data!['customerUpdate']['userErrors'];
    //   if (errors != null && errors.isNotEmpty) {
    //     var errorMessage = errors[0].message;
    //     return errorMessage;
    //   } else {
    //     return false;
    //   }
    // }
  }

  Future<bool> addAddress(request, userId) async {
    String addUserGql = """
            mutation customerAddressCreate(\$address:MailingAddressInput!,\$customerAccessToken: String!){
              customerAddressCreate(address: \$address,customerAccessToken: \$customerAccessToken){
           customerUserErrors {
             code
             message
           }
           customerAddress {
             id
            }
            userErrors {
                field
              message
           }
          
        }
        }
  """;
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    final vble = {
      "address": request,
      "customerAccessToken": userId,
    };
    QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(addUserGql),
        variables: vble,
      ),
    );
    if (!result.hasException) {
      var addAddress = result.data!['customerAddressCreate'];
      if (addAddress != null && addAddress["_id"] != null) {
        return true;
      } else {
        return true;
      }
    }
    return false;
  }

  updateUserProfile(user, userId) async {
    String addUserGql = """
    mutation customerUpdate(\$customer: CustomerUpdateInput!, \$customerAccessToken: String!){
      customerUpdate(customer: \$customer, customerAccessToken: \$customerAccessToken){
        customer {
          firstName
          lastName
          email
          phone
        }
        userErrors {
          field
          message
        }
      }
    }
   """;

    final vble = {"customer": user, "customerAccessToken": userId};
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(addUserGql),
        variables: vble,
      ),
    );
    if (!result.hasException) {
      var data = result.data!['customerUpdate'];
      print(data);
      if (data != null) {
        // login = loginDataFromJson(data);
        updateDatails = registrationModelFromJson(data);
      }
      // if (addAddress != null && addAddress["customer"]["_id"] != null) {
      //   return true;
      // } else {
      //   return true;
      // }
    } else {
      var data = {
        "customer": null,
        "customerUserErrors": [
          {
            "message": result.exception?.graphqlErrors.first.message,
            "__typename": "Error"
          }
        ]
      };
      updateDatails = registrationModelFromJson(data);
    }
    return updateDatails;
  }

  Future createEmailAndSmsOtp(data) async {}

  Future createEmailorSmsOtp(input) async {}

  Future resendOTP(tempId, resend) async {}

  Future userCreatedSubmit(data) async {}

  Future createUser(input) async {}

  Future getPinCodeFormService(data) async {}
  Future updateAddressDetail(data) async {}
  Future addAddressDetails(data) async {}
  Future getUserDetailById(String id) async {}
  Future updateUserDetails(data) async {}
  Future emailUpdatedReq(data) async {}
  Future otpChecker(data) async {}
  Future mobileNumberUpdateReq(mobileNumber, newMobileNumber) async {}
  Future changeMobileNumber(mobileNumber, status) async {}
  Future updateUserPasswordById(input) async {}
}
