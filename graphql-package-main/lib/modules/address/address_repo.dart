// import 'package:b2b_graphql_package/modules/b2b_wishList/wishlist.model.dart';

import '../../GraphQLConfiguration.dart';

class AddressRepo {
  var graphQLConfiguration;

  AddressRepo() {
    graphQLConfiguration = GraphQLConfiguration();
  }
  var allWishList;
  var wishListCheck = false;
  var userAddressDetails;

  Future getUserMyAddressDetails(data) async {}

  Future updateUserDetails(data) async {}

  Future getSingleAddress(data) async {}

  Future removeSingleAddress(data) async {}

  Future updatePincode(data) async {}

  Future addAddressDetails(data) async {}
}
