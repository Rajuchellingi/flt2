import 'package:b2b_graphql_package/GraphQLConfiguration.dart';

class MultiBookingRepo {
  GraphQLConfiguration? graphQLConfiguration;

  MultiBookingRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }

  Future getMultiBookingProducts(productIds) async {
    return null;
  }

  Future getBookingDetailByUser(state) async {}
  Future initiateMultiBookingByUser() async {}
  Future createTempBooking(data) async {}
}
