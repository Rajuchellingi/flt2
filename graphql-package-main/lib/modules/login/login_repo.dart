// ignore_for_file: unnecessary_null_comparison

import 'package:b2b_graphql_package/GraphQLConfiguration.dart';
import 'package:b2b_graphql_package/modules/login/login_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginRepo {
  var graphQlConfiguration;

  LoginRepo() {
    graphQlConfiguration = GraphQLConfiguration();
  }

  Future logInWithEmailAndPassword(String email, String password) async {
    GraphQLClient _client = graphQlConfiguration.clientToQuery();

    var LogInGql = """
      mutation customerAccessTokenCreate(\$input:CustomerAccessTokenCreateInput!) {
        customerAccessTokenCreate(input: \$input) {
             customerAccessToken {
                accessToken
                expiresAt
              }
             customerUserErrors {
                message
                   code
                 field
              }
         }
      }

     """;

    final vble = {
      "input": {
        "email": email,
        "password": password,
      }
    };
    QueryResult result = await _client.mutate(MutationOptions(
      document: gql(LogInGql),
      variables: vble,
    ));
    if (!result.hasException) {
      var signInModel =
          result.data!['customerAccessTokenCreate']['customerAccessToken'];
      var userErrors =
          result.data!['customerAccessTokenCreate']['customerUserErrors'];
      if (signInModel != null) {
        // signInWithPassword = userByIdFromJson(signInModel);
        return signInModel;
      } else if (userErrors != null && userErrors.length > 0) {
        return null;
      }
      // print("signInModel $signInModel");
    } else {
      var errors = result.exception!.graphqlErrors;
      if (errors != null && errors.length > 0) {
        return {"message": errors.first.message};
      }
    }
    return null;
  }

  Future verifyAndRegisterUser(user) async {
    String addUserGql = """
        mutation verifyAndCreateShopifyUser(\$user: ShopifyUserInput) {
          verifyAndCreateShopifyUser(user: \$user) {
            userId
            error
            message
          }
        }
      """;
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    final vble = {"user": user};
    QueryResult result = await _client.mutate(
      MutationOptions(
          document: gql(addUserGql),
          variables: vble,
          operationName: 'verifyAndCreateShopifyUser'),
    );
    var userData;
    graphQLConfiguration.getToken(result);
    // if (!result.hasException) {
    var userResponse = result.data!['verifyAndCreateShopifyUser'];
    if (userResponse != null) {
      userData = userRegisterFromJson(userResponse);
      return userData;
    } else {
      return userData;
    }
    // }
  }

  Future forgetassword(email) async {
    String addUserGql = """
      mutation customerRecover(\$email:String!){ 
      customerRecover(email:\$email) {
      customerUserErrors {
      code
      field
      message
    }
  }
}

    """;
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    final vble = {"email": email};
    QueryResult result = await _client.mutate(
      MutationOptions(
          document: gql(addUserGql),
          variables: vble,
          operationName: 'customerRecover'),
    );
    graphQLConfiguration.getToken(result);
    if (!result.hasException) {
      var user = result.data!['customerRecover'];
      if (user != null) return user;
    } else {
      var errors = result.exception!.graphqlErrors;
      return {
        "errors": errors,
      };
    }
    return null;
  }

  Future sendOTPForLogin(mobileNumber) async {
    String addUserGql = """
      mutation sendOTPForLogin(\$mobileNumber: String) {
        sendOTPForLogin(mobileNumber: \$mobileNumber) {
          error
          message
          otpId
        }
      }

    """;
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    final vble = {"mobileNumber": mobileNumber};
    QueryResult result = await _client.mutate(
      MutationOptions(
          document: gql(addUserGql),
          variables: vble,
          operationName: 'sendOTPForLogin'),
    );
    graphQLConfiguration.getToken(result);
    if (!result.hasException) {
      var user = result.data!['sendOTPForLogin'];
      if (user != null) return user;
    }
    return null;
  }

  Future verifyLoginOTP(otpId, otp) async {
    String addUserGql = """
      mutation verifyLoginOTP(\$otpId: String, \$otp: String) {
        verifyLoginOTP(otpId: \$otpId, otp: \$otp) {
          error
          message
          emailId
          loginData
        }
      }
    """;
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery(type: 2);
    final vble = {"otpId": otpId, "otp": otp};
    QueryResult result = await _client.mutate(
      MutationOptions(
          document: gql(addUserGql),
          variables: vble,
          operationName: 'verifyLoginOTP'),
    );
    graphQLConfiguration.getToken(result);
    if (!result.hasException) {
      var user = result.data!['verifyLoginOTP'];
      if (user != null) return user;
    }
    return null;
  }

  Future accountLogin(data) async {}
  Future accountLoginWithPassword(data) async {}
  Future resendOtp(data) async {}
  Future getLoginSettingForUI() async {}
  Future verifyUserForForgotPassword(loginDetail) async {}
  Future resendForgotPasswordOTP(loginDetail) async {}
  Future verifyForgotPasswordOtp(loginDetail, otp) async {}
  Future verifyAndChangePassword(token, password) async {}
  Future requestLoginRenewal(input) async {}
}
